Return-Path: <linuxppc-dev+bounces-28686-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FCDCA5FD2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 20:22:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwjyc2QLDz30Sx;
	Fri, 02 Oct 2026 06:22:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::646"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790886168;
	cv=none; b=OQ44ZKkedVtvgF+n6DC9N5VEcbPgxUKzY5K+ZXhlTSN1mUxDCV9UN7+iG8NGgcLfLF2Vtd3LYlj4yDf8o+tc5MUjwNEMTSlbAizZyblbA3XCdO/BWkVlxpAZlwS4XBD/qehfenfi8Sq5Wma6Ipv2IvW6b1B3azMxcGDm1RwMFkHiV8zln0Ls5mee9QpAQOyVYHB7xphoXtPX87BzyynPKvhGJ4KugE5aqc3opthj/CHoR+a+kS8LC8jlB9OX0Loall053CaLezmwyjl+TR+RSaqPf7UPI/IA/qNwK51N7Rq+G2RbQm+Ec29g55HrH+yzctFXu7RCT7JMtRAIcUsO9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790886168; c=relaxed/relaxed;
	bh=r48n+JYZ8dbjdJkdgBh0OvhmILEEnWUiGdrrAjEBorc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WRVKtEp8Tv2BA2q0nNuryrTtFINU0UBPZFE/Ksm4YEsAFBUzaJ/JQHUjALJp4Pg9M/OkHhI2L58wbaFaBSU+FGAVrmks/50Z/I+pm3diLRFGn4jFODyLEI/vCsUQZTnhqHxIU2ioqgzlRvUDUdlw+IEslpgSwj1vVybx2HYfpMZclIidWOlw4jzC/oZBP4OdBlt3Ypbd4apf7R349Cq8uho1jPlFaLWe+Vmc82iWsg+oXBcjOsUmeUc3znhZuorSmVA2T/FjPdsfKN3W4LdH2OpiAIBpw/MJmaj00Bs/3WM2Sxpvy0Qxg/R1OwTzz9MFIs8/1XGnHhFFGtx1MsUxLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=WyMRCVpz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::646; helo=mail-pl1-x646.google.com; envelope-from=3esg-agykdosfrnawptbbtyr.pbzyvahkccp-qriyvfgf.bmynof.bet@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=WyMRCVpz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::646; helo=mail-pl1-x646.google.com; envelope-from=3esg-agykdosfrnawptbbtyr.pbzyvahkccp-qriyvfgf.bmynof.bet@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x646.google.com (mail-pl1-x646.google.com [IPv6:2607:f8b0:4864:20::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwjyY4yZnz30DY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 06:22:45 +1000 (AEST)
Received: by mail-pl1-x646.google.com with SMTP id d9443c01a7336-2df375fb9b2so71287725ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 13:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790886163; x=1791490963; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=r48n+JYZ8dbjdJkdgBh0OvhmILEEnWUiGdrrAjEBorc=;
        b=WyMRCVpzDKydmcdYX4ktBI2EFQ6o7EbUf560msb+GKOUC2pN6M6bNMwpH+VNkvFpdY
         idmnOcKbZXSjBJowOQI8QLO4gpcaXO0QkrG5VhMG5qEBiZ3zpexob/ra0/FRj4inVOJK
         jUhVbHKsvS2A79xMMAslDktZzIrdpWNQYZ2h+iqXVFX99Hq3j+zN35qNaOt3f5nOIubt
         q6Jr0HyYUvypar2PMI+Yab8ky6oyDlBxJhpr21/SS57Q1ERqfGK8jkgIsdEEJz3tTU1v
         kRdgOcpOnGOkXGfqalRNRipd/8VeME9UOrOUH/UDzQ8W+Gz3khDHx12N826/WfIZpZIW
         c87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790886163; x=1791490963;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r48n+JYZ8dbjdJkdgBh0OvhmILEEnWUiGdrrAjEBorc=;
        b=EC0NJsJdZonFqX7bdeEdjaL52v2p/xWWQYwA7EfRijH4or9JKiWSySqeewd1djZhNI
         prqkiMRb4AQ4TaK/BLwETS9tZAba7Kg7NvauRD48fLkJjyELyGqaru7riDpl+MU4uYaI
         J+vV3DKeSvtcScgzx+ycYlox68HTReu2M+fGNr6Vueuo+VABBJiRAMbGuvTu/kb8gX3F
         LQ4KSSpYypC63276aRK+LiJ3vC8ABrj8n9iftAfEcERXEP1Sn72yjRho2vPiI/lpZoPn
         hpHQv/CLsLtwkkBM9CZW/C4s4j8nmJBCJiRU3426bor58JkLpTCayXPxPGWQUx89oOhF
         gAuw==
X-Forwarded-Encrypted: i=1; AKwUvBxDxTcqPKXYFHVXxDtWb/6zQ8DGhpsY8moZWsVVdK4LqLuNQfA7wofi3oIKyjnsRSNU9dhihY/xyRqwVyU=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJo+SeK4/W8U7gBl7WqD/sozJw0Irl8FNpnomRm1/jV5bXaYHzJ
	TWk1CfOWVJhOtAr16WDehr3RzEvIUc77rhsNytYWfE2PwTzVaKCoAngiRFnBPBQRJiK+k5bgo1Y
	bsXVtSQ==
X-Received: from plhc3.prod.google.com ([2002:a17:903:2343:b0:2e4:9be2:d072])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db0e:b0:2e3:1d30:8658
 with SMTP id d9443c01a7336-2e499f0961emr6315885ad.10.1790886162723; Thu, 01
 Oct 2026 13:22:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  1 Oct 2026 13:22:25 -0700
In-Reply-To: <20261001202234.3794060-1-seanjc@google.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0
References: <20261001202234.3794060-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001202234.3794060-2-seanjc@google.com>
Subject: [PATCH v2 01/10] KVM: Reject user accesses to guest memory if
 current->mm != kvm->mm
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Reject user accesses to guest memory, which are supposed to be done only
in the context of KVM_RUN or similar operations, if the current address
space is not the VM's (host userspace) address space.  If KVM writes to
guest memory after the owning host process has exited, or if the VM is
being destroyed in the context of a different process, then writing using
the wrong address space will corrupt a different process' memory.

Reject the access but don't WARN() or KVM_BUG_ON() event though attempting
to access guest memory with a mismatched address space is a blatant KVM
bug, because unfortunately KVM is buggy.  On KVM VMX, when a vCPU is
destroyed while L2 is active, KVM synthesizes a nested VM-Exit to force the
vCPU out of L2 in order to free the nested VMX assets, and a side effect of
a nested VM-Exit is that it flushes the cached shadow VMCS12 back to guest
memory:

  vmx_vcpu_free()
  |-> nested_vmx_free_vcpu()
      |-> vmx_leave_nested()
          |-> nested_vmx_vmexit(vcpu, -1, 0, 0)
              |-> nested_flush_cached_shadow_vmcs12()
                  |-> kvm_write_guest_cached()
                      |-> __copy_to_user(ghc->hva, ...)

Fix the bug broadly even though the "real" bug is that KVM abuses the
nested VM-Exit flow for non-architectural purposes, as there may be other
such violations lurking.  For now, punt on fixing individual bugs and
hardening the common flows, e.g. with WARNs.

Opportunistically provide wrappers in anticipation of adding more checks
and hardening, i.e. growing the logic beyond checking current->mm.

Fixes: 61ada7488ffd ("KVM: nVMX: Cache shadow vmcs12 on VMEntry and flush to memory on VMExit")
Cc: stable@vger.kernel.org
Reported-by: Jim Mattson <jmattson@google.com>
Closes: https://lore.kernel.org/all/20260908132838.2116068-1-jmattson@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/sgx.c   |  2 +-
 arch/x86/kvm/vmx/vmx.c   |  8 ++++----
 include/linux/kvm_host.h | 25 +++++++++++++++++++++++--
 virt/kvm/kvm_main.c      | 24 ++++++++++++------------
 4 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/vmx/sgx.c b/arch/x86/kvm/vmx/sgx.c
index 771c75a58343..52a6d0f8bb9e 100644
--- a/arch/x86/kvm/vmx/sgx.c
+++ b/arch/x86/kvm/vmx/sgx.c
@@ -64,7 +64,7 @@ static void sgx_handle_emulation_failure(struct kvm_vcpu *vcpu, u64 addr,
 static int sgx_read_hva(struct kvm_vcpu *vcpu, unsigned long hva, void *data,
 			unsigned int size)
 {
-	if (__copy_from_user(data, (void __user *)hva, size)) {
+	if (kvm_copy_from_user(vcpu->kvm, data, (void __user *)hva, size)) {
 		sgx_handle_emulation_failure(vcpu, hva, size);
 		return -EFAULT;
 	}
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 612ab07d4100..b2ffa6002944 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4011,16 +4011,16 @@ static int init_rmode_tss(struct kvm *kvm, void __user *ua)
 	int i;
 
 	for (i = 0; i < 3; i++) {
-		if (__copy_to_user(ua + PAGE_SIZE * i, zero_page, PAGE_SIZE))
+		if (kvm_copy_to_user(kvm, ua + PAGE_SIZE * i, zero_page, PAGE_SIZE))
 			return -EFAULT;
 	}
 
 	data = TSS_BASE_SIZE + TSS_REDIRECTION_SIZE;
-	if (__copy_to_user(ua + TSS_IOPB_BASE_OFFSET, &data, sizeof(u16)))
+	if (kvm_copy_to_user(kvm, ua + TSS_IOPB_BASE_OFFSET, &data, sizeof(u16)))
 		return -EFAULT;
 
 	data = ~0;
-	if (__copy_to_user(ua + RMODE_TSS_SIZE - 1, &data, sizeof(u8)))
+	if (kvm_copy_to_user(kvm, ua + RMODE_TSS_SIZE - 1, &data, sizeof(u8)))
 		return -EFAULT;
 
 	return 0;
@@ -4055,7 +4055,7 @@ static int init_rmode_identity_map(struct kvm *kvm)
 	for (i = 0; i < (PAGE_SIZE / sizeof(tmp)); i++) {
 		tmp = (i << 22) + (_PAGE_PRESENT | _PAGE_RW | _PAGE_USER |
 			_PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_PSE);
-		if (__copy_to_user(uaddr + i * sizeof(tmp), &tmp, sizeof(tmp))) {
+		if (kvm_copy_to_user(kvm, uaddr + i * sizeof(tmp), &tmp, sizeof(tmp))) {
 			r = -EFAULT;
 			goto out;
 		}
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3dd04605f2e5..b37cf275ef79 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1350,13 +1350,34 @@ int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 			      gpa_t gpa, unsigned long len);
 
+static __always_inline __must_check bool kvm_can_do_uaccess(struct kvm *kvm)
+{
+	return current->mm == kvm->mm;
+}
+
+#define BUILD_KVM_COPY_USER_WRAPPER(fn, to_user, from_user)				\
+static __always_inline __must_check unsigned long kvm_##fn(struct kvm *kvm,		\
+							   void to_user *to,		\
+							   const void from_user *from,	\
+							   unsigned long n)		\
+{											\
+	if (!kvm_can_do_uaccess(kvm))							\
+		return n;								\
+											\
+	return __##fn(to, from, n);							\
+}
+BUILD_KVM_COPY_USER_WRAPPER(copy_from_user, , __user)
+BUILD_KVM_COPY_USER_WRAPPER(copy_from_user_inatomic, , __user)
+BUILD_KVM_COPY_USER_WRAPPER(copy_to_user, __user, )
+BUILD_KVM_COPY_USER_WRAPPER(copy_to_user_inatomic, __user, )
+
 #define __kvm_get_guest(kvm, gfn, offset, v)				\
 ({									\
 	unsigned long __addr = gfn_to_hva(kvm, gfn);			\
 	typeof(v) __user *__uaddr = (typeof(__uaddr))(__addr + offset);	\
 	int __ret = -EFAULT;						\
 									\
-	if (!kvm_is_error_hva(__addr))					\
+	if (!kvm_is_error_hva(__addr) && kvm_can_do_uaccess(kvm))	\
 		__ret = get_user(v, __uaddr);				\
 	__ret;								\
 })
@@ -1376,7 +1397,7 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	typeof(v) __user *__uaddr = (typeof(__uaddr))(__addr + offset);	\
 	int __ret = -EFAULT;						\
 									\
-	if (!kvm_is_error_hva(__addr))					\
+	if (!kvm_is_error_hva(__addr) && kvm_can_do_uaccess(kvm))	\
 		__ret = put_user(v, __uaddr);				\
 	if (!__ret)							\
 		mark_page_dirty(kvm, gfn);				\
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 108d42c5c1d6..9a24c3064896 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3192,8 +3192,8 @@ static int next_segment(unsigned long len, int offset)
 }
 
 /* Copy @len bytes from guest memory at '(@gfn * PAGE_SIZE) + @offset' to @data */
-static int __kvm_read_guest_page(struct kvm_memory_slot *slot, gfn_t gfn,
-				 void *data, int offset, int len)
+static int __kvm_read_guest_page(struct kvm *kvm, struct kvm_memory_slot *slot,
+				 gfn_t gfn, void *data, int offset, int len)
 {
 	int r;
 	unsigned long addr;
@@ -3204,7 +3204,7 @@ static int __kvm_read_guest_page(struct kvm_memory_slot *slot, gfn_t gfn,
 	addr = gfn_to_hva_memslot_prot(slot, gfn, NULL);
 	if (kvm_is_error_hva(addr))
 		return -EFAULT;
-	r = __copy_from_user(data, (void __user *)addr + offset, len);
+	r = kvm_copy_from_user(kvm, data, (void __user *)addr + offset, len);
 	if (r)
 		return -EFAULT;
 	return 0;
@@ -3215,7 +3215,7 @@ int kvm_read_guest_page(struct kvm *kvm, gfn_t gfn, void *data, int offset,
 {
 	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
 
-	return __kvm_read_guest_page(slot, gfn, data, offset, len);
+	return __kvm_read_guest_page(kvm, slot, gfn, data, offset, len);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_read_guest_page);
 
@@ -3224,7 +3224,7 @@ int kvm_vcpu_read_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *data,
 {
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 
-	return __kvm_read_guest_page(slot, gfn, data, offset, len);
+	return __kvm_read_guest_page(vcpu->kvm, slot, gfn, data, offset, len);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_read_guest_page);
 
@@ -3268,8 +3268,8 @@ int kvm_vcpu_read_guest(struct kvm_vcpu *vcpu, gpa_t gpa, void *data, unsigned l
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_read_guest);
 
-static int __kvm_read_guest_atomic(struct kvm_memory_slot *slot, gfn_t gfn,
-			           void *data, int offset, unsigned long len)
+static int __kvm_read_guest_atomic(struct kvm *kvm, struct kvm_memory_slot *slot,
+				   gfn_t gfn, void *data, int offset, unsigned long len)
 {
 	int r;
 	unsigned long addr;
@@ -3281,7 +3281,7 @@ static int __kvm_read_guest_atomic(struct kvm_memory_slot *slot, gfn_t gfn,
 	if (kvm_is_error_hva(addr))
 		return -EFAULT;
 	pagefault_disable();
-	r = __copy_from_user_inatomic(data, (void __user *)addr + offset, len);
+	r = kvm_copy_from_user_inatomic(kvm, data, (void __user *)addr + offset, len);
 	pagefault_enable();
 	if (r)
 		return -EFAULT;
@@ -3295,7 +3295,7 @@ int kvm_vcpu_read_guest_atomic(struct kvm_vcpu *vcpu, gpa_t gpa,
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 	int offset = offset_in_page(gpa);
 
-	return __kvm_read_guest_atomic(slot, gfn, data, offset, len);
+	return __kvm_read_guest_atomic(vcpu->kvm, slot, gfn, data, offset, len);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_read_guest_atomic);
 
@@ -3313,7 +3313,7 @@ static int __kvm_write_guest_page(struct kvm *kvm,
 	addr = gfn_to_hva_memslot(memslot, gfn);
 	if (kvm_is_error_hva(addr))
 		return -EFAULT;
-	r = __copy_to_user((void __user *)addr + offset, data, len);
+	r = kvm_copy_to_user(kvm, (void __user *)addr + offset, data, len);
 	if (r)
 		return -EFAULT;
 	mark_page_dirty_in_slot(kvm, memslot, gfn);
@@ -3451,7 +3451,7 @@ int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	if (unlikely(!ghc->memslot))
 		return kvm_write_guest(kvm, gpa, data, len);
 
-	r = __copy_to_user((void __user *)ghc->hva + offset, data, len);
+	r = kvm_copy_to_user(kvm, (void __user *)ghc->hva + offset, data, len);
 	if (r)
 		return -EFAULT;
 	mark_page_dirty_in_slot(kvm, ghc->memslot, gpa >> PAGE_SHIFT);
@@ -3489,7 +3489,7 @@ int kvm_read_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	if (unlikely(!ghc->memslot))
 		return kvm_read_guest(kvm, gpa, data, len);
 
-	r = __copy_from_user(data, (void __user *)ghc->hva + offset, len);
+	r = kvm_copy_from_user(kvm, data, (void __user *)ghc->hva + offset, len);
 	if (r)
 		return -EFAULT;
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


