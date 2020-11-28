Return-Path: <SRS0=bT9L=FC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11A2C63697
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2020 07:16:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12EAD2225B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2020 07:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCdFD4Zm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12EAD2225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CjjTB2ND5zF1BP
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2020 18:15:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::543;
 helo=mail-pg1-x543.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=NCdFD4Zm; dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CjjHq46gfzDsY5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2020 18:07:51 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id j19so6009770pgg.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2020 23:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YHTQ2tLy/d04r6IvpEtna9DRjc+d1mk5YsFV97Z4NF0=;
 b=NCdFD4ZmTUdhk0ZrCNBTRE5MiY5aURIjx/nnVALmGV/8lWK+q9UhUgcCoQABWsRZF2
 9bnU5nAP8i9F+xZAartmKa2FgOU3eh+BqIKkkVqvMQxNxjgnVu/vbL7xu8slLPvPLntw
 DqnZwaFj1QErs0GgDb+l/OohfINPtt+QnM2oozJf1yhnSUbZ7Z2tFLkcLYOg1H+NZo1N
 kJcxsc5AZPrAgvP4aiBsf4jw8Au1wjJ2n7/R0bFuLOxZnusCpKpWW6jOHItIsis11uGo
 2ReVfP/LxZrA0v1nJpE6riQ3Mz1tEc0hJA+AIr+5N7nZNPcdYRc09+D36UZ+S3LVqDpi
 V33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YHTQ2tLy/d04r6IvpEtna9DRjc+d1mk5YsFV97Z4NF0=;
 b=XAD0TrdgFlfktTfs7sCO/QwPqsAY2gCmuyPqbdO6zQBQjAaK9iJG2WAj4yUwcsYkGP
 eFowht5O2cXhROjIiYDpKl6qJRx1VN2VQ6zMHt7mztFO/9MSETiopIGYRZfYXtDq7VHL
 wF51/moUHdQuDf7NaF8fp3chAAjieeidgGyyLcknptYKx43CTGMjs/PDUGq5S0PgF4fS
 ZMggTNFv53vvamJi+4uzOdSkXHbAqE+DNlqfaZ0jr+V1k5uHFF6VpbXY3sOvvLqLCWTs
 MIeLjTf/lg4WYQadJAElBt7L2gS/UnERq7Hw01kYOwpWKZDnRxV+iInNOk2kAzjLYZfl
 PUMA==
X-Gm-Message-State: AOAM530O0ntFpQl4v71ywP3a54n1uQG3KQeojn1EM90caq60VwQ6LXTN
 qXx3VjaZWAJu1znaDhxCafDK574sF9w=
X-Google-Smtp-Source: ABdhPJy62w/d0sevYcY0gWUiJGcx9ttCDDHknzoO+hkfyH8YEcZkBW1JUplHuEWEXItMLS2UKo+9HA==
X-Received: by 2002:a63:1d12:: with SMTP id d18mr9590988pgd.314.1606547269307; 
 Fri, 27 Nov 2020 23:07:49 -0800 (PST)
Received: from bobo.ibm.com (193-116-103-132.tpgi.com.au. [193.116.103.132])
 by smtp.gmail.com with ESMTPSA id e31sm9087329pgb.16.2020.11.27.23.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2020 23:07:48 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/8] KVM: PPC: Book3S HV: Ratelimit machine check messages
 coming from guests
Date: Sat, 28 Nov 2020 17:07:24 +1000
Message-Id: <20201128070728.825934-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201128070728.825934-1-npiggin@gmail.com>
References: <20201128070728.825934-1-npiggin@gmail.com>
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
Cc: kvm-ppc@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Mahesh Salgaonkar <mahesh@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

A number of machine check exceptions are triggerable by the guest.
Ratelimit these to avoid a guest flooding the host console and logs.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index e3b1839fc251..c94f9595133d 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1328,8 +1328,12 @@ static int kvmppc_handle_exit_hv(struct kvm_vcpu *vcpu,
 		r = RESUME_GUEST;
 		break;
 	case BOOK3S_INTERRUPT_MACHINE_CHECK:
-		/* Print the MCE event to host console. */
-		machine_check_print_event_info(&vcpu->arch.mce_evt, false, true);
+		/*
+		 * Print the MCE event to host console. Ratelimit so the guest
+		 * can't flood the host log.
+		 */
+		if (printk_ratelimit())
+			machine_check_print_event_info(&vcpu->arch.mce_evt,false, true);
 
 		/*
 		 * If the guest can do FWNMI, exit to userspace so it can
@@ -1519,7 +1523,8 @@ static int kvmppc_handle_nested_exit(struct kvm_vcpu *vcpu)
 		/* Pass the machine check to the L1 guest */
 		r = RESUME_HOST;
 		/* Print the MCE event to host console. */
-		machine_check_print_event_info(&vcpu->arch.mce_evt, false, true);
+		if (printk_ratelimit())
+			machine_check_print_event_info(&vcpu->arch.mce_evt, false, true);
 		break;
 	/*
 	 * We get these next two if the guest accesses a page which it thinks
-- 
2.23.0

