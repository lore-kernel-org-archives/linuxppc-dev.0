Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkBdh03dfzDqrm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:04:56 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkBdc6lR8z9s9Z
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 15:04:51 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 09/41] powerpc: Update obsolete comments in setup_32.c about
 entry conditions
Date: Tue,  5 Jul 2016 15:03:45 +1000
Message-Id: <1467695057-12431-10-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
References: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

early_init() is called in-place before kernel relocation and using
whatever MMU setup exists at the point the kernel is entered.

machine_init() is called after relocation and after some initial
mapping of PAGE_OFFSET has been established (typically using BATs
on 6xx/7xx/7xxx processors or some form of bolted TLB on others).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/setup_32.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 34e61d68..3f0aca2 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -61,9 +61,7 @@ int icache_bsize;
 int ucache_bsize;
 
 /*
- * We're called here very early in the boot.  We determine the machine
- * type and call the appropriate low-level setup functions.
- *  -- Cort <cort@fsmlabs.com>
+ * We're called here very early in the boot.
  *
  * Note that the kernel may be running at an address which is different
  * from the address that it was linked at, so we must use RELOC/PTRRELOC
@@ -91,6 +89,10 @@ notrace unsigned long __init early_init(unsigned long dt_ptr)
 
 
 /*
+ * This is run before start_kernel(), the kernel has been relocated
+ * and we are running with enough of the MMU enabled to have our
+ * proper kernel virtual addresses
+ *
  * Find out what kind of machine we're on and save any data we need
  * from the early boot process (devtree is copied on pmac by prom_init()).
  * This is called very early on the boot process, after a minimal
-- 
2.7.4
