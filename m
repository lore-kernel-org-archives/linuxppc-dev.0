Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A9CC65BAE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 03:26:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C3520849
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 03:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fybUxWLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C3520849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GGDl3HZ2zDqgs
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 14:26:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fybUxWLD";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="fybUxWLD"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GFvN2l3vzDr6L
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 14:11:44 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id z11so2024543pgu.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 19:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=v/8AAl8q/xQgZCOCCKR0EHdYpuAx8C+FNvDhIEvGom4=;
 b=fybUxWLDjXRMU/p+6vKKumJAXI39y0d/52yJYq+IEvepb4CkCtjbTHx3d23oX5xi9M
 oUTPw3E3cN/lEaUpv6CMnsuebel1V5yhnE3zJ2oSZOAcyFyOKQymkV/fbLUEgrrpnL2Z
 qETCKNCz7MVyKb8lUkBpLuA/48AU4FsdFsq18/K2u1nGEcmBHM+XUH6QlXRnSZ8iZFMv
 XYihWXd8hkHk+x5CRL6KJYZP+uD8gE+0GQYEkTP66KMeqfBq1mIydBKtp2b7QVy4r9Bm
 /5EyIO6X61Gf7tsREAOida1SCtOq7koxDjj1jAHjaMLrlQA/9cxaIexGIX3OdLGtc13J
 ekrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=v/8AAl8q/xQgZCOCCKR0EHdYpuAx8C+FNvDhIEvGom4=;
 b=koKiqu6y5x97YimMkh0GYNoQOrUR9mzP0hktw/G8eSmfQGBeIe/Xd5wotWoZGXlBeY
 uudDhAsXQGCZ5oXldn6u4cnMfB/9B/5ZDyxTnEU7FSiDSdC/Q3ADmDvewOYax2efLQ68
 zNBjbCpLIgM0AzkuRBG5Hw2FNqK9FPtvy3PC2IztqNUP1pGCzawh3+fourZrYgm7nKTH
 hl9dN3KmYJIr7qmjttwLjz2qAuHkYlfoQkf8Ea6v/Vfl5GNt3B2nslZB/qwcySiSiziF
 JtUMDfVRI9xOqON/E3Is3pAQLPJMYoRh5T7mH9Hpn2ABym3kZNoreNEARNqBcvm6DEzp
 HWEA==
X-Gm-Message-State: AA+aEWZlsCzr8PNkvL3mNWq23Dj2kQdA8bWuoma+wFPm6wxp5yw/DHXm
 2JxQDIxzfuoOAawdMYLlhtU=
X-Google-Smtp-Source: AFSGD/VlU7gGIEE7t83ytMhrVP+DYkO9UKmK/OoNQnOTN1qYtc3UQN2xvixJ70beAwwPnDCTz1pHgg==
X-Received: by 2002:a62:5c1:: with SMTP id 184mr1261616pff.165.1544757102820; 
 Thu, 13 Dec 2018 19:11:42 -0800 (PST)
Received: from surajjs2.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id e188sm4079326pfg.130.2018.12.13.19.11.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 13 Dec 2018 19:11:42 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH V3 5/8] KVM: PPC: Update kvmppc_st and kvmppc_ld to use
 quadrants
Date: Fri, 14 Dec 2018 14:11:06 +1100
Message-Id: <20181214031109.14464-6-sjitindarsingh@gmail.com>
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

The functions kvmppc_st and kvmppc_ld are used to access guest memory
from the host using a guest effective address. They do so by translating
through the process table to obtain a guest real address and then using
kvm_read_guest or kvm_write_guest to make the access with the guest real
address.

This method of access however only works for L1 guests and will give the
incorrect results for a nested guest.

We can however use the store_to_eaddr and load_from_eaddr kvmppc_ops to
perform the access for a nested guesti (and a L1 guest). So attempt this
method first and fall back to the old method if this fails and we aren't
running a nested guest.

At this stage there is no fall back method to perform the access for a
nested guest and this is left as a future improvement. For now we will
return to the nested guest and rely on the fact that a translation
should be faulted in before retrying the access.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/kvm/powerpc.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 95859c53a5cd..cb029fcab404 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -331,10 +331,17 @@ int kvmppc_st(struct kvm_vcpu *vcpu, ulong *eaddr, int size, void *ptr,
 {
 	ulong mp_pa = vcpu->arch.magic_page_pa & KVM_PAM & PAGE_MASK;
 	struct kvmppc_pte pte;
-	int r;
+	int r = -EINVAL;
 
 	vcpu->stat.st++;
 
+	if (vcpu->kvm->arch.kvm_ops && vcpu->kvm->arch.kvm_ops->store_to_eaddr)
+		r = vcpu->kvm->arch.kvm_ops->store_to_eaddr(vcpu, eaddr, ptr,
+							    size);
+
+	if ((!r) || (r == -EAGAIN))
+		return r;
+
 	r = kvmppc_xlate(vcpu, *eaddr, data ? XLATE_DATA : XLATE_INST,
 			 XLATE_WRITE, &pte);
 	if (r < 0)
@@ -367,10 +374,17 @@ int kvmppc_ld(struct kvm_vcpu *vcpu, ulong *eaddr, int size, void *ptr,
 {
 	ulong mp_pa = vcpu->arch.magic_page_pa & KVM_PAM & PAGE_MASK;
 	struct kvmppc_pte pte;
-	int rc;
+	int rc = -EINVAL;
 
 	vcpu->stat.ld++;
 
+	if (vcpu->kvm->arch.kvm_ops && vcpu->kvm->arch.kvm_ops->load_from_eaddr)
+		rc = vcpu->kvm->arch.kvm_ops->load_from_eaddr(vcpu, eaddr, ptr,
+							      size);
+
+	if ((!rc) || (rc == -EAGAIN))
+		return rc;
+
 	rc = kvmppc_xlate(vcpu, *eaddr, data ? XLATE_DATA : XLATE_INST,
 			  XLATE_READ, &pte);
 	if (rc)
-- 
2.13.6

