Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 379AA67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Apr 2005 08:12:38 +1000 (EST)
Date: Fri, 15 Apr 2005 15:12:35 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Shawn Jin <shawnxjin@gmail.com>
Message-ID: <20050415221235.GA29802@gate.ebshome.net>
References: <c3d0340b05041514362746169a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c3d0340b05041514362746169a@mail.gmail.com>
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: Interrupt prioritization on linux for ppc440
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Apr 15, 2005 at 02:36:51PM -0700, Shawn Jin wrote:
> 
> The home-made interrupt controller PIC supports interrupt priorities
> and critical/non-critical interrupts. I found that the current kernel
> doesn't support interrupt priorities. 

Yes, we don't have IRQ priorities on 4xx. Theoretically, they can be 
emulated in get_irq, but I really don't think it's worth it.

> Is this observation true? Is
> there any existing patch to support that? 

I'm not aware of such patch existence.

> I noticed that the implementation of ppc4xx_pic.c disables all
> critical interrupts during initialization. To support critical
> interrupts, is it so simple that we change the handler of critical
> exception from CriticalInput to do_IRQ in head_44x.S?

No, it's not that simple. Linux doesn't support a notion of critical 
IRQs versus normal ones. Until there is an infrastructure for this, it 
doesn't make any sense to implement 4xx support.

--
Eugene
