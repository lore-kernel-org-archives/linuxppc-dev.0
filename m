Return-Path: <linuxppc-dev+bounces-29655-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A85ACCF2C4
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2026 13:50:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j70RN713Nz3bTf;
	Mon, 19 Oct 2026 00:49:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792331392;
	cv=none; b=MM/UZ3I1q8yBcjQzAAwy0/02sjFgP3o+w3VJahsVjYSQdo8JlK9haAUJ/84ydD5I1AHQYF2L2r6/N/ePLsyV8PD5JBxvu+M+GnLS2OkCI+d8onhqECNAPbkay0DQ6KiHYViAySJRsYGPVg6VW7ruIyrSbtj6pz4y2zHoBEWhc7DcqXuxb1KlHgGQ9NDMjQHzG4R76i2eFlemW9sQs09sn1c4XXIZtzUiVJ/6o+FNPT+PQkix53AnnvB/7A/c7j3HiBo0VHmzkEHmCFd0WVBP9A1BEkRkm2+m3eTT7f3Uta82n8hwaZFUlyCqn9dlcgGwBd+ZRWfNkKnBUFAgOfAI2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792331392; c=relaxed/relaxed;
	bh=xf4DsDndYrdpWXL1CLcg308mCcphdBjI61Eg5LQ4nys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkXArzBdLNNs26Gsnn3FlQm8JJzxzUFJFatRCQYRx25KvdK4gdFZc/3fZFaHyQWFMGiFGzvzc+DcHeRy3OuRo1uQ2Tax+ULEzr38lkE3XHZcT0Ln4Etv/aQT5P69nKgTJZhavrR5o3tT4XgbKJ5bl6V7V8PHJARj4mYwigJ8fmXOyqLtxIzpe/6cXnL3Mb9Acz2CAatEo5pP/lt65FnSPqwuFiGw1WMHr8KjTOsXz3U4Oa16irAmFrXkQAQYkXHXMRPHchsYtFMHc7GOMPcNSMflXl/mHv+g+ENhMFJgF+0mFHVNYyRNX4prn5SlP4EMKk70oOhknpQ4pxRnzV9ULA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NZa7YEQQ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NZa7YEQQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j70RM1nv4z3bRp
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 00:49:51 +1100 (AEDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-c43fbcb4393so19760566b.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 06:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792331388; x=1792936188; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xf4DsDndYrdpWXL1CLcg308mCcphdBjI61Eg5LQ4nys=;
        b=NZa7YEQQZKkr9ILIi4mKySCn7apjpOp+VjdLqZJg2JC9dkJxksaJuW5NbjDIvOHhEz
         RXG1YsnuGogKUQIjtyNPYQ0qJHyrstQ4gUoq6GuZ5yHbgx1jh8BqxS+MlivUPEEkPuzu
         kY+UrB6DfC2eGiHO5Ym3Hr6/P2sGCxypTlj5qu31c2WKYqUSYbhYonDeFYGecECPNt9a
         m1hZ8J/J4KL2J4vKyWrttNohYn3Jwda+OvfaKBm8jPQrbaH/H8b1Ot7qjjf/SA6pYKGS
         2pR9ZjAYxrFjwFiZnh9YSxDmBkNZw4jmMhcnHxSQtKsJTLcS0yaJmvE+K6WYHKz7Acms
         9fAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331388; x=1792936188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xf4DsDndYrdpWXL1CLcg308mCcphdBjI61Eg5LQ4nys=;
        b=FSVQ+W4L+8fP8Sd+avgCC6rBfkNu1/lYh3IwrRi3WEBKO3xBMdTC2LRPIywfG4um74
         jjsnhIiSj4LUtT9PzetpE1EZugmgt0sceKU550b7tKCQyaqf/oufKg9EUfcZ0RH9tX9c
         ktby68REVuZpcjdZ8NMUhBvj5K5MCo7NOaZrJf2A1q40rDXDg2a9q7Ul5ELZ03FYthLM
         CC/SLAPIE1I50R6hKuEUhaK8BTY7wCvZQiHwTaXKsXjcP9TdxV+okKBKyW/ioKAQ8AcD
         lCSpgpwz4jBdkJrOFBGL2VlWPXUccAakrESNbvOwRK6sRGIacTknt0/Jog9EDGtxj+XB
         U4OA==
X-Forwarded-Encrypted: i=1; AKwUvByZ33E7TlbENw3QK83huQqI/8j7IOCwaH9F+AWjGt4DvbkfLvv/cQBhDTZnOG4JxznTc6R2Y9jkMZHQ4kg=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIQ+hMJnosrKQVSyE95/2S84iTk5kUExx0f4u7iAbG/mU2OHpAG
	25YREvZtdmBaUk14PofbNnswNZy0+unPFOrzDzyoCzVzW7uDMlKWTPQ9
X-Gm-Gg: AYBFou2Eap3iYTC5km3myoqoOSRbcXAoI3u3+KRzqubLvP0rB9eVuXJ0KKl5YQvHJM/
	9dr1khbU2vGfCybXmAiikpRJxmihWumDsza6ZxCTc5H3sTzJsrm/mT5A8GeC6sIfFQSE50tuYgp
	NYVpDP+ZeEAD5vjmbEi+4MKmMHdFZSRtFSfH0wWUeBd3Fenj88f0l4NEz7rMdgeQ1rrYUIqs1ik
	EEeVhIm7hbnP1jnZUosU6qOMGQYu6LY5iNC4e4Kcm8SBMXyaTGPQ7GjVhRzqboT2ODEvBb8Sii2
	Eq9oogEj1pZcltdovxhfiz6+vp42rcdqEDaGlIRmO/OMoPngGVceKgjJIKotkXNEZdJlBUBaocK
	hZPfgHtzuygiz9baiFdTDmLuGAkaZiHE2T9K5B4N7Ea7Ry8IIegJuTAcpzybd36EiNQmn8Wa9IC
	osGqa8AxPLCVfA4H2/E2rM8T8PuKQQ+9wFKYA63G5ht9tOM7Tqo8AT9WvVkYJHTkgTxay96rb9h
	1nl9otOy9tqg0fm+nwl0HKGKJhImH1rLUHocSru
X-Received: by 2002:a17:907:d48f:b0:c32:110d:682f with SMTP id a640c23a62f3a-c419e63cbc2mr357315666b.18.1792331387779;
        Sun, 18 Oct 2026 06:49:47 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm267678266b.61.2026.10.18.06.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:49:46 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com
Subject: [PATCH v4 09/10] sparc64: add M3000 Oberon PCIe support
Date: Sun, 18 Oct 2026 15:45:11 +0200
Message-ID: <20261018134738.1016106-10-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018134738.1016106-1-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recognize Oberon from its firmware compatible property without a platform
Kconfig option, preserving firmware link setup. Flush DVMA translations
and changed noncoherent IOTSB cache lines, and route legacy interrupts
using the bridge's ten-bit target ID.

Cache the bridge type and share target encoding. Leave MSI queues
uninitialized so the existing architecture path uses legacy interrupts
even with CONFIG_PCI_MSI=y; native bridge error handling is not provided.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/include/asm/iommu_64.h |  1 +
 arch/sparc/include/asm/irq_64.h   |  1 +
 arch/sparc/kernel/iommu.c         | 44 +++++++++++++++++++++++++++
 arch/sparc/kernel/irq_64.c        | 50 ++++++++++++++++++++++++-------
 arch/sparc/kernel/pci_fire.c      | 26 ++++++++++++++--
 arch/sparc/kernel/pci_impl.h      |  1 +
 arch/sparc/kernel/prom_irqtrans.c |  5 ++++
 7 files changed, 115 insertions(+), 13 deletions(-)

diff --git a/arch/sparc/include/asm/iommu_64.h b/arch/sparc/include/asm/iommu_64.h
index 0ef6dedf747e..abd7bb0fa615 100644
--- a/arch/sparc/include/asm/iommu_64.h
+++ b/arch/sparc/include/asm/iommu_64.h
@@ -62,6 +62,7 @@ struct iommu {
 	unsigned long		iommu_tsbbase;
 	unsigned long		iommu_flush;
 	unsigned long		iommu_flushinv;
+	unsigned long		iommu_cache_flush; /* Oberon IOTSB cache */
 	unsigned long		iommu_tags;
 	unsigned long		iommu_ctxflush;
 	unsigned long		write_complete_reg;
diff --git a/arch/sparc/include/asm/irq_64.h b/arch/sparc/include/asm/irq_64.h
index 8c4c0c87f998..c3e88f2f8e80 100644
--- a/arch/sparc/include/asm/irq_64.h
+++ b/arch/sparc/include/asm/irq_64.h
@@ -45,6 +45,7 @@ void irq_install_pre_handler(int irq,
 			     void *arg1, void *arg2);
 #define irq_canonicalize(irq)	(irq)
 unsigned int build_irq(int inofixup, unsigned long iclr, unsigned long imap);
+unsigned int oberon_build_irq(int inofixup, unsigned long iclr, unsigned long imap);
 unsigned int sun4v_build_irq(u32 devhandle, unsigned int devino);
 unsigned int sun4v_build_virq(u32 devhandle, unsigned int devino);
 unsigned int sun4v_build_msi(u32 devhandle, unsigned int *irq_p,
diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index 66aaafbf1621..27d269a8b52c 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -52,6 +52,8 @@ static void iommu_flushall(struct iommu_map_table *iommu_map_table)
 	struct iommu *iommu = container_of(iommu_map_table, struct iommu, tbl);
 	if (iommu->iommu_flushinv) {
 		iommu_write(iommu->iommu_flushinv, ~(u64)0);
+		if (iommu->iommu_cache_flush)
+			(void)iommu_read(iommu->write_complete_reg);
 	} else {
 		unsigned long tag;
 		int entry;
@@ -67,6 +69,30 @@ static void iommu_flushall(struct iommu_map_table *iommu_map_table)
 	}
 }
 
+/*
+ * Oberon's noncoherent IOTSB needs each changed 64-byte cache line flushed
+ * along with its DVMA translations. Call only for device-inactive mappings.
+ */
+static void iommu_sync_mapping(struct iommu *iommu, iopte_t *base,
+			       unsigned long npages)
+{
+	unsigned long slot, i;
+
+	if (!iommu->iommu_cache_flush || !npages)
+		return;
+	slot = base - iommu->page_table;
+	/* Publish IOPTE stores before invalidating the hardware caches. */
+	wmb();
+	for (i = 0; i < npages; i++, slot++) {
+		iommu_write(iommu->iommu_flush,
+			    iommu->tbl.table_map_base + (slot << IO_PAGE_SHIFT));
+		if ((slot & 7) == 7 || i == npages - 1)
+			iommu_write(iommu->iommu_cache_flush,
+				    __pa(iommu->page_table + slot));
+	}
+	(void)iommu_read(iommu->write_complete_reg);
+}
+
 #define IOPTE_CONSISTENT(CTX) \
 	(IOPTE_VALID | IOPTE_CACHE | \
 	 (((CTX) << 47) & IOPTE_CONTEXT))
@@ -240,6 +266,8 @@ static void *dma_4u_alloc_coherent(struct device *dev, size_t size,
 		first_page += IO_PAGE_SIZE;
 	}
 
+	iommu_sync_mapping(iommu, iopte - (size >> IO_PAGE_SHIFT),
+			   size >> IO_PAGE_SHIFT);
 	return ret;
 }
 
@@ -253,6 +281,15 @@ static void dma_4u_free_coherent(struct device *dev, size_t size,
 	npages = IO_PAGE_ALIGN(size) >> IO_PAGE_SHIFT;
 	iommu = dev->archdata.iommu;
 
+	if (iommu->iommu_cache_flush) {
+		iopte_t *base = iommu->page_table +
+			((dvma - iommu->tbl.table_map_base) >> IO_PAGE_SHIFT);
+		unsigned long i;
+
+		for (i = 0; i < npages; i++)
+			iopte_make_dummy(iommu, base + i);
+		iommu_sync_mapping(iommu, base, npages);
+	}
 	iommu_tbl_range_free(&iommu->tbl, dvma, npages, IOMMU_ERROR_CODE);
 
 	order = get_order(size);
@@ -316,6 +353,7 @@ static dma_addr_t dma_4u_map_phys(struct device *dev, phys_addr_t phys,
 
 	for (i = 0; i < npages; i++, base++, phys += IO_PAGE_SIZE)
 		iopte_val(*base) = iopte_protection | phys;
+	iommu_sync_mapping(iommu, base - npages, npages);
 
 	return ret;
 
@@ -432,6 +470,7 @@ static void dma_4u_unmap_phys(struct device *dev, dma_addr_t bus_addr,
 	/* Step 2: Clear out TSB entries. */
 	for (i = 0; i < npages; i++)
 		iopte_make_dummy(iommu, base + i);
+	iommu_sync_mapping(iommu, base, npages);
 
 	iommu_free_ctx(iommu, ctx);
 	spin_unlock_irqrestore(&iommu->lock, flags);
@@ -523,6 +562,9 @@ static int dma_4u_map_sg(struct device *dev, struct scatterlist *sglist,
 			paddr += IO_PAGE_SIZE;
 		}
 
+		iommu_sync_mapping(iommu, iommu->page_table + entry,
+				   base - (iommu->page_table + entry));
+
 		/* If we are in an open segment, try merging */
 		if (segstart != s) {
 			/* We cannot merge if:
@@ -577,6 +619,7 @@ static int dma_4u_map_sg(struct device *dev, struct scatterlist *sglist,
 
 			for (j = 0; j < npages; j++)
 				iopte_make_dummy(iommu, base + j);
+			iommu_sync_mapping(iommu, base, npages);
 
 			iommu_tbl_range_free(&iommu->tbl, vaddr, npages,
 					     IOMMU_ERROR_CODE);
@@ -653,6 +696,7 @@ static void dma_4u_unmap_sg(struct device *dev, struct scatterlist *sglist,
 
 		for (i = 0; i < npages; i++)
 			iopte_make_dummy(iommu, base + i);
+		iommu_sync_mapping(iommu, base, npages);
 
 		iommu_tbl_range_free(&iommu->tbl, dma_handle, npages,
 				     IOMMU_ERROR_CODE);
diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 4cceeba726ab..338f58246feb 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -206,6 +206,7 @@ struct irq_handler_data {
 	struct ino_bucket bucket;
 	unsigned long	iclr;
 	unsigned long	imap;
+	bool		oberon;
 };
 
 static inline unsigned int irq_data_to_handle(struct irq_data *data)
@@ -364,6 +365,16 @@ static int irq_choose_cpu(unsigned int irq, const struct cpumask *affinity)
 	real_hard_smp_processor_id()
 #endif
 
+/* Oberon IMAP destination is a ten-bit interrupt target ID. */
+#define OBERON_IMAP_TID_SHIFT	21
+#define OBERON_IMAP_TID_MASK	(0x3ffUL << OBERON_IMAP_TID_SHIFT)
+
+static unsigned long oberon_imap_target(unsigned long val, unsigned int cpuid)
+{
+	return (val & ~OBERON_IMAP_TID_MASK) |
+		((cpuid << OBERON_IMAP_TID_SHIFT) & OBERON_IMAP_TID_MASK);
+}
+
 static void sun4u_irq_enable(struct irq_data *data)
 {
 	struct irq_handler_data *handler_data;
@@ -377,12 +388,16 @@ static void sun4u_irq_enable(struct irq_data *data)
 				       irq_data_get_affinity_mask(data));
 		imap = handler_data->imap;
 
-		tid = sun4u_compute_tid(imap, cpuid);
-
 		val = upa_readq(imap);
-		val &= ~(IMAP_TID_UPA | IMAP_TID_JBUS |
-			 IMAP_AID_SAFARI | IMAP_NID_SAFARI);
-		val |= tid | IMAP_VALID;
+		if (handler_data->oberon) {
+			val = oberon_imap_target(val, cpuid);
+		} else {
+			tid = sun4u_compute_tid(imap, cpuid);
+			val &= ~(IMAP_TID_UPA | IMAP_TID_JBUS |
+				 IMAP_AID_SAFARI | IMAP_NID_SAFARI);
+			val |= tid;
+		}
+		val |= IMAP_VALID;
 		upa_writeq(val, imap);
 		upa_writeq(ICLR_IDLE, handler_data->iclr);
 	}
@@ -401,12 +416,16 @@ static int sun4u_set_affinity(struct irq_data *data,
 		cpuid = irq_choose_cpu(data->irq, mask);
 		imap = handler_data->imap;
 
-		tid = sun4u_compute_tid(imap, cpuid);
-
 		val = upa_readq(imap);
-		val &= ~(IMAP_TID_UPA | IMAP_TID_JBUS |
-			 IMAP_AID_SAFARI | IMAP_NID_SAFARI);
-		val |= tid | IMAP_VALID;
+		if (handler_data->oberon) {
+			val = oberon_imap_target(val, cpuid);
+		} else {
+			tid = sun4u_compute_tid(imap, cpuid);
+			val &= ~(IMAP_TID_UPA | IMAP_TID_JBUS |
+				 IMAP_AID_SAFARI | IMAP_NID_SAFARI);
+			val |= tid;
+		}
+		val |= IMAP_VALID;
 		upa_writeq(val, imap);
 		upa_writeq(ICLR_IDLE, handler_data->iclr);
 	}
@@ -646,6 +665,17 @@ unsigned int build_irq(int inofixup, unsigned long iclr, unsigned long imap)
 	return irq;
 }
 
+unsigned int oberon_build_irq(int inofixup, unsigned long iclr,
+			      unsigned long imap)
+{
+	unsigned int irq = build_irq(inofixup, iclr, imap);
+	struct irq_handler_data *data = irq_get_handler_data(irq);
+
+	if (data)
+		data->oberon = true;
+	return irq;
+}
+
 static unsigned int sun4v_build_common(u32 devhandle, unsigned int devino,
 		void (*handler_data_init)(struct irq_handler_data *data,
 		u32 devhandle, unsigned int devino),
diff --git a/arch/sparc/kernel/pci_fire.c b/arch/sparc/kernel/pci_fire.c
index db160eeb0ffe..f2776144d1d4 100644
--- a/arch/sparc/kernel/pci_fire.c
+++ b/arch/sparc/kernel/pci_fire.c
@@ -46,11 +46,21 @@ static int pci_fire_pbm_iommu_init(struct pci_pbm_info *pbm)
 	iommu->iommu_tsbbase  = pbm->pbm_regs + FIRE_IOMMU_TSBBASE;
 	iommu->iommu_flush    = pbm->pbm_regs + FIRE_IOMMU_FLUSH;
 	iommu->iommu_flushinv = pbm->pbm_regs + FIRE_IOMMU_FLUSHINV;
+	if (pbm->is_oberon) {
+		/*
+		 * 0x40100 flushes an IOTSB cache line by physical address;
+		 * 0x40010 flushes a translated DVMA page.
+		 */
+		iommu->iommu_flush = pbm->pbm_regs + 0x40010UL;
+		iommu->iommu_cache_flush = pbm->pbm_regs + 0x40100UL;
+		iommu->write_complete_reg = iommu->iommu_control;
+	}
 
 	/* We use the main control/status register of FIRE as the write
 	 * completion register.
 	 */
-	iommu->write_complete_reg = pbm->controller_regs + 0x410000UL;
+	if (!iommu->iommu_cache_flush)
+		iommu->write_complete_reg = pbm->controller_regs + 0x410000UL;
 
 	/*
 	 * Invalidate TLB Entries.
@@ -62,6 +72,8 @@ static int pci_fire_pbm_iommu_init(struct pci_pbm_info *pbm)
 	if (err)
 		return err;
 
+	/* Make initialized IOPTEs visible before publishing the table base. */
+	wmb();
 	upa_writeq(__pa(iommu->page_table) | 0x7UL, iommu->iommu_tsbbase);
 
 	control = upa_readq(iommu->iommu_control);
@@ -70,6 +82,10 @@ static int pci_fire_pbm_iommu_init(struct pci_pbm_info *pbm)
 		    0x00000002 /* Bypass enable */		|
 		    0x00000001 /* Translation enable */);
 	upa_writeq(control, iommu->iommu_control);
+	if (iommu->iommu_cache_flush) {
+		upa_writeq(~(u64)0, iommu->iommu_flushinv);
+		(void)upa_readq(iommu->iommu_control);
+	}
 
 	return 0;
 }
@@ -425,6 +441,7 @@ static int pci_fire_pbm_init(struct pci_pbm_info *pbm,
 	}
 
 	pbm->numa_node = NUMA_NO_NODE;
+	pbm->is_oberon = of_device_is_compatible(dp, "pciex108e,80f8");
 
 	pbm->pci_ops = &sun4u_pci_ops;
 	pbm->config_space_reg_bits = 12;
@@ -444,13 +461,15 @@ static int pci_fire_pbm_init(struct pci_pbm_info *pbm,
 
 	pci_get_pbm_props(pbm);
 
-	pci_fire_hw_init(pbm);
+	if (!pbm->is_oberon)
+		pci_fire_hw_init(pbm);
 
 	err = pci_fire_pbm_iommu_init(pbm);
 	if (err)
 		return err;
 
-	pci_fire_msi_init(pbm);
+	if (!pbm->is_oberon)
+		pci_fire_msi_init(pbm);
 
 	pbm->pci_bus = pci_scan_one_pbm(pbm, &op->dev);
 
@@ -510,6 +529,7 @@ static const struct of_device_id fire_match[] = {
 		.name = "pci",
 		.compatible = "pciex108e,80f0",
 	},
+	{ .name = "pci", .compatible = "pciex108e,80f8" },
 	{},
 };
 
diff --git a/arch/sparc/kernel/pci_impl.h b/arch/sparc/kernel/pci_impl.h
index 83718876f1d4..92505fcc3cf3 100644
--- a/arch/sparc/kernel/pci_impl.h
+++ b/arch/sparc/kernel/pci_impl.h
@@ -117,6 +117,7 @@ struct pci_pbm_info {
 	/* State of 66MHz capabilities on this PBM. */
 	int				is_66mhz_capable;
 	int				all_devs_66mhz;
+	bool				is_oberon;
 
 #ifdef CONFIG_PCI_MSI
 	/* MSI info.  */
diff --git a/arch/sparc/kernel/prom_irqtrans.c b/arch/sparc/kernel/prom_irqtrans.c
index 558ed5114664..58c5b4565f41 100644
--- a/arch/sparc/kernel/prom_irqtrans.c
+++ b/arch/sparc/kernel/prom_irqtrans.c
@@ -481,6 +481,7 @@ static void __init pci_sun4v_irq_trans_init(struct device_node *dp)
 struct fire_irq_data {
 	unsigned long pbm_regs;
 	u32 portid;
+	bool oberon;
 };
 
 #define FIRE_IMAP_BASE	0x001000
@@ -537,6 +538,8 @@ static unsigned int fire_irq_build(struct device_node *dp,
 	 */
 	ino |= (irq_data->portid << 6);
 	ino -= int_ctrlr;
+	if (irq_data->oberon)
+		return oberon_build_irq(ino, iclr, imap);
 	return build_irq(ino, iclr, imap);
 }
 
@@ -559,6 +562,7 @@ static void __init fire_irq_trans_init(struct device_node *dp)
 
 	dp->irq_trans->data = irq_data;
 
+	irq_data->oberon = of_device_is_compatible(dp, "pciex108e,80f8");
 	irq_data->pbm_regs = regs[0].phys_addr;
 	irq_data->portid = of_getintprop_default(dp, "portid", 0);
 }
@@ -784,6 +788,7 @@ static struct irq_trans __initdata pci_irq_trans_table[] = {
 	{ "pci108e,a801", tomatillo_irq_trans_init },
 	{ "SUNW,sun4v-pci", pci_sun4v_irq_trans_init },
 	{ "pciex108e,80f0", fire_irq_trans_init },
+	{ "pciex108e,80f8", fire_irq_trans_init },
 };
 #endif
 
-- 
2.43.0


