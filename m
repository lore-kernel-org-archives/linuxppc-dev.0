Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B7BC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 03:40:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A051E20651
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 03:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NR3B9CoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A051E20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444gGr4g5CzDqML
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 14:40:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=jniethe5@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="NR3B9CoF"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444g301tJMzDq9T
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 14:30:19 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id u9so5768413pfn.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 19:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=63t96RQiKpNGzgnr+RYXcq0/eY03TTk4vtQMm5L/9O4=;
 b=NR3B9CoF3c+oV66ZIhVPoj0MmVfiPrLiXQtePgRy0oqke8j96UhIZNEKl565i26XW9
 n0fHdQzzCOQH6dnyfDJRe9oA8+jxClTc47QMzl92OkwbJ1HWvGIyoKqU6JRWAVcK0CEg
 FjVhi308AVFy/Rsa85u1c/P7PHtiAY6cI6uY9dWn2U3Us9MKS3fVO7xf71RcC6qFYpUE
 4OV5usQPIAB75CXU4szkqUvCSIy7ehWkWHeFwD5Pfm/9IuFsjpH5MTELwmkUvFK+PKOl
 M53lX/1SiqGHUFbhavX/u3jwomLgmR27Rd4BhuzTf1C6XI4zk3E25KXhfg+4hJSgQi5a
 xPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=63t96RQiKpNGzgnr+RYXcq0/eY03TTk4vtQMm5L/9O4=;
 b=ERh9zY3Bx+whhrYk8gAt2vy826fcfnee5pEhIAPZ0+uTyAysp8LcZSwdF5SF+RUOvb
 drNJpu3yZzwHVoqI/pM+rZgX4tmO/rgH/97bXCEfWzTe7e6ODk8Co82lbIUMm03BXug3
 EWOLD9Mm3Ahns6/85vScctcxljzSUJjjsLy+Gvs55pFRt84rYuCpymRAIu4TkE02yhs7
 Ara57oSFQgCXPJV4W9FYy/lqqFzjqEKfEk8SOSq/XAE13heUrOgpD7PiWqC0n0sA7gKR
 Bncg/fqyByy2YXuXnRjYbatbGALELx3RG+0i6gJk0hYBkZDWx77Wy+TXxkgLHSrb165E
 SeHg==
X-Gm-Message-State: AHQUAuaa3HtxbOTcY3pUIpU6Nui8XJ63YnS+0eeoht8UA9p6tJfyWJFb
 k4gcnQTIK0CJEgdAeMUoQIQaxSrJ
X-Google-Smtp-Source: AHgI3IaTUIw4UmfLv8oaO6Xiw8KWnfv0aiIhSkKeeJ+Cf7W26tEO6OZC6Rk/4EkvDIEdyLSjlq3H2Q==
X-Received: by 2002:a65:64d9:: with SMTP id t25mr32630252pgv.244.1550719817677; 
 Wed, 20 Feb 2019 19:30:17 -0800 (PST)
Received: from pasglop.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id z1sm31464093pfi.155.2019.02.20.19.30.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 20 Feb 2019 19:30:16 -0800 (PST)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH] KVM: PPC: Book3S HV: Fix build failure without IOMMU support
Date: Thu, 21 Feb 2019 14:28:48 +1100
Message-Id: <20190221032848.22590-1-jniethe5@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 21 Feb 2019 14:39:06 +1100
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
Cc: Jordan Niethe <jniethe5@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently trying to build without IOMMU support will fail:

  (.text+0x1380): undefined reference to `kvmppc_h_get_tce'
  (.text+0x1384): undefined reference to `kvmppc_rm_h_put_tce'
  (.text+0x149c): undefined reference to `kvmppc_rm_h_stuff_tce'
  (.text+0x14a0): undefined reference to `kvmppc_rm_h_put_tce_indirect'

This happens because turning off IOMMU support will prevent
book3s_64_vio_hv.c from being built because it is only built when
SPAPR_TCE_IOMMU is set, which depends on IOMMU support.

Fix it using ifdefs for the undefined references.

Fixes: 76d837a4c0f9 ("KVM: PPC: Book3S PR: Don't include SPAPR TCE code on non-pseries platforms")
Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c            |  2 ++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 5a066fc299e1..94e50438e6a2 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -937,6 +937,7 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 		ret = kvmppc_h_set_xdabr(vcpu, kvmppc_get_gpr(vcpu, 4),
 						kvmppc_get_gpr(vcpu, 5));
 		break;
+#ifdef CONFIG_SPAPR_TCE_IOMMU
 	case H_GET_TCE:
 		ret = kvmppc_h_get_tce(vcpu, kvmppc_get_gpr(vcpu, 4),
 						kvmppc_get_gpr(vcpu, 5));
@@ -966,6 +967,7 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 		if (ret == H_TOO_HARD)
 			return RESUME_HOST;
 		break;
+#endif
 	case H_RANDOM:
 		if (!powernv_get_random_long(&vcpu->arch.regs.gpr[4]))
 			ret = H_HARDWARE;
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 9b8d50a7cbaf..541b121477e4 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -2264,8 +2264,13 @@ hcall_real_table:
 	.long	DOTSYM(kvmppc_h_clear_mod) - hcall_real_table
 	.long	DOTSYM(kvmppc_h_clear_ref) - hcall_real_table
 	.long	DOTSYM(kvmppc_h_protect) - hcall_real_table
+#ifdef CONFIG_SPAPR_TCE_IOMMU
 	.long	DOTSYM(kvmppc_h_get_tce) - hcall_real_table
 	.long	DOTSYM(kvmppc_rm_h_put_tce) - hcall_real_table
+#else
+	.long	0		/* 0x1c */
+	.long	0		/* 0x20 */
+#endif
 	.long	0		/* 0x24 - H_SET_SPRG0 */
 	.long	DOTSYM(kvmppc_h_set_dabr) - hcall_real_table
 	.long	0		/* 0x2c */
@@ -2343,8 +2348,13 @@ hcall_real_table:
 	.long	0		/* 0x12c */
 	.long	0		/* 0x130 */
 	.long	DOTSYM(kvmppc_h_set_xdabr) - hcall_real_table
+#ifdef CONFIG_SPAPR_TCE_IOMMU
 	.long	DOTSYM(kvmppc_rm_h_stuff_tce) - hcall_real_table
 	.long	DOTSYM(kvmppc_rm_h_put_tce_indirect) - hcall_real_table
+#else
+	.long	0		/* 0x138 */
+	.long	0		/* 0x13c */
+#endif
 	.long	0		/* 0x140 */
 	.long	0		/* 0x144 */
 	.long	0		/* 0x148 */
-- 
2.20.1

