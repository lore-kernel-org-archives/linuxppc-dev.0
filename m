Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from imx9.toshiba.co.jp (imx9.toshiba.co.jp [202.33.96.51])
	by ozlabs.org (Postfix) with ESMTP id C832167BD9
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 15:58:18 +1100 (EST)
Received: from imx12.toshiba.co.jp (imx12 [61.202.160.132])
	by imx9.toshiba.co.jp  with ESMTP id kBF4wFS3024782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 13:58:15 +0900 (JST)
Received: from wall11.toshiba.co.jp (wall11 [133.199.90.149])
	by imx12.toshiba.co.jp  with ESMTP id kBF4wAZh010066
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 13:58:10 +0900 (JST)
Received: (from root@localhost) by wall11.toshiba.co.jp  id kBF4wAPV029499
	for linuxppc-dev@ozlabs.org; Fri, 15 Dec 2006 13:58:10 +0900 (JST)
Received: from mx2.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id kBF4w8g1002878
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 13:58:09 +0900 (JST)
Message-Id: <200612150458.kBF4w8KC028184@toshiba.co.jp>
MIME-Version: 1.0
Date: Fri, 15 Dec 2006 13:59:40 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: paulus@samba.org, benh@kernel.crashing.org
Subject: Re: [PATCH 5/19] powerpc: add IRQ remapping hook
In-Reply-To: <1166072316.11914.284.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul-san, Ben-san,

> On Thu, 2006-12-14 at 11:27 +0900, Ishizaki Kou wrote:
> > This patch adds irq remapping hook. On interrupt mechanism on Beat,
> > when an irq outlet who has an id which is formerly used is created,
> > remapping the irq is required.
> 
> Today paulus asked me what that was for and I must admit that despite
> your earlier explanations, I was a bit at a loss justifying it.
> 
> Can you explain us again the exact cicrumstances in which this is
> necessary ? It seems to us that if an interrupt outlet<->plug linkage is
> removed in the hypervisor itself, it should be also removed in linux
> using irq_dispose_mapping().
> 
> What are the cases where the HV might require a linkage to be
> re-established by that remap function that the kernel couldn't have done
> the cleanup itself beforehand ?

Okay, I'll try to explain.

Beat has two IDs to handle interrupts and events. IRQ outlets represent
interrupt sources, and IRQ plugs bind IRQ outlet to Guest OS.
So you have to "bind" IRQ plugs and IRQ outlets to receive interrupts.

Because of our design, you can assign and deassign any IRQ outlet to
a Guest OS even if the Guest OS uses the IRQ outlet without any notice
to the Guest OS. If the IRQ outlet is deassigned, bound IRQ plugs will
be also destroyed.

So, following scenario will be occur:
  1. Construct an IRQ outlet.
  2. Map it into IRQ plug by calling irq_create_mapping()
  3. Destruct the IRQ outlet.
  4. Forget to call irq_displose_mapping() because GuestOS is not
     notified.
  5. Reconstruct an IRQ outlet.
  6. If port number got at 1. and 5. are same, irq_create_mapping()
     (withour remapping patch) will reject binding between VIRQ and
     IRQ outlet, so IRQ plug is not constructed and connected to the
     IRQ outlet.

It can be occured with event receive port (sort of IRQ outlet).
Because I have no confidence that the "event receive port" users call
surely irq_dispose_mapping() whenever they destruct any event
receive port, I think interrupt-handling subsystem should overcome
this troublesome situation.

Best regards,
Akira Iguchi
Toshiba
