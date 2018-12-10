Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8662C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 04:04:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143452081F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 04:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgNcDzzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143452081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43CqFm5kK1zDqnf
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 15:04:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AgNcDzzi";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="AgNcDzzi"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Cq7b1Q8xzDqcV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 14:58:51 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id 101so4583554pld.6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Dec 2018 19:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=d9n2ndYxPLku3kpK66KCR216WXpYN1G+1wSQlGxFKcY=;
 b=AgNcDzzig7F7GZAq+h+i7Z/e37eQXANWWTxWHpMzZ5bmfBCVW7RWUN/6blrytm8SIt
 +wPxNdcCR/veJdwfeuifMxDMX0tmOmW9tYJfZ3XCdJOC1JjEArsUYHW1E93kAkvsp+gF
 O3zhpgOQKYonHh8a0Yg2ETRDYVSkA7XznHsx9bgLjehNcs3388G1NSbtubqhQGASqgqH
 TNiTC5nSjkE0fZ0HziS/Y3Aggg2OPdILXj6dr7VKQmIY90kYNKTnj/sEnOAwxLjRMd9+
 t0JtFHjJjDQfO0p1F581h+1yi19uOWhWrvny8Ru6aOSowq3tvQjhQoMjgFIf+LBQioy8
 zXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=d9n2ndYxPLku3kpK66KCR216WXpYN1G+1wSQlGxFKcY=;
 b=csGZ2bw+UeHvoh5rSovsVSWNY7ja9QhBXpQRLuDQpC98ifKYg5RWBRc4abCByPKefY
 h5J6JlpG3+zCxvsfYpOsAjWGPQMUhFRsajIFLioEWsDX4WT5QMN8eA03VWa30k2N4X3s
 2dYOWJqL4Nhn9WZopoEBXnzgGrUA6qvCvTvNfKX11L3N5wiDS53CyertsmLB/2ISZPns
 zEUG3Z02cUN6ygrzNxefD60YY7gmqqaTW/vhOPj58XKbRnlWGoC2vLxrwrOOkfxghJ9r
 WrNignoNUSFL/OUdgTAsof79/0jI1mlkf3j3GqYOE682M4tgSEPErANxfTWOEqML7wdx
 Pk/w==
X-Gm-Message-State: AA+aEWYh3jkj9hot3sD7EQatMZKj2gXJpEZcnsIEUslGVCsiflGDBacX
 sJjvqAz8uueZbgfKaWc56QM=
X-Google-Smtp-Source: AFSGD/XcudXpDAFVVAZTUfFhtxTvwwT5aVGuGFRZQbYGlO4gYyO8ed2zJyHIxx6I27I386SZL9NPzQ==
X-Received: by 2002:a17:902:7005:: with SMTP id
 y5mr10760175plk.7.1544414329468; 
 Sun, 09 Dec 2018 19:58:49 -0800 (PST)
Received: from surajjs2.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id f6sm14291899pfg.188.2018.12.09.19.58.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 09 Dec 2018 19:58:48 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH V2 1/8] KVM: PPC: Only report KVM_CAP_SPAPR_TCE_VFIO on
 powernv machines
Date: Mon, 10 Dec 2018 14:58:18 +1100
Message-Id: <20181210035825.29404-2-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181210035825.29404-1-sjitindarsingh@gmail.com>
References: <20181210035825.29404-1-sjitindarsingh@gmail.com>
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

The kvm capability KVM_CAP_SPAPR_TCE_VFIO is used to indicate the
availability of in kernel tce acceleration for vfio. However it is
currently the case that this is only available on a powernv machine,
not for a pseries machine.

Thus make this capability dependent on having the cpu feature
CPU_FTR_HVMODE.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/kvm/powerpc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 2869a299c4ed..95859c53a5cd 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -496,6 +496,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	int r;
 	/* Assume we're using HV mode when the HV module is loaded */
 	int hv_enabled = kvmppc_hv_ops ? 1 : 0;
+	int kvm_on_pseries = !cpu_has_feature(CPU_FTR_HVMODE);
 
 	if (kvm) {
 		/*
@@ -543,8 +544,11 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 #ifdef CONFIG_PPC_BOOK3S_64
 	case KVM_CAP_SPAPR_TCE:
 	case KVM_CAP_SPAPR_TCE_64:
-		/* fallthrough */
+		r = 1;
+		break;
 	case KVM_CAP_SPAPR_TCE_VFIO:
+		r = !kvm_on_pseries;
+		break;
 	case KVM_CAP_PPC_RTAS:
 	case KVM_CAP_PPC_FIXUP_HCALL:
 	case KVM_CAP_PPC_ENABLE_HCALL:
-- 
2.13.6

