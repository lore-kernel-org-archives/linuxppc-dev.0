Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 97ADB1A010C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Oct 2015 00:34:55 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 3 Oct 2015 00:34:53 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4FCAD357804F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Oct 2015 00:34:47 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t92EYdwN46858436
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 3 Oct 2015 00:34:47 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t92EYE4P016640
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 3 Oct 2015 00:34:14 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: Fix _ALIGN_* errors due to type difference.
Date: Fri,  2 Oct 2015 20:03:48 +0530
Message-Id: <1443796428-11517-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This avoid errors like

        unsigned int usize = 1 << 30;
        int size = 1 << 30;
        unsigned long addr = 64UL << 30 ;

        value = _ALIGN_DOWN(addr, usize); -> 0
        value = _ALIGN_DOWN(addr, size);  -> 0x1000000000

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/boot/page.h        | 4 ++--
 arch/powerpc/include/asm/page.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/page.h b/arch/powerpc/boot/page.h
index 14eca30fef64..87c42d7d283d 100644
--- a/arch/powerpc/boot/page.h
+++ b/arch/powerpc/boot/page.h
@@ -22,8 +22,8 @@
 #define PAGE_MASK	(~(PAGE_SIZE-1))
 
 /* align addr on a size boundary - adjust address up/down if needed */
-#define _ALIGN_UP(addr,size)	(((addr)+((size)-1))&(~((size)-1)))
-#define _ALIGN_DOWN(addr,size)	((addr)&(~((size)-1)))
+#define _ALIGN_UP(addr, size)	(((addr)+((size)-1))&(~((typeof(addr))(size)-1)))
+#define _ALIGN_DOWN(addr, size)	((addr)&(~((typeof(addr))(size)-1)))
 
 /* align addr on a size boundary - adjust address up if needed */
 #define _ALIGN(addr,size)     _ALIGN_UP(addr,size)
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 71294a6e976e..1dd69774a31c 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -240,8 +240,8 @@ extern long long virt_phys_offset;
 #endif
 
 /* align addr on a size boundary - adjust address up/down if needed */
-#define _ALIGN_UP(addr,size)	(((addr)+((size)-1))&(~((size)-1)))
-#define _ALIGN_DOWN(addr,size)	((addr)&(~((size)-1)))
+#define _ALIGN_UP(addr, size)	(((addr)+((size)-1))&(~((typeof(addr))(size)-1)))
+#define _ALIGN_DOWN(addr, size)	((addr)&(~((typeof(addr))(size)-1)))
 
 /* align addr on a size boundary - adjust address up if needed */
 #define _ALIGN(addr,size)     _ALIGN_UP(addr,size)
-- 
2.5.0
