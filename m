Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 66FA767B8E
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Jul 2006 01:59:39 +1000 (EST)
Subject: Re: Kexec initial registers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jimi Xenidis <jimix@watson.ibm.com>
In-Reply-To: <28C15305-BE9F-4EE7-93A2-437EAEA7B886@watson.ibm.com>
References: <4CE0FC89-084F-42E8-8E3B-8D2C41AC06F2@watson.ibm.com>
	<1152911297.23037.109.camel@localhost.localdomain>
	<28C15305-BE9F-4EE7-93A2-437EAEA7B886@watson.ibm.com>
Content-Type: text/plain
Date: Sun, 16 Jul 2006 11:59:15 -0400
Message-Id: <1153065556.5905.4.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-07-15 at 22:10 -0400, Jimi Xenidis wrote:
> On Jul 14, 2006, at 5:08 PM, Benjamin Herrenschmidt wrote:
> 
> > On Fri, 2006-07-14 at 12:02 -0400, Jimi Xenidis wrote:
> >> This is what I have so far:
> >>
> >>    r3: address of device tree blob
> >>    r4: address that kernel was loaded
> >>    r5: not OF (=0)
> >
> > Correct and that's all that should be needed
> >
> >>    r13: local_paca address (0?)
> >
> > You shouldn't have to care about r13 at all, it should be set by the
> > kernel before it's used. If not, please let us know as that means  
> > there
> > is a bug :)
> 
> Not! 99.99% :)
> When loading a kernel under Xen using kexec we set r1-r5 and set all  
> other GPRS to all 5's (cuz we can) with CONFIG_PPC_EARLY_DEBUG=y and  
> all hell breaks loose in the first printk()/DBG() from early_setup()  
> for:
>    kernel/printk.c:506
>    506		spin_lock_irqsave(&logbuf_lock, flags);
> 
> where is access local_paca.
> 
> I think everyone else (ot just the sane ones) just sets all GPRS to 0

Then we have a bug and we need to initialize local_paca before we call
early_setup...

Ben.
