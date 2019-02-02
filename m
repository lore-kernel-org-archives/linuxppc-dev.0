Return-Path: <SRS0=/SFz=QJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A1EC282D8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 01:52:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 401A420857
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 01:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qcua337T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401A420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43rxmc2Kh5zDqlp
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 12:52:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qcua337T"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43rxV60hg9zDqjx
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Feb 2019 12:39:42 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id q1so4095372pfi.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Feb 2019 17:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=mzJwBxC9uXB//tA5PSpVVWly8ERu6+h2503MPrKjGcg=;
 b=Qcua337T8myRK46Z4hgHoGruUwG/fSBmBnSudxXeOK8Fr05S1ddajw6sNis92exhPt
 91bfxvoG8/bj38NRAvNU0VbnuCvp1IA4d3IBZPg2VR1jcdjTbhnH5tw2+33fXRCQwfQQ
 PaDqBTFs1gd7oq8qgZfqsi2SbuGsCOYckgitb24/j+YFida+o8CNJlvt7C9YK+XTKiwv
 WYBig8UHSHrJymgn0spCgGoXWwY5pEG92CWOozExwelAWAsFbnHnTJ/FSOAY5PSKSzsU
 aYlGJgXbwgix947+4Tlt8Xx3oCLgEiw9P0s3gscqbJo7fHZNSqzBDJlv6JwINZfn2oDM
 6skw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=mzJwBxC9uXB//tA5PSpVVWly8ERu6+h2503MPrKjGcg=;
 b=b+O67JTmekFx8wkZ1LkfCQWDqHW8hEnCBoe+pSEnuM1ajBun/hlPZf4F5Gb0ShUNIf
 zZHTkQOFci0TTUQrIGcMz4ykB5eGuJD/TbRJorQ/3wObZmHBwHH4SHp8zxPUECX8LJ3G
 ph79sUU1ROezhs5w/WYQz5NAg4ItPXx3OsmpPcj6RJKBrTftIW2HCAWuoPVJJmmhZdfM
 X35Ta6KM4haR1XtUGPa6OOXcLzbV+fbfZ0FVI/7FOX7eCtgLUa7fP6HqlZxumiavwi0B
 /wlX1hWmYBDYP2FQmbXBaR+lgaMGHXF+UBn4ThczBAaqwJhVfndhs8YdNWdeUkHRuQ+U
 +cfg==
X-Gm-Message-State: AHQUAua5M/Z0rAiRgzxQBeX7aHCtDgr42ZN7Ynx/TfScZcXKbt5TBvtu
 YO3RpPX0/sakdhndSHkI1eQ=
X-Google-Smtp-Source: AHgI3IYabhaPzvhFuMYVtOsFddmUk5xY+xDep8I/zRTsc2nUVkd3NGA16u1jhZqEAaNh3r6MH4P4EQ==
X-Received: by 2002:a65:560e:: with SMTP id l14mr4576873pgs.168.1549071580503; 
 Fri, 01 Feb 2019 17:39:40 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id d3sm9183425pgl.64.2019.02.01.17.39.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Feb 2019 17:39:39 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V2 7/10] KVM: Add kvm_get_memslot() to get memslot via slot id
Date: Sat,  2 Feb 2019 09:38:23 +0800
Message-Id: <20190202013825.51261-8-Tianyu.Lan@microsoft.com>
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

This patch is to add kvm_get_memslot() to get struct kvm_memory_slot
via slot it and remove redundant codes. The function will also be used
in the following changes.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 include/linux/kvm_host.h |  1 +
 virt/kvm/kvm_main.c      | 45 +++++++++++++++++++--------------------------
 2 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c38cc5eb7e73..aaa2b57eeb19 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -758,6 +758,7 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
 			      struct kvm_dirty_log *log, bool *flush);
 int kvm_clear_dirty_log_protect(struct kvm *kvm,
 				struct kvm_clear_dirty_log *log, bool *flush);
+struct kvm_memory_slot *kvm_get_memslot(struct kvm *kvm, u32 slot);
 
 void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 					struct kvm_memory_slot *slot,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 7ebe36a13045..b2097fa4b618 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1095,22 +1095,30 @@ static int kvm_vm_ioctl_set_memory_region(struct kvm *kvm,
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
 
@@ -1154,20 +1162,13 @@ EXPORT_SYMBOL_GPL(kvm_get_dirty_log);
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
@@ -1225,24 +1226,16 @@ EXPORT_SYMBOL_GPL(kvm_get_dirty_log_protect);
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

