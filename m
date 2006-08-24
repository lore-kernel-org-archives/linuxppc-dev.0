Return-Path: <tim.martin@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id 498F067C47
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 09:08:44 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Cache coherency question
Date: Thu, 24 Aug 2006 16:08:42 -0700
Message-ID: <821B2170E9E7F04FA38DF7EC21DE487106282397@VCAEXCH01.hq.corp.viasat.com>
From: "Martin, Tim" <tim.martin@viasat.com>
To: "ppc" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm using an MVME6100 with Linux 2.6.14 and experiencing what I think is
a cache coherency problem.  An external PCIX master performs a DMA
transfer of a well known data pattern into SDRAM, but when the device
driver goes to look at the data it is mostly okay, but occasionally has
garbage.

I'm allocating the memory using alloc_skb, then giving a PCI translated
pointer to the PCIX master.  Since I think it is a cache coherency
problem, I tried to use the dma_cache_inv macro to invalidate the cache
before looking at the data, but realized that for this board, that
function does nothing since CONFIG_NOT_COHERENT_CACHE is undefined.  So
questions:

1) Should the processor bus cache snooping actually work on an MVME6100?
E.g. is it correct that CONFIG_NOT_COHERENT_CACHE is undefined?
1a) Does this type of bus snooping work when a bus master physically
external to the PowerPC chip is doing the transfer?

2) If this really is a cache coherency problem, are there other cache
management functions available in ppc linux besides the dma_cache_inv,
dma_cache_wback, dma_cache_wback_inv macros I should be looking at?

Tim
