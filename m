Return-Path: <SRS0=yiwx=H3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581BFC433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 13:49:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC90764F0A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 13:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC90764F0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DmYzj1zPPz3cnR
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Feb 2021 00:49:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=OPHu1jGz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f;
 helo=mail-pj1-x102f.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=OPHu1jGz; dkim-atps=neutral
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DmYxh4gTKz3ccR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2021 00:47:20 +1100 (AEDT)
Received: by mail-pj1-x102f.google.com with SMTP id t5so5067857pjd.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2021 05:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eJhojtxV4qkzw509yP6Eq/ZPkxtU7/fUkZd3OCkgR3c=;
 b=OPHu1jGz9QvQ28B3ue7zbnd81xaCapKmz+ha0rh06dZZFqf6JHdholBZwFdPYXZuSi
 QJyFsGVusNacpanQWnLBFrpXQieY/L2gm9N/DQ1PCGTpgFgunUCRBE7f3Fsu4lZrnA73
 RHHANpxa1j9t/WQdLs1KurNglGkt8wH0HNQcFWkgk4b+5IRpv+N402x8YH9lwnatE00V
 uztsvC/8Jo59deOsARo6I/XKl4SbnJABkrQvKWhOEotTC/7/iE1hYVYpuRd7/LO8rl9A
 hmR31ce1LT94V7wuB3CJKOHaFmdzppfgQSpkt6RRtX51Q27OXmbv9S1dB8zduUBVNvO1
 ixLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eJhojtxV4qkzw509yP6Eq/ZPkxtU7/fUkZd3OCkgR3c=;
 b=UBifqjyGXQrRNNFEelF8A/FQ52LhYK/54MiO6ft9NGjfruQk+B2rMkAPUI3/lplZBv
 VcFfDe/bJIEpV7HW0yNHzuIihkJLGsqK70bphLE4KBCS4wviV01U3pxx/4O3TuDpfkBj
 2fgv/7V+ArwEFPaTGH092PntC0fdPVqgkr0C53M83Fh9h14rQ1OQGxND26KQTUAHCrVt
 lweiFCmS9+bu8zHYsh09GqPn6OwyLnjQUEwi6i8BSnW0tCqPndfivUEenGnuS3qw+ebl
 fF0sUzNDHDqfi1AoxQguW3rQZlGfH/Lr5rJUze2j9CFB80HjTqzLoh94gB8wwpLwWCAo
 XWyw==
X-Gm-Message-State: AOAM533MfLHptdiUO6buxfQCuyYdUw/RwDFOV4ti0PLb/Yw1+IvSoAfJ
 zQjOxUGygQSCZkqFpBdCTD5G28RKx88=
X-Google-Smtp-Source: ABdhPJyED+odZHpmKwwIYH5DXmA56S7BR1QQijuJXU5K+rDhmPiyYkAyb/pfD9IzVSieJVFjAaUYyw==
X-Received: by 2002:a17:902:e54e:b029:de:8c70:2ec4 with SMTP id
 n14-20020a170902e54eb02900de8c702ec4mr3260154plf.56.1614260838408; 
 Thu, 25 Feb 2021 05:47:18 -0800 (PST)
Received: from bobo.ibm.com (58-6-239-121.tpgi.com.au. [58.6.239.121])
 by smtp.gmail.com with ESMTPSA id a9sm5925868pjq.17.2021.02.25.05.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Feb 2021 05:47:17 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v2 04/37] powerpc/64s: remove KVM SKIP test from instruction
 breakpoint handler
Date: Thu, 25 Feb 2021 23:46:19 +1000
Message-Id: <20210225134652.2127648-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210225134652.2127648-1-npiggin@gmail.com>
References: <20210225134652.2127648-1-npiggin@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 Fabiano Rosas <farosas@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The code being executed in KVM_GUEST_MODE_SKIP is hypervisor code with
MSR[IR]=0, so the faults of concern are the d-side ones caused by access
to guest context by the hypervisor.

Instruction breakpoint interrupts are not a concern here. It's unlikely
any good would come of causing breaks in this code, but skipping the
instruction that caused it won't help matters (e.g., skip the mtmsr that
sets MSR[DR]=0 or clears KVM_GUEST_MODE_SKIP).

Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index a027600beeb1..0097e0676ed7 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -2553,7 +2553,6 @@ EXC_VIRT_NONE(0x5200, 0x100)
 INT_DEFINE_BEGIN(instruction_breakpoint)
 	IVEC=0x1300
 #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
-	IKVM_SKIP=1
 	IKVM_REAL=1
 #endif
 INT_DEFINE_END(instruction_breakpoint)
-- 
2.23.0

