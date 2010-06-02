Return-Path: <paulus@ozlabs.org>
Date: Wed, 2 Jun 2010 15:33:08 +1000
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] agp/uninorth: Fix oops caused by flushing too much
Message-ID: <20100602053308.GA24509@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org,
	Michel =?iso-8859-1?Q?D=E4nzer?= <daenzer@vmware.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes a sporadic oops at boot on G5 Power Macs.  The table_end
variable has the address of the last byte of the table.  Adding on
PAGE_SIZE means we flush too much, and if the page after the table
is not mapped for any reason, the kernel will oops.  Instead we add
on 1 because flush_dcache_range() interprets its second argument as
the first byte past the range to be flushed.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff --git a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-agp.c
index 6f48931..9aaa0eb 100644
--- a/drivers/char/agp/uninorth-agp.c
+++ b/drivers/char/agp/uninorth-agp.c
@@ -413,7 +413,7 @@ static int uninorth_create_gatt_table(struct agp_bridge_data *bridge)
 	bridge->gatt_table_real = (u32 *) table;
 	/* Need to clear out any dirty data still sitting in caches */
 	flush_dcache_range((unsigned long)table,
-			   (unsigned long)(table_end + PAGE_SIZE));
+			   (unsigned long)table_end + 1);
 	bridge->gatt_table = vmap(pages, (1 << page_order), 0, PAGE_KERNEL_NCG);
 
 	if (bridge->gatt_table == NULL)
