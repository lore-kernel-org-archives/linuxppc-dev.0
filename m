Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA9FC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 15:14:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B72F42075C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 15:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFBImuIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72F42075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445Zd64c1PzDqYL
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 02:14:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="CFBImuIf"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445ZSn3VBLzDqRY
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Feb 2019 02:07:21 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id bj4so1219159plb.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 07:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Mf/z10rMsVUftoqc8y3M+np7GkZ7fKmVzfglvuSuVXs=;
 b=CFBImuIfxVblpp2dVFSl9Lp9rPMyBKJbp6SYubcKgkfBvz6HEnk2yuVurnpcFMX2jU
 cTnhiQi/FOhPDBwkoIQDJLl0zyH3eS9nXM4J9QsHwFxLU0MIYCx/f0WjO0sKTtmcgRV8
 AxLNTbxwQz+kF7evW9hWhTBmzTA/d0zBmJcztZRYNpgfeo0j99UBLFidJY2Va7EAP1M1
 CmD+rEsUr+8L9SZnkQLZ18nAAAlVLhEpxaYU64OrDAXS0e/CFewKx4NO/okJzcUpM0Cb
 jQknNeAoXBSSXwIAomw0sE6m+7zn4B+9Ndv/Mmzu5dSlNwXJHDC/5kjPbjjc1tazRh38
 fSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Mf/z10rMsVUftoqc8y3M+np7GkZ7fKmVzfglvuSuVXs=;
 b=Z02w6nv0gJFiuSVvwlswCjWu6a6kfGC6ZjpJtFqutY1XJSpI2HkY7XybJtLYfl6B49
 KmVOjsv4SyqNUcblFLXk6LRnvCcBQ3p4UoEBObDHt1mT0nBz4lcbJhS83zw+ojayeUqI
 zxWpanXBIryLNypUtn1yVkX+bsnVClnhUNOUMyGdeQWLLfGXbJujU1Vrsrw9aJuHuHSj
 LuqhW61Fu+5uQS161eSJ4si53HR5s3rFeWRDJSDAFfurNGsAUELPHULd/T/M5LU6H0Es
 DNdCuoZT4gYz3Z7FHWMHUuY8opSwt+aiDsyKk+Z/rfLHFTETcr/lj3Ad8p0doc7u3lIX
 cvCQ==
X-Gm-Message-State: AHQUAuZjDG25OcZuv1WYjQMbPpfvt7YncYsmGbtxyKrkZEy1GyOM+EWV
 PCF8iAOPVOjATudCBbccXxY=
X-Google-Smtp-Source: AHgI3IZvijtWlx7ZoYkznF2XUyI7kKJ/XBTUftVSqGMWnP6U+sXA5icoLNJDjyf30+XMJJVp91f3sw==
X-Received: by 2002:a17:902:2be8:: with SMTP id
 l95mr4682383plb.270.1550848039252; 
 Fri, 22 Feb 2019 07:07:19 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id a4sm6151780pga.52.2019.02.22.07.07.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 07:07:18 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V3 3/10] KVM/MMU: Introduce tlb flush with range list
Date: Fri, 22 Feb 2019 23:06:30 +0800
Message-Id: <20190222150637.2337-4-Tianyu.Lan@microsoft.com>
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

This patch is to introduce tlb flush with range list interface and use
struct kvm_mmu_page as list entry. Use flush list function in the
kvm_mmu_commit_zap_page().

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 8d43b7c0f56f..7a862c56b954 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -291,6 +291,20 @@ static void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
 
 	range.start_gfn = start_gfn;
 	range.pages = pages;
+	range.flush_list = NULL;
+
+	kvm_flush_remote_tlbs_with_range(kvm, &range);
+}
+
+static void kvm_flush_remote_tlbs_with_list(struct kvm *kvm,
+		struct hlist_head *flush_list)
+{
+	struct kvm_tlb_range range;
+
+	if (hlist_empty(flush_list))
+		return;
+
+	range.flush_list = flush_list;
 
 	kvm_flush_remote_tlbs_with_range(kvm, &range);
 }
@@ -2719,6 +2733,7 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
 				    struct list_head *invalid_list)
 {
 	struct kvm_mmu_page *sp, *nsp;
+	HLIST_HEAD(flush_list);
 
 	if (list_empty(invalid_list))
 		return;
@@ -2732,7 +2747,14 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
 	 * In addition, kvm_flush_remote_tlbs waits for all vcpus to exit
 	 * guest mode and/or lockless shadow page table walks.
 	 */
-	kvm_flush_remote_tlbs(kvm);
+	if (kvm_available_flush_tlb_with_range()) {
+		list_for_each_entry(sp, invalid_list, link)
+				hlist_add_head(&sp->flush_link, &flush_list);
+
+		kvm_flush_remote_tlbs_with_list(kvm, &flush_list);
+	} else {
+		kvm_flush_remote_tlbs(kvm);
+	}
 
 	list_for_each_entry_safe(sp, nsp, invalid_list, link) {
 		WARN_ON(!sp->role.invalid || sp->root_count);
-- 
2.14.4

