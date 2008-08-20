Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from VA3EHSOBE001.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 9B102DE17C
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 06:19:15 +1000 (EST)
Message-ID: <48AC7C30.3040608@am.sony.com>
Date: Wed, 20 Aug 2008 13:18:56 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 4/4] powerpc/ps3: Fix ioremap of spu shadow regs
References: <48AC78BA.3070902@am.sony.com>
In-Reply-To: <48AC78BA.3070902@am.sony.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Masakazu Mokuno <mokuno@sm.sony.co.jp>

Fix the ioremap of the spu shadow regs on the PS3.

The current PS3 hypervisor requires the spu shadow regs to be
mapped with the PTE page protection bits set as read-only (PP=3).
This implementation uses the low level __ioremap() to bypass the
page protection settings inforced by ioremap_flags() to get the
needed PTE bits set for the shadow regs.

This fixes a runtime failure on the PS3 introduced by the powerpc
ioremap_prot rework of commit a1f242ff460e4b50a045fa237c3c56cce9eabf83.

Signed-off-by: Masakazu Mokuno <mokuno@sm.sony.co.jp>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/spu.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

--- a/arch/powerpc/platforms/ps3/spu.c
+++ b/arch/powerpc/platforms/ps3/spu.c
@@ -186,14 +186,24 @@ static void spu_unmap(struct spu *spu)
 	iounmap(spu_pdata(spu)->shadow);
 }
 
+/**
+ * setup_areas - Map the spu regions into the address space.
+ *
+ * The current HV requires the spu shadow regs to be mapped with the
+ * PTE page protection bits set as read-only (PP=3).  This implementation
+ * uses the low level __ioremap() to bypass the page protection settings
+ * inforced by ioremap_flags() to get the needed PTE bits set for the
+ * shadow regs.
+ */
+
 static int __init setup_areas(struct spu *spu)
 {
 	struct table {char* name; unsigned long addr; unsigned long size;};
+	static const unsigned long shadow_flags = _PAGE_NO_CACHE | 3;
 
-	spu_pdata(spu)->shadow = ioremap_flags(spu_pdata(spu)->shadow_addr,
-					       sizeof(struct spe_shadow),
-					       pgprot_val(PAGE_READONLY) |
-					       _PAGE_NO_CACHE);
+	spu_pdata(spu)->shadow = __ioremap(spu_pdata(spu)->shadow_addr,
+					   sizeof(struct spe_shadow),
+					   shadow_flags);
 	if (!spu_pdata(spu)->shadow) {
 		pr_debug("%s:%d: ioremap shadow failed\n", __func__, __LINE__);
 		goto fail_ioremap;

-- 
