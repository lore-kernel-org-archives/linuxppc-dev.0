Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92711C07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 03:54:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA7B420882
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 03:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtymmJNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7B420882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439z9f163NzDr1K
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 14:54:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mtymmJNw";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="mtymmJNw"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439yxf2nYnzDrWY
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 14:43:50 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id d72so1085820pga.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 19:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=LvmJuwwziss2COckjTxUbK8p0ozKauVVNTpVJ1JHZwE=;
 b=mtymmJNwbbbjjmrw5y5XPxcLb9y5V5HZwr77uihm9meS2LamyJeYHoN8jKdHL59aLm
 bw2yiPIm9hU2rJrqywtvkV0/TSlsfGWFZhRo0wNfpzZBRWe7L5D1iv6XECXWMCX6O6nl
 VppHk3S5fpphJYkbuyi6I8mGxOtOJBp653IrxX7pZ7k3hp3Jfh/aSgu578UX6ZIZmLob
 Xrao2ouzjBqZos0y7JDG4Cf3jbfBziVhv077R0XtzQZOjkxFzGvwPcXlzb/pNS6CGHxw
 GNdoO4ISJj9hYXUfmdeP5xvKMsI2L/NG0sq9wljSdH/WQIhw0aojV2a+Y8WW1PiPMv+C
 JAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=LvmJuwwziss2COckjTxUbK8p0ozKauVVNTpVJ1JHZwE=;
 b=q89fp1V1dBTfvEiUKvW23l2wgQRq2mO4yjRmO9D24h+/6zaGU7L065nsAk5KVVseG6
 0OvRbWrkbk4TWY9BTsSDkOpe4B6PRefgQtT0sHyl2ES+/8++RN2J9+Xwu9f9SQxUqrt+
 Dki+nR9d+gPUmuEeTZuUJxQD4xkOD2fAtVcSi3EIjqcZlZckWfNyk2ROEC0R3Z9DmXlx
 +0aMQoFhaeXi5s3h9MvG6Df1ZottB8+FDk3AJsxyy0yB0AKt0D/c2UQVjg/xVxhFW5dV
 LNcrpT31cSC03l2O6iu6V70IF539vru75kvy6M4ONT1Nx1OwE6gVP3zHVGfcgyoXCxUE
 dVjQ==
X-Gm-Message-State: AA+aEWY9WtjsPHlzmvfDtHT9V0FGIgeL0pNmA91e048kAsBkBhcamrBs
 Sn+Ki4cp2zp2grKO7Uhhp3Y=
X-Google-Smtp-Source: AFSGD/U+FpNBTlzvB41XHEU8Mx9wIl1GqMUXnSSssl6PBmxQKlaR36n8AZRfAE+KDhQx0wiwvJ/eYA==
X-Received: by 2002:a63:bf0b:: with SMTP id v11mr591318pgf.302.1544154228517; 
 Thu, 06 Dec 2018 19:43:48 -0800 (PST)
Received: from localhost.localdomain ([1.129.152.198])
 by smtp.gmail.com with ESMTPSA id e23sm2262646pfh.68.2018.12.06.19.43.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 19:43:47 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 2/8] KVM: PPC: Book3S HV: Add function kvmhv_vcpu_is_radix()
Date: Fri,  7 Dec 2018 14:43:20 +1100
Message-Id: <20181207034326.3564-4-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181207034326.3564-1-sjitindarsingh@gmail.com>
References: <20181207034326.3564-1-sjitindarsingh@gmail.com>
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
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 sjitindarsingh@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

There exists a function kvm_is_radix() which is used to determine if a
kvm instance is using the radix mmu. However this only applies to the
first level (L1) guest. Add a function kvmhv_vcpu_is_radix() which can
be used to determine if the current execution context of the vcpu is
radix, accounting for if the vcpu is running a nested guest.

Currently all nested guests must be radix but this may change in the
future.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/include/asm/kvm_book3s_64.h | 13 +++++++++++++
 arch/powerpc/kvm/book3s_hv_nested.c      |  1 +
 2 files changed, 14 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 6d298145d564..7a9e472f2872 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -55,6 +55,7 @@ struct kvm_nested_guest {
 	cpumask_t need_tlb_flush;
 	cpumask_t cpu_in_guest;
 	short prev_cpu[NR_CPUS];
+	u8 radix;			/* is this nested guest radix */
 };
 
 /*
@@ -150,6 +151,18 @@ static inline bool kvm_is_radix(struct kvm *kvm)
 	return kvm->arch.radix;
 }
 
+static inline bool kvmhv_vcpu_is_radix(struct kvm_vcpu *vcpu)
+{
+	bool radix;
+
+	if (vcpu->arch.nested)
+		radix = vcpu->arch.nested->radix;
+	else
+		radix = kvm_is_radix(vcpu->kvm);
+
+	return radix;
+}
+
 #define KVM_DEFAULT_HPT_ORDER	24	/* 16MB HPT by default */
 #endif
 
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index 401d2ecbebc5..4fca462e54c4 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -480,6 +480,7 @@ struct kvm_nested_guest *kvmhv_alloc_nested(struct kvm *kvm, unsigned int lpid)
 	if (shadow_lpid < 0)
 		goto out_free2;
 	gp->shadow_lpid = shadow_lpid;
+	gp->radix = 1;
 
 	memset(gp->prev_cpu, -1, sizeof(gp->prev_cpu));
 
-- 
2.13.6

