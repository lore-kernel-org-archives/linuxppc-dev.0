Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E5DCFDDFA2
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2009 13:23:40 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n3K3NLKR017022
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Apr 2009 20:23:32 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n3K3NJff017918
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Apr 2009 22:23:20 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: Potential performance issue on DMA_FROM_DEVICE
Date: Mon, 20 Apr 2009 11:23:17 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB1208928C0D3@zch01exm21.fsl.freescale.net>
From: "Liu Dave-R63238" <DaveLiu@freescale.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guys,

The commit 03d70617 is using the dcbf for all of unaligned start
or non-multi cache line of size. It will cause performance lost
due to dcbf all M-state cache line in the whole address range
(start->end). It causes unnecessary bus traffic (when the mid part
of range with M-state).

However, we actually need care for only unaligned head part and
unaligned tail part of range (start->end).

Patch welcomed.

Thanks, Dave

Ps:
/*
 * make an area consistent.
 */
void __dma_sync(void *vaddr, size_t size, int direction)
{
        unsigned long start =3D (unsigned long)vaddr;
        unsigned long end   =3D start + size;

        switch (direction) {
        case DMA_NONE:
                BUG();
        case DMA_FROM_DEVICE:
                /*
                 * invalidate only when cache-line aligned otherwise
there is
                 * the potential for discarding uncommitted data from
the cache
                 */
                if ((start & (L1_CACHE_BYTES - 1)) || (size &
(L1_CACHE_BYTES - 1)))
                        flush_dcache_range(start, end);
                else
                        invalidate_dcache_range(start, end);
                break;
        case DMA_TO_DEVICE:             /* writeback only */
                clean_dcache_range(start, end);
                break;
        case DMA_BIDIRECTIONAL: /* writeback and invalidate */
                flush_dcache_range(start, end);
                break;
        }
}
EXPORT_SYMBOL(__dma_sync);
