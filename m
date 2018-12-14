Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91113C65BAE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 03:24:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0313E206BA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 03:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijR9N+RB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0313E206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GG9V1Rv2zDqQs
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 14:23:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ijR9N+RB";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ijR9N+RB"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GFvJ5LJjzDr6w
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 14:11:40 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id d72so2001663pga.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 19:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=h7DqnNU1Ggyii/PzsZtgi3n0KTNf05KRkHCfe8fV+04=;
 b=ijR9N+RBKfqLMXXYZFdmfxU1eo6Mh1gHur7hjgUQdUClqmEFMuyg2a1EuAAsq0PWtk
 AfC8AJxUCezuC3oq0OqwgCmyxrLKg+PD34fLwEfCZ4lx3CROPrLgmx91qSF5hOqL5RLP
 cF/pg7wyLPincTGWDcYshwh+xZ5yxrXijnZBLz2Vb6/kSzB+hdt4HL1VqcwKidxnxq6+
 boFUFBLBAYvH1MNQEFGNvlTEuEhCNWQfTFMQC8vURZ+/JXlPblzI5YuxbH/1Eej/4Ywv
 MxUPLYPgj4SvNBwlfzqZxYziCaFc6jEisgMqtcQP3xPilio/kc3014HHeM2BAkCyrWoM
 w9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=h7DqnNU1Ggyii/PzsZtgi3n0KTNf05KRkHCfe8fV+04=;
 b=tuSkZpCbaj4pLFK75o9njRnsAEtwzoH/Im5dcVtPigU+BBwH67F7470EBB6PGtEeea
 qyox2rt9bOH9YejBEWD6LIHEcKt2JddvJ5xGldzGx5Ll8a/6cUwpXJ09jvVS8qd3NMEg
 e/0TLdJenDjvSWNgl0z/YvnG/gbD01dDfyaoZnlO55MEJWeVOfhoRJpQ6xI3RYnpdVKU
 fwCL371bNAGx+RsDkHiDmzzxq9MoV9+9AgR2qzTb9qRqVGEETPiRBuW3SKdtCIo1k5KT
 BFEyhUs9h/JmFRxeKffTqrykq3chEFYHr48M7UhPM4iMhvWF7JwdrcQHLccYdKZcICdu
 8nmg==
X-Gm-Message-State: AA+aEWYqHLr0ANxmVNbJkWw7EunCXSjgifC434HfYreUfXY8QBG5HGVs
 s+UQwO7o7NZZ5OgAkDXI9M0=
X-Google-Smtp-Source: AFSGD/W3vI68Lh4GjDzAg5ENNJDWEcXa6TZ9QAhRfC2EjPTTscUZJvyRM7QyMqkv560zv+K+GvLBEg==
X-Received: by 2002:a62:42d4:: with SMTP id h81mr1260849pfd.259.1544757098617; 
 Thu, 13 Dec 2018 19:11:38 -0800 (PST)
Received: from surajjs2.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id e188sm4079326pfg.130.2018.12.13.19.11.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 13 Dec 2018 19:11:37 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH V3 4/8] KVM: PPC: Add load_from_eaddr and store_to_eaddr to
 the kvmppc_ops struct
Date: Fri, 14 Dec 2018 14:11:05 +1100
Message-Id: <20181214031109.14464-5-sjitindarsingh@gmail.com>
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
index a56f8413758a..8a0921176a60 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -5214,6 +5214,44 @@ static int kvmhv_enable_nested(struct kvm *kvm)
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
@@ -5254,6 +5292,8 @@ static struct kvmppc_ops kvm_ops_hv = {
 	.get_rmmu_info = kvmhv_get_rmmu_info,
 	.set_smt_mode = kvmhv_set_smt_mode,
 	.enable_nested = kvmhv_enable_nested,
+	.load_from_eaddr = kvmhv_load_from_eaddr,
+	.store_to_eaddr = kvmhv_store_to_eaddr,
 };
 
 static int kvm_init_subcore_bitmap(void)
-- 
2.13.6

