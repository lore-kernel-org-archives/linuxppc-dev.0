Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9EAC07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 17:47:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A654A20838
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 17:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A654A20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43BKfm5vNhzF0PZ
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 04:47:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43BKcV6t8kzF0Bm
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Dec 2018 04:45:14 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43BKcP2drLzB09bP;
 Fri,  7 Dec 2018 18:45:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id qZDQxY8lqwhS; Fri,  7 Dec 2018 18:45:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43BKcP1RSGzB09bM;
 Fri,  7 Dec 2018 18:45:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D8C368B90D;
 Fri,  7 Dec 2018 18:45:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id j2PiGjkfjL3Y; Fri,  7 Dec 2018 18:45:10 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A0A1F8B8F6;
 Fri,  7 Dec 2018 18:45:10 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 6F2C9716A7; Fri,  7 Dec 2018 17:45:10 +0000 (UTC)
Message-Id: <a44ea11ba6a80cf270393b780841eb7ffe5f9c6a.1544204546.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc: implement CONFIG_DEBUG_VIRTUAL
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri,  7 Dec 2018 17:45:10 +0000 (UTC)
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

This patch implements CONFIG_DEBUG_VIRTUAL to warn about
incorrect use of virt_to_phys() and page_to_phys()

Below is the result of test_debug_virtual:

[    1.438746] WARNING: CPU: 0 PID: 1 at ./arch/powerpc/include/asm/io.h:808 test_debug_virtual_init+0x3c/0xd4
[    1.448156] CPU: 0 PID: 1 Comm: swapper Not tainted 4.20.0-rc5-00560-g6bfb52e23a00-dirty #532
[    1.457259] NIP:  c066c550 LR: c0650ccc CTR: c066c514
[    1.462257] REGS: c900bdb0 TRAP: 0700   Not tainted  (4.20.0-rc5-00560-g6bfb52e23a00-dirty)
[    1.471184] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 48000422  XER: 20000000
[    1.477811]
[    1.477811] GPR00: c0650ccc c900be60 c60d0000 00000000 006000c0 c9000000 00009032 c7fa0020
[    1.477811] GPR08: 00002400 00000001 09000000 00000000 c07b5d04 00000000 c00037d8 00000000
[    1.477811] GPR16: 00000000 00000000 00000000 00000000 c0760000 c0740000 00000092 c0685bb0
[    1.477811] GPR24: c065042c c068a734 c0685b8c 00000006 00000000 c0760000 c075c3c0 ffffffff
[    1.512711] NIP [c066c550] test_debug_virtual_init+0x3c/0xd4
[    1.518315] LR [c0650ccc] do_one_initcall+0x8c/0x1cc
[    1.523163] Call Trace:
[    1.525595] [c900be60] [c0567340] 0xc0567340 (unreliable)
[    1.530954] [c900be90] [c0650ccc] do_one_initcall+0x8c/0x1cc
[    1.536551] [c900bef0] [c0651000] kernel_init_freeable+0x1f4/0x2cc
[    1.542658] [c900bf30] [c00037ec] kernel_init+0x14/0x110
[    1.547913] [c900bf40] [c000e1d0] ret_from_kernel_thread+0x14/0x1c
[    1.553971] Instruction dump:
[    1.556909] 3ca50100 bfa10024 54a5000e 3fa0c076 7c0802a6 3d454000 813dc204 554893be
[    1.564566] 7d294010 7d294910 90010034 39290001 <0f090000> 7c3e0b78 955e0008 3fe0c062
[    1.572425] ---[ end trace 6f6984225b280ad6 ]---
[    1.577467] PA: 0x09000000 for VA: 0xc9000000
[    1.581799] PA: 0x061e8f50 for VA: 0xc61e8f50

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig          |  1 +
 arch/powerpc/include/asm/io.h | 12 +++++++++++-
 arch/powerpc/mm/pgtable_32.c  |  2 +-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index fd634a293d7f..1a3ed380f7d0 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -128,6 +128,7 @@ config PPC
 	#
 	# Please keep this list sorted alphabetically.
 	#
+	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_DMA_SET_COHERENT_MASK
 	select ARCH_HAS_ELF_RANDOMIZE
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index e746becd9d6f..75fb9f110eb6 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -29,6 +29,7 @@ extern struct pci_dev *isa_bridge_pcidev;
 
 #include <linux/device.h>
 #include <linux/compiler.h>
+#include <linux/mm_types.h>
 #include <asm/page.h>
 #include <asm/byteorder.h>
 #include <asm/synch.h>
@@ -804,6 +805,8 @@ extern void __iounmap_at(void *ea, unsigned long size);
  */
 static inline unsigned long virt_to_phys(volatile void * address)
 {
+	WARN_ON(IS_ENABLED(CONFIG_DEBUG_VIRTUAL) && !virt_addr_valid(address));
+
 	return __pa((unsigned long)address);
 }
 
@@ -827,7 +830,14 @@ static inline void * phys_to_virt(unsigned long address)
 /*
  * Change "struct page" to physical address.
  */
-#define page_to_phys(page)	((phys_addr_t)page_to_pfn(page) << PAGE_SHIFT)
+static inline phys_addr_t page_to_phys(struct page *page)
+{
+	unsigned long pfn = page_to_pfn(page);
+
+	WARN_ON(IS_ENABLED(CONFIG_DEBUG_VIRTUAL) && !pfn_valid(pfn));
+
+	return PFN_PHYS(pfn);
+}
 
 /*
  * 32 bits still uses virt_to_bus() for it's implementation of DMA
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index deb49a6e9cad..9c4e6ed19a93 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -143,7 +143,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, pgprot_t prot, void *call
 	 * Don't allow anybody to remap normal RAM that we're using.
 	 * mem_init() sets high_memory so only do the check after that.
 	 */
-	if (slab_is_available() && (p < virt_to_phys(high_memory)) &&
+	if (slab_is_available() && virt_addr_valid(p) &&
 	    page_is_ram(__phys_to_pfn(p))) {
 		printk("__ioremap(): phys addr 0x%llx is RAM lr %ps\n",
 		       (unsigned long long)p, __builtin_return_address(0));
-- 
2.13.3

