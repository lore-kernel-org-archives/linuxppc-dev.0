Date: Wed, 12 Mar 2003 13:02:14 -0600
From: Eric Seppanen <eds@reric.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: cache control functions
Message-ID: <20030312130214.A7123@reric.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm writing a driver module, for a pci device that lives in a 405GPr
based system.  I notice that the 405 doesn't seem to have a consistent
cache after the pci device busmasters a bunch of data into SDRAM (or
before it pulls data out), so I think the thing I'm supposed to do is
call (depending on direction) one of these:
 invalidate_dcache_range
 clean_dcache_range
 flush_dcache_range
or what seems to be the equivalent, but cross-platform names
 dma_cache_inv
 dma_cache_wback
 dma_cache_wback_inv
 (these are just macros calling the first three; include/asm-ppc/io.h)

But invalidate_dcache_range and clean_dcache_range are never exported,
so they're unavailable to modules.  (and means that dma_cache_inv and
dma_cache_wback are unavailable as well.)

Is this intentional or an oversight?  I can't see how I can write a
driver for a busmaster device (that will work on a 405) without them.

Eric

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
