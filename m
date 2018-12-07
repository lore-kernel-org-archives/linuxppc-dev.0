Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E83C64EB1
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 04:02:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B27A52064D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 04:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HINwW3BN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27A52064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439zLn4bRFzDqlD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 15:02:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HINwW3BN";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="HINwW3BN"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439yxv5hMVzDrWV
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 14:44:03 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id i12so1231846pfo.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 19:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=v/8AAl8q/xQgZCOCCKR0EHdYpuAx8C+FNvDhIEvGom4=;
 b=HINwW3BNw5+WJjwf5Ig5s4PQLnfDvFapWZmWWo/nwyc4uen1+FwcTi7+HXOKz5O1Ip
 wFayGtBavJyL+xyWM5cPl2N0ZjoJDwGou3B/yKD1Kr//GIsjGH+kwi8Lwg6BnPXIl+6a
 48I1jjCx3kQuoZhamArTVvTvQSbABM5QVPHAXbl4OSGEuxRNcw3ZHDemod2Pv1jxkdKl
 YwRH56HvOE+GhnTdkEXaKdk1UkMRBrY2/oZHTjWYQGCEDt192TN7v1qAg520hI9EpMPi
 FrNx/a2aM1XJM9V95OShdsGO9zHisH4q1J9RraJFnnzWtFyOqNFdy/rmszZEhjLoGXFr
 4utA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=v/8AAl8q/xQgZCOCCKR0EHdYpuAx8C+FNvDhIEvGom4=;
 b=LDz/lYXcVuhEh80nryvNDWemZEnUzKeu4w+imdYigArIRaq48e9KBk/qaiM4y4C5KI
 n4C3uLg7pesIgMkikIpTF19Pbk+dHm/kfxr4avdoMmnVKUU+REFclSILnOxJiDZS4sEl
 R/rZDyGzdiKhC4Merg6kpS3SO98zDg8c164jE1YCXclA6Vox3/NheSw4s1lel1TgFrn/
 EPbncXwvrb+BElyymJGqukXghBXQy3CfkkSlYfJ4CsNi4hmKYdo2ETjOwbNXxoD+bvBe
 vecjeOYkG0DB5Laei4+JqhnbvxlGPASHoLqPR+L5lMmlmkC0RjAon7fFSHP6EEOpPIlE
 HVPg==
X-Gm-Message-State: AA+aEWaMiiXFkpBcum/GzEAaVOXpuoa8s2xg9Px4TqF/Z90m3QHy2Vv0
 oZi7WtObCsaUYzkv6H7oOUI=
X-Google-Smtp-Source: AFSGD/WbkNQwlncT4LBqzbKiUeTq4dt0q5zhF3qWFqgppf4nvDvTFAvVW8d3oksV1gtJI1wv6A3D1w==
X-Received: by 2002:a62:e201:: with SMTP id a1mr652119pfi.75.1544154242080;
 Thu, 06 Dec 2018 19:44:02 -0800 (PST)
Received: from localhost.localdomain ([1.129.152.198])
 by smtp.gmail.com with ESMTPSA id e23sm2262646pfh.68.2018.12.06.19.43.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 19:44:01 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 5/8] KVM: PPC: Update kvmppc_st and kvmppc_ld to use quadrants
Date: Fri,  7 Dec 2018 14:43:23 +1100
Message-Id: <20181207034326.3564-7-sjitindarsingh@gmail.com>
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

