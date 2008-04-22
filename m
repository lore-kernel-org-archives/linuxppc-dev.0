Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id 40769DE213
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 10:49:40 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so2249139pyg.27
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 17:49:39 -0700 (PDT)
Subject: [PATCH 1/2] [PPC] 4xx: Fix duplicate phys_addr_t definition
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1208825276.6654.41.camel@vader.jdub.homelinux.org>
References: <1208825276.6654.41.camel@vader.jdub.homelinux.org>
Content-Type: text/plain
Date: Mon, 21 Apr 2008 19:49:34 -0500
Message-Id: <1208825374.6654.44.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: paulus@samba.org
Reply-To: jwboyer@linux.vnet.ibm.com
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
