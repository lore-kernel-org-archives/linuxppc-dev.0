Return-Path: <SRS0=+E7l=JU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFED6C433ED
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Apr 2021 03:12:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 571C661445
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Apr 2021 03:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571C661445
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FRK9N01dpz3bsS
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Apr 2021 13:12:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=mwm4jume;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636;
 helo=mail-pl1-x636.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=mwm4jume; dkim-atps=neutral
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FRK7b4PB8z2ysm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Apr 2021 13:11:23 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id t22so24226445ply.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Apr 2021 20:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KC1MpzfZtSO0WGF5h+z+8jnyGB55U8R9yQfcOBF9yio=;
 b=mwm4jumeHO+N54uTgl1iv/3DRcBHD2Eg8F7qBw8h6YV0QEHhKRDw7xYgHshhhJ9Zmo
 3cS4zMB70v1uNDKAXj/Mq1RPPFtmYdazMMYO0dzAHPG5uIzriBv/v1ruAXGCw9i/npdE
 TR5I1Cvm/lK5GvBTCyavnh3+igdKYG+UvE9awP0cxjpGR0AdKW+2rB/1yc4fAzyrJlrF
 IVM4sntCBGBqDMtpEHGZJXkNBXBcoJIJRxMXNOABF1f3WgyNgVM48bB/vCIMG4hxVkl+
 +0cnaTPu70+SlhnpioLmxW9s6tNnnuwLkbFccFx9jFEdU/Kx/kISIdLf7IrbTuOQXifg
 5DTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KC1MpzfZtSO0WGF5h+z+8jnyGB55U8R9yQfcOBF9yio=;
 b=QypqkbHN5W8mUxnczKeo5pF59T9ZPShlbkTBKGMtwORBsZ7a5EKzHBelGv8TBwtp43
 YQWlyl7PWIjCkgGBUn1ec0QtK+MGNoONoeFFahN4AvSrfUHxtVG3eI1CUWQ6J1cau6Vx
 CV4zUBFxqvLqUSQJAZsqeEuG1xyPIElJinELV6pgCjb2aauoIzqZB/CqT9Fx+SkK1AtU
 sIvfuJUpKMx1PUKuXmWESfNMpDqIXF69diK00vc2C9f05X58vsPNftTmPekMHKcix9g2
 yh733lqWGrYqbbnvj4SDBcCbf70AbTVrdiYk+5hexNQhgc3pl6lXkr5dB/GRFcPe9VBD
 YEQw==
X-Gm-Message-State: AOAM532sofMlNM9hzQDn3TMNJfz1BqSBjm4zSeXwNTrwW70yS6Nyph0n
 RiPRJ7yH5ZOm0wCt0+y7zi7U41THgmM=
X-Google-Smtp-Source: ABdhPJzTdbTfHxPsFg/xPehHDiFzxuWqEq7gTBHbkUFz/NWY6UutQSzQ+zE6IVMIQrSB6XLJNm0nzA==
X-Received: by 2002:a17:90a:8b97:: with SMTP id
 z23mr2068133pjn.65.1619147481135; 
 Thu, 22 Apr 2021 20:11:21 -0700 (PDT)
Received: from bobo.ibm.com ([59.102.87.99])
 by smtp.gmail.com with ESMTPSA id k1sm3511962pgk.9.2021.04.22.20.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Apr 2021 20:11:20 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/4] powerpc/pseries: use notrace hcall variant for H_CEDE idle
Date: Fri, 23 Apr 2021 13:11:07 +1000
Message-Id: <20210423031108.1046067-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210423031108.1046067-1-npiggin@gmail.com>
References: <20210423031108.1046067-1-npiggin@gmail.com>
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
Cc: "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Rather than special-case H_CEDE in the hcall trace wrappers, make the
idle H_CEDE call use plpar_hcall_norets_notrace().

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/plpar_wrappers.h |  6 +++++-
 arch/powerpc/platforms/pseries/lpar.c     | 10 ----------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
index ece84a430701..83e0f701ebc6 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -28,7 +28,11 @@ static inline void set_cede_latency_hint(u8 latency_hint)
 
 static inline long cede_processor(void)
 {
-	return plpar_hcall_norets(H_CEDE);
+	/*
+	 * We cannot call tracepoints inside RCU idle regions which
+	 * means we must not trace H_CEDE.
+	 */
+	return plpar_hcall_norets_notrace(H_CEDE);
 }
 
 static inline long extended_cede_processor(unsigned long latency_hint)
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 0641779e5cde..835e7f661a05 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -1839,13 +1839,6 @@ notrace void __trace_hcall_entry(unsigned long opcode, unsigned long *args)
 	unsigned long flags;
 	unsigned int *depth;
 
-	/*
-	 * We cannot call tracepoints inside RCU idle regions which
-	 * means we must not trace H_CEDE.
-	 */
-	if (opcode == H_CEDE)
-		return;
-
 	local_irq_save(flags);
 
 	depth = this_cpu_ptr(&hcall_trace_depth);
@@ -1867,9 +1860,6 @@ notrace void __trace_hcall_exit(long opcode, long retval, unsigned long *retbuf)
 	unsigned long flags;
 	unsigned int *depth;
 
-	if (opcode == H_CEDE)
-		return;
-
 	local_irq_save(flags);
 
 	depth = this_cpu_ptr(&hcall_trace_depth);
-- 
2.23.0

