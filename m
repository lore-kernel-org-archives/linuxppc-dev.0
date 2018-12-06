Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78CFC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 13:32:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F54720868
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 13:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLHIycFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F54720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439c2m1GmvzDr1j
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 00:32:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WLHIycFY";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="WLHIycFY"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439bpm61pFzDr8g
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 00:21:36 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id g62so161793pfd.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 05:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=yl5M/YR6xjWoRgtWFGXbuS2VcfNF+kKFSMttnjzt4tA=;
 b=WLHIycFYaXQ0FyPdeQRQYs8WC6bRrqlmuBnn6QQ5Su48WMNqzCTGkVaprlW0Q2x/bR
 UTsOxyI7d2K6WaP40kFHCNbt34I9aSTgcPkW/UOAWKkTj+Yf4RP3ggqyJY5zjH2QJLo6
 CRe6IcNHI7A2foaAs4cDYedVKh+LVY9grpe2ZRjRNAO9muRrWJ4xg+bJ8rIFaVGMHU4G
 sBb3UAAH7MIql9s0cdbCgYuTZUaFHJwULgDmpVjYWOZ0NM+cKXTZa0QIaA9SJsdRKxA+
 7L+uQ8nxkQ4T70pnsws420LQGf2DRAWlBWVTwdT8YRngx6/RzjUYw3zCZ1TWxnr19JrP
 XcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=yl5M/YR6xjWoRgtWFGXbuS2VcfNF+kKFSMttnjzt4tA=;
 b=fu0eXZIhq2maj1HElJI5AtTMBVc4ZyYBQweNZ9bJr7Kft3kvuvyYGiGm/1CLfBRCsV
 /plPGC/sC4vHaEIfqZgTdKi+SjS3wIeluR9eHPbbUdYvGxtBr+t973q9boUefS/xPYHE
 UnE6k2Zt8gwcTmTOxbwVgF20VjWkBhPLVJh48FP/htDa1AFINwKVByMFLmYuHDRmzQBE
 XOzR87gfa0pcTscqLpWH69+QrUzF6Vy8RV+rfUpShR12VYfi/Cur6W0uJjbOa393a8Ni
 h41PSyjcCXEfbSDqC0Q6SSlrTHa99a+bqS00B4SmsTXFS8kJx5ZRJtttYvgvKpH+937W
 vivQ==
X-Gm-Message-State: AA+aEWa9rhCpqt01WFaWqaISRe6SKE3Z02jOMS22JmB+Fl6F/WQ6pfCL
 YmJbvYgLP0kWagJfJgASK+I=
X-Google-Smtp-Source: AFSGD/Vad2NHYMuKRk3TpLn/tHk7cqeYYELuO43hDvsNWnBZeImb5HMnRC3+z6OQuE1c3wZTRRDOFA==
X-Received: by 2002:a62:cf02:: with SMTP id b2mr29644460pfg.183.1544102494752; 
 Thu, 06 Dec 2018 05:21:34 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id y5sm2409246pge.49.2018.12.06.05.21.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 05:21:34 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [Resend PATCH V5 1/10] KVM: Add tlb_remote_flush_with_range callback
 in kvm_x86_ops
Date: Thu,  6 Dec 2018 21:21:04 +0800
Message-Id: <20181206132113.2691-2-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
References: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
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
index fbda5a917c5b..fc7513ecfc13 100644
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

