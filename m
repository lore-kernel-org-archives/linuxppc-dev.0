Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF0B51A02D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 15:40:48 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/3] powerpc/vdso: Combine start/size variables
Date: Wed, 22 Apr 2015 15:40:35 +1000
Message-Id: <1429681236-11644-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1429681236-11644-1-git-send-email-mpe@ellerman.id.au>
References: <1429681236-11644-1-git-send-email-mpe@ellerman.id.au>
Cc: scottwood@freescale.com, sam.mj@au1.ibm.com,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In vdso_fixup_features() we have start64/start32 and size64/size32, but
they have the same types, ie. void * and unsigned long.

They're only used to save the return value from find_sectionXX() for the
subsequent call to do_feature_fixups(), so there's no overlap in their
usage either.

So we can just consolidate them into start/size and avoid the
duplication.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/vdso.c | 55 ++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 869fd0c53280..8331d0bef0fb 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -525,55 +525,52 @@ static __init int vdso_fixup_datapage(struct lib32_elfinfo *v32,
 static __init int vdso_fixup_features(struct lib32_elfinfo *v32,
 				      struct lib64_elfinfo *v64)
 {
-	void *start32;
-	unsigned long size32;
+	unsigned long size;
+	void *start;
 
 #ifdef CONFIG_PPC64
-	void *start64;
-	unsigned long size64;
-
-	start64 = find_section64(v64->hdr, "__ftr_fixup", &size64);
-	if (start64)
+	start = find_section64(v64->hdr, "__ftr_fixup", &size);
+	if (start)
 		do_feature_fixups(cur_cpu_spec->cpu_features,
-				  start64, start64 + size64);
+				  start, start + size);
 
-	start64 = find_section64(v64->hdr, "__mmu_ftr_fixup", &size64);
-	if (start64)
+	start = find_section64(v64->hdr, "__mmu_ftr_fixup", &size);
+	if (start)
 		do_feature_fixups(cur_cpu_spec->mmu_features,
-				  start64, start64 + size64);
+				  start, start + size);
 
-	start64 = find_section64(v64->hdr, "__fw_ftr_fixup", &size64);
-	if (start64)
+	start = find_section64(v64->hdr, "__fw_ftr_fixup", &size);
+	if (start)
 		do_feature_fixups(powerpc_firmware_features,
-				  start64, start64 + size64);
+				  start, start + size);
 
-	start64 = find_section64(v64->hdr, "__lwsync_fixup", &size64);
-	if (start64)
+	start = find_section64(v64->hdr, "__lwsync_fixup", &size);
+	if (start)
 		do_lwsync_fixups(cur_cpu_spec->cpu_features,
-				 start64, start64 + size64);
+				 start, start + size);
 #endif /* CONFIG_PPC64 */
 
-	start32 = find_section32(v32->hdr, "__ftr_fixup", &size32);
-	if (start32)
+	start = find_section32(v32->hdr, "__ftr_fixup", &size);
+	if (start)
 		do_feature_fixups(cur_cpu_spec->cpu_features,
-				  start32, start32 + size32);
+				  start, start + size);
 
-	start32 = find_section32(v32->hdr, "__mmu_ftr_fixup", &size32);
-	if (start32)
+	start = find_section32(v32->hdr, "__mmu_ftr_fixup", &size);
+	if (start)
 		do_feature_fixups(cur_cpu_spec->mmu_features,
-				  start32, start32 + size32);
+				  start, start + size);
 
 #ifdef CONFIG_PPC64
-	start32 = find_section32(v32->hdr, "__fw_ftr_fixup", &size32);
-	if (start32)
+	start = find_section32(v32->hdr, "__fw_ftr_fixup", &size);
+	if (start)
 		do_feature_fixups(powerpc_firmware_features,
-				  start32, start32 + size32);
+				  start, start + size);
 #endif /* CONFIG_PPC64 */
 
-	start32 = find_section32(v32->hdr, "__lwsync_fixup", &size32);
-	if (start32)
+	start = find_section32(v32->hdr, "__lwsync_fixup", &size);
+	if (start)
 		do_lwsync_fixups(cur_cpu_spec->cpu_features,
-				 start32, start32 + size32);
+				 start, start + size);
 
 	return 0;
 }
-- 
2.1.0
