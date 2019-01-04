Return-Path: <SRS0=Lr1k=PM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28808C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 09:10:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A74C2184B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 09:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1NjRFrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A74C2184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43WJsp3sGszDqMX
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 20:10:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="G1NjRFrN"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43WJXK01DjzDqH2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2019 19:55:28 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id y126so17999408pfb.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Jan 2019 00:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ZK8Ep/iS40KCOfUlldAdh4saGJOIzh8GKtl9Mv0nhLM=;
 b=G1NjRFrN/C6osVf7UtbSVtMVpqA9Ea/+QkseFh5fipznXIehIqBOj+WICVCUWsH4fm
 XXrhC1ChDLsoNN78/Jf69XvF4QTvyKS9C0EiG02MtsqGdb/vznYx/ApjHr3GqQaAnc59
 iAzfvakgMPJ9lrvgBNJm4sYCxASvjQdGTWmPXRnBeoYThC7wrSDBO3dfRbcb5WIyDr3H
 /Cn6OmQEBoOqFU++9g31s+9rVVQi9bp8oJg2/DBj/pdk8x12iaIwwR0R4dkwHBh3RkSW
 8wMmO9dWO47ftRi5WiiLwFVdRdVrMEsSK046I7vBDMukcSQjf0h6zVVmkLcMYlYK+egF
 HwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ZK8Ep/iS40KCOfUlldAdh4saGJOIzh8GKtl9Mv0nhLM=;
 b=hTlq9glSNx/14Lb61oadbnbsVr3VdGaYum7MjhD/PejUFM8oakNOm7YmEKPtpBmicP
 PfTaKUiA+IQfHgBUOJMSZLeS2gilfi1HpYGQoP/4XQy/armrKQcuUic8F+qtwpuLDJ52
 qRq8QoPuJZVWHCYHFxr85PcGxHfkstLkhbhTbbK4XF+W7hkN8o5Qcx2zytsJaOP7LZIp
 phmSsCWS2/Xr4MmZYivrWB9eahxntuZHTOPY7y2t8OcfKeW/ydO3tek8OtI87BzctLna
 fBDB48Exu8UcANld5jIlah5TaG01M/qtRv23lAKsUcCD/SzHpEwkN9NdeWI4+NoTZRRz
 53jw==
X-Gm-Message-State: AJcUukcVre6bu+btweQWBCud3FQHnFGOdZ/4fmqxL4Stn7euo153Q6qN
 7mP+A5q1aidaFJJ7yQP7MMw=
X-Google-Smtp-Source: ALg8bN75sfO1wfGgbU1C9NYyKaexIVA3NbEhpqovnyfTJeb3GDT9BdXc/J/k5irnfWBqolOtTpXZ/g==
X-Received: by 2002:a63:da45:: with SMTP id l5mr909998pgj.111.1546592127395;
 Fri, 04 Jan 2019 00:55:27 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.55.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 00:55:26 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH 9/11] KVM/MMU: Flush tlb in the
 kvm_mmu_write_protect_pt_masked()
Date: Fri,  4 Jan 2019 16:54:03 +0800
Message-Id: <20190104085405.40356-10-Tianyu.Lan@microsoft.com>
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

This patch is to flush tlb in the kvm_mmu_write_protect_pt_masked() when
tlb range flush is available and make kvm_mmu_write_protect_pt_masked()
return flush request.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 9d8ee6ea02db..30ed7a79335b 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1624,20 +1624,30 @@ static bool __rmap_set_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head)
  * Used when we do not need to care about huge page mappings: e.g. during dirty
  * logging we do not have any such mappings.
  */
-static void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
+static bool kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
 				     struct kvm_memory_slot *slot,
 				     gfn_t gfn_offset, unsigned long mask)
 {
 	struct kvm_rmap_head *rmap_head;
+	bool flush = false;
 
 	while (mask) {
 		rmap_head = __gfn_to_rmap(slot->base_gfn + gfn_offset + __ffs(mask),
 					  PT_PAGE_TABLE_LEVEL, slot);
-		__rmap_write_protect(kvm, rmap_head, false);
+		flush |= __rmap_write_protect(kvm, rmap_head, false);
 
 		/* clear the first set bit */
 		mask &= mask - 1;
 	}
+
+	if (flush && kvm_available_flush_tlb_with_range()) {
+		kvm_flush_remote_tlbs_with_address(kvm,
+				slot->base_gfn + gfn_offset,
+				hweight_long(mask));
+		flush = false;
+	}
+
+	return flush;
 }
 
 /**
@@ -1683,13 +1693,14 @@ bool kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 				struct kvm_memory_slot *slot,
 				gfn_t gfn_offset, unsigned long mask)
 {
-	if (kvm_x86_ops->enable_log_dirty_pt_masked)
+	if (kvm_x86_ops->enable_log_dirty_pt_masked) {
 		kvm_x86_ops->enable_log_dirty_pt_masked(kvm, slot, gfn_offset,
 				mask);
-	else
-		kvm_mmu_write_protect_pt_masked(kvm, slot, gfn_offset, mask);
-
-	return true;
+		return true;
+	} else {
+		return kvm_mmu_write_protect_pt_masked(kvm, slot, gfn_offset,
+				mask);
+	}
 }
 
 /**
-- 
2.14.4

