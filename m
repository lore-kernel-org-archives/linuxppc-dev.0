Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6F1F967A7A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Feb 2005 09:54:18 +1100 (EST)
Date: Thu, 17 Feb 2005 14:54:14 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: "Barbier, Renaud (GE Infrastructure)" <Renaud.Barbier@ge.com>
Message-ID: <20050217225414.GA32623@gate.ebshome.net>
References: <45ABD2373C33C4459D42B40EC4F346F205E1A4F0@FTWMLVEM03.e2k.ad.ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45ABD2373C33C4459D42B40EC4F346F205E1A4F0@FTWMLVEM03.e2k.ad.ge.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 440GX interrupt
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Feb 17, 2005 at 03:50:27PM -0600, Barbier, Renaud (GE Infrastructure) wrote:
> I have a question regarding interrupt and irq locking.
> I derived  (or copied from somehwere)a library (linux 2.4.26) for the 440GX from ppc4xx_pic.c to take care of the last interrupt register (UIC2).
> This a newbie question regarding get_irq/spin_lock
> here is get_irq:
> ...
>      bits = mfdcr(DCRN_UIC_MSR(UICBASE));
>      if ((bits & 0x40000000) == 0x40000000)
>      {
>         bits = mfdcr(DCRN_UIC_MSR(UIC0));
>         irq = ( ffs(bits));
>         irq = 32-irq;
> 	}
> 	...
> 
> my question is what guarantee that the code is executed atomically?

ppc_md.get_irq is called with hard irqs disabled, this makes 
its execution context atomic.

> The reason I asked is that we have a driver that did the following in the ioctl call:
> 
> 	disable_irq(26);
> 	/* do something */
> 	enable_irq(26);
> 
> as you noticed there is not any spin_lock.
> Sometimes, this leads  get_irq to see UICBASE indicating an irq in UIC0 and
> UIC0_MSR to return 0. hence you get irq 32 (MAL_SERR) and an infinite loop.

> My current fix is to use irqsave/irqrestore in the driver which I 
> think is the correct way to do (but I may be wrong please help).

Yes, this is preferable to disable/enable_irq.

> However, I have a colleague (here is the human problem of my 
> questions: him or me is the problem) that insists that I should do 
> something in get_irq to have atomic execution.

No, it's already atomic. 

Probably it's a race which cannot be avoided anyway because external 
IRQs are completely async, and your version of ppc4xx_pic.c just has a 
bug. I'll think about it a little more.

Could you try 2.6 version of ppc_4xx_pic.c? I don't think 2.4 has any 
official support for UIC2 anyway.

--
Eugene.
