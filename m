Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EEAECDE47
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 14:50:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A2362081D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 14:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+Ieh8f3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2362081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rR5g3psWzF3Qn
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 01:49:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="u+Ieh8f3";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="u+Ieh8f3"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rR250SX9zF3PY
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 01:46:52 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id b11-v6so9400027pfi.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Nov 2018 06:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=yiyADj8185+lR6YtIPxI/9OlNcR1QogQW5VAb4fNZlE=;
 b=u+Ieh8f3qfjTxqUeTZ2algF1CEGnXeJx1sAg9socsFBe0+RezxQX80e5prVeAOHZmY
 icR0KXzvJL4vGN0ROj0jg1ryZEx+Gi3Fb4hx4weXtMyfy2+eiUizNHGkrTX/olcFiFOY
 WZDOeg/4+xYx2ZTTYnRZtDTF/z8OjLoSW8BJtUozZVa1lLhI07D3GmBImm1/oN+GD7e7
 qA6K3aelJQQxFTmV3yZnIF5dj3IwsYxjYYEkhbLD0J3ibcbJSOoMKgjPuJL6BfT+XihI
 F62rPzVl+6qgi2bTAfx30crPQUsf/q/kFe8Ej9KOG8ocX811swqDCQUfbN03fBEreMOi
 Hnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=yiyADj8185+lR6YtIPxI/9OlNcR1QogQW5VAb4fNZlE=;
 b=cuOiGb8F946WBelYq7USixUTUqqg80kAqFCx3yrg0HirdrUWHY/m1gUvhAyO908wfI
 mreN4pEo1IlMMC9Rba2mFdzbdZU6jqHKR2VDqZfTfe9slGVBrDRDu/jUpCegG57gheA2
 dqrDhM9fedPibs6AgcDS0g/4ywju9bAriT7H9OE/O/ZPv98W9FSwjK3E1tedohtRL3Qw
 O6rvWxH+IOI63+M2O4LYoNnKJEKQHt624hRfBxL3T+W9HZ6YMS/nGMEdza5QXuQUzRw0
 rPSHzhxOBNcpaI2g9KiHVTRhYzyTItsAihbLqqs0STmHzddn49KSDGj8SsQEFZXYI3Jv
 3gtA==
X-Gm-Message-State: AGRZ1gJlyNclLX3ONsGo+WojRJZV88Sdxigsqv7ZQBjX4IzbFgjr/gjB
 tEL6gRE1fLtQsnBMqRVTwOY=
X-Google-Smtp-Source: AJdET5feGS/RXRvm4uJ38TQRmWSiiTRsWmdCxatvMEDX3Rva1bkcCH0h71uVKtGhhB9g0GT/xwrfeg==
X-Received: by 2002:a63:5e43:: with SMTP id s64mr4024148pgb.101.1541688411056; 
 Thu, 08 Nov 2018 06:46:51 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id
 k75-v6sm11526731pfb.119.2018.11.08.06.46.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 08 Nov 2018 06:46:50 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [Resend PATCH V5 1/10] KVM: Add tlb_remote_flush_with_range callback
 in kvm_x86_ops
Date: Thu,  8 Nov 2018 22:46:30 +0800
Message-Id: <20181108144639.11206-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
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
Cc: linux-mips@linux-mips.org, kvm@vger.kernel.org, rkrcmar@redhat.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 hpa@zytor.com, kys@microsoft.com, kvmarm@lists.cs.columbia.edu,
 sthemmin@microsoft.com, x86@kernel.org, linux@armlinux.org.uk,
 michael.h.kelley@microsoft.com, mingo@redhat.com, jhogan@kernel.org,
 Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 haiyangz@microsoft.com, kvm-ppc@vger.kernel.org, bp@alien8.de,
 devel@linuxdriverproject.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, christoffer.dall@arm.com,
 ralf@linux-mips.org, paul.burton@mips.com, pbonzini@redhat.com,
 vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

Add flush range call back in the kvm_x86_ops and platform can use it
to register its associated function. The parameter "kvm_tlb_range"
accepts a single range and flush list which contains a list of ranges.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v1:
       Change "end_gfn" to "pages" to aviod confusion as to whether
"end_gfn" is inclusive or exlusive.
---
 arch/x86/include/asm/kvm_host.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 55e51ff7e421..c8a65f0a7107 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -439,6 +439,11 @@ struct kvm_mmu {
 	u64 pdptrs[4]; /* pae */
 };
 
+struct kvm_tlb_range {
+	u64 start_gfn;
+	u64 pages;
+};
+
 enum pmc_type {
 	KVM_PMC_GP = 0,
 	KVM_PMC_FIXED,
@@ -1042,6 +1047,8 @@ struct kvm_x86_ops {
 
 	void (*tlb_flush)(struct kvm_vcpu *vcpu, bool invalidate_gpa);
 	int  (*tlb_remote_flush)(struct kvm *kvm);
+	int  (*tlb_remote_flush_with_range)(struct kvm *kvm,
+			struct kvm_tlb_range *range);
 
 	/*
 	 * Flush any TLB entries associated with the given GVA.
-- 
2.14.4

