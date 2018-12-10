Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7899C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 04:13:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4784820821
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 04:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ac+TcSMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4784820821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43CqT10sGFzDqRv
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 15:13:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ac+TcSMB";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ac+TcSMB"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Cq7r3QRpzDqgS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 14:59:04 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id a14so4576155plm.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Dec 2018 19:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=v/8AAl8q/xQgZCOCCKR0EHdYpuAx8C+FNvDhIEvGom4=;
 b=ac+TcSMBwFlXVewfw+gklKTllhnR6h4oWCN8TULDqGyapBZylBiEvJrv/0FF7jHj4p
 URQX8ezo1vh2598CMszPRQeVNRDgXJfe6jvjvofdtGfucjPbvwxW05GkAgS/RQEKu+We
 YxFMd3iypcyI9rSr0k0/OjLeGNHQvstKL3XNrQoUGj8lOlN90zQD7wnQAe6VVF81Gv4G
 JuU0Z5mzetbenLGzsyvnkWldmWrT+z2uMp5DfTX0/joPdAjmBMFM+b9TQrxCEujBtwm8
 mKX8MCqc61tjrGy3lTJkjThCnKp4cII4Hc2Bw2IIaRBJLL2GN30lCOz8m5N69S+GVtYJ
 u9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=v/8AAl8q/xQgZCOCCKR0EHdYpuAx8C+FNvDhIEvGom4=;
 b=jnFf3fZi8gq508xTRvqFHs5s2GcLH6HWgYuzCpzvrQEqQ6huSpWse9RlMaKtWqkXon
 a7A4IeDqKd5RqTs7p8U8GYsfigKTsoUaajVKWZzIYzWODWWBLmn6ExZg6iylSGxaosnT
 v5uNWueKyvpBu8hHmg9tMMSPJD67L0WZD9Q3knWuA+jsREqgoy8WFleskJ4oUAk9zvSm
 pi/ysZbboCO+kEAp0d0mHVGwhlqH297drrZ5QWCjY495n7S5OmQu/HDHrq0gTDODOIUY
 147HD7JfbMlHu3YuzB8PTmWU0xpp/jQZhC+xJ4dVOjOBdI0PrxALm4mDbsDA700irHTd
 5hcw==
X-Gm-Message-State: AA+aEWacG+qgjlpxf9z8NGcN79qDMAcAGlJXFhhfzXa/2RDt6hci5HgW
 xP1zWILssj/xHdBkEs60MmE=
X-Google-Smtp-Source: AFSGD/X4vHBLgX0OQGfuwb/XOvmGxtLkXrAKx+4MXLbKqFFNmvSfMF82pMwANFen/0VjTyUbNYEb8A==
X-Received: by 2002:a17:902:2bc5:: with SMTP id
 l63mr10896824plb.107.1544414341693; 
 Sun, 09 Dec 2018 19:59:01 -0800 (PST)
Received: from surajjs2.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id f6sm14291899pfg.188.2018.12.09.19.58.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 09 Dec 2018 19:59:01 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH V2 5/8] KVM: PPC: Update kvmppc_st and kvmppc_ld to use
 quadrants
Date: Mon, 10 Dec 2018 14:58:22 +1100
Message-Id: <20181210035825.29404-6-sjitindarsingh@gmail.com>
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

