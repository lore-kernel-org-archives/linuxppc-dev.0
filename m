Return-Path: <SRS0=u7Bz=I4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EB4C433C1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 04:52:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED9E61957
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 04:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED9E61957
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F8cW43v2Yz30LC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 15:52:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=PH9c3K8Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631;
 helo=mail-pl1-x631.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=PH9c3K8Y; dkim-atps=neutral
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F8cVZ33zrz2yhs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Mar 2021 15:51:49 +1100 (AEDT)
Received: by mail-pl1-x631.google.com with SMTP id o2so5510119plg.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Mar 2021 21:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i+RLYpf36ODBBPLbJG0f4dTUZEBgV1e7jabXrJZZ/T0=;
 b=PH9c3K8YwzOwSC2u1vH9MJOUapIvqw6U0sO5HLJVkMOxu1u2VPV5oT5BZiu5yxFb+J
 f7YmhIQYU69TYv8jveOiWOj4bKT5oLaDcy57X/FpBgOlMVD3fIQ9qg/zNr9dR9iQMynZ
 GLfSHUTpV9t3bvIUJAkDhLtzqfUynXuNqL8fHYSRHJMaup1qSIse/2ZnNbPzngeAVSQM
 ORhxk9IdRUQbhN6NJyxXG68BQ4im31d+oOJWTtG9n54m8ZaeiDZWbNIpxGmQYqe9VJGu
 ze4V2MibSCEpKVAyYHVTa9FsVjmj04ItkP05Ar4vpLCr7Cklqx46wO4Cg/d7HHN2u19q
 2d7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i+RLYpf36ODBBPLbJG0f4dTUZEBgV1e7jabXrJZZ/T0=;
 b=jUrcQw35jDXK9M6WKveHkPSPKYyudSZHbOL/7e+YqIPGXmLJgpVky9X1V7q2T9Hdax
 sRF/InlSiMDqFr4em/EYVK929XF+DpAYynYmYF+uQxIb25IDca3ynRuFpLYXbDFwfwOS
 tpuK+Xtloa6DkSKqS7mHGOzT+TZPsYHnI5oVDChEzAQCaEJ0FuIEcmN6hVjTmnaKt6nH
 v4r9aVV3C8YpDBLRfjuKUmLu4ZzbgdhDeJFd/RFWzS98pr3e7EowaSo+gvLEe8vhFxaR
 bgJIMZIgRY/R2coeHRHUFsCFr3ogd49jitoMiqQWO5uSr+wBFqPrauTBooxilTigulKt
 z7AA==
X-Gm-Message-State: AOAM532RNL8mYU4SQMsjisGddzKJN2YdsCawFGfA3klT8CYfvDNareZx
 Yd0ZHmH7uGLOKhiWHAVsRQLfFuGOwvfnrg==
X-Google-Smtp-Source: ABdhPJyF8BM8fjGkUi+56DFGaKfWac4090Kok22X5xO29gyiPzpigMrMBslQQwnd0rhRU5pfDZVbJA==
X-Received: by 2002:a17:902:e80e:b029:e4:b2b8:e36e with SMTP id
 u14-20020a170902e80eb02900e4b2b8e36emr31860468plg.45.1617079905523; 
 Mon, 29 Mar 2021 21:51:45 -0700 (PDT)
Received: from tee480.ibm.com (159-196-117-139.9fc475.syd.nbn.aussiebb.net.
 [159.196.117.139])
 by smtp.gmail.com with ESMTPSA id a18sm14136574pfa.18.2021.03.29.21.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Mar 2021 21:51:45 -0700 (PDT)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v10 00/10] powerpc: Further Strict RWX support
Date: Tue, 30 Mar 2021 15:51:22 +1100
Message-Id: <20210330045132.722243-1-jniethe5@gmail.com>
X-Mailer: git-send-email 2.25.1
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
 Jordan Niethe <jniethe5@gmail.com>, naveen.n.rao@linux.ibm.com, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Another revision to this series adding more Strict RWX support on powerpc, in
particular Strict Module RWX.  This revision adds consideration for bpf.

The changes in v10 for each patch:

Christophe Leroy (2):
  powerpc/mm: implement set_memory_attr()
  powerpc/32: use set_memory_attr()

Jordan Niethe (3):
  powerpc/lib/code-patching: Set up Strict RWX patching earlier
  powerpc: Always define MODULES_{VADDR,END}
    v10: - New to series

  powerpc/bpf: Write protect JIT code
    v10: - New to series

Russell Currey (5):
  powerpc/mm: Implement set_memory() routines
    v10: - WARN if trying to change the hash linear map

  powerpc/kprobes: Mark newly allocated probes as ROX
    v10: - Use __vmalloc_node_range()

  powerpc/mm/ptdump: debugfs handler for W+X checks at runtime
    v10: check_wx_pages now affects kernel_page_tables rather
         then triggers its own action.

  powerpc: Set ARCH_HAS_STRICT_MODULE_RWX
    v10: - Predicate on !PPC_BOOK3S_604
         - Make module_alloc() use PAGE_KERNEL protection

  powerpc/configs: Enable STRICT_MODULE_RWX in skiroot_defconfig

 arch/powerpc/Kconfig                   |   2 +
 arch/powerpc/Kconfig.debug             |   6 +-
 arch/powerpc/configs/skiroot_defconfig |   1 +
 arch/powerpc/include/asm/pgtable.h     |   5 +
 arch/powerpc/include/asm/set_memory.h  |  34 +++++++
 arch/powerpc/kernel/kprobes.c          |  14 +++
 arch/powerpc/kernel/module.c           |  14 +--
 arch/powerpc/lib/code-patching.c       |  12 +--
 arch/powerpc/mm/Makefile               |   2 +-
 arch/powerpc/mm/pageattr.c             | 121 +++++++++++++++++++++++++
 arch/powerpc/mm/pgtable_32.c           |  60 ++----------
 arch/powerpc/mm/ptdump/ptdump.c        |  34 ++++++-
 arch/powerpc/net/bpf_jit_comp.c        |   5 +-
 arch/powerpc/net/bpf_jit_comp64.c      |   4 +
 14 files changed, 245 insertions(+), 69 deletions(-)
 create mode 100644 arch/powerpc/include/asm/set_memory.h
 create mode 100644 arch/powerpc/mm/pageattr.c

-- 
2.25.1

