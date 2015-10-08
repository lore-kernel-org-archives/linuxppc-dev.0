Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E02CC1A0171
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 19:00:37 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 8 Oct 2015 18:00:36 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 133C02CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 19:00:33 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9880O5c64225422
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Oct 2015 19:00:33 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t98800bM011299
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Oct 2015 19:00:00 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2] powerpc: Fix _ALIGN_* errors due to type difference.
Date: Thu,  8 Oct 2015 13:29:28 +0530
Message-Id: <1444291168-2360-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/page.h | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

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
index 71294a6e976e..0711b3188247 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -12,6 +12,7 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
+#include <linux/kernel.h>
 #else
 #include <asm/types.h>
 #endif
@@ -240,8 +241,8 @@ extern long long virt_phys_offset;
 #endif
 
 /* align addr on a size boundary - adjust address up/down if needed */
-#define _ALIGN_UP(addr,size)	(((addr)+((size)-1))&(~((size)-1)))
-#define _ALIGN_DOWN(addr,size)	((addr)&(~((size)-1)))
+#define _ALIGN_UP(addr, size)   __ALIGN_KERNEL(addr, size)
+#define _ALIGN_DOWN(addr, size)	((addr)&(~((typeof(addr))(size)-1)))
 
 /* align addr on a size boundary - adjust address up if needed */
 #define _ALIGN(addr,size)     _ALIGN_UP(addr,size)
-- 
2.5.0
