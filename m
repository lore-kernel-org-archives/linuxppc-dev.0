Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id A3305DE4AF
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Apr 2008 01:26:21 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so1062849pyg.27
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 08:26:20 -0700 (PDT)
Subject: [PATCH] [PPC] 4xx: Fix arch/ppc 440 builds
From: Josh Boyer <jwboyer@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Sat, 19 Apr 2008 10:26:15 -0500
Message-Id: <1208618775.6654.12.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit d04ceb3fc294ea2c4f538a04343f3a473953a3b0 moved phys_addr_t definitions
to include/asm-powerpc/types.h.  However, arch/ppc 440 builds had a duplicate
definition in include/asm-ppc/mmu.h that caused the build to fail.

This removes the duplicate definition in arch/ppc.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 include/asm-ppc/mmu.h |    2 --
 1 file changed, 2 deletions(-)

--- linux-2.6.orig/include/asm-ppc/mmu.h
+++ linux-2.6/include/asm-ppc/mmu.h
@@ -15,10 +15,8 @@
  * physical need a larger than native word size type. -Matt
  */
 #ifndef CONFIG_PHYS_64BIT
-typedef unsigned long phys_addr_t;
 #define PHYS_FMT	"%.8lx"
 #else
-typedef unsigned long long phys_addr_t;
 extern phys_addr_t fixup_bigphys_addr(phys_addr_t, phys_addr_t);
 #define PHYS_FMT	"%16Lx"
 #endif
