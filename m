Return-Path: <clifford@clifford.at>
Received: from phoenix.clifford.at (phoenix.clifford.at [88.198.7.52])
	by ozlabs.org (Postfix) with ESMTP id 034AFDDE1F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jul 2007 19:31:46 +1000 (EST)
Date: Wed, 11 Jul 2007 11:35:34 +0200
From: Clifford Wolf <clifford@clifford.at>
To: linuxppc-embedded@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: Mem-2-Mem DMA - Generalized API
Message-ID: <20070711093534.GA6366@clifford.at>
References: <20070624193932.GA11797@clifford.at>
	<20070625180110.GH20463@clifford.at>
	<20070704090554.GA30693@clifford.at>
	<200707071508.04143.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200707071508.04143.arnd@arndb.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi again,

The updated status of my DMA Transfer API can be found at:

	http://www.clifford.at/priv/dmatransfer-20070711.diff

I have incorporated your feedback and would appreciate if you could have
another look over the updated sourcecode. Changes include:

	- Many cosmetic / coding style related changes

	- Added MPC3494 Scatter/Gather DMA Support

	- Added a 'softdma' driver providing software emulation

	- Added DMATRANSFER_MAYFAIL flag, panic() if a DMA Transfer without
	  this flag set fails.

	- Added /proc/dmatransfer with statistic data

I also have two questions. In the my current source there is the following
hack:

--snip--
	wmb();
	dma_cache_wback_inv(sg_list, sizeof(struct chain_desc) * segment_n);

#if 1
	/* FIXME: dma_cache_wback_inv() should have done this already! */
	{
		void *p = sg_list;
		while (p < ((void*)sg_list) +
				sizeof(struct chain_desc) * segment_n) {
			__asm__ __volatile__ ("dcbf 0,%0" : : "r" (p));
			p += 4;
		}
		__asm__ __volatile__ ("sync");
	}
#endif
--snap--

In my understanding, dma_cache_wback_inv() should do exactly the same thing
as my loop with PowerPC inline assembly. However, if I change the '#if 1'
to '#if 0' in this source it stopps working.

What am I doing wrong? What function should I use instead of
dma_cache_wback_inv() in this place?

> BUG() may be a little harsh here, especially since you are holding spinlocks.
> It would be better to try to recover here, unless you expect actual data
> corruption, in which case a full panic() might be more appropriate.

So what exactly would be the correct usecase of BUG() over panic()?

My impressions was that BUG() would be the right choice for errors coming
from bad programming while panic() would be for errors coming from bad
hardware.

yours,
 - clifford

-- 
For extra security, this message has been encrypted with double-ROT13.
