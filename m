Return-Path: <dan.j.williams@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by ozlabs.org (Postfix) with ESMTP id C9F1CB7D3B
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Feb 2010 08:02:47 +1100 (EST)
Message-ID: <4B6892F4.9070906@intel.com>
Date: Tue, 02 Feb 2010 14:02:44 -0700
From: Dan Williams <dan.j.williams@intel.com>
MIME-Version: 1.0
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH 8/8] fsldma: major cleanups and fixes
References: <1262820846-13198-1-git-send-email-iws@ovro.caltech.edu>
	<1262820846-13198-9-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1262820846-13198-9-git-send-email-iws@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Ira W. Snyder wrote:
> Fix locking. Use two queues in the driver, one for pending transacions, and
> one for transactions which are actually running on the hardware. Call
> dma_run_dependencies() on descriptor cleanup so that the async_tx API works
> correctly.

I notice that fsldma diverges from other dma drivers in that the 
callback is performed with interrupts disabled.  MD/raid5 currently 
assumes that interrupts are enabled in its callback routines (see 
ops_complete_biofill()'s use of spin_lock_irq()).  On top of these 
changes can we align fsldma to the other raid offload drivers (mv_xor, 
iop-adma, ioatdma) and provide callbacks with irq's enabled?

I'll proceed with applying these patches as they obviously improve 
things, but you will hit the irq problem when performing reads to a 
degraded array.

--
Dan
