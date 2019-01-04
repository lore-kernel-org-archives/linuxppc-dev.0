Return-Path: <SRS0=Lr1k=PM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE19C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 09:02:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB692184B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 09:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uIGZ66sW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB692184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43WJht5ScjzDqK5
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 20:02:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="uIGZ66sW"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43WJWc0kVPzDqGG
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2019 19:54:52 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id i12so17995893pfo.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Jan 2019 00:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=DbPYODlBh2cswgOkm5n3Xtx1VG29YKWZuHO2kRQx3jE=;
 b=uIGZ66sWc3MSyPixVlFIwqq9X9Xawe/7lcCM/24F9OUU1MhgIXXEp+AbmzflEK13nM
 2o+Z7uoAl1u/wmPUG3KdiBwSgFXXPl4EIy5LvDsMJPUd2xQxtWZR+TAhyRkwglbNz5am
 o/KasvYoE5o7W/xDHeUq9nW1U+hq6D2rEmY+fBsBoq/f34Ew+f9isuerC2+UXmqf/7xW
 VEHXij5Tmwcu8CH5Sve62zd3WlvJk2e1xqpMBDePH5ZEkitNlq/TWfWZEQBZXcHzrVop
 sJBt1UN3Ju9tBhxkEk4LYvpZdCJEK2L7xGpWi4h9Qu/xiaccyXt/cvhCySXdqM36T05O
 eX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=DbPYODlBh2cswgOkm5n3Xtx1VG29YKWZuHO2kRQx3jE=;
 b=nYg2DXCMc5oLAN4M+jobj7w7HHavNyVLzH1Leg/q/+qFSWD4ejUNy9grr0Rx3tX9yz
 0s/mplDMy+dSjNXwK4ZVKPxDW+p1PqFVJ1zlWA0jWxDIyq5yJeTcPvGALxuuo6SpDmvA
 Dwf/6i4Ml+/lozbXpVodFobK/o5BGSg/pwouBQ4SbK2ZYChk3Sq8z1lMfSBrTvJgz0Xy
 wq6BEKS8RJ91gazqFUC+z7WXGp1SH/x+9StsYtqgGeKsagsZnKyLnKH6sjiaJr3XhyC1
 yhiEXgjSKSkJXFafVRR8VyiTl6jUvNM3JtjcKDsGMGPNoU2NnZmZ1vl9aHH4xARdaSNK
 NgXg==
X-Gm-Message-State: AA+aEWYR9addT0eGgTK1jeg0Cyjh3sqHAS629axK6DseiwfnB+6A1P6p
 MGZ6hfNtrTxpM2D/QgrPfi4=
X-Google-Smtp-Source: ALg8bN4wIfpC3j2afh4wGFjYegQADeZ0K/ccHcj0qIsaA3H5W5N7IpT4CBOOzO8AUje2LUSMO2pDwg==
X-Received: by 2002:a62:1992:: with SMTP id 140mr51523150pfz.33.1546592089991; 
 Fri, 04 Jan 2019 00:54:49 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.54.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 00:54:49 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH 4/11] KVM/MMU: Introduce tlb flush with range list
Date: Fri,  4 Jan 2019 16:53:58 +0800
Message-Id: <20190104085405.40356-5-Tianyu.Lan@microsoft.com>
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

This patch is to introduce tlb flush with range list interface and use
struct kvm_mmu_page as list entry. Use flush list function in the
kvm_mmu_commit_zap_page().

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/include/asm/kvm_host.h |  7 +++++++
 arch/x86/kvm/mmu.c              | 24 +++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 78d2a6714c3b..22dbaa8fba32 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -316,6 +316,12 @@ struct kvm_rmap_head {
 
 struct kvm_mmu_page {
 	struct list_head link;
+
+	/*
+	 * Tlb flush with range list uses struct kvm_mmu_page as list entry
+	 * and all list operations should be under protection of mmu_lock.
+	 */
+	struct list_head flush_link;
 	struct hlist_node hash_link;
 	bool unsync;
 
@@ -443,6 +449,7 @@ struct kvm_mmu {
 struct kvm_tlb_range {
 	u64 start_gfn;
 	u64 pages;
+	struct list_head *flush_list;
 };
 
 enum pmc_type {
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 068694fa2371..d3272c5066ea 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -289,6 +289,17 @@ static void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
 
 	range.start_gfn = start_gfn;
 	range.pages = pages;
+	range.flush_list = NULL;
+
+	kvm_flush_remote_tlbs_with_range(kvm, &range);
+}
+
+static void kvm_flush_remote_tlbs_with_list(struct kvm *kvm,
+		struct list_head *flush_list)
+{
+	struct kvm_tlb_range range;
+
+	range.flush_list = flush_list;
 
 	kvm_flush_remote_tlbs_with_range(kvm, &range);
 }
@@ -2708,6 +2719,7 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
 				    struct list_head *invalid_list)
 {
 	struct kvm_mmu_page *sp, *nsp;
+	LIST_HEAD(flush_list);
 
 	if (list_empty(invalid_list))
 		return;
@@ -2721,7 +2733,17 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
 	 * In addition, kvm_flush_remote_tlbs waits for all vcpus to exit
 	 * guest mode and/or lockless shadow page table walks.
 	 */
-	kvm_flush_remote_tlbs(kvm);
+	if (kvm_available_flush_tlb_with_range()) {
+		list_for_each_entry(sp, invalid_list, link)
+			if (sp->sptep && is_last_spte(*sp->sptep,
+			    sp->role.level))
+				list_add(&sp->flush_link, &flush_list);
+
+		if (!list_empty(&flush_list))
+			kvm_flush_remote_tlbs_with_list(kvm, &flush_list);
+	} else {
+		kvm_flush_remote_tlbs(kvm);
+	}
 
 	list_for_each_entry_safe(sp, nsp, invalid_list, link) {
 		WARN_ON(!sp->role.invalid || sp->root_count);
-- 
2.14.4

