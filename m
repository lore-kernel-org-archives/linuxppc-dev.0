Return-Path: <SRS0=MsOR=LD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ACAC4743D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jun 2021 01:36:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F314B61042
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jun 2021 01:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F314B61042
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G08pY1hk5z3cDW
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jun 2021 11:36:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=LPy9dNYy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52c;
 helo=mail-pg1-x52c.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=LPy9dNYy; dkim-atps=neutral
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G08mc6JHkz309H
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jun 2021 11:34:56 +1000 (AEST)
Received: by mail-pg1-x52c.google.com with SMTP id y11so9920148pgp.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Jun 2021 18:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wElaRe/HPCovqN7hkQ2IiQyQLOhk9QoYWe+561JgrOY=;
 b=LPy9dNYy8NifW1+hAf0MQfHplqgjoj10zQuEeCG/INMhDtU5SXbnneGGV3cpuRLm78
 Q99eBusMaggQGR31quDvnWud+6RvTsz3Cc2QH4qfh2oh2qJF9kS+1JI+Ume7SsfuybGY
 mfzgZUwLZF8Ak41+XHkQc5o1RtS8QtMtdGrQmyYilqwldQP3fAAF+Ju1gVqaE3XKlE0E
 m6RfrN5sjnoSQ0HZbLj0y4ugnLDXuyRhYdZUuVd7Gh/9tMgvMkXyHWDqzauSTdvwyQdO
 ElL3TBXte27wYQhlgNNRpeNEVumN5nti0DDyY+H9ShHcbAtuQPQjP33KxiVjIey3xQwi
 Qiww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wElaRe/HPCovqN7hkQ2IiQyQLOhk9QoYWe+561JgrOY=;
 b=g/ncv/Jh31LWaTnc0HIz/vkTTY8PQEgZ6AupFbBxHkt/4KzEG/LySassd6njdT5OCB
 E52HNIsPXsRINPpkkVyn3eNOUDzzFL02rzkinfDhXNQhZlwAfMFm46ITcHt4UjE8X7gr
 iGZ62gt+7q5SWwDtZqg9B4K8q547kxFtQSXVRQj6oebZCh1ESCWxRZ0NqqFw2qTH5Wxv
 8byDu0Zmse4OLcEug5/B6gOr6KOODlX+2KMBzOmhIocC/ygmKIcSgDBrOArjehdZWUwI
 4AsNNPc/RtiNAp+Z42YlhUrTVYyXU7F9QiVTzV5KDlB4F40oDfP00i46wd6TQeSyR8sO
 Mx+w==
X-Gm-Message-State: AOAM530Mv0VIh7l0BKlpHry4RBxn7sJYbzKSKhbXTfHlpmJPmyjrQzap
 1UsPxgcE6paOCm/jWNFYpl7DP3rZ1FE=
X-Google-Smtp-Source: ABdhPJwY5zoSCvbIvEA/vODmR2pCk9bSonM1wD/QLSV2fK1Y9t7qtzVZynnD+ZZtr+2/cBAIRULb0w==
X-Received: by 2002:a62:6491:0:b029:28e:8c90:6b16 with SMTP id
 y139-20020a6264910000b029028e8c906b16mr2662305pfb.24.1623202493489; 
 Tue, 08 Jun 2021 18:34:53 -0700 (PDT)
Received: from tee480.ozlabs.ibm.com (110-175-254-242.static.tpgi.com.au.
 [110.175.254.242])
 by smtp.gmail.com with ESMTPSA id s10sm11369406pfk.186.2021.06.08.18.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jun 2021 18:34:53 -0700 (PDT)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v15 3/9] powerpc/modules: Make module_alloc() Strict Module
 RWX aware
Date: Wed,  9 Jun 2021 11:34:25 +1000
Message-Id: <20210609013431.9805-4-jniethe5@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609013431.9805-1-jniethe5@gmail.com>
References: <20210609013431.9805-1-jniethe5@gmail.com>
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
Cc: ajd@linux.ibm.com, cmr@codefail.de, npiggin@gmail.com,
 aneesh.kumar@linux.ibm.com, naveen.n.rao@linux.ibm.com,
 Jordan Niethe <jniethe5@gmail.com>, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Make module_alloc() use PAGE_KERNEL protections instead of
PAGE_KERNEL_EXEX if Strict Module RWX is enabled.

Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
v14: - Split out from powerpc: Set ARCH_HAS_STRICT_MODULE_RWX
     - Add and use strict_module_rwx_enabled() helper
---
 arch/powerpc/include/asm/mmu.h | 5 +++++
 arch/powerpc/kernel/module.c   | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 998fe01dd1a8..27016b98ecb2 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -345,6 +345,11 @@ static inline bool strict_kernel_rwx_enabled(void)
 	return false;
 }
 #endif
+
+static inline bool strict_module_rwx_enabled(void)
+{
+	return IS_ENABLED(CONFIG_STRICT_MODULE_RWX) && strict_kernel_rwx_enabled();
+}
 #endif /* !__ASSEMBLY__ */
 
 /* The kernel use the constants below to index in the page sizes array.
diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index 3f35c8d20be7..ed04a3ba66fe 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -92,12 +92,14 @@ int module_finalize(const Elf_Ehdr *hdr,
 static __always_inline void *
 __module_alloc(unsigned long size, unsigned long start, unsigned long end)
 {
+	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
+
 	/*
 	 * Don't do huge page allocations for modules yet until more testing
 	 * is done. STRICT_MODULE_RWX may require extra work to support this
 	 * too.
 	 */
-	return __vmalloc_node_range(size, 1, start, end, GFP_KERNEL, PAGE_KERNEL_EXEC,
+	return __vmalloc_node_range(size, 1, start, end, GFP_KERNEL, prot,
 				    VM_FLUSH_RESET_PERMS | VM_NO_HUGE_VMAP,
 				    NUMA_NO_NODE, __builtin_return_address(0));
 }
-- 
2.25.1

