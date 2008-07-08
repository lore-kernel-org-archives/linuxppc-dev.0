Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 47DE5DE116
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 05:00:16 +1000 (EST)
Date: Tue, 8 Jul 2008 15:00:10 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: support nand boot for rev A warps
Message-ID: <20080708150010.3988395d@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch is against linux-next.

Allow the Rev A Warp boards to boot from NAND.

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---

diff --git a/arch/powerpc/platforms/44x/warp-nand.c b/arch/powerpc/platforms/44x/warp-nand.c
index 7bec281..e55746b 100644
--- a/arch/powerpc/platforms/44x/warp-nand.c
+++ b/arch/powerpc/platforms/44x/warp-nand.c
@@ -113,9 +113,14 @@ static int warp_setup_nand_flash(void)
 		pp = of_find_property(np, "reg", NULL);
 		if (pp && (pp->length == 12)) {
 			u32 *v = pp->value;
-			if (v[2] == 0x4000000)
+			if (v[2] == 0x4000000) {
 				/* Rev A = 64M NAND */
-				warp_nand_chip0.nr_partitions = 2;
+				warp_nand_chip0.nr_partitions = 3;
+
+				nand_parts[1].size   = 0x3000000;
+				nand_parts[2].offset = 0x3200000;
+				nand_parts[2].size   = 0x0e00000;
+			}
 		}
 		of_node_put(np);
 	}
