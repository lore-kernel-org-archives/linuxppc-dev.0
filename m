Return-Path: <msm@freescale.com>
Received: from TX2EHSOBE010.bigfish.com (tx2ehsobe005.messaging.microsoft.com
	[65.55.88.15]) by ozlabs.org (Postfix) with ESMTP id 34B33B6F01
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Aug 2010 15:12:21 +1000 (EST)
From: Matthew McClintock <msm@freescale.com>
To: kexec@lists.infradead.org
Subject: [PATCH v2 2/3] Prevent multiple reservations for cpu-release-addr
Date: Wed, 18 Aug 2010 23:56:50 -0500
Message-ID: <1282193811-23098-3-git-send-email-msm@freescale.com>
In-Reply-To: <20100819042023.GC13965@verge.net.au>
References: <20100819042023.GC13965@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain
Cc: muvarov@gmail.com, linuxppc-dev@ozlabs.org,
	Kumar Gala <kumar.gala@freescale.com>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
	Matthew McClintock <msm@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, we can add a lot of reservations over a small range, this
does a simple check to verify the previous entry is not the same
as the current one and skips it if so

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 kexec/arch/ppc/fixup_dtb.c |   28 +++++++++++++++++-----------
 1 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/kexec/arch/ppc/fixup_dtb.c b/kexec/arch/ppc/fixup_dtb.c
index 09f9ac1..910a3f0 100644
--- a/kexec/arch/ppc/fixup_dtb.c
+++ b/kexec/arch/ppc/fixup_dtb.c
@@ -139,6 +139,7 @@ static void fixup_reserve_regions(struct kexec_info *info, char *blob_buf, off_t
 {
 	int ret, i;
 	int nodeoffset;
+	u64 val = 0;
 
 	/* If this is a KEXEC kernel we add all regions since they will
 	 * all need to be saved */
@@ -175,20 +176,25 @@ static void fixup_reserve_regions(struct kexec_info *info, char *blob_buf, off_t
 	while (nodeoffset != -FDT_ERR_NOTFOUND) {
 		const void *buf;
 		int sz, ret;
-		u64 val = 0;
+		u64 tmp;
 
 		buf = fdt_getprop(blob_buf, nodeoffset, "cpu-release-addr", &sz);
-		if (sz == 4) {
-			val = *(u32 *)buf;
-		} else if (sz == 8) {
-			val = *(u64 *)buf;
-		}
 
-		if (val) {
-			ret = fdt_add_mem_rsv(blob_buf, PAGE_ALIGN(val-PAGE_SIZE), PAGE_SIZE);
-			if (ret)
-				printf("%s: Unable to add reserve for cpu-release-addr!\n",
-					fdt_strerror(ret));
+		if (buf) {
+			if (sz == 4) {
+				tmp = *(u32 *)buf;
+			} else if (sz == 8) {
+				tmp = *(u64 *)buf;
+			}
+
+			/* crude check to see if last value is repeated */
+			if (_ALIGN_DOWN(tmp, PAGE_SIZE) != _ALIGN_DOWN(val, PAGE_SIZE)) {
+				val = tmp;
+				ret = fdt_add_mem_rsv(blob_buf, _ALIGN_DOWN(val, PAGE_SIZE), PAGE_SIZE);
+				if (ret)
+					printf("%s: Unable to add reserve for cpu-release-addr!\n",
+						fdt_strerror(ret));
+			}
 		}
 
 		nodeoffset = fdt_node_offset_by_prop_value(blob_buf, nodeoffset,
-- 
1.6.0.6
