Return-Path: <SRS0=Lr1k=PM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D8AC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 09:06:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4AE62184B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 09:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSNQv0ht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4AE62184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43WJmg5Y2WzDqDM
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 20:06:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="JSNQv0ht"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43WJWt4MGDzDqGC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2019 19:55:06 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id t13so17145164ply.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Jan 2019 00:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=VAVkaVsyvHGb3944LCTx3RYQpKB8eIkyndjj2Ikvaks=;
 b=JSNQv0hto48d+cy9OmeC8+vpqtt4/8EI9u9HIqEmmUbj6f2TxB9IIfx/sXfdswigSu
 EfVz+80dJ8PkWlx+96miP5z94XhYM+ykxX3Fmq4clNe8KPorrdKxjWxhLblkovBxKOoE
 xNYBVIAgaXQScDW+EAKSKC9Vr5FCyiuV4d9SXDVbYKPiXlyZHItxqT9jBQmvUlY+lIX6
 QQxwdeg3r8Jc/hvz7dkxYLqoh+osKRZY5AyLcBIZ0cLUIsntPEjJnC3IB6sc65dcu4X5
 0h2aJEJSkwZD10HfzE989QUcENXgc2JHiKAXwoElzz9FnMX6UUYrCm3geYrKeF6nQ2K2
 q/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=VAVkaVsyvHGb3944LCTx3RYQpKB8eIkyndjj2Ikvaks=;
 b=Ejc4S0JfmUPYSsrNRuaCRaOMsjw4HPaj4V8BMLa9evahWmBibywNwdbsEdsz9N+yiN
 VevewN4BhJ39Eq5u1LeWaQ81Ls3qZCawdI8SJefQJZnGOlwjqIvo8UaxigelnRV2NW3R
 +JHWNzqDEgKpnHN22NnWPGwQtcayP6OOrg5MbD3PBV0sVtLYzXNy+p34TwKxYBH7OxRE
 +DctRHVmmoDH4upTuZtMyjLIJBbfBuP72kBKFEYb8NywcxJondi88c3KI7wmYE3GrBNu
 MzmS+oKNTnJHqFETamClN6DtnU4RkeTzFiL55bi6KwY4R1sbYEoxOTv/tGKPAQdNS1dZ
 Ki+w==
X-Gm-Message-State: AJcUukeG7kYnHN79Y3jyO73JeudqMgH3+2eib2uEyGc2yoQtgxtWKBkB
 A9JYRYY/R9Rl6wljJMiD3EY=
X-Google-Smtp-Source: ALg8bN4OjtFEk71VDHPjiuzCk2TCpCOEwCai/Wt7CBSpw62HsAigCPIHdjQRvUBI364td6kTt3nr6A==
X-Received: by 2002:a17:902:7882:: with SMTP id
 q2mr51489397pll.305.1546592104889; 
 Fri, 04 Jan 2019 00:55:04 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.54.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 00:55:04 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH 6/11] KVM/MMU: Flush tlb with range list in sync_page()
Date: Fri,  4 Jan 2019 16:54:00 +0800
Message-Id: <20190104085405.40356-7-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
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
Cc: kvm@vger.kernel.org, rkrcmar@redhat.com, catalin.marinas@arm.com,
 will.deacon@arm.com, christoffer.dall@arm.com, hpa@zytor.com,
 kys@microsoft.com, kvmarm@lists.cs.columbia.edu, x86@kernel.org,
 linux@armlinux.org.uk, michael.h.kelley@microsoft.com, mingo@redhat.com,
 jhogan@kernel.org, linux-mips@vger.kernel.org,
 Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 kvm-ppc@vger.kernel.org, bp@alien8.de, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 ralf@linux-mips.org, paul.burton@mips.com, pbonzini@redhat.com,
 vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to flush tlb via flush list function.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/paging_tmpl.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index 833e8855bbc9..866ccdea762e 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -973,6 +973,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 	bool host_writable;
 	gpa_t first_pte_gpa;
 	int set_spte_ret = 0;
+	LIST_HEAD(flush_list);
 
 	/* direct kvm_mmu_page can not be unsync. */
 	BUG_ON(sp->role.direct);
@@ -980,6 +981,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 	first_pte_gpa = FNAME(get_level1_sp_gpa)(sp);
 
 	for (i = 0; i < PT64_ENT_PER_PAGE; i++) {
+		int tmp_spte_ret = 0;
 		unsigned pte_access;
 		pt_element_t gpte;
 		gpa_t pte_gpa;
@@ -1029,14 +1031,24 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 
 		host_writable = sp->spt[i] & SPTE_HOST_WRITEABLE;
 
-		set_spte_ret |= set_spte(vcpu, &sp->spt[i],
+		tmp_spte_ret = set_spte(vcpu, &sp->spt[i],
 					 pte_access, PT_PAGE_TABLE_LEVEL,
 					 gfn, spte_to_pfn(sp->spt[i]),
 					 true, false, host_writable);
+
+		if (kvm_available_flush_tlb_with_range()
+		    && (tmp_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH)) {
+			struct kvm_mmu_page *leaf_sp = page_header(sp->spt[i]
+					& PT64_BASE_ADDR_MASK);
+			list_add(&leaf_sp->flush_link, &flush_list);
+		}
+
+		set_spte_ret |= tmp_spte_ret;
+
 	}
 
 	if (set_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH)
-		kvm_flush_remote_tlbs(vcpu->kvm);
+		kvm_flush_remote_tlbs_with_list(vcpu->kvm, &flush_list);
 
 	return nr_present;
 }
-- 
2.14.4

