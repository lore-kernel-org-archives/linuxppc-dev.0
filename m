Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF157C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 09:47:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C26C20880
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 09:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="xabn7bvk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2S0Nrp/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C26C20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444qQ32dV8zDqQj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 20:47:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=66.111.4.26; helo=out2-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="xabn7bvk"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="2S0Nrp/K"; dkim-atps=neutral
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444q9j5tvgzDqQ5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 20:36:41 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 5896721D3C;
 Thu, 21 Feb 2019 04:36:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 21 Feb 2019 04:36:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=W9af/3OISCb3J
 Rn+pdEMmCl8rnXCvaXdCKyI6HzDcso=; b=xabn7bvkUlTUbsQPTJYEYSrOqSGy/
 S6b5K17DXCkkrZQC/mFTlqaaz6od6m8OthQZ6Fm7UqQ6KTSigsq8ptmSBfhJTC5G
 wRRxdWvPEgrundvVXwUa7KqYerW5nCgLRT6bTsFejpNWmVEr8I3dge8+iKtTyREr
 lOPSImO9KDQiCb4HxTiOa42cFVje8Ph+fnGnaQTWCFWBU0XItFRDFSW6pVQJdrp5
 Ee2htyqFUPXG13O4II2cVwhtm2DVXz96TLoDBXClVnsCeDHlFSbHGnsF6b7oLYLL
 IGH/niHls+XI/VDhqVrv38NhpaEdBs0HWHOjrVGtpcORtvFnRCbo7Ujpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=W9af/3OISCb3JRn+pdEMmCl8rnXCvaXdCKyI6HzDcso=; b=2S0Nrp/K
 sFPCCY0i9OiPEThSOt5cfYZrFCieE1fISZZGVtoh35/zMbTZFWy7CWoWXP9ut1MV
 2lU+1hes7NH+Vr3Wt7WqMx5wlp4tzQvFda4g8niMJk7XwmM2IDZw5pExYf0/Rip6
 YzpwUS/UNd4KwQZvzgKn8QAfA3fQSwsJLm+2Cf5TWZa5Zle5X+9u2pluGUW/yYQ7
 ulsufCR4uNaXC57L9lJUL/9PIWnHyHMhCFSaxDkIVab5PJSPHgTDnjtcdZ4ctRWE
 ryTArJ3/gvxtIM/dLY60vRDU7lvRf8OVi+2BKuFnQJ/TyrjH6bRV7QTFi82iprHo
 QlC2zL5ookTfdw==
X-ME-Sender: <xms:J3FuXG2_vXgYNamLoX0JfWXMCqwdT9wVJ1b3-OLZxq32jCX5UcM2oA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtdekgddtjeculddtuddrgedtledrtddtmd
 cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
 uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfedtmdenucfjughrpefhvf
 fufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhushhsvghllhcuvehurhhr
 vgihuceorhhushgtuhhrsehruhhsshgvlhhlrdgttgeqnecukfhppeduvddvrdelledrke
 dvrddutdenucfrrghrrghmpehmrghilhhfrhhomheprhhushgtuhhrsehruhhsshgvlhhl
 rdgttgenucevlhhushhtvghrufhiiigvpeef
X-ME-Proxy: <xmx:J3FuXJCwo-DAtx8xFad-H_zRrQSUl2VNcZgzMRKm6gfkAAJhI_qrjg>
 <xmx:J3FuXKerFGvXkbfjIhuQf7G3_Hiek2HU_TGrZZUXRSc1d6AE3Ptd0Q>
 <xmx:J3FuXMx0wZaFRiHHf2BcnCbrWXvYswqZarrH9X_IsFa-apy2pS22jw>
 <xmx:J3FuXCBlD-CYdGsUTXPFAo2K2C-0EErL6lo0GZsbC7vUL8r7yOWX8w>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id B53B810310;
 Thu, 21 Feb 2019 04:36:36 -0500 (EST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/7] powerpc/mm/radix: Use KUEP API for Radix MMU
Date: Thu, 21 Feb 2019 20:35:59 +1100
Message-Id: <20190221093601.27920-6-ruscur@russell.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221093601.27920-1-ruscur@russell.cc>
References: <20190221093601.27920-1-ruscur@russell.cc>
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
Cc: Russell Currey <ruscur@russell.cc>, npiggin@gmail.com,
 kernel-hardening@lists.openwall.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Execution protection already exists on radix, this just refactors
the radix init to provide the KUEP setup function instead.

Thus, the only functional change is that it can now be disabled.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/mm/pgtable-radix.c        | 12 +++++++++---
 arch/powerpc/platforms/Kconfig.cputype |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 931156069a81..224bcd4be5ae 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -535,8 +535,15 @@ static void radix_init_amor(void)
 	mtspr(SPRN_AMOR, (3ul << 62));
 }
 
-static void radix_init_iamr(void)
+#ifdef CONFIG_PPC_KUEP
+void __init setup_kuep(bool disabled)
 {
+	if (disabled || !early_radix_enabled())
+		return;
+
+	if (smp_processor_id() == boot_cpuid)
+		pr_info("Activating Kernel Userspace Execution Prevention\n");
+
 	/*
 	 * Radix always uses key0 of the IAMR to determine if an access is
 	 * allowed. We set bit 0 (IBM bit 1) of key0, to prevent instruction
@@ -544,6 +551,7 @@ static void radix_init_iamr(void)
 	 */
 	mtspr(SPRN_IAMR, (1ul << 62));
 }
+#endif
 
 void __init radix__early_init_mmu(void)
 {
@@ -605,7 +613,6 @@ void __init radix__early_init_mmu(void)
 
 	memblock_set_current_limit(MEMBLOCK_ALLOC_ANYWHERE);
 
-	radix_init_iamr();
 	radix_init_pgtable();
 	/* Switch to the guard PID before turning on MMU */
 	radix__switch_mmu_context(NULL, &init_mm);
@@ -627,7 +634,6 @@ void radix__early_init_mmu_secondary(void)
 		      __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
 		radix_init_amor();
 	}
-	radix_init_iamr();
 
 	radix__switch_mmu_context(NULL, &init_mm);
 	if (cpu_has_feature(CPU_FTR_HVMODE))
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 7fa5ddbdce12..25cc7d36b27d 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -320,6 +320,7 @@ config PPC_RADIX_MMU
 	bool "Radix MMU Support"
 	depends on PPC_BOOK3S_64
 	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
+	select PPC_HAVE_KUEP
 	default y
 	help
 	  Enable support for the Power ISA 3.0 Radix style MMU. Currently this
-- 
2.20.1

