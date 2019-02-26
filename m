Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6F8C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 08:56:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF8A72147C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 08:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnB8+1c7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8A72147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447t2n2vDZzDq7F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 19:56:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="VnB8+1c7"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447sxD52YYzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 19:51:28 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id 196so5875285pgf.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 00:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=w//6IyHJWKphJY5Mewg+Ps/G6CeWL9p7pVCVT2t80jc=;
 b=VnB8+1c7DYIENOx6Pd6z6yLjwnOqFY5omFPV2gig9njW17KmCk3YNRO4ajDptgcZ9z
 NYqle/uSuY+2ade7d+4r4ys9DkwSjL7g/cGxSKwsn6u7ztfMIsz/7plOZhdFywdFApi8
 Pan5bMq/93fIEtMFMIuS2coyEdc33WOOoQiQjLgYG5wYjcHK0x1KJP/wysKTAGkCNlCx
 eIQ6JSXY3bvQbig/BhQR2qH2A2UWVlNRo02tElZKtC8B5iU6bhnm6SIbaasJnMce70eA
 rVbboaOoORsUc5+BOdhP/xQvrdh8//m6AsRe15U9qoeiwAVShtwacrgZfPz6TI0KVAIT
 F/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=w//6IyHJWKphJY5Mewg+Ps/G6CeWL9p7pVCVT2t80jc=;
 b=A7lhCI/VWj7AIK0Jhp5MtyyMCneEMgzgoWz/QjhjR8vcweSKkAxBWtUxHisxfzUQcU
 hS6edtrv7E9HDYONvDM8Cg6ztp8+NU8/Dy94LhKBKn/CIh04NrXvnaXy+Moj9Ny4qkLv
 ElJxu3p6E0l9pixHiQIaHhfwnOnHJGxgpnvfNm/5uZYyi5WZEB5QpVEDslxw2/V8gByT
 a8OClRp8wUiFt2jHtO/1vecUuUDGWhq/gWRtw6AayAL/py4BIF+5u86lPMWvVEkQnQek
 35mWInsi0gKliQhKTFEDTsxO2Q22atEzsXpgNHYYAN/gs9Ciq6OaWmkrYrOb+6ASRmn6
 hBeA==
X-Gm-Message-State: AHQUAuZD6UmLHQyA3E6c2IqqXF2E94yGGG2qhBifib452GHmDBH4/ZMK
 3DwiTbeP2vMXaRGfPEKIJA1I+rlZ
X-Google-Smtp-Source: AHgI3IaQZb6EBbRmLthIB/YNf+p28WDt3MVSXgmH/wSj3/dPln3f8+cf2DR1ilS2FqQYft81v6+8uQ==
X-Received: by 2002:a63:f310:: with SMTP id l16mr23173375pgh.72.1551171086339; 
 Tue, 26 Feb 2019 00:51:26 -0800 (PST)
Received: from roar.local0.net ([125.254.1.96])
 by smtp.gmail.com with ESMTPSA id t10sm29217103pfa.151.2019.02.26.00.51.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 00:51:25 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 2/4] powerpc/64s: system reset interrupt preserve HSRRs
Date: Tue, 26 Feb 2019 18:51:08 +1000
Message-Id: <20190226085110.29653-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190226085110.29653-1-npiggin@gmail.com>
References: <20190226085110.29653-1-npiggin@gmail.com>
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

Code that uses HSRR registers is not required to clear MSR[RI] by
convention, however the system reset NMI itself may use HSRR
registers (e.g., to call OPAL) and clobber them.

Rather than introduce the requirement to clear RI in order to use
HSRRs, have system reset interrupt save and restore HSRRs.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/traps.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 12b54908c15d..f2191755fdf5 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -442,14 +442,32 @@ void hv_nmi_check_nonrecoverable(struct pt_regs *regs)
 
 void system_reset_exception(struct pt_regs *regs)
 {
+	unsigned long hsrr0, hsrr1;
+	bool nested = in_nmi();
+	bool saved_hsrrs = false;
+
 	/*
 	 * Avoid crashes in case of nested NMI exceptions. Recoverability
 	 * is determined by RI and in_nmi
 	 */
-	bool nested = in_nmi();
 	if (!nested)
 		nmi_enter();
 
+	/*
+	 * System reset can interrupt code where HSRRs are live and MSR[RI]=1.
+	 * The system reset interrupt itself may clobber HSRRs (e.g., to call
+	 * OPAL), so save them here and restore them before returning.
+	 *
+	 * Machine checks don't need to save HSRRs, as the real mode handler
+	 * is careful to avoid them, and the regular handler is not delivered
+	 * as an NMI.
+	 */
+	if (cpu_has_feature(CPU_FTR_HVMODE)) {
+		hsrr0 = mfspr(SPRN_HSRR0);
+		hsrr1 = mfspr(SPRN_HSRR1);
+		saved_hsrrs = true;
+	}
+
 	hv_nmi_check_nonrecoverable(regs);
 
 	__this_cpu_inc(irq_stat.sreset_irqs);
@@ -499,6 +517,11 @@ void system_reset_exception(struct pt_regs *regs)
 	if (!(regs->msr & MSR_RI))
 		nmi_panic(regs, "Unrecoverable System Reset");
 
+	if (saved_hsrrs) {
+		mtspr(SPRN_HSRR0, hsrr0);
+		mtspr(SPRN_HSRR1, hsrr1);
+	}
+
 	if (!nested)
 		nmi_exit();
 
-- 
2.18.0

