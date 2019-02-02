Return-Path: <SRS0=/SFz=QJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49896C282D8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 01:49:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A8420857
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 01:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcBSvhg6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A8420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43rxht5XWFzDqSr
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 12:49:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="JcBSvhg6"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43rxTp5l08zDqgD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Feb 2019 12:39:26 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id v28so3748937pgk.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Feb 2019 17:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rByqLCOGvQ8nC7iVvwCr6DlPApr36fgfZWbbNDw3cPc=;
 b=JcBSvhg6DtXatbgMnyQPHGvUT0KXMV+vsEQvkE+bwnES3r8FwaD6AuXKWbGneMDz3s
 aEP9gz3gTzw9afwA1Vn2/whKrqSfJnjlvkxH/60fVrq78G65y2YhzxhMqoSMw/VRwiZC
 dgP1qtfqZasGPDUNv4b3GGuTWfjRYD5EqS8hLpq/97GVas2CizzxVgexa58vT7e4WITd
 azMgVpqULEKmZfeGFvw+m2BQka6NAtIoGdwOu76ZznsaS+VBDxpRT71E0Mc1h19Q5OlU
 d1sJPU2mHk8QHI42wWDvTqlVz6u7A3UgRLvity26FGTvlrRKwNuldw6wMGzlTElyz/zh
 iOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=rByqLCOGvQ8nC7iVvwCr6DlPApr36fgfZWbbNDw3cPc=;
 b=OKr7vZzInRmYWvl87xtCHYHEZOs/u/crCfGRcMGAGMm00rUd3Rl9I/GI58ZqDgkNvA
 rzvYPPYp7AXyL87ArnhifK5OPGgzH7zqOhri6rX31YC01dKC32bmH4wekUfqcnr+sxLS
 ASsROjntrP3pkQtHxLtAYE3Ki3QZICoz1qbwP3kI8bVQ4TtCpXnxIyXJK5dlnUvwM5Yh
 4Cj+nteCsVei9wYAnMu7vs5epLL+uBcBsWFgn114IyKQTHADBdJTCD7HeCthvi1+e0cJ
 AVQ6wgpDSrvsqcE2Uqo400YHkVteLO5N/udFw9Ql5MAEXvq9KtsYs0uN3Ta5sKUrpIvi
 cGvg==
X-Gm-Message-State: AHQUAubMQ7zNWh2CcOcUW4qU9CPYQ1jQIf66l0V/z6MTEibOTl/7KjiH
 zYDQs4wM7/3Ed5eWjpLdHbw=
X-Google-Smtp-Source: AHgI3IY4pbsGdSsiplWwzuSajzIs74vE3bWXmAl9AhEm/chKi5rYt5/pCLZhODFUahdG52LiNoncsw==
X-Received: by 2002:a63:e5c:: with SMTP id 28mr4247053pgo.369.1549071565234;
 Fri, 01 Feb 2019 17:39:25 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id d3sm9183425pgl.64.2019.02.01.17.39.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Feb 2019 17:39:24 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V2 5/10] KVM/MMU: Flush tlb with range list in sync_page()
Date: Sat,  2 Feb 2019 09:38:21 +0800
Message-Id: <20190202013825.51261-6-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
References: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
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

This patch is to flush tlb via flush list function. Put
page into flush list when return value of set_spte()
includes flag SET_SPTE_NEED_REMOTE_TLB_FLUSH. kvm_flush_remote_
tlbs_with_list() checks whether the flush list is empty
or not. It also checks whether range tlb flush is available
and go back to tradiion flush if not.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v1:
       Use check of list_empty in the kvm_flush_remote_tlbs_with_list()
       to determine flush or not instead of checking set_spte_ret.
 
arch/x86/kvm/paging_tmpl.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index 6bdca39829bc..d84486e75345 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -970,7 +970,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 	int i, nr_present = 0;
 	bool host_writable;
 	gpa_t first_pte_gpa;
-	int set_spte_ret = 0;
+	HLIST_HEAD(flush_list);
 
 	/* direct kvm_mmu_page can not be unsync. */
 	BUG_ON(sp->role.direct);
@@ -978,6 +978,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 	first_pte_gpa = FNAME(get_level1_sp_gpa)(sp);
 
 	for (i = 0; i < PT64_ENT_PER_PAGE; i++) {
+		int set_spte_ret = 0;
 		unsigned pte_access;
 		pt_element_t gpte;
 		gpa_t pte_gpa;
@@ -1027,14 +1028,20 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 
 		host_writable = sp->spt[i] & SPTE_HOST_WRITEABLE;
 
-		set_spte_ret |= set_spte(vcpu, &sp->spt[i],
+		set_spte_ret = set_spte(vcpu, &sp->spt[i],
 					 pte_access, PT_PAGE_TABLE_LEVEL,
 					 gfn, spte_to_pfn(sp->spt[i]),
 					 true, false, host_writable);
+
+		if (set_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH) {
+			struct kvm_mmu_page *leaf_sp = page_header(sp->spt[i]
+					& PT64_BASE_ADDR_MASK);
+			hlist_add_head(&leaf_sp->flush_link, &flush_list);
+		}
+
 	}
 
-	if (set_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH)
-		kvm_flush_remote_tlbs(vcpu->kvm);
+	kvm_flush_remote_tlbs_with_list(vcpu->kvm, &flush_list);
 
 	return nr_present;
 }
-- 
2.14.4

