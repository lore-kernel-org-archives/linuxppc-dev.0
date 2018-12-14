Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0513BC67839
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 05:34:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E84A2086D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 05:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUrab52g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E84A2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GK4b3XwdzDqyw
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 16:34:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rUrab52g";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="rUrab52g"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GJyV2RcYzDr0C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 16:29:38 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id p8so2191543plo.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 21:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=d9n2ndYxPLku3kpK66KCR216WXpYN1G+1wSQlGxFKcY=;
 b=rUrab52gZAbainOlLyFEOSr6lw3s2KCawAl1kQeXq4lxoDCRuUjKXDiJRO5V0Hx/Qr
 p/QpnKxvKow70o01uOMdeSwFN3X1Sf7Z0AWEvkoOCf9zFVAd06LjcoNtGPNXNisD6qha
 nLZduq3ovgxz2g9sKgFCNa9rUFBMcjp3j4HdJLA42QWUZ9m5L1xyfP7c6rehscMSpVeE
 pQTq9n3JDF4UVKuiNFeqhqGKp0F9PUZfiYpioqzsLWkjH4W8zvKwSIowR/+egk/QgWV4
 r0LsehwlkrV6jA1lh4b5rDmulSHhIfrw3N1AYE70wz3AtlKrUIHyb4gasltrUVw6LY1C
 ZZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=d9n2ndYxPLku3kpK66KCR216WXpYN1G+1wSQlGxFKcY=;
 b=MKlGD/PWi2ojjTmwqnNIJIMdOhQX3Zbnh4KpyIHvqb/8hQz2hNNUNbDeC27MuHsFDC
 n/tJFvNcK1CmYlAnXtBnSiY6M9XoZlnXdjZF1Q872AR7vBU/ENUPs3Sz1dAC6HIvA72A
 QtqBSpULyMZPofUTla1jupmyI6CyFf+xLopRxn4U6Hw9HPEMRAFzje5eTeZHc+6fNQeB
 JUqtjycJ3wu77dnb5RQy7ceIWQfO9eP2uoxwdXIuVxFBBz42S1mUN53p4xkZQpELGaWS
 QsySp7gFm1Q4OJORSeaLV6jJls0UENY6/cBseeas49s1twRJX1TMZeW97NOv0STtifZu
 XsWQ==
X-Gm-Message-State: AA+aEWbLzdhfkMge8psZZnZs0vbeCHV4ArINLhgifG/9wq9cwmzBByS0
 6hVy9BPfIzrWzdbY4/QcfwU=
X-Google-Smtp-Source: AFSGD/Wa8jOi5LKPuQPs3Tvil1QaA24yPmGwq/zywKTCEIPo8CIgpfPVA43DKJdb/DF2n/e7i+k4yw==
X-Received: by 2002:a17:902:128c:: with SMTP id
 g12mr1582346pla.146.1544765376475; 
 Thu, 13 Dec 2018 21:29:36 -0800 (PST)
Received: from surajjs2.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id d21sm5358697pgv.37.2018.12.13.21.29.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 13 Dec 2018 21:29:35 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH V4 1/8] KVM: PPC: Only report KVM_CAP_SPAPR_TCE_VFIO on
 powernv machines
Date: Fri, 14 Dec 2018 16:29:03 +1100
Message-Id: <20181214052910.23639-2-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181214052910.23639-1-sjitindarsingh@gmail.com>
References: <20181214052910.23639-1-sjitindarsingh@gmail.com>
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
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, sjitindarsingh@gmail.com,
 kvm@vger.kernel.org
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

