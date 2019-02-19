Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA26C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 03:56:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 144432147A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 03:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s99RJ+VM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144432147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443Rjd4nSKzDq5t
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 14:56:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="s99RJ+VM"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443RgN23LRzDqHh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 14:54:07 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id 101so9715335pld.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 19:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Hpae+Cn7fvx8SZf70hgI8zVNXSz5QD/XB5kgI4NdgAs=;
 b=s99RJ+VMFCimGO1Nwnbfa5/KjipGbUFNQaZyFlkTttbj35BOZRWiYsFPv3o6fYpEpW
 1e60kKMPcQkD0hxbgZJzthOgnLveMrP/xui76kVxgRxB4wyjjselwGvO7r422o5Vf/4A
 wPoxKC8E4hGW3FAmdRnDflOBWa1r7mOctRA7SI/kVBRzhRI7go8ou5fkCf86Sr99J71u
 rW8pavpLb3jnybR2PY6+4Ghd/PeL7VxFvTzQN5RgQ1/9fRpBNICmVSOfuW4liu9q+xrN
 VxqGo5uN8ylvKpHX4oy+tX445LY+rxNXoWm4lShiWtjj5HZXqwkBuaklm0w0I5qNGA5E
 yQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Hpae+Cn7fvx8SZf70hgI8zVNXSz5QD/XB5kgI4NdgAs=;
 b=NVzCfGkGdZ4PH2kMfqVJ5vWbvy6Thtctuj40T/VloPamaXEkgMybJ4kd6swQ/zLhgw
 AE0VQS24sKQrQchppt9fF5t53e+NEtW8U4iD14FS0ZB3Bdn73WmjLCXZO2dvxievzaZQ
 uA1ay2K+Ny4f7VOwMqKHTuFy2KGqV05RXEEI2ucIjQf/xcaJM5/7TZUD6HCZ1StVdJiX
 1cDsmBU9BDH0xh8oar8pUwNNfdFbXHUs62VXOWnZ5d4wunys/H6XwjmiSf1yNctOdWxc
 Hd4O49G/sT5dAo0qfR73hXjvBYVBvF8EMcviSmN8i13NCq+Vg0ISLT9yWqG2+TBhaaWV
 0sSA==
X-Gm-Message-State: AHQUAubARiXy8EtOdM9dMeFcfvFb3FuCHN4CSnkrrd5xyGqXtL3ozCog
 dfyHanofxye+b4w12S6FRjN0z0bM
X-Google-Smtp-Source: AHgI3IbCEMpS0yt5WXYpWM2xJnHePHC6Ak+K0uqB0n9yH7/9knXMN6whRl4qiyRTpLwvcVXlyQAvPQ==
X-Received: by 2002:a17:902:4827:: with SMTP id
 s36mr28148457pld.168.1550548446349; 
 Mon, 18 Feb 2019 19:54:06 -0800 (PST)
Received: from surajjs2.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id o6sm14116536pgo.27.2019.02.18.19.54.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 19:54:05 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v2] KVM: PPC: Book3S: Add KVM stat largepages_[2M/1G]
Date: Tue, 19 Feb 2019 14:53:45 +1100
Message-Id: <20190219035345.26239-1-sjitindarsingh@gmail.com>
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

V1 -> V2:
- Rename debugfs files from num_[2M/1G]_pages to largepages_[2M/1G] to match
  x86

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
index bd1a677dd9e4..72fd7d44379b 100644
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
+	{ "largepages_2M",    VM_STAT(num_2M_pages) },
+	{ "largepages_1G",    VM_STAT(num_1G_pages) },
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

