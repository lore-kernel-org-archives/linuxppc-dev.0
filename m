Return-Path: <jacmet@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.26])
	by ozlabs.org (Postfix) with ESMTP id 30CB3DDE9F
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 03:38:27 +1100 (EST)
Received: by ey-out-2122.google.com with SMTP id d26so77298eyd.15
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 08:38:26 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] fsldma: print correct IRQ on mpc83xx
References: <1231944284-18296-1-git-send-email-jacmet@sunsite.dk>
	<496E0E85.7060801@freescale.com> <87iqohc19b.fsf@macbook.be.48ers.dk>
	<496E1317.9070804@freescale.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 14 Jan 2009 17:38:23 +0100
In-Reply-To: <496E1317.9070804@freescale.com> (Timur Tabi's message of "Wed\,
	14 Jan 2009 10\:30\:15 -0600")
Message-ID: <87eiz5c074.fsf@macbook.be.48ers.dk>
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
 >> Why? Does it buy us anything to request_irq again for each channel?
 >> 
 >> Now we're at it, it seems like there's a check for != NO_IRQ missing
 >> in fsl_dma_chan_remove().

 Timur> If the device tree doesn't specify an interrupts property in
 Timur> the device channel, then I think that's an error.  All the
 Timur> device trees already do that.  So where do you see this
 Timur> problem?

Documentation/powerpc/dts-bindings/fsl/dma.txt and
The NO_IRQ check in fsldma.c:fsl_dma_chan_probe()

And it makes sense, there's no per-channel DMAC interrupts on mpc83xx.

-- 
Bye, Peter Korsgaard
