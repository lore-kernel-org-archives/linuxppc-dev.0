Return-Path: <jeff@theptrgroup.com>
Received: from mail.theptrgroup.com (mail.theptrgroup.com [209.183.211.17])
	by ozlabs.org (Postfix) with ESMTP id 07E132BDA6
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Sep 2004 23:36:00 +1000 (EST)
From: Jeff Angielski <jeff@theptrgroup.com>
To: jonathan@jonmasters.org
In-Reply-To: <35fb2e59040922181249d18af6@mail.gmail.com>
References: <35fb2e5904090607241087442d@mail.gmail.com>
	<35fb2e59040919131864c26952@mail.gmail.com>
	<35fb2e59040922181249d18af6@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1095946560.13705.7.camel@nighteyes.localdomain>
Mime-Version: 1.0
Date: Thu, 23 Sep 2004 09:36:00 -0400
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] xsa_use_interrupts flag [WAS: xilinx_sysace]
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2004-09-22 at 21:12, Jon Masters wrote:
> On Sun, 19 Sep 2004 21:18:14 +0100, Jon Masters <jonmasters@gmail.com> wrote:
> 
> > It's as I thought on and off and then on again - the code checks out
> > ok (it's not pretty but it works) - and I seem to be getting unwanted
> > extra unhandled interrupts from the hardware. This driver needs a lot
> > of cleanup anyway - it doesn't handle these kinds of error state, nor
> > does it handle the removal of a mounted CompactFlash, and a dozen
> > other typical problems. I'll post a patch when I've solved the main
> > problem - moan at me by private mail if you're using this, having
> > similar issues, and feel like helping.
> 
> Hi all,
> 
> I have spoken to a number of people about this ongoing issue with the
> Xilinx System ACE hardware that I am using (I have a Memec board - not
> the Xilinx one) and the fact that the hardware insists on generating
> an extra interrupt on SectorWrite operations which is neither
> documented nor otherwise explainable (but I'd love it if someone would
> enlighten me).

We are using the SystemACE on our custom MPC8260 platform and I do not
recall seeing extra interrupts on the sector writes.

However, we did uncover some general interrupt issues with interrupt
handling in the PPC kernel.  We were seeing a large number of BAD
interrupts in /proc/interrupts.  Unfortunately, the only information I
have on the work around is this email snippet that I saved:

<begin snippet>
> > This problem was discussed on mailing list before also and you can
> > eliminate this problem by inserting a sync instruction at a
> certainplace in the 8260 interrupt handling code. See, for example,
> > http://www.geocrawler.com/archives/3/8358/2002/11/100/10173445/
> > 
> > Add a __asm__ volatile("sync"); at the end of the m8260_mask_and_ack
> > function in arch/ppc/kernel/ppc8260_pic.c to fix it.
<end snippet>


Jeff Angielski
The PTR Group
