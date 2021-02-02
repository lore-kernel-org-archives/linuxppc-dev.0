Return-Path: <SRS0=8mZb=HF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD02C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 01:18:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CCF864F5F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 01:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCF864F5F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DVkMH5gsZzDwlR
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 12:18:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033;
 helo=mail-pj1-x1033.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=GjDhNjlo; dkim-atps=neutral
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DVMT45mCNzDqnF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Feb 2021 22:06:48 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id m12so2041243pjs.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Feb 2021 03:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FaeqGDPDVUhZKacvJWFVXk0fi+RckdTnjepUSOw+GFs=;
 b=GjDhNjlo8WM1mrgLHvbOwrxZc7nRXMU/VBM1Tv3rS4CBALQMxNJhejkdeZWxgsByVQ
 r4yA/LHh0e7VOATygXnQKPpfmunhm+FbzuphRBa8mrDo2u6pt5O43a/qtl6zUGt1RfPF
 VK4vr39Wvi728wAAs7nvRQZo1BcofDZiCLayrH71cK1QQh1IXyidpqT/jXEB+/E2kNyA
 aTI6AcJujut2yUfbv8gauXhu6ABhOF/47kNxf9e8vgmxLCnhWJS7+AwxsGyKRCLVB346
 /71rQxibTZobs+WTxOlJ4F6F8kdQT0qcnnrrhRg+CI8PNVsnkS9xCwNpFdBNipMMn2Wc
 JKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FaeqGDPDVUhZKacvJWFVXk0fi+RckdTnjepUSOw+GFs=;
 b=C53HElcAJzIj4a5Tg2/nV12ZYTl2dJaQ6sV4wzoJoMKE8C2XyATzf3bRTKNP6ayqrU
 5u9dkOhE6B5OFszFiFby5H1qROjuce8q9E8Sg8mAVRKd67uB3NhxEtVIRyBWu1+0Ma1I
 J5oOuCKXZPihZ9tZTGzix948bHcNbUwn+Sds1lFa14w79Ozir0uJkfmUnK7JNCEa7VzJ
 5UkB0ezoyP7uDeDRawCLBjU0Go8jGboav2YUQNDW7uo+p9m2WLDOHRCri8t9RTU0ER70
 rJGU+lljItUqomb40zUfKk+4zCyqqInJWjzEQ9tP2salAyfAFDqdHkC+oMlW9dBxtHaj
 yrWg==
X-Gm-Message-State: AOAM532BYvU7tt9zIZoiFvnffYLDzkgdsGZDCt+I9cgTYDl35zNgIhXW
 Lftw/eJ6SeckF+D0fC1gC+w=
X-Google-Smtp-Source: ABdhPJynX/oPNKQRM+SLHmtxwuqqGcjp2rkz5lI2AnOP58cVv+dR7CCN1OyW9GXsEsXailS2IkyO1g==
X-Received: by 2002:a17:90b:17ca:: with SMTP id
 me10mr936389pjb.60.1612264006127; 
 Tue, 02 Feb 2021 03:06:46 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (60-242-11-44.static.tpgi.com.au.
 [60.242.11.44])
 by smtp.gmail.com with ESMTPSA id g19sm3188979pfk.113.2021.02.02.03.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Feb 2021 03:06:45 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v12 14/14] powerpc/64s/radix: Enable huge vmalloc mappings
Date: Tue,  2 Feb 2021 21:05:15 +1000
Message-Id: <20210202110515.3575274-15-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210202110515.3575274-1-npiggin@gmail.com>
References: <20210202110515.3575274-1-npiggin@gmail.com>
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
Cc: linux-arch@vger.kernel.org, Ding Tianhong <dingtianhong@huawei.com>,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Christoph Hellwig <hch@infradead.org>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This reduces TLB misses by nearly 30x on a `git diff` workload on a
2-node POWER9 (59,800 -> 2,100) and reduces CPU cycles by 0.54%, due
to vfs hashes being allocated with 2MB pages.

Cc: linuxppc-dev@lists.ozlabs.org
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         |  2 ++
 arch/powerpc/Kconfig                          |  1 +
 arch/powerpc/kernel/module.c                  | 21 +++++++++++++++----
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a10b545c2070..d62df53e5200 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3225,6 +3225,8 @@
 
 	nohugeiomap	[KNL,X86,PPC,ARM64] Disable kernel huge I/O mappings.
 
+	nohugevmalloc	[PPC] Disable kernel huge vmalloc mappings.
+
 	nosmt		[KNL,S390] Disable symmetric multithreading (SMT).
 			Equivalent to smt=1.
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 107bb4319e0e..781da6829ab7 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -181,6 +181,7 @@ config PPC
 	select GENERIC_GETTIMEOFDAY
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMAP		if PPC_BOOK3S_64 && PPC_RADIX_MMU
+	select HAVE_ARCH_HUGE_VMALLOC		if HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KASAN			if PPC32 && PPC_PAGE_SHIFT <= 14
 	select HAVE_ARCH_KASAN_VMALLOC		if PPC32 && PPC_PAGE_SHIFT <= 14
diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index a211b0253cdb..07026335d24d 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -87,13 +87,26 @@ int module_finalize(const Elf_Ehdr *hdr,
 	return 0;
 }
 
-#ifdef MODULES_VADDR
 void *module_alloc(unsigned long size)
 {
+	unsigned long start = VMALLOC_START;
+	unsigned long end = VMALLOC_END;
+
+#ifdef MODULES_VADDR
 	BUILD_BUG_ON(TASK_SIZE > MODULES_VADDR);
+	start = MODULES_VADDR;
+	end = MODULES_END;
+#endif
+
+	/*
+	 * Don't do huge page allocations for modules yet until more testing
+	 * is done. STRICT_MODULE_RWX may require extra work to support this
+	 * too.
+	 */
 
-	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END, GFP_KERNEL,
-				    PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
+	return __vmalloc_node_range(size, 1, start, end, GFP_KERNEL,
+				    PAGE_KERNEL_EXEC,
+				    VM_NO_HUGE_VMAP | VM_FLUSH_RESET_PERMS,
+				    NUMA_NO_NODE,
 				    __builtin_return_address(0));
 }
-#endif
-- 
2.23.0

