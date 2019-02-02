Return-Path: <SRS0=/SFz=QJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86291C282D8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 01:47:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F25EB20857
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 01:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYWWdogH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25EB20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43rxgB73ZfzDqjv
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 12:47:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="rYWWdogH"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43rxTg0zVhzDqjd
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Feb 2019 12:39:19 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id y4so3739726pgc.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Feb 2019 17:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6fivvub99Xix9SC3KKfxY3DnEgPVHfJZb9qun3OaRWg=;
 b=rYWWdogHyyfoXHNw5vYGz1rLozTLpmOkP0KHq197u7SHmMLbh+SkNqa7NpQtSdMfQq
 Sg2+fJLGoIFUvNopzkSuf+xcc4vTZubXH7cPBLLLEF9z9cMpKmuLzM00WWcaWtYOlYoY
 8QZOVzS/gUsOqXwweSfmeSAQirZ8DFeZxbW/1g1BV9EA1eQNZMAK5En0+ASsQb0IFPtW
 9ehITCoiqh4YiLLPrNJ9/A5Hqo5hIs9LcngkxxNaQ7bQ2DORxuesRxtd5sJsPHHiZCUq
 iuLVUhdb9FEKI7KaHoyxW5MzXqgNtzYoWOuflVepi2+pqZY5pl9G0HkcTbOHhVZ1b240
 7JiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6fivvub99Xix9SC3KKfxY3DnEgPVHfJZb9qun3OaRWg=;
 b=OeETpMbA037+NiHbBLs/K62RbIJPVxJIL4jN4c6vDBwlv4jMUI3nC5lKu7yoNKPuTF
 fHSKubqebNp81YEP59EtBuvWWjdbxSBdhJU6xWVeEvOFvkS7ydp8Vzo6U8w3DMuqf/9c
 OUPZV4ytDxztDTmbW20SO9kSt1zu72HjvnR7S7090t/3ZaBU0qZF/ZfLfqtvDOiC0XV9
 i7sgWd+++zJRqorIeRe6Clp2UVgSqT7lS0/GvxJoGlZsLI5GT4Dk1pBykPEFLer0dqMF
 mjV73eNp2nNn4vpWmAGmx7Y3ALUFXiQ1Frc9LK1HxIWGYkBYZK0DpZ4NWutHpNBkO6If
 bC0Q==
X-Gm-Message-State: AJcUukdLVwpd3sISmkjCIgFSvemuK89WJGIPFE+hJbJhOC8aqvAtcUKs
 cxp7hk1S5hCqK2mktAzpA+s=
X-Google-Smtp-Source: ALg8bN7W+aadejbG7oa19lQl7G9yPYUZCeqRb9Yml4K7aisKFkTmeYC8Fchg3oAyUGiZP9Vgewt9Xw==
X-Received: by 2002:a62:16d6:: with SMTP id 205mr41603341pfw.256.1549071557589; 
 Fri, 01 Feb 2019 17:39:17 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id d3sm9183425pgl.64.2019.02.01.17.39.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Feb 2019 17:39:16 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V2 4/10] KVM/MMU: Introduce tlb flush with range list
Date: Sat,  2 Feb 2019 09:38:20 +0800
Message-Id: <20190202013825.51261-5-Tianyu.Lan@microsoft.com>
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

This patch is to introduce tlb flush with range list interface and use
struct kvm_mmu_page as list entry. Use flush list function in the
kvm_mmu_commit_zap_page().

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 70cafd3f95ab..d57574b49823 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -289,6 +289,20 @@ static void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
 
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
@@ -2708,6 +2722,7 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
 				    struct list_head *invalid_list)
 {
 	struct kvm_mmu_page *sp, *nsp;
+	HLIST_HEAD(flush_list);
 
 	if (list_empty(invalid_list))
 		return;
@@ -2721,7 +2736,15 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
 	 * In addition, kvm_flush_remote_tlbs waits for all vcpus to exit
 	 * guest mode and/or lockless shadow page table walks.
 	 */
-	kvm_flush_remote_tlbs(kvm);
+	if (kvm_available_flush_tlb_with_range()) {
+		list_for_each_entry(sp, invalid_list, link)
+			if (sp->last_level)
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

