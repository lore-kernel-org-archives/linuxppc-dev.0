Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 341D41A11B5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Dec 2015 16:14:15 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	benh@kernel.crashing.org,
	bharata@linux.vnet.ibm.com
Cc: thuth@redhat.com, lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [RFC 1/3] pseries: Add hypercall wrappers for hash page table resizing
Date: Tue, 22 Dec 2015 16:14:56 +1100
Message-Id: <1450761298-12172-2-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1450761298-12172-1-git-send-email-david@gibson.dropbear.id.au>
References: <1450761298-12172-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds the hypercall numbers and wrapper functions for the hash page
table resizing hypercalls.

These are experimental "platform specific" values for now, until we have a
formal PAPR update.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/hvcall.h         |  2 ++
 arch/powerpc/include/asm/plpar_wrappers.h | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 85bc8c0..ae1fcb7 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -273,6 +273,8 @@
 
 /* Platform specific hcalls, used by KVM */
 #define H_RTAS			0xf000
+#define H_RESIZE_HPT_PREPARE	0xf003
+#define H_RESIZE_HPT_COMMIT	0xf004
 
 /* "Platform specific hcalls", provided by PHYP */
 #define H_GET_24X7_CATALOG_PAGE	0xF078
diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
index 67859ed..8f1d8fe 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -225,6 +225,18 @@ static inline long plpar_pte_protect(unsigned long flags, unsigned long ptex,
 	return plpar_hcall_norets(H_PROTECT, flags, ptex, avpn);
 }
 
+static inline long plpar_resize_hpt_prepare(unsigned long flags,
+					    unsigned long shift)
+{
+	return plpar_hcall_norets(H_RESIZE_HPT_PREPARE, flags, shift);
+}
+
+static inline long plpar_resize_hpt_commit(unsigned long flags,
+					   unsigned long shift)
+{
+	return plpar_hcall_norets(H_RESIZE_HPT_COMMIT, flags, shift);
+}
+
 static inline long plpar_tce_get(unsigned long liobn, unsigned long ioba,
 		unsigned long *tce_ret)
 {
-- 
2.5.0
