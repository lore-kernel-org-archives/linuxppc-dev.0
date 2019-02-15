Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3ACC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 04:12:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08AE021A80
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 04:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LB/0vDPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08AE021A80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4410Fz6JjvzDqcD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 15:12:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="LB/0vDPW"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4410D24Fd2zDqcF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 15:10:26 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id g6so4175958pfh.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 20:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=WmGbMniKCgUsrxyyJwK4gUwIV2Lp6eqak7RPGGw1vkc=;
 b=LB/0vDPW3mIBUwAuxXZ/CgFpn9R/Xt/v2bJDRW/2ALuxTPzn6qrSpx16ijBGYX1Bct
 aUxQ8G1MO0Efs3QjuwSM59VzL8TMbQuhOgJoCQp6TXFbw21yFQ1E7Xx40jEtRI/mZkZh
 jfb2+G+ft6KhZM1Rk+VrTNv+78g+40Z0KGrB4unCWDb9feNmucjy/6mrjZ366QT4VJ2Y
 rfm3kwZQ2BhoL7Th+aqqpwL3sBgA603GJuICUCe4VGRoYoJ0BrWR9Bb58RsTHb67CgNv
 PRShTGaZwFKHcCmRnK76MVtH/ZkexIM3cD+agiWb7Fo0EX1AWuP1Z0xVABKtpzBMNbjh
 cARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=WmGbMniKCgUsrxyyJwK4gUwIV2Lp6eqak7RPGGw1vkc=;
 b=li8778X9LxoGQ0ssdN4RLXcbeheUTv99XfwA9WNzzR/CYa4YErvjyhkAAJOtac/qGh
 EXwdfAkGzKy9AgXadqx4kez1SA8Riy8ZL2KIiSfLxBS0aE9OML7DmaZslftafD4TGKe+
 Wza6U/gpTJiryAPNlH3pJz6bXQ0bluh3l5AKpOHQorUh8hf8PdbtnEBr44m6Cfmn45GB
 6a3KIVyqtxmyC2c8fWgI/pcHBMvDWxlpQhr6rlJvjJH9A/eybGc5kNksAx952wrXtEZ+
 KywTYLdtSd5+4LF9YLfTcbVoKOW3Swp8Em5auK4MKklzA+puujV5sIHMRF1EoAybTp4m
 SnUQ==
X-Gm-Message-State: AHQUAuZcoKLuKRBlGiBRBPlKdggpAuYubSQsOJRAdvEKq4p6VoQppuLL
 FvPY+4YTcx41B79zu5jYfC4=
X-Google-Smtp-Source: AHgI3IabauFapV4yiDX0/GrikfoNH7r7KVHLYrRaspd6HMXryW+mGjdIxweOCDlkLp03Vl+UZ7d4Zw==
X-Received: by 2002:aa7:85cc:: with SMTP id z12mr7843671pfn.196.1550203824493; 
 Thu, 14 Feb 2019 20:10:24 -0800 (PST)
Received: from surajjs2.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id t65sm8413310pfi.117.2019.02.14.20.10.21
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Feb 2019 20:10:23 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH] KVM: PPC: Book3S: Add KVM stat num_[2M/1G]_pages
Date: Fri, 15 Feb 2019 15:10:04 +1100
Message-Id: <20190215041004.10575-1-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
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
Cc: linuxppc-dev@lists.ozlabs.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, kvm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This adds an entry to the kvm_stats_debugfs directory which provides the
number of large (2M or 1G) pages which have been used to setup the guest
mappings.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/include/asm/kvm_host.h    |  2 ++
 arch/powerpc/kvm/book3s.c              |  3 +++
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 15 ++++++++++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 0f98f00da2ea..cbb090010312 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -99,6 +99,8 @@ struct kvm_nested_guest;
 
 struct kvm_vm_stat {
 	ulong remote_tlb_flush;
+	ulong num_2M_pages;
+	ulong num_1G_pages;
 };
 
 struct kvm_vcpu_stat {
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index bd1a677dd9e4..3cc5215bdb2e 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -39,6 +39,7 @@
 #include "book3s.h"
 #include "trace.h"
 
+#define VM_STAT(x) offsetof(struct kvm, stat.x), KVM_STAT_VM
 #define VCPU_STAT(x) offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU
 
 /* #define EXIT_DEBUG */
@@ -71,6 +72,8 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "pthru_all",       VCPU_STAT(pthru_all) },
 	{ "pthru_host",      VCPU_STAT(pthru_host) },
 	{ "pthru_bad_aff",   VCPU_STAT(pthru_bad_aff) },
+	{ "num_2M_pages",    VM_STAT(num_2M_pages) },
+	{ "num_1G_pages",    VM_STAT(num_1G_pages) },
 	{ NULL }
 };
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 1b821c6efdef..f55ef071883f 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -403,8 +403,13 @@ void kvmppc_unmap_pte(struct kvm *kvm, pte_t *pte, unsigned long gpa,
 		if (!memslot)
 			return;
 	}
-	if (shift)
+	if (shift) { /* 1GB or 2MB page */
 		page_size = 1ul << shift;
+		if (shift == PMD_SHIFT)
+			kvm->stat.num_2M_pages--;
+		else if (shift == PUD_SHIFT)
+			kvm->stat.num_1G_pages--;
+	}
 
 	gpa &= ~(page_size - 1);
 	hpa = old & PTE_RPN_MASK;
@@ -878,6 +883,14 @@ int kvmppc_book3s_instantiate_page(struct kvm_vcpu *vcpu,
 		put_page(page);
 	}
 
+	/* Increment number of large pages if we (successfully) inserted one */
+	if (!ret) {
+		if (level == 1)
+			kvm->stat.num_2M_pages++;
+		else if (level == 2)
+			kvm->stat.num_1G_pages++;
+	}
+
 	return ret;
 }
 
-- 
2.13.6

