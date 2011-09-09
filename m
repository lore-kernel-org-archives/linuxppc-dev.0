Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 157F6B6FA6
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Sep 2011 22:11:05 +1000 (EST)
Received: from mail1.transmode.se (mail1.transmode.se [192.168.201.18])
	by gw1.transmode.se (Postfix) with ESMTP id D22A8258283
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Sep 2011 14:11:00 +0200 (CEST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Optimize __arch_swab32 and __arch_swab16
Date: Fri, 9 Sep 2011 14:10:58 +0200
Message-Id: <1315570258-12275-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PPC __arch_swab32 and __arch_swab16 generates non optimal code.
They do not schedule very well, need to copy its input register
and swab16 needs an extra insn to clear its upper bits.
Fix this with better inline ASM.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/powerpc/include/asm/swab.h |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/swab.h b/arch/powerpc/include/asm/swab.h
index c581e3e..3b9a200 100644
--- a/arch/powerpc/include/asm/swab.h
+++ b/arch/powerpc/include/asm/swab.h
@@ -61,25 +61,25 @@ static inline void __arch_swab32s(__u32 *addr)
 
 static inline __attribute_const__ __u16 __arch_swab16(__u16 value)
 {
-	__u16 result;
-
-	__asm__("rlwimi %0,%1,8,16,23"
-	    : "=r" (result)
-	    : "r" (value), "0" (value >> 8));
-	return result;
+	__asm__("rlwimi %0,%0,16,0x00ff0000\n\t"
+		"rlwinm %0,%0,24,0x0000ffff"
+		: "+r"(value));
+	return value;
 }
 #define __arch_swab16 __arch_swab16
 
 static inline __attribute_const__ __u32 __arch_swab32(__u32 value)
 {
-	__u32 result;
-
-	__asm__("rlwimi %0,%1,24,16,23\n\t"
-	    "rlwimi %0,%1,8,8,15\n\t"
-	    "rlwimi %0,%1,24,0,7"
-	    : "=r" (result)
-	    : "r" (value), "0" (value >> 24));
-	return result;
+	__u32 tmp;
+
+	__asm__("rlwimi %0,%1,24,0xffffffff"
+		: "=r" (value) : "r" (value));
+	tmp = value;
+	__asm__("rlwimi %0,%1,16,0x00ff0000"
+		: "+r" (value) : "r" (tmp));
+	__asm__("rlwimi %0,%1,16,0x000000ff"
+		: "+r" (value) : "r" (tmp));
+	return value;
 }
 #define __arch_swab32 __arch_swab32
 
-- 
1.7.3.4
