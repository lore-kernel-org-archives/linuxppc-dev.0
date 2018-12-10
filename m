Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072CFC65BAF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 07:05:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EEB7205C9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 07:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q+8qUHAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EEB7205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43CvGz3CpkzDqPR
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 18:05:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q+8qUHAp";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (helo)
 smtp.helo=out1-smtp.messagingengine.com (client-ip=66.111.4.25;
 helo=out1-smtp.messagingengine.com; envelope-from=ruscur@russell.cc;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="Q+8qUHAp"; dkim-atps=neutral
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Cv9F6VKNzDqsj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 18:00:33 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 248CE21D0C;
 Mon, 10 Dec 2018 02:00:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Mon, 10 Dec 2018 02:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=jXZseDeB0rjmPwzPlsXPjsGfNInIjhjIkcFiU8pGsdg=; b=Q+8qUHAp
 0xb4/iPhF8/IDqrnv3dl4nOPD08kyTrKXX9EES3DdeKdAvoi4HvhrU6jwwZAOU9P
 ZOYJb7iHeRe6tfv0CY9AizZ2scZIATctIxNwWpRMpnsTeezk+0em1QSqRE3ZNMxv
 sVkBiMk03zkDHp/7rNXkgNMtxWX9Z8DuAcfd21yw9vT7WxqMmuP7G4GLAkBVlZJn
 lgdDTMI4Rni9olksEX2mhtE/LMFrSaRdRC9F5ptHIbp1rl67bcuVnuv7zwF9zdWF
 B4QdzuCzAJsQ4CVwAGJtdoKxiBYSz3v2H90c7wSxJ0MrftUma9Yl/E2kjgRKLgSv
 bNNeNUrhdzSfWA==
X-ME-Sender: <xms:Cw8OXKsTI7FXIukAteM2TU6wylOjMUTxC4iP-xPm-DiIYG7o1yUkEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudeggedguddtiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
 fedttdenucgfrhhlucfvnfffucdlfedtmdenucfjughrpefhvffufffkofgjfhgggfestd
 ekredtredttdenucfhrhhomheptfhushhsvghllhcuvehurhhrvgihuceorhhushgtuhhr
 sehruhhsshgvlhhlrdgttgeqnecukfhppeduvddvrdelledrkedvrddutdenucfrrghrrg
 hmpehmrghilhhfrhhomheprhhushgtuhhrsehruhhsshgvlhhlrdgttgenucevlhhushht
 vghrufhiiigvpedt
X-ME-Proxy: <xmx:Cw8OXPwRRiNfj9t-RNu3wKdkikOy3Wj2r5Q4EIHYXRNFRu7OtZG7pw>
 <xmx:Cw8OXDe88vdoUgqIxNFP0D8VlBoVVDGj4r2Rg_a-aShZxVcc0ML_vg>
 <xmx:DA8OXAf09-A4w8h0FV4bgVJg-zAez5eJxujgYrHH1mSY4I43AsBo0w>
 <xmx:DA8OXFGT0IUPZBvjmamuu0jyHd6aS4DH548gQD8mCHZm8VgS_9DuZw>
 <xmx:DA8OXCUfSUxg2XWBTwHJaXrs8h30sVEk8b9A2Wq7QDnadP_4Mk9toA>
 <xmx:DA8OXNAjzh73XLkHG9aaRkPEkbA6yUxl0itYxWoa6sZFq7THcCIwqg>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id 39F72E4892;
 Mon, 10 Dec 2018 02:00:24 -0500 (EST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/3] powerpc/mm/radix: Use KUEP API for Radix MMU
Date: Mon, 10 Dec 2018 18:00:42 +1100
Message-Id: <20181210070044.27503-2-ruscur@russell.cc>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210070044.27503-1-ruscur@russell.cc>
References: <20181210070044.27503-1-ruscur@russell.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: mikey@neuling.org, kernel-hardening@lists.openwall.com,
 Russell Currey <ruscur@russell.cc>, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Execution protection already exists on radix, this just refactors
the radix init to provide the KUEP setup function instead.

Thus, the only functional change is that it can now be disabled.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/mm/pgtable-radix.c        | 11 ++++++++---
 arch/powerpc/platforms/Kconfig.cputype |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 931156069a81..3565e266994b 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -535,8 +535,14 @@ static void radix_init_amor(void)
 	mtspr(SPRN_AMOR, (3ul << 62));
 }
 
-static void radix_init_iamr(void)
+#ifdef CONFIG_PPC_KUEP
+void __init setup_kuep(bool disabled)
 {
+	if (disabled || !early_radix_enabled())
+		return;
+
+	pr_warn("Activating Kernel Userspace Execution Prevention\n");
+
 	/*
 	 * Radix always uses key0 of the IAMR to determine if an access is
 	 * allowed. We set bit 0 (IBM bit 1) of key0, to prevent instruction
@@ -544,6 +550,7 @@ static void radix_init_iamr(void)
 	 */
 	mtspr(SPRN_IAMR, (1ul << 62));
 }
+#endif
 
 void __init radix__early_init_mmu(void)
 {
@@ -605,7 +612,6 @@ void __init radix__early_init_mmu(void)
 
 	memblock_set_current_limit(MEMBLOCK_ALLOC_ANYWHERE);
 
-	radix_init_iamr();
 	radix_init_pgtable();
 	/* Switch to the guard PID before turning on MMU */
 	radix__switch_mmu_context(NULL, &init_mm);
@@ -627,7 +633,6 @@ void radix__early_init_mmu_secondary(void)
 		      __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
 		radix_init_amor();
 	}
-	radix_init_iamr();
 
 	radix__switch_mmu_context(NULL, &init_mm);
 	if (cpu_has_feature(CPU_FTR_HVMODE))
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 9997b5ea5693..48cc8df0fdd2 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -335,6 +335,7 @@ config PPC_RADIX_MMU
 	bool "Radix MMU Support"
 	depends on PPC_BOOK3S_64
 	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
+	select PPC_HAVE_KUEP
 	default y
 	help
 	  Enable support for the Power ISA 3.0 Radix style MMU. Currently this
-- 
2.19.2

