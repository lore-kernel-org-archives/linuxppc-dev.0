Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F05AC07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 03:51:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 830DD20837
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 03:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffVzjUWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830DD20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439z6g13R5zDrPG
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 14:51:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ffVzjUWY";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ffVzjUWY"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439yxZ6XF4zDrVX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 14:43:46 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id u6so1164012plm.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 19:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=d9n2ndYxPLku3kpK66KCR216WXpYN1G+1wSQlGxFKcY=;
 b=ffVzjUWYba7ggG+9uO1KoWhlIgoeo/sdZOl+xfelQEmF7eupn3tL8PykbTGMlexHq7
 2EWgznQjAj9JAmo3yx7HykpX+orBgkius2WhGe7qefBoInB+bHwvC98m7x/Vrlw/7Tp3
 Sj07g7L1rUqTjv1J1l2cSUOCJK+MU+iXYOlvBSpskvKWILS8JDbmkJ0dRF1Wgt4lqDLb
 uzw775qrf6WF7rcW3uUFBoDpIPDqFoXyTTiwkfFP4wRVZSuFNNKnxgv4gor9GHT5/yxR
 TW8n+yqDbR6HHQpeBHwMuc0BJVacOLi0BzA7WWp2QkPJen12DdPCeyudHJDMzegOZWF6
 i4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=d9n2ndYxPLku3kpK66KCR216WXpYN1G+1wSQlGxFKcY=;
 b=VJH1dEQKYM9ukPM5TUqZJF2fXZaGBm42gycmEWW9np7n+3X6Xqg/4CsW772jc4ohKF
 ztVNNVkxjd1UoT9T+T42DzBRSSHutcA7TUHglRNrPjlxHw72T3PvVRz8WlxJmrPuMTSy
 sOeh9IiIlH7yVuLMCgGt8EWB+5FYCjW5Y/5LD85Yi321vp44q2viLqKWh+wMKQZVINTc
 Vg9LhsCrRedNSpffE3DntOlmqFX3g5GN7HhpE2oMBlFmn8YSZ0Gu/hDDQvEEA3Q5GJ/F
 a3ZBfx8j+d/mX/xgekCpNEgiAZD7A/TDpwbknv13f2MtzJhAG4JgWAQRMhgGT1O8xbTk
 KQWQ==
X-Gm-Message-State: AA+aEWYkA/G+6ItjllbjhL6swBWvxoHXdU8JL1G3E/MA0JFYKHp+q8XZ
 OZleDKui5mRDgQeve79NshE=
X-Google-Smtp-Source: AFSGD/XqMdPtHdtVpAYWRJReFPRdS81OSQATfKJmZ5Q1WDvRm2lIUgAZqVvhbYmNxfLkaW5EpqifFQ==
X-Received: by 2002:a17:902:830a:: with SMTP id
 bd10mr620942plb.321.1544154224845; 
 Thu, 06 Dec 2018 19:43:44 -0800 (PST)
Received: from localhost.localdomain ([1.129.152.198])
 by smtp.gmail.com with ESMTPSA id e23sm2262646pfh.68.2018.12.06.19.43.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 19:43:44 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 1/8] KVM: PPC: Only report KVM_CAP_SPAPR_TCE_VFIO on powernv
 machines
Date: Fri,  7 Dec 2018 14:43:19 +1100
Message-Id: <20181207034326.3564-3-sjitindarsingh@gmail.com>
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

