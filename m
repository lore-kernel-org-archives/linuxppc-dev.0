Return-Path: <andrew-lewis@netspace.net.au>
Received: from mail.netspace.net.au (mail-out5.netspace.net.au [203.10.110.92])
	by ozlabs.org (Postfix) with ESMTP id 5D2ADDE041
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 19:50:00 +1000 (EST)
Message-ID: <48636161.6080603@netspace.net.au>
Date: Thu, 26 Jun 2008 17:29:05 +0800
From: Andrew Lewis <andrew-lewis@netspace.net.au>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH/RFC] powerpc: prevent memory corruption due to cache
	invalidation of unaligned DMA buffer
Content-Type: text/plain; charset=ISO-8859-1
Cc: 'Andrew Lewis' <andrew-lewis@netspace.net.au>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On PowerPC processors with non-coherent cache architectures the DMA
subsystem calls invalidate_dcache_range() before performing a DMA read
operation.  If the address and length of the DMA buffer are not aligned
to a cache-line boundary this can result in memory outside of the DMA
buffer being invalidated in the cache.  If this memory has an
uncommitted store then the data will be lost and a subsequent read of
that address will result in an old value being returned from main memory.

Only when the DMA buffer starts on a cache-line boundary and is an exact
mutiple of the cache-line size can invalidate_dcache_range() be called,
otherwise flush_dcache_range() must be called.  flush_dcache_range()
will first flush uncommitted writes, and then invalidate the cache.

Signed-off-by: Andrew Lewis <andrew-lewis at netspace.net.au>
---
This problem was originally observed using SLUB on the ADS5121
development kit for the Freescale MPC5121e SoC.  When booting with a USB
flash disk connected there was a highly intermittent kernel panic where
an attempt was made to dereference an address containing 0x6b6b6b6b, the
SLUB poison marker.

Tracing the origin of the corruption was difficult as modifying the
kernel would often result in the corruption vanishing.  Eventually it
was determined that the SCSI request pointer us->srb->request was being
corrupted from a valid value to 0x6b6b6b6b somewhere in the call to
us->proto_handler(us->srb, us) in usb_stor_control_thread()
(drivers/usb/storage/usb.c).

Further tracing revealed the corruption to be occuring when
invalidate_dcache_range() was called.

The address of us->srb->request was 0xCFAC81EC, while the parameters
passed to invalidate_dcache_range() were start=0xCFAC81F0 and
end=0xCFAC8202.

As these addresses are not on a cache-line boundary,
invalidate_dcache_range() actually invalidates from 0xCFAC81E0 to
0xCFAC82E0.  This results in an uncommitted store at address 0xCFAC81EC
being discarded to be replaced with 0x6b6b6b6b from the SLUB poisoning
which had been committed to main memory.

Applying this patch also corrected random crashes observed when
connecting and disconnecting a ZD1121 Wireless LAN USB adapter.

 dma-noncoherent.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff -upNr linux-2.6.24.6/arch/powerpc/lib/dma-noncoherent.c wk-linux-2.6.24.6/arch/powerpc/lib/dma-noncoherent.c
--- linux-2.6.24.6/arch/powerpc/lib/dma-noncoherent.c	2008-05-02 05:50:00.000000000 +0800
+++ wk-linux-2.6.24.6/arch/powerpc/lib/dma-noncoherent.c	2008-06-25 15:11:25.000000000 +0800
@@ -348,8 +348,15 @@ void __dma_sync(void *vaddr, size_t size
 	switch (direction) {
 	case DMA_NONE:
 		BUG();
-	case DMA_FROM_DEVICE:	/* invalidate only */
-		invalidate_dcache_range(start, end);
+	case DMA_FROM_DEVICE:	
+		/*
+		 * invalidate only when cache-line aligned otherwise there is
+		 * the potential for discarding uncommitted data from the cache
+		 */
+		if ((start & (L1_CACHE_BYTES - 1)) || (size & (L1_CACHE_BYTES - 1)))
+			flush_dcache_range(start, end);
+		else
+			invalidate_dcache_range(start, end);
 		break;
 	case DMA_TO_DEVICE:		/* writeback only */
 		clean_dcache_range(start, end);
