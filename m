Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C7BC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 15:12:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF4DD20657
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 15:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVTWaQnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF4DD20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445ZZj28YTzDqZP
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 02:12:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="VVTWaQnA"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445ZSd0RYtzDqW8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Feb 2019 02:07:13 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id p19so1235603plo.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 07:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Q0P5XgUhHSeogEE24zx3HNxWmK4nJsBPit2rUo7j0iI=;
 b=VVTWaQnAfH2eioa468QYwi8FCfMVGxfTUkZ1MqTKn4GjsZOFCHMNz49Hi7A6Ca5Lp9
 prEuk2Pk3UMgw+0LuXko8oH4teeiagMaMwpxbrWUKc1M+qc5Jp9VDoYeCSlLGaptlatg
 rWPZ77LiAzAHabZciKq1NuQ795+t/yhYaKJq5kgZHSB1rhI1qUnivpbXq5O7aThbedLC
 eq1WSwTpJri9Z2l5ITc7QB53GZd1R+5h9gSpqBUWC0Hwt0V16EdNsgTgWjLPgJN5K2c7
 Yff0G/aB75brz6zuq0/sI9Dp22FEy4SF12u1enbC3QzY62hltFL5Y88E19PzAMCVNqj+
 wpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Q0P5XgUhHSeogEE24zx3HNxWmK4nJsBPit2rUo7j0iI=;
 b=DGSEu3npfQekmGddW+6WiqfogWSjnJ5Crs6Fb5eUlyTeKjnXR6YTydJcbCFxYQHpMh
 jWYcu5fiZOfBL0oyoHh4fh7QUv9uP+GBoZjmGRgNp9EvHGCoV/wyQgODOmuUUCqTDogI
 PFQyu4Kg+91mWKfIfsCsrKAPfoQZrgalzOqHu4+hKkCNPiQvC6VE2WdKATlguhKtC7EV
 SMhKk80TG7IYmp0ku5HAJaskYG0I6GRMzffjMwVg8e61QGl3ybKl4OJh1RHT+RvEZ0if
 2ShFtzBb/9NMom614en4ADwiTIRjxYGZkwKX/Pudw/Ka39sQMbKpjZ4cuY24XmqnU7bf
 JLtw==
X-Gm-Message-State: AHQUAuZMSMgV0tmewml2sjkQOcLcvV50RcQRiatiw6kD2BMU6b9hIY4J
 xRDecIfmaOYyr83NkhCGhkc=
X-Google-Smtp-Source: AHgI3IYt1nmRnL4fTVfYPNhScGJwllP9ezkrwos1wRWo49n4OUOin7xMzg9Vx3TPBgs0S4KkcyRnlw==
X-Received: by 2002:a17:902:5a8d:: with SMTP id
 r13mr4655676pli.190.1550848031497; 
 Fri, 22 Feb 2019 07:07:11 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id a4sm6151780pga.52.2019.02.22.07.07.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 07:07:10 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V3 2/10] KVM/VMX: Fill range list in
 kvm_fill_hv_flush_list_func()
Date: Fri, 22 Feb 2019 23:06:29 +0800
Message-Id: <20190222150637.2337-3-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
References: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
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

Populate ranges on the flush list into struct hv_guest_mapping_flush_list
when flush list is available in the struct kvm_tlb_range.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v2:
	- Fix calculation of flush pages in the kvm_fill_hv_flush_list_func()
---
 arch/x86/include/asm/kvm_host.h |  7 +++++++
 arch/x86/kvm/vmx/vmx.c          | 18 ++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 875ae7256608..9fc9dd0c92cb 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -318,6 +318,12 @@ struct kvm_rmap_head {
 
 struct kvm_mmu_page {
 	struct list_head link;
+
+	/*
+	 * Tlb flush with range list uses struct kvm_mmu_page as list entry
+	 * and all list operations should be under protection of mmu_lock.
+	 */
+	struct hlist_node flush_link;
 	struct hlist_node hash_link;
 	bool unsync;
 	bool mmio_cached;
@@ -441,6 +447,7 @@ struct kvm_mmu {
 struct kvm_tlb_range {
 	u64 start_gfn;
 	u64 pages;
+	struct hlist_head *flush_list;
 };
 
 enum pmc_type {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 77b5379e3655..85139d318490 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -432,9 +432,23 @@ static int kvm_fill_hv_flush_list_func(struct hv_guest_mapping_flush_list *flush
 		void *data)
 {
 	struct kvm_tlb_range *range = data;
+	struct kvm_mmu_page *sp;
 
-	return hyperv_fill_flush_guest_mapping_list(flush, 0, range->start_gfn,
-			range->pages);
+	if (!range->flush_list) {
+		return hyperv_fill_flush_guest_mapping_list(flush,
+			0, range->start_gfn, range->pages);
+	} else {
+		int offset = 0;
+
+		hlist_for_each_entry(sp, range->flush_list, flush_link) {
+			int pages = KVM_PAGES_PER_HPAGE(sp->role.level + 1);
+
+			offset = hyperv_fill_flush_guest_mapping_list(flush,
+					offset, sp->gfn, pages);
+		}
+
+		return offset;
+	}
 }
 
 static inline int __hv_remote_flush_tlb_with_range(struct kvm *kvm,
-- 
2.14.4

