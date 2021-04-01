Return-Path: <SRS0=m4lh=I6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59336C433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 15:08:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC886115C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 15:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC886115C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FB64l31ksz3cMN
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Apr 2021 02:08:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=XXKremNE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030;
 helo=mail-pj1-x1030.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=XXKremNE; dkim-atps=neutral
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FB6086lKbz3by1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Apr 2021 02:04:08 +1100 (AEDT)
Received: by mail-pj1-x1030.google.com with SMTP id
 f2-20020a17090a4a82b02900c67bf8dc69so3235708pjh.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Apr 2021 08:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vhk5eaBmxWkbr+Epj2Hc1XmHXLbdd/xQRYqCdVqL+Go=;
 b=XXKremNElPwZzRGUX70pZH09o602m8sKz6LJV7GzHjdw4hDDx1KLifXqgg3tGAkVNe
 bkmO+f+Z8hXEWmWh2wBhM9XjUoVWCTomVj3Kyfh9r1kO3P2Pb20t+VkVgNoEnNkmQeIQ
 T7U+B4JijQN34+8e8XOwbYNcJiqaIGCthetrDYHiEGJM9y3KED30jg9jCPQrjNdej/BT
 sbhlBGYhBQulhsdD/kXz6beAspfJKcNnIcL9B2sytrvGPMUHin8zVFnO1UMdRn3kFB9E
 BRdpMBXIO72RahNLKVJOXXLSEwk83EObaLIOHXV1VpP9pWRKLJ043gbf90sZlzLwa6q2
 JVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vhk5eaBmxWkbr+Epj2Hc1XmHXLbdd/xQRYqCdVqL+Go=;
 b=QOWr+8agIJpacj64i1C1Wgo4qT+M1AXz0MXsgbkHj0/gvOWIUq9jMmUhkEdkkNUXeF
 xrf3gQ+0Wi5t5X/0CfBU4rj9fW0pg8bQxCbZgbS8nmmAjCxpxrlSZXuQi6p7H+YPQ2DG
 qXQexdBAr+pgBDY7qs28Qb3ATsYubiA+qvhdx+onxx4Y2CBMAF7PKd9JQop85qOWxrsw
 HfMoy7MQ6p/gjyY24qdjU3yxgBhswDNjq1C4bIV/51mBebDnifL0WAIOrwabUDIB/g54
 +Qx18PDFDZNGOm34gekLaWLFSmNjFA1E6BHZ0fVmpKAiVenb0FWae271bEv0qDP4U75v
 Cw0g==
X-Gm-Message-State: AOAM5303Is+Idxq8+k2OvFM9V9GhEy5E5omkiOhaafUS2g7ZiErs7dRl
 pXI62lAPi4kUGxtV/lKoi8w=
X-Google-Smtp-Source: ABdhPJxoax6gmAncwDS3ZOuydrNdoH19ZPm2BWJTlz+4i83RomB+/QqTXn73aNWH0CyVNw2YNQpHbQ==
X-Received: by 2002:a17:902:a415:b029:e7:137b:ef9c with SMTP id
 p21-20020a170902a415b02900e7137bef9cmr8180384plq.28.1617289446703; 
 Thu, 01 Apr 2021 08:04:06 -0700 (PDT)
Received: from bobo.ibm.com ([1.128.218.207])
 by smtp.gmail.com with ESMTPSA id l3sm5599632pju.44.2021.04.01.08.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Apr 2021 08:04:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v5 09/48] powerpc/64s: remove KVM SKIP test from instruction
 breakpoint handler
Date: Fri,  2 Apr 2021 01:02:46 +1000
Message-Id: <20210401150325.442125-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210401150325.442125-1-npiggin@gmail.com>
References: <20210401150325.442125-1-npiggin@gmail.com>
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
Cc: Fabiano Rosas <farosas@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>, Daniel Axtens <dja@axtens.net>
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

Paul notes: the 0x1300 interrupt was dropped from the architecture a
long time ago and is not generated by P7, P8, P9 or P10.

Acked-by: Paul Mackerras <paulus@ozlabs.org>
Reviewed-by: Daniel Axtens <dja@axtens.net>
Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index a0515cb829c2..c9c446ccff54 100644
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

