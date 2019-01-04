Return-Path: <SRS0=Lr1k=PM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A8EC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 09:09:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F72D2184B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 09:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvSEP/K+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F72D2184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43WJr83THvzDqNd
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 20:09:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="lvSEP/K+"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43WJX93Q75zDqH2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2019 19:55:21 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id e5so17155981plb.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Jan 2019 00:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xRXc/XwU+0JK+tTKqDimxoIXZnhU9RFFAnNgcWVG9mA=;
 b=lvSEP/K+omY4BY0Ld25k59kJSSur3J2dCgRgr+6yby9CvFFfsgXTOn3+D1aJsvNalY
 eTPJapgS5iRWe8Q3VJfTJ0Bthyr9frF7QnBsGgTCvldicoKf7P4ofSI8pZ09IAgB4oJH
 S57zVxQI3vvPDAKwm0oQsJsa4UNZsPZkF0t/oCsc/oq0RtM8Bl0af8yVHC4PZOGlv3vr
 xk5+cqM8Wco6xLzbT7VEmWSN2LwGnGl4YyFdTsgfVbY6uz3M5hvZsFc6A91Yr6tdVH+Z
 ElpfqsR5cbQQTFpFgingD74oF7Tm329wgchjSs/dW+HIz+j+Txq5ZkJoxgkX4QVwmqbB
 /xgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xRXc/XwU+0JK+tTKqDimxoIXZnhU9RFFAnNgcWVG9mA=;
 b=FGLEk2GZfdcGo+qBNbaZ8/vlqxZLRZvzmUGVi3wwdOrwu6g59rm+Q8PKgZkpyzGaem
 lGappV3bzpn0pdFfsaaWWXLqm3k2FbLeewXK+uWKCTFLOvJxj+kbSmO2yUn37JwFhFCP
 QHGkQ+l7tcMeAnAJ2csDj4L532IeiYYzCm2HbXxwnIlguBxaFmqHjCpZqUEQLopqvXxg
 1xGat18STnKbuwuiwsMY6WHiBrEC2G96Yaus6ZsYBnZwLkp3Q6ZRxt1EUvx4Vu6CX3E0
 x159mBy+WGUOgHuKQZyK51Hq/Vc8Pp1XV1XnGfNJMSFftgwM9wS413SFmA4rIlQbHyVu
 fIAw==
X-Gm-Message-State: AJcUuke7EC/g8tSy9Iux1EUCmswwMdRK8ZxDMN+LGPtXiJ48MG+bk85L
 Y2mX6oFToKa7Ps1aY/YKzfU=
X-Google-Smtp-Source: ALg8bN6SD6ySHgduF3UiOSRUnfYBNpkE+dVu9pEO0AqBi2lbwhCbWkSW6krUk3+TRsHaKT0HX3RnDg==
X-Received: by 2002:a17:902:2b84:: with SMTP id
 l4mr50247049plb.191.1546592119875; 
 Fri, 04 Jan 2019 00:55:19 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.55.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 00:55:19 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH 8/11] KVM: Make kvm_arch_mmu_enable_log_dirty_pt_masked()
 return value
Date: Fri,  4 Jan 2019 16:54:02 +0800
Message-Id: <20190104085405.40356-9-Tianyu.Lan@microsoft.com>
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

This patch is to make kvm_arch_mmu_enable_log_dirty_pt_masked() return value
and caller can use it to determine whether tlb flush is necessary.
kvm_get_dirty_log_protect() and kvm_clear_dirty_log_protect() use the return
value of kvm_arch_mmu_enable_log_dirty_pt_masked() to populate flush
parameter.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/mips/kvm/mmu.c      |  5 ++++-
 arch/x86/kvm/mmu.c       |  6 +++++-
 include/linux/kvm_host.h |  2 +-
 virt/kvm/arm/mmu.c       |  5 ++++-
 virt/kvm/kvm_main.c      | 10 ++++------
 5 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 97e538a8c1be..f36ccb2d43ec 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -437,8 +437,10 @@ int kvm_mips_mkclean_gpa_pt(struct kvm *kvm, gfn_t start_gfn, gfn_t end_gfn)
  *
  * Walks bits set in mask write protects the associated pte's. Caller must
  * acquire @kvm->mmu_lock.
+ *
+ * Returns: Whether caller needs to flush tlb.
  */
-void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
+bool kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 		struct kvm_memory_slot *slot,
 		gfn_t gfn_offset, unsigned long mask)
 {
@@ -447,6 +449,7 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 	gfn_t end = base_gfn + __fls(mask);
 
 	kvm_mips_mkclean_gpa_pt(kvm, start, end);
+	return true;
 }
 
 /*
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 6d4f7dfeaa57..9d8ee6ea02db 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1676,8 +1676,10 @@ EXPORT_SYMBOL_GPL(kvm_mmu_clear_dirty_pt_masked);
  *
  * Used when we do not need to care about huge page mappings: e.g. during dirty
  * logging we do not have any such mappings.
+ *
+ * Return value means whether caller needs to flush tlb.
  */
-void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
+bool kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 				struct kvm_memory_slot *slot,
 				gfn_t gfn_offset, unsigned long mask)
 {
@@ -1686,6 +1688,8 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 				mask);
 	else
 		kvm_mmu_write_protect_pt_masked(kvm, slot, gfn_offset, mask);
+
+	return true;
 }
 
 /**
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c38cc5eb7e73..e86b8c38342b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -759,7 +759,7 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
 int kvm_clear_dirty_log_protect(struct kvm *kvm,
 				struct kvm_clear_dirty_log *log, bool *flush);
 
-void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
+bool kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 					struct kvm_memory_slot *slot,
 					gfn_t gfn_offset,
 					unsigned long mask);
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 3053bf2584f8..232007ff3208 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1564,12 +1564,15 @@ static void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
  *
  * It calls kvm_mmu_write_protect_pt_masked to write protect selected pages to
  * enable dirty logging for them.
+ *
+ * Return value means whether caller needs to flush tlb.
  */
-void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
+bool kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 		struct kvm_memory_slot *slot,
 		gfn_t gfn_offset, unsigned long mask)
 {
 	kvm_mmu_write_protect_pt_masked(kvm, slot, gfn_offset, mask);
+	return true;
 }
 
 static void clean_dcache_guest_page(kvm_pfn_t pfn, unsigned long size)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e75dbb15fd09..bcbe059d98be 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1202,13 +1202,12 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
 			if (!dirty_bitmap[i])
 				continue;
 
-			*flush = true;
 			mask = xchg(&dirty_bitmap[i], 0);
 			dirty_bitmap_buffer[i] = mask;
 
 			offset = i * BITS_PER_LONG;
-			kvm_arch_mmu_enable_log_dirty_pt_masked(kvm, memslot,
-								offset, mask);
+			*flush = kvm_arch_mmu_enable_log_dirty_pt_masked(kvm,
+							memslot, offset, mask);
 		}
 		spin_unlock(&kvm->mmu_lock);
 	}
@@ -1275,9 +1274,8 @@ int kvm_clear_dirty_log_protect(struct kvm *kvm,
 		 * a problem if userspace sets them in log->dirty_bitmap.
 		*/
 		if (mask) {
-			*flush = true;
-			kvm_arch_mmu_enable_log_dirty_pt_masked(kvm, memslot,
-								offset, mask);
+			*flush = kvm_arch_mmu_enable_log_dirty_pt_masked(kvm,
+					memslot, offset, mask);
 		}
 	}
 	spin_unlock(&kvm->mmu_lock);
-- 
2.14.4

