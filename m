Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 619B51A017A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 12:29:04 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B6ED1140081
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2014 12:29:03 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id s5O2Suwc004261
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2014 21:28:59 -0500
Message-ID: <1403576936.4587.145.camel@pasglop>
Subject: [PATCH] powerpc: Remove __arch_swab*
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Date: Tue, 24 Jun 2014 12:28:56 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The generic code uses gcc built-ins which work fine so there's no benefit
in implementing our own anymore.

We can't completely remove the ld/st_le* functions as some historical
cruft still uses them, but that's next on the radar

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/include/asm/swab.h b/arch/powerpc/include/asm/swab.h
index b9bd1ca..96f59de 100644
--- a/arch/powerpc/include/asm/swab.h
+++ b/arch/powerpc/include/asm/swab.h
@@ -9,10 +9,6 @@
 
 #include <uapi/asm/swab.h>
 
-#ifdef __GNUC__
-#ifndef __powerpc64__
-#endif /* __powerpc64__ */
-
 static __inline__ __u16 ld_le16(const volatile __u16 *addr)
 {
 	__u16 val;
@@ -20,19 +16,12 @@ static __inline__ __u16 ld_le16(const volatile __u16 *addr)
 	__asm__ __volatile__ ("lhbrx %0,0,%1" : "=r" (val) : "r" (addr), "m" (*addr));
 	return val;
 }
-#define __arch_swab16p ld_le16
 
 static __inline__ void st_le16(volatile __u16 *addr, const __u16 val)
 {
 	__asm__ __volatile__ ("sthbrx %1,0,%2" : "=m" (*addr) : "r" (val), "r" (addr));
 }
 
-static inline void __arch_swab16s(__u16 *addr)
-{
-	st_le16(addr, *addr);
-}
-#define __arch_swab16s __arch_swab16s
-
 static __inline__ __u32 ld_le32(const volatile __u32 *addr)
 {
 	__u32 val;
@@ -40,42 +29,10 @@ static __inline__ __u32 ld_le32(const volatile __u32 *addr)
 	__asm__ __volatile__ ("lwbrx %0,0,%1" : "=r" (val) : "r" (addr), "m" (*addr));
 	return val;
 }
-#define __arch_swab32p ld_le32
 
 static __inline__ void st_le32(volatile __u32 *addr, const __u32 val)
 {
 	__asm__ __volatile__ ("stwbrx %1,0,%2" : "=m" (*addr) : "r" (val), "r" (addr));
 }
 
-static inline void __arch_swab32s(__u32 *addr)
-{
-	st_le32(addr, *addr);
-}
-#define __arch_swab32s __arch_swab32s
-
-static inline __attribute_const__ __u16 __arch_swab16(__u16 value)
-{
-	__u16 result;
-
-	__asm__("rlwimi %0,%1,8,16,23"
-	    : "=r" (result)
-	    : "r" (value), "0" (value >> 8));
-	return result;
-}
-#define __arch_swab16 __arch_swab16
-
-static inline __attribute_const__ __u32 __arch_swab32(__u32 value)
-{
-	__u32 result;
-
-	__asm__("rlwimi %0,%1,24,16,23\n\t"
-	    "rlwimi %0,%1,8,8,15\n\t"
-	    "rlwimi %0,%1,24,0,7"
-	    : "=r" (result)
-	    : "r" (value), "0" (value >> 24));
-	return result;
-}
-#define __arch_swab32 __arch_swab32
-
-#endif /* __GNUC__ */
 #endif /* _ASM_POWERPC_SWAB_H */
