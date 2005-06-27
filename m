Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F0111679E7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Jun 2005 06:06:21 +1000 (EST)
Date: Mon, 27 Jun 2005 11:28:03 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050627142803.GA9810@logos.cnet>
References: <20050625145318.GA32117@logos.cnet>
	<f14f5f5aebd45879c39c6ce69f29c004@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f14f5f5aebd45879c39c6ce69f29c004@embeddededge.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] 8xx: tlbie debugging aid (try #2)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, Jun 25, 2005 at 06:24:47PM -0400, Dan Malek wrote:

> We really want to see this generate an error.  We shouldn't be
> calling this on any of the pinned spaces.  In the case of initially
> mapping the kernel space, we should set up the page tables but
> not call this far down that we get here.


How about the  following addressing your comments: 

1) handles more than a single contiguous region by having a list_head (I thought of a
binary tree for storing the ranges but sounds like overkill at first given the
small amount of pinned regions).

2) implement as C code.

it yields

_tlbie on pinned range: c0000000-c1800000
Badness in _tlbie at arch/ppc/mm/pgtable.c:527
Call trace:
 [c0005530] dump_stack+0x18/0x28
 [c0003628] check_bug_trap+0x84/0xac
 [c00037b0] ProgramCheckException+0x160/0x1a0
 [c0002d50] ret_from_except_full+0x0/0x4c
 [c000a91c] _tlbie+0x94/0xa0
 [c902f018] alloc_init_module+0x18/0x40 [alloc]
 [c002c4ac] sys_init_module+0x224/0x324
 [c00026f0] ret_from_syscall+0x0/0x44


diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -1296,6 +1296,11 @@ config BOOT_LOAD
 config PIN_TLB
 	bool "Pinned Kernel TLBs (860 ONLY)"
 	depends on ADVANCED_OPTIONS && 8xx
+
+config DEBUG_PIN_TLBIE
+	bool "Check for overlapping TLB invalidates inside the pinned area"
+	depends on ADVANCED_OPTIONS && 8xx && PIN_TLB
+
 endmenu
 
 source "drivers/Kconfig"
diff --git a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
--- a/arch/ppc/kernel/misc.S
+++ b/arch/ppc/kernel/misc.S
@@ -494,7 +494,7 @@ _GLOBAL(_tlbia)
 /*
  * Flush MMU TLB for a particular address
  */
-_GLOBAL(_tlbie)
+_GLOBAL(__tlbie)
 #if defined(CONFIG_40x)
 	tlbsx.	r3, 0, r3
 	bne	10f
diff --git a/arch/ppc/mm/pgtable.c b/arch/ppc/mm/pgtable.c
--- a/arch/ppc/mm/pgtable.c
+++ b/arch/ppc/mm/pgtable.c
@@ -32,6 +32,7 @@
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/io.h>
+#include <asm/tlb.h>
 
 #include "mmu_decl.h"
 
@@ -469,3 +470,48 @@ exit:
 	return ret;
 }
 
+#ifndef CONFIG_DEBUG_PIN_TLBIE
+
+void _tlbie(unsigned long address)
+{
+	__tlbie(address);
+}
+
+#else
+LIST_HEAD(pin_range_root);
+
+static struct pinned_range kernelbase = { 
+		start:	KERNELBASE,
+		end:	KERNELBASE+0x1800000,
+};
+
+static struct pinned_range immr = { 
+		start:	IMMR,
+		end:	IMMR+0x800000,
+};
+
+inline void register_pinned_entries(void)
+{
+	list_add(&kernelbase.pin_list, &pin_range_root);
+	list_add(&immr.pin_list, &pin_range_root);
+}
+
+void _tlbie(unsigned long address)
+{
+        struct list_head *l;
+        struct pinned_range *r;
+
+        list_for_each(l, &pin_range_root) {
+                r = list_entry(l, struct pinned_range, pin_list);
+
+                if (address < r->start)
+                        continue;
+                if (address >= r->end)
+                        continue;
+                printk("_tlbie on pinned range: %lx-%lx\n", r->start, r->end);
+                WARN_ON(1);
+        }
+
+	__tlbie(address);
+}
+#endif
diff --git a/include/asm-ppc/tlb.h b/include/asm-ppc/tlb.h
--- a/include/asm-ppc/tlb.h
+++ b/include/asm-ppc/tlb.h
@@ -18,6 +18,18 @@
 #include <asm/page.h>
 #include <asm/mmu.h>
 
+#ifdef CONFIG_DEBUG_PIN_TLBIE
+struct pinned_range {
+	unsigned long start, end;
+	struct list_head pin_list;
+};
+inline void register_pinned_entries(void);
+#else
+inline void register_pinned_entries(void)
+{
+	return;
+}
+#endif
 #ifdef CONFIG_PPC_STD_MMU
 /* Classic PPC with hash-table based MMU... */
 
diff --git a/include/asm-ppc/tlbflush.h b/include/asm-ppc/tlbflush.h
--- a/include/asm-ppc/tlbflush.h
+++ b/include/asm-ppc/tlbflush.h
@@ -13,9 +13,14 @@
 #include <linux/config.h>
 #include <linux/mm.h>
 
+extern void __tlbie(unsigned long address);
 extern void _tlbie(unsigned long address);
 extern void _tlbia(void);
 
+#ifdef CONFIG_DEBUG_PIN_TLBIE
+extern struct list_head pin_range_root;
+#endif
+
 #if defined(CONFIG_4xx)
 
 #ifndef CONFIG_44x
