Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe006.messaging.microsoft.com
 [216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 758CBB6F98
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 06:34:15 +1100 (EST)
Message-ID: <4F3D5A28.4010905@freescale.com>
Date: Thu, 16 Feb 2012 13:34:00 -0600
From: Timur Tabi <b04825@freescale.com>
MIME-Version: 1.0
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH 1/1] fsldma: ignore end of segments interrupt
References: <1327611520-18256-1-git-send-email-iws@ovro.caltech.edu>
 <CAOZdJXVccE0GqZU2PvAz3RTh+X9ZYZr-9YufxS+mYWJkhSOGEQ@mail.gmail.com>
 <20120216190040.GA9262@ovro.caltech.edu>
In-Reply-To: <20120216190040.GA9262@ovro.caltech.edu>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Dan Williams <dan.j.williams@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ira W. Snyder wrote:
> This leads me to believe that this occurs mostly (but not always)
> concurrent with the end-of-chain interrupt.

Have you tested this on an 85xx platform?

I noticed something odd.  You're modifying fsldma_chan_irq(), which is for
DMA controllers that have per-channel IRQs.  83xx devices don't have
per-channel IRQs -- all channels on one controller have the same IRQ.
Looking at the device tree, I see that the IRQs are listed in the channel
nodes *and* in the controller node.  I don't see how we ever use the
per-controller ISR.

I wonder if the shared IRQ is the part of the cause of the interrupts
you're seeing.

> 
> In the last month, the "unhandled sr" error has occurred on 92 out of
> 120 boards in production use. The statistics are included below. On some
> boards, it is much more frequent than on others. All boards have roughly
> the same workload.
> 
> Another interesting tidbit from my logs: this only occurs on DMA channel
> 2 (the are numbered starting at 0, it is the 3rd channel). Here is an
> example log message:

What happens if you never register that channel?  That is, remove this
node from the device tree:

dma-channel@100 {
	compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
	reg = <0x100 0x80>;
	cell-index = <2>;
	interrupt-parent = <&ipic>;
	interrupts = <71 8>;
};

-- 
Timur Tabi
Linux kernel developer at Freescale
