Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 23A42B7D51
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Feb 2010 08:17:00 +1100 (EST)
Date: Tue, 2 Feb 2010 13:16:57 -0800
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 8/8] fsldma: major cleanups and fixes
Message-ID: <20100202211656.GA2609@ovro.caltech.edu>
References: <1262820846-13198-1-git-send-email-iws@ovro.caltech.edu>
	<1262820846-13198-9-git-send-email-iws@ovro.caltech.edu>
	<4B6892F4.9070906@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4B6892F4.9070906@intel.com>
Cc: "R58472@freescale.com" <R58472@freescale.com>,
	"B04825@freescale.com" <B04825@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"scottwood@freescale.com" <scottwood@freescale.com>,
	"Dipen.Dudhat@freescale.com" <Dipen.Dudhat@freescale.com>,
	"Maneesh.Gupta@freescale.com" <Maneesh.Gupta@freescale.com>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 02, 2010 at 02:02:44PM -0700, Dan Williams wrote:
> Ira W. Snyder wrote:
> > Fix locking. Use two queues in the driver, one for pending transacions, and
> > one for transactions which are actually running on the hardware. Call
> > dma_run_dependencies() on descriptor cleanup so that the async_tx API works
> > correctly.
> 
> I notice that fsldma diverges from other dma drivers in that the 
> callback is performed with interrupts disabled.  MD/raid5 currently 
> assumes that interrupts are enabled in its callback routines (see 
> ops_complete_biofill()'s use of spin_lock_irq()).  On top of these 
> changes can we align fsldma to the other raid offload drivers (mv_xor, 
> iop-adma, ioatdma) and provide callbacks with irq's enabled?
> 
> I'll proceed with applying these patches as they obviously improve 
> things, but you will hit the irq problem when performing reads to a 
> degraded array.
> 

In the fsldma driver, all callbacks are run from tasklet (softirq)
context. That's under local_irq_disable(), right? Hardirq's certainly
aren't disabled there.

Is a DMAEngine user expected to call the device_is_tx_complete()
function until it returns that the DMA has completed?

If so, it is pretty easy to switch to a workqueue instead of a tasklet
to handle the callbacks. The cost is increased latency until the
callbacks are processed.

Would you want a driver-wide singlethreaded workqueue? A driver-wide
multi-threaded workqueue? A workqueue per-device? A workqueue
per-channel? This starts to get excessive, IMO.

Ira
