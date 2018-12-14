Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6453EC65BAE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 03:16:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17C12086D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 03:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edicgHeT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17C12086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GG0w6npJzDr6t
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 14:16:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="edicgHeT";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="edicgHeT"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GFv26SWJzDr5Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 14:11:26 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id u6so2090016pfh.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 19:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=d9n2ndYxPLku3kpK66KCR216WXpYN1G+1wSQlGxFKcY=;
 b=edicgHeTrE9mYHv5oqmfkX/OXDWj98t59BX9SxKW8Y8CbAtq5/6FwVX+p/pvQjIYLM
 kcDOPyRL+MWSLbwI4lVb2kYVq+FH9fwdojHw7kq589+fK+sxfVM0SeHk562WyEPjXaVr
 m74u6dYu7/68I/ehXe/gdccyB/02CoQlMFDNZjnCuodAP6jmtbq70sSb9Bf11W5UTN5K
 nRwbUEjB8Ns2DXsU4kGH4M9SNIbXmqsRh6pljLr/Fd96iG5s0LC1nAnyeSESYTBBhPDK
 mkrcjP6LdqsIrYA064TbOGB7U58f4OoKO9pmdxqHT6Fhjns0+0io5ns7zxXBVZ6jn7LA
 lCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=d9n2ndYxPLku3kpK66KCR216WXpYN1G+1wSQlGxFKcY=;
 b=kftAIu5+jJ7nh9gJQtAlDJaOdVl6s1gvbiwlGz4TfM+3uRO/aVKjwZf3BK99OXDqxP
 prNyfS2bqf1CnVMidoTkPimx7C1ktlCFUCNrngbtyfAME2JSF8F/qp0AGI6mZXgkeBRj
 L9Z4nzY9852kXFDI4j1GC2ekWd6D9p1m7U35wbPQw6E9Y53T83KxNvZ/rk8NF5MPsh2X
 fAFdGENnLUroLN1B3cH+nsMaEZFqPB/g6lnOL1MB0yVgss8M4SBil6WqxlJuHyLPRGGV
 15JQVAPd0uoGbMLDtr4UakkKraxSac3PtXwOMyejlWg+s223vxklFj+KDxXCkqNBe2YA
 Y5YA==
X-Gm-Message-State: AA+aEWaQ4SG8KLb9LCoJJvsKBnF2/2peoNYUKwmfFOPKnDOThhGuO8dV
 45F+9wtAhohf+SXo+Tii7qs=
X-Google-Smtp-Source: AFSGD/X4ewBgTDRnVeWZIKEsGwCKspKzrMKV+THAqNrEj5yJFmtEW72560Gg5kGfpoZAd9tHvy8zMQ==
X-Received: by 2002:a63:d047:: with SMTP id s7mr1223668pgi.311.1544757085312; 
 Thu, 13 Dec 2018 19:11:25 -0800 (PST)
Received: from surajjs2.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id e188sm4079326pfg.130.2018.12.13.19.11.21
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 13 Dec 2018 19:11:24 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH V3 1/8] KVM: PPC: Only report KVM_CAP_SPAPR_TCE_VFIO on
 powernv machines
Date: Fri, 14 Dec 2018 14:11:02 +1100
Message-Id: <20181214031109.14464-2-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181214031109.14464-1-sjitindarsingh@gmail.com>
References: <20181214031109.14464-1-sjitindarsingh@gmail.com>
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

