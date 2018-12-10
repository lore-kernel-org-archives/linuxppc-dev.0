Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B59FC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 04:08:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 413EA20821
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 04:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQrNQxe1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413EA20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43CqMC6D4lzDqfd
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 15:08:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NQrNQxe1";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="NQrNQxe1"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Cq7j30nfzDqgq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 14:58:57 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id y1so4576310plp.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Dec 2018 19:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8HeWXUBwSnhJhwa0lSBGy+RixzwB2qy89KlhIMg333A=;
 b=NQrNQxe1tlPruobHmcobsI6UlFlzM/vW9I0cmx0LSUv8LxBbjrYLJ71Q8aJdEIf8Wc
 L30IQ7Nm79gPaGD8xM7LXvoVHBsy6p6D6qrmr//z7KdKyx4y6jc7Tq0Jw1o3mnATmLh1
 wC+3lbsnBOXYY/ITO8WD7nsSznosgJVJ1uZ79w4ExhTy/m8asJ3TEThMoZTlqq0XHucJ
 aDa+tqvQ2vRDW4Wv2Sr4RpmZZAmHvi7T7g5QaZs8cQqaXTfXgMyAKL5gwI9KLGKPU+us
 9rWzUqd11ZMwjSG/m/sK4JPDZicxBp2v/CsgYSx95gTwBng009BsT9TjYJ8ONZd6c82B
 pSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8HeWXUBwSnhJhwa0lSBGy+RixzwB2qy89KlhIMg333A=;
 b=d3jg9OZzA5gJ+M5kQS3qsXnV8DXD+DxLnLsV2HMQog1lWNGLjWfeVFyO+rqWRUMnTN
 B0UDFdHYzpNDS/AuvhaHoKfNoNSBXOdDh7pykxvHczjWmrHJHTBLiWmh6ylYZb8sr5TH
 3Lia8A9a7guwKLxQBTLC+i2hxFK5odYnn9FkVJI+MYo199gUeb2KzU9wuA1VRjfw4hOZ
 th9e0awbSMJBWM4h1YVNNvPhRdfyWg5f5Uv1ndWM7bEhvSNCpwlpJYRqQimtLPjxsHFq
 3lNkDu/XVUt3xpf7ty0xtxcfeMAA03BqRbldq9UWum+FXts9l56LilieEMsXzox7NKyO
 GZyA==
X-Gm-Message-State: AA+aEWYb77WKkAgelVxJxbPuzEGrCe3WjJbmWJiOTGGnjNIMFsgPzwUZ
 ZawiGGl0cnQIOYH/SKQu4/s=
X-Google-Smtp-Source: AFSGD/WOvGhPKnJOQa2fx//Kn0it2uabQHZF4aznDImtAec006Gq5qUdCnrPwY6CbfYuPsuDKfqpqg==
X-Received: by 2002:a17:902:59d6:: with SMTP id
 d22mr10945061plj.10.1544414335632; 
 Sun, 09 Dec 2018 19:58:55 -0800 (PST)
Received: from surajjs2.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id f6sm14291899pfg.188.2018.12.09.19.58.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 09 Dec 2018 19:58:55 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH V2 3/8] KVM: PPC: Book3S HV: Implement functions to access
 quadrants 1 & 2
Date: Mon, 10 Dec 2018 14:58:20 +1100
Message-Id: <20181210035825.29404-4-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181210035825.29404-1-sjitindarsingh@gmail.com>
References: <20181210035825.29404-1-sjitindarsingh@gmail.com>
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
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 sjitindarsingh@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The POWER9 radix mmu has the concept of quadrants. The quadrant number
is the two high bits of the effective address and determines the fully
qualified address to be used for the translation. The fully qualified
address consists of the effective lpid, the effective pid and the
effective address. This gives then 4 possible quadrants 0, 1, 2, and 3.

When accessing these quadrants the fully qualified address is obtained
as follows:

Quadrant		| Hypervisor		| Guest
--------------------------------------------------------------------------
			| EA[0:1] = 0b00	| EA[0:1] = 0b00
0			| effLPID = 0		| effLPID = LPIDR
			| effPID  = PIDR	| effPID  = PIDR
--------------------------------------------------------------------------
			| EA[0:1] = 0b01	|
1			| effLPID = LPIDR	| Invalid Access
			| effPID  = PIDR	|
--------------------------------------------------------------------------
			| EA[0:1] = 0b10	|
2			| effLPID = LPIDR	| Invalid Access
			| effPID  = 0		|
--------------------------------------------------------------------------
			| EA[0:1] = 0b11	| EA[0:1] = 0b11
3			| effLPID = 0		| effLPID = LPIDR
			| effPID  = 0		| effPID  = 0
--------------------------------------------------------------------------

In the Guest;
Quadrant 3 is normally used to address the operating system since this
uses effPID=0 and effLPID=LPIDR, meaning the PID register doesn't need to
be switched.
Quadrant 0 is normally used to address user space since the effLPID and
effPID are taken from the corresponding registers.

In the Host;
Quadrant 0 and 3 are used as above, however the effLPID is always 0 to
address the host.

Quadrants 1 and 2 can be used by the host to address guest memory using
a guest effective address. Since the effLPID comes from the LPID register,
the host loads the LPID of the guest it would like to access (and the
PID of the process) and can perform accesses to a guest effective
address.

This means quadrant 1 can be used to address the guest user space and
quadrant 2 can be used to address the guest operating system from the
hypervisor, using a guest effective address.

Access to the quadrants can cause a Hypervisor Data Storage Interrupt
(HDSI) due to being unable to perform partition scoped translation.
Previously this could only be generated from a guest and so the code
path expects us to take the KVM trampoline in the interrupt handler.
This is no longer the case so we modify the handler to call
bad_page_fault() to check if we were expecting this fault so we can
handle it gracefully and just return with an error code. In the hash mmu
case we still raise an unknown exception since quadrants aren't defined
for the hash mmu.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/include/asm/kvm_book3s.h  |  4 ++
 arch/powerpc/kernel/exceptions-64s.S   |  9 ++++
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 97 ++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/fault.c                |  1 +
 4 files changed, 111 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 09f8e9ba69bc..5883fcce7009 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -188,6 +188,10 @@ extern int kvmppc_book3s_hcall_implemented(struct kvm *kvm, unsigned long hc);
 extern int kvmppc_book3s_radix_page_fault(struct kvm_run *run,
 			struct kvm_vcpu *vcpu,
 			unsigned long ea, unsigned long dsisr);
+extern long kvmhv_copy_from_guest_radix(struct kvm_vcpu *vcpu, gva_t eaddr,
+					void *to, unsigned long n);
+extern long kvmhv_copy_to_guest_radix(struct kvm_vcpu *vcpu, gva_t eaddr,
+				      void *from, unsigned long n);
 extern int kvmppc_mmu_walk_radix_tree(struct kvm_vcpu *vcpu, gva_t eaddr,
 				      struct kvmppc_pte *gpte, u64 root,
 				      u64 *pte_ret_p);
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 89d32bb79d5e..db2691ff4c0b 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -995,7 +995,16 @@ EXC_COMMON_BEGIN(h_data_storage_common)
 	bl      save_nvgprs
 	RECONCILE_IRQ_STATE(r10, r11)
 	addi    r3,r1,STACK_FRAME_OVERHEAD
+BEGIN_MMU_FTR_SECTION
+	ld	r4,PACA_EXGEN+EX_DAR(r13)
+	lwz	r5,PACA_EXGEN+EX_DSISR(r13)
+	std	r4,_DAR(r1)
+	std	r5,_DSISR(r1)
+	li	r5,SIGSEGV
+	bl      bad_page_fault
+MMU_FTR_SECTION_ELSE
 	bl      unknown_exception
+ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_TYPE_RADIX)
 	b       ret_from_except
 
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index d68162ee159b..e1e3ef710bd0 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -29,6 +29,103 @@
  */
 static int p9_supported_radix_bits[4] = { 5, 9, 9, 13 };
 
+static unsigned long __kvmhv_copy_tofrom_guest_radix(int lpid, int pid,
+					gva_t eaddr, void *to, void *from,
+					unsigned long n)
+{
+	unsigned long quadrant, ret = n;
+	int old_pid, old_lpid;
+	bool is_load = !!to;
+
+	/* Can't access quadrants 1 or 2 in non-HV mode */
+	if (kvmhv_on_pseries()) {
+		/* TODO h-call */
+		return -EPERM;
+	}
+
+	quadrant = 1;
+	if (!pid)
+		quadrant = 2;
+	if (is_load)
+		from = (void *) (eaddr | (quadrant << 62));
+	else
+		to = (void *) (eaddr | (quadrant << 62));
+
+	preempt_disable();
+
+	/* switch the lpid first to avoid running host with unallocated pid */
+	old_lpid = mfspr(SPRN_LPID);
+	if (old_lpid != lpid)
+		mtspr(SPRN_LPID, lpid);
+	if (quadrant == 1) {
+		old_pid = mfspr(SPRN_PID);
+		if (old_pid != pid)
+			mtspr(SPRN_PID, pid);
+	}
+	isync();
+
+	pagefault_disable();
+	if (is_load)
+		ret = raw_copy_from_user(to, from, n);
+	else
+		ret = raw_copy_to_user(to, from, n);
+	pagefault_enable();
+
+	/* switch the pid first to avoid running host with unallocated pid */
+	if (quadrant == 1 && pid != old_pid)
+		mtspr(SPRN_PID, old_pid);
+	if (lpid != old_lpid)
+		mtspr(SPRN_LPID, old_lpid);
+	isync();
+
+	preempt_enable();
+
+	return ret;
+}
+
+static long kvmhv_copy_tofrom_guest_radix(struct kvm_vcpu *vcpu, gva_t eaddr,
+					  void *to, void *from, unsigned long n)
+{
+	int lpid = vcpu->kvm->arch.lpid;
+	int pid = vcpu->arch.pid;
+
+	/* This would cause a data segment intr so don't allow the access */
+	if (eaddr & (0x3FFUL << 52))
+		return -EINVAL;
+
+	/* Should we be using the nested lpid */
+	if (vcpu->arch.nested)
+		lpid = vcpu->arch.nested->shadow_lpid;
+
+	/* If accessing quadrant 3 then pid is expected to be 0 */
+	if (((eaddr >> 62) & 0x3) == 0x3)
+		pid = 0;
+
+	eaddr &= ~(0xFFFUL << 52);
+
+	return __kvmhv_copy_tofrom_guest_radix(lpid, pid, eaddr, to, from, n);
+}
+
+long kvmhv_copy_from_guest_radix(struct kvm_vcpu *vcpu, gva_t eaddr, void *to,
+				 unsigned long n)
+{
+	long ret;
+
+	ret = kvmhv_copy_tofrom_guest_radix(vcpu, eaddr, to, NULL, n);
+	if (ret > 0)
+		memset(to + (n - ret), 0, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kvmhv_copy_from_guest_radix);
+
+long kvmhv_copy_to_guest_radix(struct kvm_vcpu *vcpu, gva_t eaddr, void *from,
+			       unsigned long n)
+{
+	return kvmhv_copy_tofrom_guest_radix(vcpu, eaddr, NULL, from, n);
+}
+EXPORT_SYMBOL_GPL(kvmhv_copy_to_guest_radix);
+
 int kvmppc_mmu_walk_radix_tree(struct kvm_vcpu *vcpu, gva_t eaddr,
 			       struct kvmppc_pte *gpte, u64 root,
 			       u64 *pte_ret_p)
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 1697e903bbf2..2e6fb1d758c3 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -636,6 +636,7 @@ void bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
 	switch (TRAP(regs)) {
 	case 0x300:
 	case 0x380:
+	case 0xe00:
 		printk(KERN_ALERT "Unable to handle kernel paging request for "
 			"data at address 0x%08lx\n", regs->dar);
 		break;
-- 
2.13.6

