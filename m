Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E25C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 15:19:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54853207E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 15:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZn34zh1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54853207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445Zkk36w8zDqjX
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 02:19:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="sZn34zh1"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445ZTF2hgSzDqVm
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Feb 2019 02:07:45 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id s1so1212300plp.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 07:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=CpN/0CU4PssPimucBDW3qrQE8gB87OVfmQk4MBzKcb0=;
 b=sZn34zh121esQ9rHu7OfdWYgI567kymvyPtthBEFuNmOfJWc+SL6SiHZRqxvpLi/DS
 5j/HkSPzuvMHTcnA3dFymxGR4aVkky9kxKZwNg/3Y/dwfBbb5Au9iqewX8XYNPB1VdL0
 6k+2hIADWR2i5LzFzyDDyL7AG59h18992mECk/VkD80umCmdi5UmrWr9Px/rOmt7JwN9
 Zaxl2vdv628qNQ5yrIMbynBoCupTr5SOdm9HZF35o07h8qIZNoYKY+FGD0/1lErJMkiS
 Qrm986aMPblJDFt1pQK+S/V7cGMf2wMl/qZYusz1PX9Ia+wGbYclVCX4a2J/up3pieyZ
 ugpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=CpN/0CU4PssPimucBDW3qrQE8gB87OVfmQk4MBzKcb0=;
 b=jTznK5MVcYN9yaxahZpp9b/hinLvnH/EzmRnUxbjfrDmegFHIlBetfKMn7fE8oe56n
 6zY3+Go1sd1zzOD29F5SkuNhLOh+jYxo/tKBp7La+gKKnGQiHMbUjkHi+9btVEuHNsDA
 hhT/DryH50sNL2qiQPLEF/yJ2svx6o8zTseu0O2Fnov3bndIkoJzREqqt/F+0ToKOhkB
 3ScobWLrbFEqOUBCdJ48uTMjcKFx6LruiZOd46ZEVGQcGdvvvknRBmF2DorHwL5QzGfc
 scM6qQ7vBgRYlBcrW7sh5kYV8hjtnNulX0qExeOPZx6YxsuG8g4j1CDYlY8ER0QcZpc3
 uxEQ==
X-Gm-Message-State: AHQUAuYM0uJWDPTfcVTBGF6H6hQ/ET7+iitWJcqWOl/nrgKNbg9odzgE
 K+jP4wRRrq8j9W9mIAyux3s=
X-Google-Smtp-Source: AHgI3IYMepLojh2DFE0IB9ZwxY853xtXspAtLpEVzZyrdb9ij0IMu6tFRllJJBjnpjslRP6pU0AOLQ==
X-Received: by 2002:a17:902:bd97:: with SMTP id
 q23mr4685513pls.210.1550848062453; 
 Fri, 22 Feb 2019 07:07:42 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id a4sm6151780pga.52.2019.02.22.07.07.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 07:07:41 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V3 6/10] KVM: Add kvm_get_memslot() to get memslot via slot id
Date: Fri, 22 Feb 2019 23:06:33 +0800
Message-Id: <20190222150637.2337-7-Tianyu.Lan@microsoft.com>
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

This patch is to add kvm_get_memslot() to get struct kvm_memory_slot
via slot it and remove redundant codes. The function will also be used
in the following changes.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 include/linux/kvm_host.h |  1 +
 virt/kvm/kvm_main.c      | 45 +++++++++++++++++++--------------------------
 2 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9d55c63db09b..87e665069f6d 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -779,6 +779,7 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
 			      struct kvm_dirty_log *log, bool *flush);
 int kvm_clear_dirty_log_protect(struct kvm *kvm,
 				struct kvm_clear_dirty_log *log, bool *flush);
+struct kvm_memory_slot *kvm_get_memslot(struct kvm *kvm, u32 slot);
 
 void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 					struct kvm_memory_slot *slot,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 276af92ace6c..61ddc3f0425c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1099,22 +1099,30 @@ static int kvm_vm_ioctl_set_memory_region(struct kvm *kvm,
 	return kvm_set_memory_region(kvm, mem);
 }
 
+struct kvm_memory_slot *kvm_get_memslot(struct kvm *kvm, u32 slot)
+{
+	struct kvm_memslots *slots;
+	int as_id, id;
+
+	as_id = slot >> 16;
+	id = (u16)slot;
+	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
+		return NULL;
+
+	slots = __kvm_memslots(kvm, as_id);
+	return id_to_memslot(slots, id);
+}
+
 int kvm_get_dirty_log(struct kvm *kvm,
 			struct kvm_dirty_log *log, int *is_dirty)
 {
-	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
-	int i, as_id, id;
 	unsigned long n;
 	unsigned long any = 0;
+	int i;
 
-	as_id = log->slot >> 16;
-	id = (u16)log->slot;
-	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
-		return -EINVAL;
+	memslot = kvm_get_memslot(kvm, log->slot);
 
-	slots = __kvm_memslots(kvm, as_id);
-	memslot = id_to_memslot(slots, id);
 	if (!memslot->dirty_bitmap)
 		return -ENOENT;
 
@@ -1158,20 +1166,13 @@ EXPORT_SYMBOL_GPL(kvm_get_dirty_log);
 int kvm_get_dirty_log_protect(struct kvm *kvm,
 			struct kvm_dirty_log *log, bool *flush)
 {
-	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
-	int i, as_id, id;
 	unsigned long n;
 	unsigned long *dirty_bitmap;
 	unsigned long *dirty_bitmap_buffer;
+	int i;
 
-	as_id = log->slot >> 16;
-	id = (u16)log->slot;
-	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
-		return -EINVAL;
-
-	slots = __kvm_memslots(kvm, as_id);
-	memslot = id_to_memslot(slots, id);
+	memslot = kvm_get_memslot(kvm, log->slot);
 
 	dirty_bitmap = memslot->dirty_bitmap;
 	if (!dirty_bitmap)
@@ -1227,24 +1228,16 @@ EXPORT_SYMBOL_GPL(kvm_get_dirty_log_protect);
 int kvm_clear_dirty_log_protect(struct kvm *kvm,
 				struct kvm_clear_dirty_log *log, bool *flush)
 {
-	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
-	int as_id, id;
 	gfn_t offset;
 	unsigned long i, n;
 	unsigned long *dirty_bitmap;
 	unsigned long *dirty_bitmap_buffer;
 
-	as_id = log->slot >> 16;
-	id = (u16)log->slot;
-	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
-		return -EINVAL;
-
 	if ((log->first_page & 63) || (log->num_pages & 63))
 		return -EINVAL;
 
-	slots = __kvm_memslots(kvm, as_id);
-	memslot = id_to_memslot(slots, id);
+	memslot = kvm_get_memslot(kvm, log->slot);
 
 	dirty_bitmap = memslot->dirty_bitmap;
 	if (!dirty_bitmap)
-- 
2.14.4

