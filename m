Return-Path: <SRS0=LfhS=C4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AF0C43463
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Sep 2020 10:09:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E242B21582
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Sep 2020 10:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4aGjXseo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z+O8xe+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E242B21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Btmdd4fv2zDqxX
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Sep 2020 20:09:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1;
 helo=galois.linutronix.de; envelope-from=tglx@linutronix.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256
 header.s=2020 header.b=4aGjXseo; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=Z+O8xe+M; 
 dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BtmCZ6LTtzDqjv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2020 19:50:18 +1000 (AEST)
Message-Id: <20200919092616.736510871@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1600509011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=KCsaboacsuJ88jqIg0buxiu+ksgl22D90Mxj1XlMJa8=;
 b=4aGjXseoaPwfvC1RztSPZmMPssvx2DAHZ0yqYHLoXSYiocGwX1jEFz1j94PvUMprh1rKNl
 epJRsEhX8k8BXyGAbHBQcU8ti2G1WgSmO45ofO7u685Iiiq33ZlBm40IDsBQx4SVN1qG8p
 NvNgwqpPxE7jmG6tO5AwRcx3XLlluU4maXhXXRVsvbIFK11+FNNbChWbuzWY2FrHT1sH7C
 jTR6uDLqw/6GXaa62jrp2/RD9ANnlOBeRj5oltXG0EtUxVFJhgkUrLkw6SsHV0NWbDq+nQ
 iKJgZmVYUCq01IQvsyKTNQnpNYvIqMR5MAwU0vq6advwfeunO0NLj41fZ7cRlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1600509011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=KCsaboacsuJ88jqIg0buxiu+ksgl22D90Mxj1XlMJa8=;
 b=Z+O8xe+MGt5jyRp84X/pvcvuy8DIoXD1jiMiTNmpv474C8OxJBYxsbYAxaWRzNO/Jc2Oo6
 D5mWn+A1kiGj7wCw==
Date: Sat, 19 Sep 2020 11:18:00 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch RFC 09/15] nds32/mm/highmem: Switch to generic kmap atomic
References: <20200919091751.011116649@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
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
Cc: Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, Ben Segall <bsegall@google.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>,
 sparclinux@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 linux-arch@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org,
 David Airlie <airlied@linux.ie>, Mel Gorman <mgorman@suse.de>,
 linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
 Paul McKenney <paulmck@kernel.org>,
 intel-gfx <intel-gfx@lists.freedesktop.org>, linuxppc-dev@lists.ozlabs.org,
 Steven Rostedt <rostedt@goodmis.org>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Nick Hu <nickhu@andestech.com>, Linux-MM <linux-mm@kvack.org>,
 Vineet Gupta <vgupta@synopsys.com>, linux-mips@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel@ffwll.ch>,
 Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Greentime Hu <green.hu@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The mapping code is odd and looks broken. See FIXME in the comment.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Nick Hu <nickhu@andestech.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
---
Note: Completely untested
---
 arch/nds32/Kconfig.cpu           |    1 
 arch/nds32/include/asm/highmem.h |   21 +++++++++++++----
 arch/nds32/mm/Makefile           |    1 
 arch/nds32/mm/highmem.c          |   48 ---------------------------------------
 4 files changed, 17 insertions(+), 54 deletions(-)

--- a/arch/nds32/Kconfig.cpu
+++ b/arch/nds32/Kconfig.cpu
@@ -157,6 +157,7 @@ config HW_SUPPORT_UNALIGNMENT_ACCESS
 config HIGHMEM
 	bool "High Memory Support"
 	depends on MMU && !CPU_CACHE_ALIASING
+        select KMAP_ATOMIC_GENERIC
 	help
 	  The address space of Andes processors is only 4 Gigabytes large
 	  and it has to accommodate user address space, kernel address
--- a/arch/nds32/include/asm/highmem.h
+++ b/arch/nds32/include/asm/highmem.h
@@ -45,11 +45,22 @@ extern pte_t *pkmap_page_table;
 extern void kmap_init(void);
 
 /*
- * The following functions are already defined by <linux/highmem.h>
- * when CONFIG_HIGHMEM is not set.
+ * FIXME: The below looks broken vs. a kmap_atomic() in task context which
+ * is interupted and another kmap_atomic() happens in interrupt context.
+ * But what do I know about nds32. -- tglx
  */
-#ifdef CONFIG_HIGHMEM
-extern void *kmap_atomic_pfn(unsigned long pfn);
-#endif
+#define arch_kmap_temp_post_map(vaddr, pteval)			\
+	do {							\
+		__nds32__tlbop_inv(vaddr);			\
+		__nds32__mtsr_dsb(vaddr, NDS32_SR_TLB_VPN);	\
+		__nds32__tlbop_rwr(pteval);			\
+		__nds32__isb();					\
+	} while (0)
+
+#define arch_kmap_temp_pre_unmap(vaddr, pte)			\
+	do {							\
+		__nds32__tlbop_inv(vaddr);			\
+		__nds32__isb();					\
+	} while (0)
 
 #endif
--- a/arch/nds32/mm/Makefile
+++ b/arch/nds32/mm/Makefile
@@ -3,7 +3,6 @@ obj-y				:= extable.o tlb.o fault.o init
                                    mm-nds32.o cacheflush.o proc.o
 
 obj-$(CONFIG_ALIGNMENT_TRAP)	+= alignment.o
-obj-$(CONFIG_HIGHMEM)           += highmem.o
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_proc.o     = $(CC_FLAGS_FTRACE)
--- a/arch/nds32/mm/highmem.c
+++ /dev/null
@@ -1,48 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/export.h>
-#include <linux/highmem.h>
-#include <linux/sched.h>
-#include <linux/smp.h>
-#include <linux/interrupt.h>
-#include <linux/memblock.h>
-#include <asm/fixmap.h>
-#include <asm/tlbflush.h>
-
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	unsigned int idx;
-	unsigned long vaddr, pte;
-	int type;
-	pte_t *ptep;
-
-	type = kmap_atomic_idx_push();
-
-	idx = type + KM_TYPE_NR * smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	pte = (page_to_pfn(page) << PAGE_SHIFT) | prot;
-	ptep = pte_offset_kernel(pmd_off_k(vaddr), vaddr);
-	set_pte(ptep, pte);
-
-	__nds32__tlbop_inv(vaddr);
-	__nds32__mtsr_dsb(vaddr, NDS32_SR_TLB_VPN);
-	__nds32__tlbop_rwr(pte);
-	__nds32__isb();
-	return (void *)vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	if (kvaddr >= (void *)FIXADDR_START) {
-		unsigned long vaddr = (unsigned long)kvaddr;
-		pte_t *ptep;
-		kmap_atomic_idx_pop();
-		__nds32__tlbop_inv(vaddr);
-		__nds32__isb();
-		ptep = pte_offset_kernel(pmd_off_k(vaddr), vaddr);
-		set_pte(ptep, 0);
-	}
-}
-EXPORT_SYMBOL(kunmap_atomic_high);

