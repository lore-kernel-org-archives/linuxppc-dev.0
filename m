Return-Path: <SRS0=Y1I/=GS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225E9C433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Jan 2021 16:53:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FFC623136
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Jan 2021 16:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FFC623136
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DHS0v20XRzDshy
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Jan 2021 03:53:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432;
 helo=mail-pf1-x432.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=GIiui6q9; dkim-atps=neutral
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DHRxv3WS4zDsgv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jan 2021 03:50:26 +1100 (AEDT)
Received: by mail-pf1-x432.google.com with SMTP id y205so16314pfc.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2021 08:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ox1+kJB8/svJPOlYh8jiLo0n0VnUtKrOgdur+kuGqWU=;
 b=GIiui6q9Vy/u0VLhKY1rzjdyMVHCPtuQqko+TsutQwhkCRwIT3ahF8vAEpiRowVIG2
 CaDO5L0U7UZwVYzfGWNP/hV0NWymuqbFmnWeZXQZN3CV3XoNx5gCTNOIgkKciVR9D7DN
 ymglN6RRXuGfEscC7Vbias7Avros2hSQnxp6iPC6ph0S4056SKyD9glWghB8qcr+QlBc
 cR1uFX4v43E9nuGvtmQxvf9EJieOUkO+IsIRZqKWnv5TsL9v4J50g7ttBcxbuHRqHU5K
 WpCDOUTvuYBCsVkb0FgT0mWhTcyRaJmL3hoARIZjFtGtYhnB1aojXADKUdL58q5yr7fe
 wN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ox1+kJB8/svJPOlYh8jiLo0n0VnUtKrOgdur+kuGqWU=;
 b=OI1dSTYWyIZsinRvTqd8b/pij6MQKfwTTmqN3TsvuMcoJOzTEym/aNQR0M8NMdzyyg
 Gr+0b0zq5NyZXyytazLo9X6+y0BaNsH/DfwVrWuZ+geig/Ifzs8h2QCJE2Fu/itEaIX7
 1zbqo1ZHAIF/ajXu21uTIKybfXd3raz7hrBaBRpQSI2WHB5JFgyTKuWrw/8Q6z7aJleJ
 XLnI34XARuMfDBBIw0yDqahDi8EHpnp09AUccOoYxWqWg/YUK30WQPpn8bmYg6Ttdkq2
 X3Z3braulviZXlleedVvj5vFEA1c7tvlUg5dy2SC+DEXZztYfC9UH5gupgRMSx0L/yyL
 kkjw==
X-Gm-Message-State: AOAM530RW+fP5iIZqHKT5ND9s4B+WfNStcciGzpi2YmOvCjyNjMpJWe1
 kFyUkRMOxyMa8jAx9v9gCP8GP6s+gj4=
X-Google-Smtp-Source: ABdhPJxAInOSpswkrOe9JKPoooLZxSMoSmMTL9H6e0nUJDIM1dztJk2rzEZ9ncHQRliyHHycYff+nw==
X-Received: by 2002:a63:d041:: with SMTP id s1mr13367575pgi.249.1610729423327; 
 Fri, 15 Jan 2021 08:50:23 -0800 (PST)
Received: from bobo.ibm.com ([124.170.13.62])
 by smtp.gmail.com with ESMTPSA id u1sm8455477pjr.51.2021.01.15.08.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Jan 2021 08:50:22 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 01/39] KVM: PPC: Book3S HV: Context tracking exit guest
 context before enabling irqs
Date: Sat, 16 Jan 2021 02:49:34 +1000
Message-Id: <20210115165012.1260253-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210115165012.1260253-1-npiggin@gmail.com>
References: <20210115165012.1260253-1-npiggin@gmail.com>
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
Cc: kvm-ppc@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Interrupts that occur in kernel mode expect that context tracking
is set to kernel. Enabling local irqs before context tracking
switches from guest to host means interrupts can come in and trigger
warnings about wrong context, and possibly worse.

Cc: kvm-ppc@vger.kernel.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 6f612d240392..d348e77cee20 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3407,8 +3407,9 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 
 	kvmppc_set_host_core(pcpu);
 
+	guest_exit_irqoff();
+
 	local_irq_enable();
-	guest_exit();
 
 	/* Let secondaries go back to the offline loop */
 	for (i = 0; i < controlled_threads; ++i) {
@@ -4217,8 +4218,9 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
 
 	kvmppc_set_host_core(pcpu);
 
+	guest_exit_irqoff();
+
 	local_irq_enable();
-	guest_exit();
 
 	cpumask_clear_cpu(pcpu, &kvm->arch.cpu_in_guest);
 
-- 
2.23.0

