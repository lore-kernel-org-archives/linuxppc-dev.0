Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B78C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 06:43:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 685522148D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 06:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="TibbSA/v";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IiXRCeJD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 685522148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44prPH2Vj4zDqVx
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 16:43:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=64.147.123.24; helo=wout1-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="TibbSA/v"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="IiXRCeJD"; dkim-atps=neutral
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44prKl5SCvzDqT5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 16:40:27 +1000 (AEST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 64FB346C;
 Wed, 24 Apr 2019 02:40:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 24 Apr 2019 02:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=7MyW4GxXhW1W5
 8ONqyyz8LLG6ocOURmExBJLXh9tlbI=; b=TibbSA/vvYV2dySn7O4nyojicdG8u
 R8o6PYLTMMdI+iFU9F9JrRsN1ascxOKLuXBPrznga5xU6Do2/yMr85ZhGPmm4zVl
 vR2SUtx9GAr+wwPYRr0e9ltsbhQfzXiZlFDG6KMQbXerAzrYSW79kUO8aCGaFh6k
 mkpfpZYCStdFAoqVLahuenJi9VGAJ6tzoUBwAOBW0i4xXDt3CN6Lyb8UoyVRGZr0
 FPVxZ2Q07ui9oA3wqqG2Q3lqdz5ybO2gXUBDeSTv7btdZO1Dxp+IiB8FXwm1QmjU
 oewluQTriDc1qekM2KTbvF0LgEgCZMBxlEpn/aQyDGNZlquyhO54+OdAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=7MyW4GxXhW1W58ONqyyz8LLG6ocOURmExBJLXh9tlbI=; b=IiXRCeJD
 ppWv0ulj5lsDei/UZJ52IjROlB/P3lkNVod1eMRwnxHHG58/lQ+krjLSkcmMH3zV
 w8fY3xPuv0nvg1TaAqF+OLkeRnpkhF9Lu1oQr1DTwoZ0WooKZY/ma1sFBd2Q7/GR
 vwJEMaKxxnnK8fn87wAessQyCHam0czQaRhthLYER2Ru3BC16E+RS9R6WJqZ2Crf
 IXDKUq7EHnaQEs0p/wvgxO52fpE8aMh/5NfktUH1ssTEWs3nES1Kb+8y1MAxG/RJ
 Zrmd0cJZN3/YmTdkRWWXlfXhn36TihCftnRvvg/GnRieyjgoT2xMvo+bKd4USUff
 u5LuyiCmMOuEEw==
X-ME-Sender: <xms:2ATAXFhyKKcBglwYr-wZU3zhNF5oj1DcTbJpgnEtkZ08nQPTi-xOMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrgeelgddutdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfedtmdenucfjughrpefhvf
 fufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhushhsvghllhcuvehurhhr
 vgihuceorhhushgtuhhrsehruhhsshgvlhhlrdgttgeqnecukfhppeduvddvrdelledrke
 dvrddutdenucfrrghrrghmpehmrghilhhfrhhomheprhhushgtuhhrsehruhhsshgvlhhl
 rdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:2ATAXCKREmdWZ6tl9o0ta8mn6Ga7p-m-zCxCQQ8zXYhO4ndCBp10XA>
 <xmx:2ATAXEllPaI4VeGG-M8bRMz7H4W9MJN78bNOtnPrj_RoOkG5bxuVIg>
 <xmx:2ATAXKM02jxLbUzcCy6MLCWUlURPTrMxy9B-ZvOzHXsCHzOVFg3aWQ>
 <xmx:2QTAXFAKA4OTNmwbPtylau-flO6OKQxoz7JGTnyfWjR4Gx4Ap8W_Pg>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id 058F210316;
 Wed, 24 Apr 2019 02:40:21 -0400 (EDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/mm: Warn if W+X pages found on boot
Date: Wed, 24 Apr 2019 16:39:58 +1000
Message-Id: <20190424063958.24559-2-ruscur@russell.cc>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424063958.24559-1-ruscur@russell.cc>
References: <20190424063958.24559-1-ruscur@russell.cc>
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
Cc: Julia.Lawall@lip6.fr, rashmica.g@gmail.com,
 Russell Currey <ruscur@russell.cc>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Implement code to walk all pages and warn if any are found to be both
writable and executable.  Depends on STRICT_KERNEL_RWX enabled, and is
behind the DEBUG_WX config option.

This only runs on boot and has no runtime performance implications.

Very heavily influenced (and in some cases copied verbatim) from the
ARM64 code written by Laura Abbott (thanks!), since our ptdump
infrastructure is similar.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/Kconfig.debug         | 19 +++++++++++++++
 arch/powerpc/include/asm/pgtable.h |  5 ++++
 arch/powerpc/mm/pgtable_32.c       |  5 ++++
 arch/powerpc/mm/pgtable_64.c       |  5 ++++
 arch/powerpc/mm/ptdump/ptdump.c    | 38 ++++++++++++++++++++++++++++++
 5 files changed, 72 insertions(+)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 4e00cb0a5464..a4160ff02ed4 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -361,6 +361,25 @@ config PPC_PTDUMP
 
 	  If you are unsure, say N.
 
+config DEBUG_WX
+	bool "Warn on W+X mappings at boot"
+	select PPC_PTDUMP
+	---help---
+	  Generate a warning if any W+X mappings are found at boot.
+
+	  This is useful for discovering cases where the kernel is leaving
+	  W+X mappings after applying NX, as such mappings are a security risk.
+
+	  Note that even if the check fails, your kernel is possibly
+	  still fine, as W+X mappings are not a security hole in
+	  themselves, what they do is that they make the exploitation
+	  of other unfixed kernel bugs easier.
+
+	  There is no runtime or memory usage effect of this option
+	  once the kernel has booted up - it's a one time check.
+
+	  If in doubt, say "Y".
+
 config PPC_FAST_ENDIAN_SWITCH
 	bool "Deprecated fast endian-switch syscall"
         depends on DEBUG_KERNEL && PPC_BOOK3S_64
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 505550fb2935..be785f221e56 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -104,6 +104,11 @@ void pgtable_cache_init(void);
 
 #if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_PPC32)
 void mark_initmem_nx(void);
+
+#ifdef CONFIG_DEBUG_WX
+extern void ptdump_check_wx(void);
+#endif /* CONFIG_DEBUG_WX */
+
 #else
 static inline void mark_initmem_nx(void) { }
 #endif
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 6e56a6240bfa..054a6174ff7f 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -384,6 +384,11 @@ void mark_rodata_ro(void)
 		   PFN_DOWN((unsigned long)__start_rodata);
 
 	change_page_attr(page, numpages, PAGE_KERNEL_RO);
+
+#ifdef CONFIG_DEBUG_WX
+	// mark_initmem_nx() should have already run by now
+	ptdump_check_wx();
+#endif
 }
 #endif
 
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index fb1375c07e8c..48036b25a958 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -328,6 +328,11 @@ void mark_rodata_ro(void)
 		radix__mark_rodata_ro();
 	else
 		hash__mark_rodata_ro();
+
+#ifdef CONFIG_DEBUG_WX
+	// mark_initmem_nx() should have already run by now
+	ptdump_check_wx();
+#endif
 }
 
 void mark_initmem_nx(void)
diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index c50cb7faa334..b4b09df839bb 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -68,6 +68,8 @@ struct pg_state {
 	unsigned long last_pa;
 	unsigned int level;
 	u64 current_flags;
+	bool check_wx;
+	unsigned long wx_pages;
 };
 
 struct addr_marker {
@@ -177,6 +179,19 @@ static void dump_addr(struct pg_state *st, unsigned long addr)
 
 }
 
+static void note_prot_wx(struct pg_state *st, unsigned long addr)
+{
+	if (!st->check_wx)
+		return;
+	if (!((st->current_flags & _PAGE_EXEC) && (st->current_flags & _PAGE_WRITE)))
+		return;
+
+	WARN_ONCE(1, "powerpc/mm: Found insecure W+X mapping at address %p/%pS\n",
+		  (void *)st->start_address, (void *)st->start_address);
+
+	st->wx_pages += (addr - st->start_address) / PAGE_SIZE;
+}
+
 static void note_page(struct pg_state *st, unsigned long addr,
 	       unsigned int level, u64 val)
 {
@@ -206,6 +221,7 @@ static void note_page(struct pg_state *st, unsigned long addr,
 
 		/* Check the PTE flags */
 		if (st->current_flags) {
+			note_prot_wx(st, addr);
 			dump_addr(st, addr);
 
 			/* Dump all the flags */
@@ -378,6 +394,28 @@ static void build_pgtable_complete_mask(void)
 				pg_level[i].mask |= pg_level[i].flag[j].mask;
 }
 
+void ptdump_check_wx(void)
+{
+	struct pg_state st = {
+		.seq = NULL,
+		.marker = address_markers,
+		.check_wx = true,
+	};
+
+	if (radix_enabled())
+		st.start_address = PAGE_OFFSET;
+	else
+		st.start_address = KERN_VIRT_START;
+
+	walk_pagetables(&st);
+
+	if (st.wx_pages)
+		pr_warn("Checked W+X mappings: FAILED, %lu W+X pages found\n",
+			st.wx_pages);
+	else
+		pr_info("Checked W+X mappings: passed, no W+X pages found\n");
+}
+
 static int ptdump_init(void)
 {
 	struct dentry *debugfs_file;
-- 
2.21.0

