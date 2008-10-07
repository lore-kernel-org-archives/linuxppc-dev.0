Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 80BC0DDDF5
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2008 19:38:47 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org,
 benh@kernel.crashing.org
Subject: [PATCH] powerpc/cell/oprofile: vma_map: fix test on overlay_tbl_offset
Date: Tue, 7 Oct 2008 10:38:33 +0200
References: <1223357268.8157.38.camel@pasglop>
In-Reply-To: <1223357268.8157.38.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810071038.34085.arnd@arndb.de>
Cc: Roel Kluin <12o3l@tiscali.nl>, oprofile-list@lists.sf.net,
	Carl Love <cel@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Roel Kluin <12o3l@tiscali.nl>

Offset is unsigned and when an address isn't found in the vma map
vma_map_lookup() returns the vma physical address + 0x10000000.

vma_map_lookup used to return 0xffffffff on a failed lookup, but
a change was made to return the vma physical address + 0x10000000
There are two callers of vam_map_lookup: one of them correctly 
deals with this new return value, but the other (below) did not.  

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
Acked-by: Maynard Johnson <maynardj@us.ibm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: oprofile-list@lists.sf.net
Cc: Carl Love <cel@us.ibm.com>

--- a/arch/powerpc/oprofile/cell/vma_map.c
+++ b/arch/powerpc/oprofile/cell/vma_map.c
@@ -229,7 +229,7 @@ struct vma_to_fileoffset_map *create_vma_map(const struct spu *aSpu,
 	 */
 	overlay_tbl_offset = vma_map_lookup(map, ovly_table_sym,
 					    aSpu, &grd_val);
-	if (overlay_tbl_offset < 0) {
+	if (overlay_tbl_offset > 0x10000000) {
 		printk(KERN_ERR "SPU_PROF: "
 		       "%s, line %d: Error finding SPU overlay table\n",
 		       __func__, __LINE__);
