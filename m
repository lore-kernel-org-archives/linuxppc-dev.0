Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id D9B18B6F0D
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Mar 2011 04:16:29 +1100 (EST)
Date: Mon, 28 Feb 2011 09:16:24 -0800
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: [PATCH 0/8] fsldma: lockup fixes
Message-ID: <20110228171624.GA24900@ovro.caltech.edu>
References: <4D6B88C6.2000404@embedded-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D6B88C6.2000404@embedded-sol.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 28, 2011 at 01:36:38PM +0200, Felix Radensky wrote:
> Hi Ira,
> 
> I've tried your patches with linux-2.6.38-rc6 on P2020RDB.
> DMA test fails with the following errors if threads_per_chan != 1
> 
> dma0chan0-copy1: terminating after 1 tests, 1 failures (status 0)
> dma0chan0-copy2: #0: test timed out
> 
> I've run the test like this:
> 
> modprobe dmatest threads_per_chan=2 iterations=1
> 

Thanks Felix. This works fine on the 83xx DMA controller. When you have
a chance, can you add "#define DEBUG 1" as the first line of
drivers/dma/fsldma.c and then rerun your test with:

modprobe dmatest threads_per_chan=2 iterations=1 max_channels=1

And send me the dmesg output.

I don't quite understand the difference between links and lists in the
85xx controller yet. I'll work my way through the datasheet this morning
and send out a fixed patch.

Thanks very much for running the tests!

Ira
