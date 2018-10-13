Return-Path: <SRS0=geFq=M2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D979C6787C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 06:00:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C3620835
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 06:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVICMHN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C3620835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XrWm4SwSzF3DR
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 17:00:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZVICMHN0";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZVICMHN0"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XSR405v0zF3DW
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 01:54:40 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id p24-v6so7586103pff.10
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 07:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GCaq3R6VmH1wWlGObzsIcMHnr3COIkQBYeAae2u7kcQ=;
 b=ZVICMHN0AFLfvRfTF9yl5eF1LtUJio6d6J3YKdxugmdHzEsj5NXvND7pZv/SidDdek
 6My4+c84eQCZREXmERXD0Z2ujNZD/ldNJn5zEVz37wk9/OYXYVpkpLkWRnABYIWyAmcK
 GF3oatbiLja/B2Ge3yx9NqdUaA+1W+keyw3OOvxZQdmm2aUfq3sYKOwk9jVqTHCjDbgk
 Wu2MFL9RTrN06WtDIlRlDY8nRY339wsHGB9T0q606/Yg7WI6wxRXmG77b0oOXGVz8pzE
 fl3VV6iszqco6/a9twuZ2bk9dauQqmQkRQ+Pzgk77Aph5Hld8/GC2Ur3ANhrpNdgLvHZ
 gQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GCaq3R6VmH1wWlGObzsIcMHnr3COIkQBYeAae2u7kcQ=;
 b=Or6kdcSm28mKlqyV9UwZYZ6hP20S4dxPgHe/jktk+5OFEP/wfVMUgI/92rorZfih2D
 u6mALmDuc2Rxih4cbWqv23jpu9/xnBlNMfFKh5We381PkTYcGH9M9ne97sGM7C+IjXa2
 Wl1u5QX5Bq4pfbRa9gb0VBsnyv7F0m/MfiBV9oy/auLf+aaC+3v6qjROlmovTRAN2sZd
 PoD+j7trIaGivomuLzZWwc0e2uvF2nIzFU9mr4NY3tfiE1WDJrtfc1s5GeadawTCdNeD
 FtIgsB9xArMpfKh2lb0xK6WWOOXJoeO4DBqwjZ8XuBCmziGpeKJrwikCN2pcsc84smxC
 0QVA==
X-Gm-Message-State: ABuFfogY89awIGobLSroFHWx5ltEPlrIaXexkip1oqWnP3gHYMLGKuk2
 yxOk8s52t/ysadluy0ooDTM=
X-Google-Smtp-Source: ACcGV62EdGNQnQ/sKcjwUyLn1xDKyo7VDncjRak4c7jj414oGg3zSQN7txG6tEyPXVxX5UwcU5idzA==
X-Received: by 2002:a65:4103:: with SMTP id
 w3-v6mr9732885pgp.284.1539442478487; 
 Sat, 13 Oct 2018 07:54:38 -0700 (PDT)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id
 v81-v6sm8688724pfj.25.2018.10.13.07.54.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 13 Oct 2018 07:54:37 -0700 (PDT)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V4 2/15] KVM/MMU: Add tlb flush with range helper function
Date: Sat, 13 Oct 2018 22:53:53 +0800
Message-Id: <20181013145406.4911-3-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
X-Mailman-Approved-At: Sun, 14 Oct 2018 16:51:35 +1100
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
Cc: linux-mips@linux-mips.org, linux@armlinux.org, kvm@vger.kernel.org,
 rkrcmar@redhat.com, catalin.marinas@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, hpa@zytor.com, kys@microsoft.com,
 kvmarm@lists.cs.columbia.edu, sthemmin@microsoft.com, x86@kernel.org,
 michael.h.kelley@microsoft.com, mingo@redhat.com, jhogan@kernel.org,
 Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 haiyangz@microsoft.com, kvm-ppc@vger.kernel.org, devel@linuxdriverproject.org,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 christoffer.dall@arm.com, ralf@linux-mips.org, paul.burton@mips.com,
 pbonzini@redhat.com, vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to add wrapper functions for tlb_remote_flush_with_range
callback.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change sicne V3:
       Remove code of updating "tlbs_dirty"
Change since V2:
       Fix comment in the kvm_flush_remote_tlbs_with_range()
---
 arch/x86/kvm/mmu.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index c73d9f650de7..ff656d85903a 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -264,6 +264,46 @@ static void mmu_spte_set(u64 *sptep, u64 spte);
 static union kvm_mmu_page_role
 kvm_mmu_calc_root_page_role(struct kvm_vcpu *vcpu);
 
+
+static inline bool kvm_available_flush_tlb_with_range(void)
+{
+	return kvm_x86_ops->tlb_remote_flush_with_range;
+}
+
+static void kvm_flush_remote_tlbs_with_range(struct kvm *kvm,
+		struct kvm_tlb_range *range)
+{
+	int ret = -ENOTSUPP;
+
+	if (range && kvm_x86_ops->tlb_remote_flush_with_range)
+		ret = kvm_x86_ops->tlb_remote_flush_with_range(kvm, range);
+
+	if (ret)
+		kvm_flush_remote_tlbs(kvm);
+}
+
+static void kvm_flush_remote_tlbs_with_list(struct kvm *kvm,
+		struct list_head *flush_list)
+{
+	struct kvm_tlb_range range;
+
+	range.flush_list = flush_list;
+
+	kvm_flush_remote_tlbs_with_range(kvm, &range);
+}
+
+static void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
+		u64 start_gfn, u64 pages)
+{
+	struct kvm_tlb_range range;
+
+	range.start_gfn = start_gfn;
+	range.pages = pages;
+	range.flush_list = NULL;
+
+	kvm_flush_remote_tlbs_with_range(kvm, &range);
+}
+
 void kvm_mmu_set_mmio_spte_mask(u64 mmio_mask, u64 mmio_value)
 {
 	BUG_ON((mmio_mask & mmio_value) != mmio_value);
-- 
2.14.4

