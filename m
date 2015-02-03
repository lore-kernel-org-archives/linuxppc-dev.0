Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6AF7B1A0AFE
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 16:36:02 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 agraf@suse.de
Subject: [PATCH 5/5] powerpc: Remove unused st_le*() and ld_le* functions
Date: Tue,  3 Feb 2015 16:36:25 +1100
Message-Id: <1422941785-22557-6-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1422941785-22557-1-git-send-email-david@gibson.dropbear.id.au>
References: <1422941785-22557-1-git-send-email-david@gibson.dropbear.id.au>
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 mdroth@us.ibm.com, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The powerpc specific st_le*() and ld_le*() functions in
arch/powerpc/asm/swab.h no longer have any users.  They are also
misleadingly named, since they always byteswap, even on a little-endian
host.

This patch removes them.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/swab.h | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/powerpc/include/asm/swab.h b/arch/powerpc/include/asm/swab.h
index 96f59de..487e090 100644
--- a/arch/powerpc/include/asm/swab.h
+++ b/arch/powerpc/include/asm/swab.h
@@ -9,30 +9,4 @@
 
 #include <uapi/asm/swab.h>
 
-static __inline__ __u16 ld_le16(const volatile __u16 *addr)
-{
-	__u16 val;
-
-	__asm__ __volatile__ ("lhbrx %0,0,%1" : "=r" (val) : "r" (addr), "m" (*addr));
-	return val;
-}
-
-static __inline__ void st_le16(volatile __u16 *addr, const __u16 val)
-{
-	__asm__ __volatile__ ("sthbrx %1,0,%2" : "=m" (*addr) : "r" (val), "r" (addr));
-}
-
-static __inline__ __u32 ld_le32(const volatile __u32 *addr)
-{
-	__u32 val;
-
-	__asm__ __volatile__ ("lwbrx %0,0,%1" : "=r" (val) : "r" (addr), "m" (*addr));
-	return val;
-}
-
-static __inline__ void st_le32(volatile __u32 *addr, const __u32 val)
-{
-	__asm__ __volatile__ ("stwbrx %1,0,%2" : "=m" (*addr) : "r" (val), "r" (addr));
-}
-
 #endif /* _ASM_POWERPC_SWAB_H */
-- 
2.1.0
