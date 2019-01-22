Return-Path: <SRS0=/GF9=P6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD96FC282C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 06:51:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB7D120861
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 06:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0y+FGWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7D120861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kJwq6889zDqP3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 17:51:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="p0y+FGWJ"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kJqG2DcszDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2019 17:46:34 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id z23so10987483plo.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 22:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=uuNoHBB/bUnSTzuLgqobc3jXhax4M4TyzcfngUSdiRA=;
 b=p0y+FGWJbT6kDDI0uvZQ945NHyW8Re9OPif26mFchgvw05hmsjdAAB8YaldnAOsE5D
 gddbbhV3n7HX56XnKFQm/8g7rng9gN2PhscbHmLPtT0F0qYMnTTlWFE6agYl5ZpVN8cB
 w8dpyhHNZaxoomJ0sq3ql2dXn6zmfQa8IbM0KR4msRq0hXhjlH5qGUliLB3tzg5S6PcQ
 n0rZs12BphbC9BiLc3oLd9QPOqMIvNFH70+M5ezXdtsHI66iMkzHhtsN1BwEXQdMVHDK
 YJsQzf1VTmu5Vq3CpDyEs7TK60/tqGwfJBhCQsXO7cUQtcG1VJ78ZRdFvo+zh33XyvEp
 sK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=uuNoHBB/bUnSTzuLgqobc3jXhax4M4TyzcfngUSdiRA=;
 b=TAiAkpKwMGi0c/vO7ACx3CTwstXpkYPzn3Tme638tSJm/yIB0PzV3TSJbYhfycNEPp
 MM4IvY4cFIyuPHByE39EFrRJzmEfW3ob8+TFibZNVLZFhc/npc1z+D4khBhckIkL31Oh
 jdDLHR9FMrOh5j6XYu/6+axR0Ymgs+Lv3GIU4Z+5MP4P5mo8q63EWwiRrak8RTDK1UEc
 SKCT4zdNWJJs+TrSvCQv0N3kMw+fpwKzNMN5LQPP43mqLQmX4kxc7zj1eu63vT83ttNe
 DM9VwilM5qr23BQ2dKjNkzVdeRYFD81uc9glfVZJd66SdKJUR0FV3x+IxI10wlmqonpj
 2H1A==
X-Gm-Message-State: AJcUukdqbMiRUAk6H0DRc8tJHTktLcqgPR1fb6thMuvOXIrGw96YA7FL
 edCO8YAkkrIwTE4ovz4XUP/hfaPB
X-Google-Smtp-Source: ALg8bN4/5eYe6qw7FyxV4LG5IRAhGsCnO+G41ZjoKxhmWKksfCSDR5FQV/1R++O094v9+rBwaGIuqw==
X-Received: by 2002:a17:902:5588:: with SMTP id
 g8mr33221148pli.22.1548139592450; 
 Mon, 21 Jan 2019 22:46:32 -0800 (PST)
Received: from roar.local0.net (193-116-118-220.tpgi.com.au. [193.116.118.220])
 by smtp.gmail.com with ESMTPSA id v15sm18341830pfn.94.2019.01.21.22.46.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Jan 2019 22:46:32 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/4] powerpc/64s: system reset interrupt preserve HSRRs
Date: Tue, 22 Jan 2019 16:46:16 +1000
Message-Id: <20190122064618.1510-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190122064618.1510-1-npiggin@gmail.com>
References: <20190122064618.1510-1-npiggin@gmail.com>
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

The system reset interrupt may use HSRR registers (e.g., to call in to
OPAL), but code that uses HSRR registers is not required to clear
MSR[RI] by convention.

Rather than introduce that requirement, have system reset interrupt
save HSRRs before they might be used.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/traps.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index b429b2264a1f..d54459152a2b 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -438,14 +438,32 @@ void hv_nmi_check_nonrecoverable(struct pt_regs *regs)
 
 void system_reset_exception(struct pt_regs *regs)
 {
+	unsigned long hsrr0, hsrr1;
+	bool hsrrs_saved = false;
+	bool nested = in_nmi();
+
 	/*
 	 * Avoid crashes in case of nested NMI exceptions. Recoverability
 	 * is determined by RI and in_nmi
 	 */
-	bool nested = in_nmi();
 	if (!nested)
 		nmi_enter();
 
+	/*
+	 * System reset can interrupt a region where HSRRs are live and
+	 * MSR[RI]=1, and it may clobber HSRRs itself (e.g., to call OPAL),
+	 * so save them before doing anything.
+	 *
+	 * Machine checks should be okay to avoid this, as the real mode
+	 * handler is careful to avoid HSRRs, and the virt code is not
+	 * delivered as an NMI.
+	 */
+	if (cpu_has_feature(CPU_FTR_HVMODE)) {
+		hsrrs_saved = true;
+		hsrr0 = mfspr(SPRN_HSRR0);
+		hsrr1 = mfspr(SPRN_HSRR1);
+	}
+
 	hv_nmi_check_nonrecoverable(regs);
 
 	__this_cpu_inc(irq_stat.sreset_irqs);
@@ -495,6 +513,11 @@ void system_reset_exception(struct pt_regs *regs)
 	if (!(regs->msr & MSR_RI))
 		nmi_panic(regs, "Unrecoverable System Reset");
 
+	if (hsrrs_saved) {
+		mtspr(SPRN_HSRR0, hsrr0);
+		mtspr(SPRN_HSRR1, hsrr1);
+	}
+
 	if (!nested)
 		nmi_exit();
 
-- 
2.18.0

