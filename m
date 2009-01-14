Return-Path: <jacmet@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.24])
	by ozlabs.org (Postfix) with ESMTP id D18E1DE0D9
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 06:29:19 +1100 (EST)
Received: by ey-out-2122.google.com with SMTP id d26so87921eyd.15
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 11:29:17 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] fsldma: print correct IRQ on mpc83xx
References: <1231944284-18296-1-git-send-email-jacmet@sunsite.dk>
	<496E0E85.7060801@freescale.com> <87iqohc19b.fsf@macbook.be.48ers.dk>
	<496E1317.9070804@freescale.com> <87eiz5c074.fsf@macbook.be.48ers.dk>
	<496E15E8.2060106@freescale.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 14 Jan 2009 20:29:15 +0100
In-Reply-To: <496E15E8.2060106@freescale.com> (Timur Tabi's message of "Wed\,
	14 Jan 2009 10\:42\:16 -0600")
Message-ID: <87ab9tbsac.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, dan.j.williams@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Timur" == Timur Tabi <timur@freescale.com> writes:

 Timur> Peter Korsgaard wrote:
 >> Documentation/powerpc/dts-bindings/fsl/dma.txt and
 >> The NO_IRQ check in fsldma.c:fsl_dma_chan_probe()
 >> 
 >> And it makes sense, there's no per-channel DMAC interrupts on mpc83xx.

 Timur> But the device trees do have IRQs in the channels:

 Timur> arch/powerpc/boot/dts/mpc836x_mds.dts:

 Timur> So I don't see what bug you're trying to fix.  If you're
 Timur> saying that the interrupts should not be specific DMA
 Timur> channels, then the proper fix is to have the DMA driver pick
 Timur> up the interrupts from the DMA controller's node when
 Timur> necessary.  Hacking up a printk doesn't fix anything.

Ok, let me try again. SOME device trees indeed have an interrupt
property per channel, but the bindings
(Documentation/powerpc/dts-bindings/fsl/dma.txt) and the probe code in
fsldma.c doesn't require it.

The only minor issues we have is the cosmetic problem of the driver
printing NO_IRQ (E.G. this patch), and the driver calling
free_irq(NO_IRQ) (E.G. the other patch I sent today) in the release
path.

-- 
Bye, Peter Korsgaard
