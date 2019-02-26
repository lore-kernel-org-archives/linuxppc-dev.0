Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABCCC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 06:14:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D8FA2173C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 06:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwwNh/cC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8FA2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447pS01Ry5zDqSt
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 17:14:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="PwwNh/cC"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447pLF3lmXzDqNl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 17:09:25 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id s22so5704560pfh.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 22:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=w//6IyHJWKphJY5Mewg+Ps/G6CeWL9p7pVCVT2t80jc=;
 b=PwwNh/cCMhIMpSdRC6mHvch0wrXhYaDbhBm7MZNS2BuucYp5dcy39UPb9QDnxAEKL+
 2CHhvk/Z60qTSb9Qp2s+gAjBZgDFWopCQacOcrZzElaUYrll1e1pznZjAzZzdhfKMcDn
 NtsZsYMbwroXC/sC/CSow5MmMNd72osEfW+jQDWr3ahYVbYLw95Ag1KA80FPIQcrtxfV
 SreljFnznFZ0VmC93fDqcXeFsPOyi54xuMxIWOdV6B3FaW71d7L5w1z+0gV/pBjm5lYN
 vH6FFi/3WuJqoezsRxD/zX+KnytGDKLPEamodGfdJOrQpBVpU+v7tt8qWZ6UioRDH9mx
 LrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=w//6IyHJWKphJY5Mewg+Ps/G6CeWL9p7pVCVT2t80jc=;
 b=gIc/9K34Eshi0Nl2hHtzYfnNJbxinK/HCxKjKNTkDa418tpWV0rPQ/PS/8nJolQwEH
 MH9yS2tNt25Y0ekTFxdcm79e6c3J2EBqigZUhrxX4Ts5VjVWFqA6qBs76kmwLEMdZt/D
 UaVvsZ2aOJ7jo0tWFGOsq3jHptPDKlaPz8PiekodJGR9vO/yT+n5SRM2boIaS+BYdw8l
 7t1ZVyLUSBzSzt9uvq2HkfWIJBxgqiuJTTFgCAOhDpVilDkUcmpGIRY5Uo1UVG7/GHKF
 X5B7FI3XvpfTsGPMoEclR20cjSK2L5wqfojONjhAxBlEExU6Tk0ilwsknug/x3cu/vyr
 jlEg==
X-Gm-Message-State: AHQUAub5GhlrFFGqhb6Aj0H4NXOnaa7Zxb3EX4a46RoJfy4ZpB4ItkJl
 pJEIR2QL/os1U44Xh0wNOo6nKYcm7f4=
X-Google-Smtp-Source: AHgI3IaQJARwhh7DjG9hwKScJTesMdL83KYPi9A9xw7LvGkhiDD41gder0tWmli4QM4mDtdppGW6nw==
X-Received: by 2002:a65:4244:: with SMTP id d4mr18381692pgq.419.1551161363252; 
 Mon, 25 Feb 2019 22:09:23 -0800 (PST)
Received: from roar.local0.net ([125.254.1.96])
 by smtp.gmail.com with ESMTPSA id s6sm18478814pgm.90.2019.02.25.22.09.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 22:09:22 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 2/4] powerpc/64s: system reset interrupt preserve HSRRs
Date: Tue, 26 Feb 2019 16:08:59 +1000
Message-Id: <20190226060901.18715-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190226060901.18715-1-npiggin@gmail.com>
References: <20190226060901.18715-1-npiggin@gmail.com>
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

