Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E9EC282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:50:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D1382087C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 14:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2lEaMvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1382087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tVx30vG1zDqJl
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 01:49:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="D2lEaMvk"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tVFY3340zDqDD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 01:19:13 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id r136so6814028pfc.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Feb 2019 06:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PIAn7ue01CoH9B7817KplVAjs49dUqzKz1mVZ9bLUFE=;
 b=D2lEaMvkPMy1wgEec3mx+V4qiJaiUXmB/M+5z/Cvkd7AtHb+5RgY+JRTDMlXv7V0qZ
 +VBGR/stOciwL6Rp6m/b4w7dhgxziHA3LdHuEBZcDQhYNxkzRa+AgTVqQ0fFnTDWIYql
 6+so8oLc92r0QAYzLNU5IaPqsosvGOr70Ehcj4wh9UC2rVsviVM4rB3pnWcYo2oh7qeg
 KrTuaqUyRzxx96olvyUUvM7OkMqB5yvjnvpEABzlZrXyzFG03okiGMpbQx4yftiaD5AA
 UaYLF3NMxfhStftOugs82E/p5PKnz948ZrOe7jSZLQqeEToCxcVdC4F5HfZml5xosexm
 Zdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PIAn7ue01CoH9B7817KplVAjs49dUqzKz1mVZ9bLUFE=;
 b=dK1Ji+RU92f/pINU67c9btYWopoLEFj5gHWH3DVJyquK9tchPSPCdtaoHiQF6B5VG+
 wLLNX0GVIdA27Waf+VHum9/cjw96e3UD1VP9h3mjg7hEovRH01Tm0uOKdoNsxzehsHo4
 tR7wAmnssKonvEv9iCVQ5/TFo5maRdnmyAQ4/E4UrLDagRoKh7uJjzZrX80nvGF5VTMt
 1wbycQ9GAQh7wd/Qw2RneSghpK/7cQ0Ha8W+4joEjlMXv7rNMFIRcA49VZpHSHa3LRom
 zZTq1oTivQ9hBHK1WFnIL7JMMLHibF4Sjz9T4JOW1sVpVYcsB9ux6GPhj+a5EGShxH1v
 MKWQ==
X-Gm-Message-State: AHQUAuaxBDKdqdhjx6xpmjeMeF7rHvi2v3UHyFQgwdoAxmDBPIL/OHHb
 U/M+mpJuP4opXvrqUwzsHZ/NQLgE
X-Google-Smtp-Source: AHgI3IajWVKdyb6KfTtOiIXnZKPFUh5wK3dBBeFAPCmTKHTRkBIQvLb3q311aXHbSfsi0ZvDOvAtlQ==
X-Received: by 2002:a63:5463:: with SMTP id e35mr11659475pgm.260.1549289951556; 
 Mon, 04 Feb 2019 06:19:11 -0800 (PST)
Received: from roar.local0.net ([210.185.78.69])
 by smtp.gmail.com with ESMTPSA id h9sm226230pgd.53.2019.02.04.06.19.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 06:19:10 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 15/17] powerpc/64s/exception: move KVM related code together
Date: Tue,  5 Feb 2019 00:18:26 +1000
Message-Id: <20190204141828.13043-16-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190204141828.13043-1-npiggin@gmail.com>
References: <20190204141828.13043-1-npiggin@gmail.com>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 40 +++++++++++++-----------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 4d3bd10ea59a..3eb8f9a4eac8 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -339,18 +339,6 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #endif
 .endm
 
-
-#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-/*
- * If hv is possible, interrupts come into to the hv version
- * of the kvmppc_interrupt code, which then jumps to the PR handler,
- * kvmppc_interrupt_pr, if the guest is a PR guest.
- */
-#define kvmppc_interrupt kvmppc_interrupt_hv
-#else
-#define kvmppc_interrupt kvmppc_interrupt_pr
-#endif
-
 /*
  * Branch to label using its 0xC000 address. This results in instruction
  * address suitable for MSR[IR]=0 or 1, which allows relocation to be turned
@@ -375,6 +363,17 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	mtctr	r12;							\
 	bctrl
 
+#else
+#define BRANCH_TO_COMMON(reg, label)					\
+	b	label
+
+#define BRANCH_LINK_TO_FAR(label)					\
+	bl	label
+#endif
+
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+
+#ifdef CONFIG_RELOCATABLE
 /*
  * KVM requires __LOAD_FAR_HANDLER.
  *
@@ -391,19 +390,22 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	bctr
 
 #else
-#define BRANCH_TO_COMMON(reg, label)					\
-	b	label
-
-#define BRANCH_LINK_TO_FAR(label)					\
-	bl	label
-
 #define __BRANCH_TO_KVM_EXIT(area, label)				\
 	ld	r9,area+EX_R9(r13);					\
 	b	label
+#endif
 
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+/*
+ * If hv is possible, interrupts come into to the hv version
+ * of the kvmppc_interrupt code, which then jumps to the PR handler,
+ * kvmppc_interrupt_pr, if the guest is a PR guest.
+ */
+#define kvmppc_interrupt kvmppc_interrupt_hv
+#else
+#define kvmppc_interrupt kvmppc_interrupt_pr
 #endif
 
-#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 .macro KVMTEST hsrr, n
 	lbz	r10,HSTATE_IN_GUEST(r13)
 	cmpwi	r10,0
-- 
2.18.0

