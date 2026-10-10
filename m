Return-Path: <linuxppc-dev+bounces-29178-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4AECA6004
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Oct 2026 12:22:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j22sf1Pw5z3br2;
	Sat, 10 Oct 2026 23:21:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1234"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791634918;
	cv=none; b=a4ZQY8ikUKARDJIBWyFDpBQK+p3HCR62uYygZHRycgaPWzc7Uk3V/iEQ4+QiO7nnpSh6fiFlK9cKwXd3Vps8omlrB5yfGGmmPVmcF+/sjzGoyxVfSiAFpnQDiK8pCveU7tOs9HpSHYEt9lLwG7FHOfGPMC5E7q1sIWOSYLucn0QyWKy3co9rT2liVLaaFuseWcK1GgQRtkOAz3o4z82lth2OxVDEZ7ajhoZ1ynJfrWxN3L12u0mTRetR3FaRzk0/JUEbZufrjZ+xXyNfSnEi6USjrIATrgJ8S6d2b0ZRsuyyQNUBSEJczjwbgCMCNFWLJO7M9zUFRtmvvd74icOodg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791634918; c=relaxed/relaxed;
	bh=CEEN2Zy6O9+c2gqiVvvZWE7KSK1IHYRZNAT8ZPZiGT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fQhQYmwGugcFpUxCPWv/Tiu5jeCVK/jVFT3RHa6FTphnklg8YZ/ohsgj2Az5uUc9f32f4UgKjLu46YPuRz0OhF6AtR+DAxABlB8lM/M7291uhKYu3GC7zz0/CZigdgFPFTj7p/kZ68hK6iv9jS+xIb03G31bJzBV9pdEemSFk/cijpWiGnCk+rT+bp0W3n0fDvW1McgavJtykWtMkFdQUkofGSPa3z37ijRYqa+kruSdh1AEA+iFcw9gTRMhJ6khzYxaKnXAcmcZQ1oLTWMPx9gh7Po5mPL+shRdkRv/Sha7npCRXE1dS5No8t6QJZstoowGzDXJDuKmhajUP2TdEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FQWb4Evs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1234; helo=mail-dl1-x1234.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FQWb4Evs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1234; helo=mail-dl1-x1234.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1234.google.com (mail-dl1-x1234.google.com [IPv6:2607:f8b0:4864:20::1234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j22sd1gqhz3bSn
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 23:21:56 +1100 (AEDT)
Received: by mail-dl1-x1234.google.com with SMTP id a92af1059eb24-1419d3416ceso989179c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 05:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791634915; x=1792239715; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CEEN2Zy6O9+c2gqiVvvZWE7KSK1IHYRZNAT8ZPZiGT0=;
        b=FQWb4EvsugEYHwrWkoPeNR2CuNeuMmu+MGXFW3M+Zje+OyYkpj3JN2/NOPZnrxqaFd
         xUjO3x+fMGEgVEdslwSWFoJXKzwaV63JZumHsvPtmJKBfKMm9mINFxpwdntsLHEimeDO
         iQFOeBbOwatwHRaWpVPs2LgeLBjaWJpU4e5fpz5Vzhz+Z4zNLgH4hkUeHQe2qhePgN6F
         ar5GoyVCuOUX7rPF1M2OcxHoZ0WYBCJlRXyi7YzWb7phR6H1UNMLKYtxfnG5jdJuwZUF
         quAQjZqmsOz+aFGxGh46JmTEn9zLKZeSLc9hGHTPCPb+pWBqcH3XuQBAekwvwyreRDMv
         ZmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791634915; x=1792239715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CEEN2Zy6O9+c2gqiVvvZWE7KSK1IHYRZNAT8ZPZiGT0=;
        b=U2lIraC+QLzgnex3Bx3c1uG1/mqFIDn99A0ICNECmsNdHwNlUDBSdeV/jUZ8C0AwPi
         JGLtFzxCNO+SgUGZ0J++30FXzn+UTkAki9bpMNEUta4dKIfWZqb99q4OAWpdZEcBSAAu
         JYodYZEYBMc65ZZyzGNZXAvaHgmD9n7F21MxHzXdAQaZPq73k8tix3K55UiNvq+/J9pr
         4UJa/ZZGyIcY7w/RVldM6rwTle0sPQLBLvxtU0pyOzlp5pyQDtO390MvVr1mdIobkhXO
         hzgImBkJq/lcOrxGj7Elht5xUvHgv32REOKV3BSPzm1qileU0rNKjCUY3M8MQMO1ZUol
         s43A==
X-Gm-Message-State: AFq9FYLIZaWoEkPrQAt6w79BHelnQDY3ws+SC8cNtbcsZn7Y/MHA/exe
	MljkP8DN0WomN8ssdO8KYfuzKq35u8QkiJBThIqwiTdfZxZOv+T3JNsoPX6sjya8
X-Gm-Gg: AYBFou0bFGEMIeWl+Y/Zvr/AR4I4+UyS8BQhsesr4kMSxHxqWU59tOT5+COxK+7sO3Q
	JZZPNNEqEaCB1Tk6sEySpkyypE9noRQ74F1n67t46SsKsvmnG8wZ/Q1hIb/XWgVn3IVo4W/ikiG
	v0JbmDqs25GJ78zcXpnkwrmOC5HiOX9q3ihUyz9SFeB0T0XD0Eb97lTmlm01d2mEBJa94HMPPI0
	9VLkbb5jP4PLKlxZCQ4SZBm3oAcqLOZ1ARi2G/WCw642cKKvc9Kog5ODmYbYgzbxkNQo0MvU3i/
	I+7kAip4VocJz93eoVMhGto9opp7VzqFPELgwSjiWHZXovo3kQ6X8gmR2a5Jk0NZJlPKOrM3q9V
	Ch4ng1UeSvlVrK3XovoxbbtC1daj4kJ4yt23RBE52JTInCkxmNdC2J8S7TbwmNtwvPr6fra34YZ
	QC9PiWvlWmjIqAXrEAJzo7SK+si5vSM9XYM+3Q8mQMpinclQocqKL5fApeYRBfagNRHX44CdpTL
	D+84ohHOttXZzaEFEAgbNxSKo4lyPDpW1q8HxMUlOOl1UVJOaHiWp3/hs2Z
X-Received: by 2002:a05:7022:ea4e:b0:144:eaa7:2765 with SMTP id a92af1059eb24-16a60ce72e1mr5151179c88.18.1791634914808;
        Sat, 10 Oct 2026 05:21:54 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1becf08sm15401816c88.5.2026.10.10.05.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 05:21:54 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 1/4] powerpc/64s: Add linear_map_use_base_page command line option
Date: Sat, 10 Oct 2026 17:51:09 +0530
Message-Id: <69b592b9741156be07b745f61f45b15c7a6aa31e.1791608423.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1791608423.git.ritesh.list@gmail.com>
References: <cover.1791608423.git.ritesh.list@gmail.com>
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

The radix linear map is built with 1G and 2M mappings wherever it can.
That is the right default for TLB reach, but it also means a single page
cannot be pulled out of the linear map later. There is no support for
splitting a live leaf, so memfd_secret() has nothing to work with.

debug_pagealloc=on already forces PAGE_SIZE mappings, but that turns on
a lot of allocator debugging that nobody wants just for secretmem. Add
linear_map_use_base_page so the linear map can be built out of base
pages on its own. debug_pagealloc=on still implies it.

The extra page tables are roughly 3% of RAM (for 64K pagesize) and it
can also cause extra TLB pressure, so leave the option off by default.

Only radix honours this for now (later we will implement this for Hash as
well).

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         | 10 +++++++++
 arch/powerpc/include/asm/book3s/64/mmu.h      |  2 ++
 arch/powerpc/mm/book3s64/pgtable.c            | 22 +++++++++++++++++++
 arch/powerpc/mm/book3s64/radix_pgtable.c      |  2 +-
 4 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 33cd30996e47..382d18c6e8e8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3563,6 +3563,16 @@ Kernel parameters
 			If there are multiple matching configurations changing
 			the same attribute, the last one is used.
 
+	linear_map_use_base_page[=<bool>]
+			[PPC(Radix), EARLY]
+			Build the kernel linear mapping out of PAGE_SIZE
+			mappings only, instead of using 2M/1G mappings where
+			possible. This allows individual pages to be removed
+			from the linear mapping at runtime, which is required
+			by memfd_secret(2). It costs roughly 3% extra memory for
+			page tables and increases kernel TLB pressure, so it is
+			off by default. debug_pagealloc=on implies this.
+
 	liveupdate=	[KNL,EARLY]
 			Format: <bool>
 			Enable Live Update Orchestrator (LUO).
diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 48631365b48c..3739e5677312 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -73,6 +73,8 @@ extern unsigned int mmu_base_pid;
 
 extern unsigned long __ro_after_init memory_block_size;
 
+bool linear_map_uses_base_pagesize(void);
+
 #define PRTB_SIZE_SHIFT	(mmu_pid_bits + 4)
 #define PRTB_ENTRIES	(1ul << mmu_pid_bits)
 
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 85ab6723c8f2..1a007902f307 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -48,6 +48,28 @@ static int __init parse_kfence_early_init(char *arg)
 early_param("kfence.sample_interval", parse_kfence_early_init);
 #endif
 
+static bool __ro_after_init linear_map_use_base_page;
+
+static int __init parse_linear_map_use_base_page(char *p)
+{
+	bool val;
+
+	if (!p)
+		val = true;
+	else if (kstrtobool(p, &val))
+		return -EINVAL;
+
+	linear_map_use_base_page = val;
+
+	return 0;
+}
+early_param("linear_map_use_base_page", parse_linear_map_use_base_page);
+
+bool linear_map_uses_base_pagesize(void)
+{
+	return debug_pagealloc_enabled() || linear_map_use_base_page;
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /*
  * This is called when relaxing access to a hugepage. It's also called in the page
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index cf692b2b5f7b..2c4cb6d6ab6e 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -308,7 +308,7 @@ static int __meminit create_physical_mapping(unsigned long start,
 	if (mapping_sz_limit < max_mapping_size)
 		max_mapping_size = mapping_sz_limit;
 
-	if (debug_pagealloc_enabled())
+	if (linear_map_uses_base_pagesize())
 		max_mapping_size = PAGE_SIZE;
 
 	start = ALIGN(start, PAGE_SIZE);
-- 
2.39.5


