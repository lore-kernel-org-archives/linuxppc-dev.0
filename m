Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52D7C07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 03:59:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E354820882
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 03:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoH4roc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E354820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439zHq46YpzDrYb
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 14:59:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PoH4roc6";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="PoH4roc6"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439yxq2kzLzDrWZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 14:43:59 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id y4so1077285pgc.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 19:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=e3i0Je8vY1d0fv+s5DNcU463pzhlEPKl1gJssLI/xzU=;
 b=PoH4roc66Qr+co5w9zMBmznaah8VRS5DhaJoR1tFlnNNDDnOp1xH4S92Yb6oxAaCgC
 hzPCXEMIiVINFg0/288qkYx3NsBX45oMSf/HJiZ5+qTWc/wYZa5AqP9GsFetCbOWKoVa
 5XenyGNfENlIDrmLNQcPF2hGeePkSH//Dv8DI/XOhAXDXUDUYU7+p+p9L4lqC7wH07QM
 J/HsVUi705h9N9+hVafBu8Z8h9su29r5zO4godfzDQZnvQXEKLdeYF24eK1lh+EkuYi0
 pPKKi1mYaphkYOCDkpCoWgjGZ4L5meFpW8ttRen+6SOTcoE1HsNAYk6dFGYit+7NkgrA
 Lz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=e3i0Je8vY1d0fv+s5DNcU463pzhlEPKl1gJssLI/xzU=;
 b=ExIDh0IrRgESMcBe/xdWYf/oOY9OgxYYZs1kBpdZvvanNlFJoehTV125yn+cKkE6p0
 POjVG2juA4Kcr+wNI89iO6R7t/ey8qmgL2FLDTUIBmsmswiuKMG3CBfmq/ewjhcL8CMQ
 rvbh+R/BM/Yn1eyROaUH1yrUf4c7AWtCdCU8b/0D3pakgtkpaGROZ6ps2Fovfj0IXokd
 EAWMzXDXduc9ATDbatZ7dP+6tsMWt1GoXhGJz2aDP0Z88x1YPTaBUPssXp+UvktmoAVO
 hMpdgzh60dHtNZY06TYzm4wWJcB698saPDLOSBTj1wfvRjXh9SdEignNhCmJ7QopabNx
 jd/Q==
X-Gm-Message-State: AA+aEWaiAAl4KRoLvVaI7NzytGW+Z+2ggjSGAHVQC43D9WPUs4X/Jp+t
 acGQAMbUiL/FBr6l03r/C58=
X-Google-Smtp-Source: AFSGD/XBBVdVTk31ogLdH4iIKg9WF8KOAyZDY5f4RsfO/het8yZQqb6t0yb3X/Ny4MARfJOJWcTdjA==
X-Received: by 2002:a62:31c1:: with SMTP id x184mr698240pfx.204.1544154237748; 
 Thu, 06 Dec 2018 19:43:57 -0800 (PST)
Received: from localhost.localdomain ([1.129.152.198])
 by smtp.gmail.com with ESMTPSA id e23sm2262646pfh.68.2018.12.06.19.43.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 19:43:57 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 4/8] KVM: PPC: Add load_from_eaddr and store_to_eaddr to the
 kvmppc_ops struct
Date: Fri,  7 Dec 2018 14:43:22 +1100
Message-Id: <20181207034326.3564-6-sjitindarsingh@gmail.com>
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

The kvmppc_ops struct is used to store function pointers to kvm
implementation specific functions.

Introduce two new functions load_from_eaddr and store_to_eaddr to be
used to load from and store to a guest effective address respectively.

Also implement these for the kvm-hv module. If we are using the radix
mmu then we can call the functions to access quadrant 1 and 2.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/include/asm/kvm_ppc.h |  4 ++++
 arch/powerpc/kvm/book3s_hv.c       | 40 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 9b89b1918dfc..159dd76700cb 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -326,6 +326,10 @@ struct kvmppc_ops {
 			    unsigned long flags);
 	void (*giveup_ext)(struct kvm_vcpu *vcpu, ulong msr);
 	int (*enable_nested)(struct kvm *kvm);
+	int (*load_from_eaddr)(struct kvm_vcpu *vcpu, ulong *eaddr, void *ptr,
+			       int size);
+	int (*store_to_eaddr)(struct kvm_vcpu *vcpu, ulong *eaddr, void *ptr,
+			      int size);
 };
 
 extern struct kvmppc_ops *kvmppc_hv_ops;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index d65b961661fb..6c8b4f632168 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -5213,6 +5213,44 @@ static int kvmhv_enable_nested(struct kvm *kvm)
 	return 0;
 }
 
+static int kvmhv_load_from_eaddr(struct kvm_vcpu *vcpu, ulong *eaddr, void *ptr,
+				 int size)
+{
+	int rc = -EINVAL;
+
+	if (kvmhv_vcpu_is_radix(vcpu)) {
+		rc = kvmhv_copy_from_guest_radix(vcpu, *eaddr, ptr, size);
+
+		if (rc > 0)
+			rc = -EINVAL;
+	}
+
+	/* For now quadrants are the only way to access nested guest memory */
+	if (rc && vcpu->arch.nested)
+		rc = -EAGAIN;
+
+	return rc;
+}
+
+static int kvmhv_store_to_eaddr(struct kvm_vcpu *vcpu, ulong *eaddr, void *ptr,
+				int size)
+{
+	int rc = -EINVAL;
+
+	if (kvmhv_vcpu_is_radix(vcpu)) {
+		rc = kvmhv_copy_to_guest_radix(vcpu, *eaddr, ptr, size);
+
+		if (rc > 0)
+			rc = -EINVAL;
+	}
+
+	/* For now quadrants are the only way to access nested guest memory */
+	if (rc && vcpu->arch.nested)
+		rc = -EAGAIN;
+
+	return rc;
+}
+
 static struct kvmppc_ops kvm_ops_hv = {
 	.get_sregs = kvm_arch_vcpu_ioctl_get_sregs_hv,
 	.set_sregs = kvm_arch_vcpu_ioctl_set_sregs_hv,
@@ -5253,6 +5291,8 @@ static struct kvmppc_ops kvm_ops_hv = {
 	.get_rmmu_info = kvmhv_get_rmmu_info,
 	.set_smt_mode = kvmhv_set_smt_mode,
 	.enable_nested = kvmhv_enable_nested,
+	.load_from_eaddr = kvmhv_load_from_eaddr,
+	.store_to_eaddr = kvmhv_store_to_eaddr,
 };
 
 static int kvm_init_subcore_bitmap(void)
-- 
2.13.6

