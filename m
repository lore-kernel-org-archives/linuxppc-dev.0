Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECED9C07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 03:57:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F8EE20882
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 03:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UorqyOlE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8EE20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439zF258rHzDqx6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 14:57:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UorqyOlE";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="UorqyOlE"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439yxk6YGDzDrX4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 14:43:54 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id z9so1243193pfi.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 19:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lvCcoPOd8DazLOFW7nsEvC0lj+VGZvm7QMOO0bwC9ZE=;
 b=UorqyOlElL7zeSB0JP4xeklSovynxDiTFqwEWqE9QYp50DdL/EojbeHch59PtaTzIU
 GQFrEpuE1oPK9PnbhvdaSqyCp9X/4LD4C97Ccba4NmVEKiKZmpOqxucKwDzv9ZS2RbHr
 QPAF4iBIEoRv7MhC9l42SJwpJLjpuTQq2cHtNxzmvzyXEQPVSpMsmU1jNN9mA83Hq/rH
 Uzyz8GmFcq5DQ1LZVCSk4G/kRBF3PkA3/efkK0PecyCQC1pvSg8UtzuVaS5Wn5WTh7Hj
 f/xDGP6NHDJ5+GXJI4CAHVxu+hJ+5Z5VCwudinWXrrlBLiw03PRE/hoc05VjS7W51pOR
 zrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=lvCcoPOd8DazLOFW7nsEvC0lj+VGZvm7QMOO0bwC9ZE=;
 b=tykDjgdPE3i4kLb2esGBsZ9xKu08DkNdztnPfRM2Uh3gneqOD5r8MEvMvFf3sHVNAP
 N9oGabJA8+rc4vFSwLv21eo0eczSogQQkkHjRYSil4ZQuIKXCJF2dNRgQK+WFCqODbhT
 VZakZqjWQLGNYh9mrbWuC3D8Xey5kEaRAW3aUg98J2QXs3wuf3+eMfqB5QyBl5F+ChTv
 5oYZgUYC0GI05BhnvAzdoWfehpTAqnHNBTme6KVXCFUTJXJ5Hi3Dn6T/OjJOxiiugwjs
 ba+E/6o1RiuAIMe0yyPxNNuAMj5akPnbO4rip9F6E/ROqY6C6T9jMuqRczfckfXayAby
 oTxw==
X-Gm-Message-State: AA+aEWY47IMuRZcvyEfLRpDhvuG8MO3/l4AmjvE7iNSkcMs5el1sXymt
 ci0atM65F5s0jA8Oo1PJTDM=
X-Google-Smtp-Source: AFSGD/XDCxJHU39458rWJxDx2GIhXfnLTYvt5kGEKkD26NIJF6DxZXzWNZ5VOqZ0Y/+hvdL3Lcyuyg==
X-Received: by 2002:a63:2315:: with SMTP id j21mr558492pgj.297.1544154233000; 
 Thu, 06 Dec 2018 19:43:53 -0800 (PST)
Received: from localhost.localdomain ([1.129.152.198])
 by smtp.gmail.com with ESMTPSA id e23sm2262646pfh.68.2018.12.06.19.43.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 19:43:52 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 3/8] KVM: PPC: Book3S HV: Implement functions to access
 quadrants 1 & 2
Date: Fri,  7 Dec 2018 14:43:21 +1100
Message-Id: <20181207034326.3564-5-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181207034326.3564-1-sjitindarsingh@gmail.com>
References: <20181207034326.3564-1-sjitindarsingh@gmail.com>
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
			| EA[0:1] = 0xb00	| EA[0:1] = 0xb00
0			| effLPID = 0		| effLPID = LPIDR
			| effPID  = PIDR	| effPID  = PIDR
--------------------------------------------------------------------------
			| EA[0:1] = 0xb01	|
1			| effLPID = LPIDR	| Invalid Access
			| effPID  = PIDR	|
--------------------------------------------------------------------------
			| EA[0:1] = 0xb10	|
2			| effLPID = LPIDR	| Invalid Access
			| effPID  = 0		|
--------------------------------------------------------------------------
			| EA[0:1] = 0xb11	| EA[0:1] = 0xb11
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

