Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE14606A327
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2026 08:38:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j85Qr32K6z2xwL;
	Tue, 20 Oct 2026 19:38:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=14.137.139.23
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792485492;
	cv=none; b=nHBhKWUsNVdtFtHZVRbnimgMDnXs0JohUThY+g03gCqPc5rixlf/uuWJnEfs6bcit5zuvd04kr1exIXEOa39KDSjuBYDtF5mdoVbX5sairboM4eLDRZh4G1heFiLsUtirkEgH2nwflFm4KKMt5RlM3Q9+cutnGcjYH6OsnuLRrDoTszbneH/R1UB53p1dS7UWhyu19nd+tAVx8MJ/HSbJbyb4uNFgHoiffO7LS9L7qyZE0ggs8tT+g1xYFDZLEIqgPZav8THJoIhzwQE2j14OvjPQg2i2y0pcdeXkrRtrCqNtxV3fcnBiNwa3MmQIh+T1P2oYE/2bnRXpD7WXBUn5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792485492; c=relaxed/relaxed;
	bh=ZdFOZo7LWaxQNBpUW6ZdsOmYz5y22ulR9ZW0yxAt+gA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Do/sYaueza/dxDixWRDpTyKLXQ6lMpwV95IE7nZQLYlCUGJzWD/IYJE0hoAknAyk0kveE0Sc33uo00v+fv1Pu2bV4+4aX67pr3D1t65s2LoS4K+NpgHZP25GdKdsbIYi9DyyT8ojF+gvUWQComSEZ1TriBECSjXq4T6wkAU+YVq3t98lHW32wTRjEGtW+1lFoJAqbvKFdspghmc1WKiOU9UQ3FBi6L8xfP/HZYAKD5Y8XD6Yagz/T/2960T3lws1gw/hqc8DvIlxZ+SLP3hSwiH8qUz8tpESSjSipGxfhUWoRBuqp/oQwisCjCMrLIg+MU/ud7z3/qP1vuk8tYkk9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass (client-ip=14.137.139.23; helo=frasgout11.his.huawei.com; envelope-from=roberto.sassu@huaweicloud.com; receiver=lists.ozlabs.org) smtp.mailfrom=huaweicloud.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=14.137.139.23; helo=frasgout11.his.huawei.com; envelope-from=roberto.sassu@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j85Qp6rPSz2xN4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 19:38:09 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j85GJ5dS0z1HCLJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 16:30:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.157])
	by mail.maildlp.com (Postfix) with ESMTP id B47C340559
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 16:38:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by dep2_app1 (Coremail) with UTF8SMTPA id nRC2B0Dmy2FaKNdqLzcBAA--.5746S2;
	Tue, 20 Oct 2026 09:38:04 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	robh@kernel.org,
	saravanak@kernel.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	zohar@linux.ibm.com,
	noodles@fb.com,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2] kexec: Select ima_get/free_kexec_buffer() with CONFIG_HAVE_IMA_KEXEC(_OF)
Date: Tue, 20 Oct 2026 10:37:27 +0200
Message-ID: <20261020083727.1906495-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:nRC2B0Dmy2FaKNdqLzcBAA--.5746S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWxJw17urW3JF48GF48WFg_yoWrKw4xpw
	n0yr18JFZrWFs8t3yjga48Wry5Zan7JrW3urs5C34kZFy3A3yDur1vq3W7ZFyj9rWkKFy8
	uFyrWFy09w4UKaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUIF4iUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgASDWrW3LUGaQAHsg
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Roberto Sassu <roberto.sassu@huawei.com>

On x86, if CONFIG_OF_FLATTREE is enabled, the kernel uses the device tree
implementation of ima_get/free_kexec_buffer(). However, x86 passes the IMA
buffer location through setup_data, not through the device tree, so the
buffer is never found and the IMA measurement list is not carried over
across kexec.

Introduce CONFIG_HAVE_IMA_KEXEC_OF (which selects CONFIG_HAVE_IMA_KEXEC)
and select it for the architectures that pass the IMA buffer location
through the device tree, via of_kexec_alloc_and_setup_fdt() (arm64,
powerpc and riscv). Build the device tree implementation of
ima_get/free_kexec_buffer() only if the new option is enabled.

Select the new option also on LoongArch, to preserve the current behavior
and avoid a link failure. LoongArch does not pass the buffer location to
the next kernel yet; this will be addressed separately.

Finally, don't select it for x86, and use x86's own setup_data-based
implementation regardless of CONFIG_OF_FLATTREE.

Fixes: b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on kexec")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---

v2:
- Reworded the commit message (no code changes), suggested by Mimi

 arch/arm64/Kconfig      | 2 +-
 arch/loongarch/Kconfig  | 2 +-
 arch/powerpc/Kconfig    | 2 +-
 arch/riscv/Kconfig      | 2 +-
 arch/x86/kernel/setup.c | 2 +-
 drivers/of/kexec.c      | 4 ++--
 kernel/Kconfig.kexec    | 4 ++++
 7 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b5a51b0ef944..4b7e248b6c91 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1697,7 +1697,7 @@ config ARCH_SUPPORTS_KEXEC_FILE
 config ARCH_SELECTS_KEXEC_FILE
 	def_bool y
 	depends on KEXEC_FILE
-	select HAVE_IMA_KEXEC if IMA
+	select HAVE_IMA_KEXEC_OF if IMA
 
 config ARCH_SUPPORTS_KEXEC_SIG
 	def_bool y
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 2067d1f2ad7a..b5420d482da4 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -690,7 +690,7 @@ config ARCH_SELECTS_KEXEC_FILE
 	depends on KEXEC_FILE
 	select KEXEC_ELF
 	select RELOCATABLE
-	select HAVE_IMA_KEXEC if IMA
+	select HAVE_IMA_KEXEC_OF if IMA
 
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool 64BIT
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2580e27e4328..096c6061893b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -643,7 +643,7 @@ config ARCH_SELECTS_KEXEC_FILE
 	def_bool y
 	depends on KEXEC_FILE
 	select KEXEC_ELF
-	select HAVE_IMA_KEXEC if IMA
+	select HAVE_IMA_KEXEC_OF if IMA
 
 config PPC64_BIG_ENDIAN_ELF_ABI_V2
 	# Option is available to BFD, but LLD does not support ELFv1 so this is
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index f8e26c4bed2b..161bf8a65beb 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -1118,7 +1118,7 @@ config ARCH_SUPPORTS_KEXEC_FILE
 config ARCH_SELECTS_KEXEC_FILE
 	def_bool y
 	depends on KEXEC_FILE
-	select HAVE_IMA_KEXEC if IMA
+	select HAVE_IMA_KEXEC_OF if IMA
 	select KEXEC_ELF
 
 config ARCH_SUPPORTS_KEXEC_PURGATORY
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index cda6adb9f69c..bc17e353c099 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -421,7 +421,7 @@ static void __init add_early_ima_buffer(u64 phys_addr)
 #endif
 }
 
-#if defined(CONFIG_HAVE_IMA_KEXEC) && !defined(CONFIG_OF_FLATTREE)
+#ifdef CONFIG_HAVE_IMA_KEXEC
 int __init ima_free_kexec_buffer(void)
 {
 	if (!ima_kexec_buffer_size)
diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 029903b986cb..724f29fef0c0 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -116,7 +116,7 @@ static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
 	return 0;
 }
 
-#ifdef CONFIG_HAVE_IMA_KEXEC
+#ifdef CONFIG_HAVE_IMA_KEXEC_OF
 /**
  * ima_get_kexec_buffer - get IMA buffer from the previous kernel
  * @addr:	On successful return, set to point to the buffer contents.
@@ -196,7 +196,7 @@ static void remove_ima_buffer(void *fdt, int chosen_node)
 	size_t size;
 	const void *prop;
 
-	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
+	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC_OF))
 		return;
 
 	prop = fdt_getprop(fdt, chosen_node, "linux,ima-kexec-buffer", &len);
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 15632358bcf7..c6ed60f04ea4 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -17,6 +17,10 @@ config KEXEC_ELF
 config HAVE_IMA_KEXEC
 	bool
 
+config HAVE_IMA_KEXEC_OF
+	bool
+	select HAVE_IMA_KEXEC
+
 config KEXEC
 	bool "Enable kexec system call"
 	depends on ARCH_SUPPORTS_KEXEC
-- 
2.43.0


