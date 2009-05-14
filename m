Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 31EFEDE04E
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 02:13:56 +1000 (EST)
Date: Thu, 14 May 2009 09:13:53 -0700
From: Ira Snyder <iws@ovro.caltech.edu>
To: Dan Williams <dan.j.williams@intel.com>, Li Yang <leoli@freescale.com>,
	Zhang Wei <wei.zhang@freescale.com>, linuxppc-dev@ozlabs.org
Subject: [RFC] Using the DMAEngine API for scatter/gather operations
Message-ID: <20090514161353.GA4379@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello all.

I'm working on a driver for a custom board (based heavily on the
MPC8349EMDS board) to dump data out of onboard FPGA's. I need to use the
onboard DMA controller for this, mostly due to data transfer rate and
timing requirements.

Of course, I'd like to "play nice" with the existing Linux
infrastructure in my driver, even though I have no plans to submit the
driver upstream (since it is only useful for our custom board).

I have been using the DMAEngine API to interact with the DMA controller,
and it works without any problems. However it seems that it is missing
one of the major features that is supported by almost all DMA
controllers: scatter/gather support.

What I'd really like to do is give the controller a scatterlist and list
of hardware addresses, and have it set up the transfer. The Freescale
hardware can handle this, and I could program it by hand to do so, but I
don't want to invent my own DMA API.

I'm aware that the DMAEngine API was designed to offload memcpy, and
pretty much nothing else. Is there any chance that such a change would
be accepted into the mainline kernel? Any opinions on what such an API
should look like?

Thanks,
Ira
