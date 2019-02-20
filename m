Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2740EC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 17:50:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1D7D2146E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 17:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="D6tDbETa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D7D2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444QBD23LTzDqCX
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 04:50:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="D6tDbETa"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444Pjb5RFlzDqGc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 04:29:23 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 444PjW0Bqrz9v0vw;
 Wed, 20 Feb 2019 18:29:19 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=D6tDbETa; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id I4vGgr5Z7gP4; Wed, 20 Feb 2019 18:29:18 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 444PjV6Cbxz9v0vr;
 Wed, 20 Feb 2019 18:29:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550683758; bh=2nXAYfjXQu9r5qvUDZpDsavDOqAgv/oXiELTI0A1Pwg=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=D6tDbETabQecGS7emHRPCslGXiv2Qa1nNil12vGjHrjA5I6YOzCiXRH3q/wyiRDpk
 VBCTb22SLpvUN+hWwlUyoePqx2SzOGK3wC+NoDLqz8kJJEr2Lb2342Corrwkmt/XAb
 +NaS+Wm8dzPOdH7pXfDeEr6Z01FFHqdRQEZTaAx0=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 82B448B84F;
 Wed, 20 Feb 2019 18:29:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id oEcDr4UwveV5; Wed, 20 Feb 2019 18:29:20 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5DFCA8B84A;
 Wed, 20 Feb 2019 18:29:20 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 4ED126E85E; Wed, 20 Feb 2019 17:29:20 +0000 (UTC)
Message-Id: <069793d48eb84c2ac9d80a51c5993bcd77d3bb9f.1550648295.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550648295.git.christophe.leroy@c-s.fr>
References: <cover.1550648295.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 13/16] powerpc/mm/32s: Use BATs for STRICT_KERNEL_RWX
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 j.neuschaefer@gmx.net
Date: Wed, 20 Feb 2019 17:29:20 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Today, STRICT_KERNEL_RWX is based on the use of regular pages
to map kernel pages.

On Book3s 32, it has three consequences:
- Using pages instead of BAT for mapping kernel linear memory severely
impacts performance.
- Exec protection is not effective because no-execute cannot be set at
page level (except on 603 which doesn't have hash tables)
- Write protection is not effective because PP bits do not provide RO
mode for kernel-only pages (except on 603 which handles it in software
via PAGE_DIRTY)

On the 603+, we have:
- Independent IBAT and DBAT allowing limitation of exec parts.
- NX bit can be set in segment registers to forbit execution on memory
mapped by pages.
- RO mode on DBATs even for kernel-only blocks.

On the 601, there is nothing much we can do other than warn the user
about it, because:
- BATs are common to instructions and data.
- BAT do not provide RO mode for kernel-only blocks.
- segment registers don't have the NX bit.

In order to use IBAT for exec protection, this patch:
- Aligns _etext to BAT block sizes (128kb)
- Set NX bit in kernel segment register (Except on vmalloc area when
CONFIG_MODULES is selected)
- Maps kernel text with IBATs.

In order to use DBAT for exec protection, this patch:
- Aligns RW DATA to BAT block sizes (4M)
- Maps kernel RO area with write prohibited DBATs
- Maps remaining memory with remaining DBATs

Here is what we get with this patch on a 832x when activating
STRICT_KERNEL_RWX:

Symbols:
c0000000 T _stext
c0680000 R __start_rodata
c0680000 R _etext
c0800000 T __init_begin
c0800000 T _sinittext

~# cat /sys/kernel/debug/block_address_translation
---[ Instruction Block Address Translation ]---
0: 0xc0000000-0xc03fffff 0x00000000 Kernel EXEC coherent
1: 0xc0400000-0xc05fffff 0x00400000 Kernel EXEC coherent
2: 0xc0600000-0xc067ffff 0x00600000 Kernel EXEC coherent
3:         -
4:         -
5:         -
6:         -
7:         -

---[ Data Block Address Translation ]---
0: 0xc0000000-0xc07fffff 0x00000000 Kernel RO coherent
1: 0xc0800000-0xc0ffffff 0x00800000 Kernel RW coherent
2: 0xc1000000-0xc1ffffff 0x01000000 Kernel RW coherent
3: 0xc2000000-0xc3ffffff 0x02000000 Kernel RW coherent
4: 0xc4000000-0xc7ffffff 0x04000000 Kernel RW coherent
5: 0xc8000000-0xcfffffff 0x08000000 Kernel RW coherent
6: 0xd0000000-0xdfffffff 0x10000000 Kernel RW coherent
7:         -

~# cat /sys/kernel/debug/segment_registers
---[ User Segments ]---
0x00000000-0x0fffffff Kern key 1 User key 1 VSID 0xa085d0
0x10000000-0x1fffffff Kern key 1 User key 1 VSID 0xa086e1
0x20000000-0x2fffffff Kern key 1 User key 1 VSID 0xa087f2
0x30000000-0x3fffffff Kern key 1 User key 1 VSID 0xa08903
0x40000000-0x4fffffff Kern key 1 User key 1 VSID 0xa08a14
0x50000000-0x5fffffff Kern key 1 User key 1 VSID 0xa08b25
0x60000000-0x6fffffff Kern key 1 User key 1 VSID 0xa08c36
0x70000000-0x7fffffff Kern key 1 User key 1 VSID 0xa08d47
0x80000000-0x8fffffff Kern key 1 User key 1 VSID 0xa08e58
0x90000000-0x9fffffff Kern key 1 User key 1 VSID 0xa08f69
0xa0000000-0xafffffff Kern key 1 User key 1 VSID 0xa0907a
0xb0000000-0xbfffffff Kern key 1 User key 1 VSID 0xa0918b

---[ Kernel Segments ]---
0xc0000000-0xcfffffff Kern key 0 User key 1 No Exec VSID 0x000ccc
0xd0000000-0xdfffffff Kern key 0 User key 1 No Exec VSID 0x000ddd
0xe0000000-0xefffffff Kern key 0 User key 1 No Exec VSID 0x000eee
0xf0000000-0xffffffff Kern key 0 User key 1 No Exec VSID 0x000fff

Aligning _etext to 128kb allows to map up to 32Mb text with 8 IBATs:
16Mb + 8Mb + 4Mb + 2Mb + 1Mb + 512kb + 256kb + 128kb (+ 128kb) = 32Mb
(A 9th IBAT is unneeded as 32Mb would need only a single 32Mb block)

Aligning data to 4M allows to map up to 512Mb data with 8 DBATs:
16Mb + 8Mb + 4Mb + 4Mb + 32Mb + 64Mb + 128Mb + 256Mb = 512Mb

Because some processors only have 4 BATs and because some targets need
DBATs for mapping other areas, the following patch will allow to
modify _etext and data alignment.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig                         |  2 +
 arch/powerpc/include/asm/book3s/32/pgtable.h | 11 ++++
 arch/powerpc/mm/init_32.c                    |  4 +-
 arch/powerpc/mm/mmu_decl.h                   |  8 +++
 arch/powerpc/mm/pgtable_32.c                 | 10 +++-
 arch/powerpc/mm/ppc_mmu_32.c                 | 87 ++++++++++++++++++++++++++--
 6 files changed, 112 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index edef40a2b446..640a7cfba9d0 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -727,11 +727,13 @@ config THREAD_SHIFT
 
 config ETEXT_SHIFT
 	int
+	default 17 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
 	default PPC_PAGE_SHIFT
 
 config DATA_SHIFT
 	int
 	default 24 if STRICT_KERNEL_RWX && PPC64
+	default 22 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
 	default PPC_PAGE_SHIFT
 
 config FORCE_MAX_ZONEORDER
diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 49d76adb9bc5..aa8406b8f7ba 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -174,7 +174,18 @@ static inline bool pte_user(pte_t pte)
  * of RAM.  -- Cort
  */
 #define VMALLOC_OFFSET (0x1000000) /* 16M */
+
+/*
+ * With CONFIG_STRICT_KERNEL_RWX, kernel segments are set NX. But when modules
+ * are used, NX cannot be set on VMALLOC space. So vmalloc VM space and linear
+ * memory shall not share segments.
+ */
+#if defined(CONFIG_STRICT_KERNEL_RWX) && defined(CONFIG_MODULES)
+#define VMALLOC_START ((_ALIGN((long)high_memory, 256L << 20) + VMALLOC_OFFSET) & \
+		       ~(VMALLOC_OFFSET - 1))
+#else
 #define VMALLOC_START ((((long)high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1)))
+#endif
 #define VMALLOC_END	ioremap_bot
 
 #ifndef __ASSEMBLY__
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index ee5a430b9a18..bc28995a37ea 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -108,10 +108,8 @@ static void __init MMU_setup(void)
 		__map_without_bats = 1;
 		__map_without_ltlbs = 1;
 	}
-	if (strict_kernel_rwx_enabled()) {
-		__map_without_bats = 1;
+	if (strict_kernel_rwx_enabled())
 		__map_without_ltlbs = 1;
-	}
 }
 
 /*
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 61730023dde3..98fc94affc29 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -165,3 +165,11 @@ unsigned long p_block_mapped(phys_addr_t pa);
 static inline phys_addr_t v_block_mapped(unsigned long va) { return 0; }
 static inline unsigned long p_block_mapped(phys_addr_t pa) { return 0; }
 #endif
+
+#if defined(CONFIG_PPC_BOOK3S_32)
+void mmu_mark_initmem_nx(void);
+void mmu_mark_rodata_ro(void);
+#else
+static inline void mmu_mark_initmem_nx(void) { }
+static inline void mmu_mark_rodata_ro(void) { }
+#endif
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 94bd7d013557..a3ad09c6e277 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -351,7 +351,10 @@ void mark_initmem_nx(void)
 	unsigned long numpages = PFN_UP((unsigned long)_einittext) -
 				 PFN_DOWN((unsigned long)_sinittext);
 
-	change_page_attr(page, numpages, PAGE_KERNEL);
+	if (v_block_mapped((unsigned long)_stext) + 1)
+		mmu_mark_initmem_nx();
+	else
+		change_page_attr(page, numpages, PAGE_KERNEL);
 }
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
@@ -360,6 +363,11 @@ void mark_rodata_ro(void)
 	struct page *page;
 	unsigned long numpages;
 
+	if (v_block_mapped((unsigned long)_sinittext)) {
+		mmu_mark_rodata_ro();
+		return;
+	}
+
 	page = virt_to_page(_stext);
 	numpages = PFN_UP((unsigned long)_etext) -
 		   PFN_DOWN((unsigned long)_stext);
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index 66f1319e8e20..53d9ed576ab5 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -32,6 +32,7 @@
 #include <asm/mmu.h>
 #include <asm/machdep.h>
 #include <asm/code-patching.h>
+#include <asm/sections.h>
 
 #include "mmu_decl.h"
 
@@ -138,15 +139,10 @@ static void clearibat(int index)
 	bat[0].batl = 0;
 }
 
-unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
+unsigned long __init __mmu_mapin_ram(unsigned long base, unsigned long top)
 {
 	int idx;
 
-	if (__map_without_bats) {
-		printk(KERN_DEBUG "RAM mapped without BATs\n");
-		return base;
-	}
-
 	while ((idx = find_free_bat()) != -1 && base != top) {
 		unsigned int size = block_size(base, top);
 
@@ -159,6 +155,85 @@ unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 	return base;
 }
 
+unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
+{
+	int done;
+	unsigned long border = (unsigned long)__init_begin - PAGE_OFFSET;
+
+	if (__map_without_bats) {
+		pr_debug("RAM mapped without BATs\n");
+		return base;
+	}
+
+	if (!strict_kernel_rwx_enabled() || base >= border || top <= border)
+		return __mmu_mapin_ram(base, top);
+
+	done = __mmu_mapin_ram(base, border);
+	if (done != border - base)
+		return done;
+
+	return done + __mmu_mapin_ram(border, top);
+}
+
+void mmu_mark_initmem_nx(void)
+{
+	int nb = mmu_has_feature(MMU_FTR_USE_HIGH_BATS) ? 8 : 4;
+	int i;
+	unsigned long base = (unsigned long)_stext - PAGE_OFFSET;
+	unsigned long top = (unsigned long)_etext - PAGE_OFFSET;
+	unsigned long size;
+
+	if (cpu_has_feature(CPU_FTR_601))
+		return;
+
+	for (i = 0; i < nb - 1 && base < top && top - base > (128 << 10);) {
+		size = block_size(base, top);
+		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_TEXT);
+		base += size;
+	}
+	if (base < top) {
+		size = block_size(base, top);
+		size = max(size, 128UL << 10);
+		if ((top - base) > size) {
+			if (strict_kernel_rwx_enabled())
+				pr_warn("Kernel _etext not properly aligned\n");
+			size <<= 1;
+		}
+		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_TEXT);
+		base += size;
+	}
+	for (; i < nb; i++)
+		clearibat(i);
+
+	update_bats();
+
+	for (i = TASK_SIZE >> 28; i < 16; i++) {
+		/* Do not set NX on VM space for modules */
+		if (IS_ENABLED(CONFIG_MODULES) &&
+		    (VMALLOC_START & 0xf0000000) == i << 28)
+			break;
+		mtsrin(mfsrin(i << 28) | 0x10000000, i << 28);
+	}
+}
+
+void mmu_mark_rodata_ro(void)
+{
+	int nb = mmu_has_feature(MMU_FTR_USE_HIGH_BATS) ? 8 : 4;
+	int i;
+
+	if (cpu_has_feature(CPU_FTR_601))
+		return;
+
+	for (i = 0; i < nb; i++) {
+		struct ppc_bat *bat = BATS[i];
+
+		if (bat_addrs[i].start < (unsigned long)__init_begin)
+			bat[1].batl = (bat[1].batl & ~BPP_RW) | BPP_RX;
+	}
+
+	update_bats();
+}
+
 /*
  * Set up one of the I/D BAT (block address translation) register pairs.
  * The parameters are not checked; in particular size must be a power
-- 
2.13.3

