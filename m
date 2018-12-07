Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FEBC64EB1
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 04:07:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E21A92064D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 04:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHeaKxjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E21A92064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439zSy30wvzDqrs
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 15:07:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NHeaKxjv";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="NHeaKxjv"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439yy45sfszDrVX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 14:44:12 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id z11so1102737pgu.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 19:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=CezgqalrTOHRTK0fULdeenAeuTLVJUaSiiP6duhLIak=;
 b=NHeaKxjvtBIPKU/xfGrr7mNtGGoQ3Rsc3xEPy1YdQYUxOS/0jdc50Z1x8C54I+Sh7Q
 Cg2PPfrwqW51osLYWoGA/5x/q3uPWNXhG4Vm5pnoXDU+O05mV15gzvolwthHnr0ogmXL
 T9X9rq7H2ThQ5wtfL3DA3FSVTpNIo9WyyY0KGGrHn/4WGSawp234OhQVmtDnaG3oMpLG
 HK7SSIdDEwyISLiDerkZ8S/Ea+Dvt/qgtlIfr16TsODdWck3PP0pNMREcOJ1BJ3E9TF+
 mgV0OuHUbXDKqzn9T3LrwEyq3m7ZLEKrGsVYH27TLb6kbaeU7ANCyT0OMLanc23PIitF
 VR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=CezgqalrTOHRTK0fULdeenAeuTLVJUaSiiP6duhLIak=;
 b=Qcb7nNHW4hbKGyhme0OQVuPsaRlPVTbaTEryej4YlLNCcKkJT8s75bhiVAqrydCCWu
 84r1UHtibVnfEC9oN/PLpW0X6WbbmSPMY/clpFMhhDl4jL3BCIj4cpW3rOShEzL0MHJG
 I+4fMarkmxHcqK6g/K4ykPKWKh1UIYRJeAz771uRpGFHMddmSDxHjtj8k2nsP+xoFd3d
 lz0ZE1pUevNglNt5Uj6mVijotzAHR63RuQsG0IUjZjjkcwDojTZzq3W5FIO/lFMT70E6
 vngYTwPEckMWoeWn/SJOlnp+/B34OMi3u/zD4n8bMlcdt0kffIYvm3jpdx+LyVdw27Mo
 rMrQ==
X-Gm-Message-State: AA+aEWYq9CkVj/VaEn/30oDD8dMptQ40aWW7+qWgDD+ZY7wIIF3skT6M
 QzJ/7CE6YK5tg6ZvglhBVFY=
X-Google-Smtp-Source: AFSGD/W5d78KlJ4mw4nG1Xs/4iVlxaNaGRHqO4XHYqtyc+7Udh/5dVxGkVi6N9ks7hvQaUemodpP2w==
X-Received: by 2002:a63:151f:: with SMTP id v31mr581946pgl.34.1544154251164;
 Thu, 06 Dec 2018 19:44:11 -0800 (PST)
Received: from localhost.localdomain ([1.129.152.198])
 by smtp.gmail.com with ESMTPSA id e23sm2262646pfh.68.2018.12.06.19.44.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 19:44:10 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 7/8] KVM: PPC: Introduce new hcall H_COPY_TOFROM_GUEST to
 access quadrants 1 & 2
Date: Fri,  7 Dec 2018 14:43:25 +1100
Message-Id: <20181207034326.3564-9-sjitindarsingh@gmail.com>
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

A guest cannot access quadrants 1 or 2 as this would result in an
exception. Thus introduce the hcall H_COPY_TOFROM_GUEST to be used by a
guest when it wants to perform an access to quadrants 1 or 2, for
example when it wants to access memory for one of its nested guests.

Also provide an implementation for the kvm-hv module.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/include/asm/hvcall.h      |  1 +
 arch/powerpc/include/asm/kvm_book3s.h  |  4 ++
 arch/powerpc/kvm/book3s_64_mmu_radix.c |  7 ++--
 arch/powerpc/kvm/book3s_hv.c           |  6 ++-
 arch/powerpc/kvm/book3s_hv_nested.c    | 75 ++++++++++++++++++++++++++++++++++
 5 files changed, 89 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 33a4fc891947..463c63a9fcf1 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -335,6 +335,7 @@
 #define H_SET_PARTITION_TABLE	0xF800
 #define H_ENTER_NESTED		0xF804
 #define H_TLB_INVALIDATE	0xF808
+#define H_COPY_TOFROM_GUEST	0xF80C
 
 /* Values for 2nd argument to H_SET_MODE */
 #define H_SET_MODE_RESOURCE_SET_CIABR		1
diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index ea94110bfde4..720483733bb2 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -188,6 +188,9 @@ extern int kvmppc_book3s_hcall_implemented(struct kvm *kvm, unsigned long hc);
 extern int kvmppc_book3s_radix_page_fault(struct kvm_run *run,
 			struct kvm_vcpu *vcpu,
 			unsigned long ea, unsigned long dsisr);
+extern unsigned long __kvmhv_copy_tofrom_guest_radix(int lpid, int pid,
+					gva_t eaddr, void *to, void *from,
+					unsigned long n);
 extern long kvmhv_copy_from_guest_radix(struct kvm_vcpu *vcpu, gva_t eaddr,
 					void *to, unsigned long n);
 extern long kvmhv_copy_to_guest_radix(struct kvm_vcpu *vcpu, gva_t eaddr,
@@ -302,6 +305,7 @@ long kvmhv_nested_init(void);
 void kvmhv_nested_exit(void);
 void kvmhv_vm_nested_init(struct kvm *kvm);
 long kvmhv_set_partition_table(struct kvm_vcpu *vcpu);
+long kvmhv_copy_tofrom_guest_nested(struct kvm_vcpu *vcpu);
 void kvmhv_set_ptbl_entry(unsigned int lpid, u64 dw0, u64 dw1);
 void kvmhv_release_all_nested(struct kvm *kvm);
 long kvmhv_enter_nested_guest(struct kvm_vcpu *vcpu);
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index e1e3ef710bd0..da89d10e5886 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -29,9 +29,9 @@
  */
 static int p9_supported_radix_bits[4] = { 5, 9, 9, 13 };
 
-static unsigned long __kvmhv_copy_tofrom_guest_radix(int lpid, int pid,
-					gva_t eaddr, void *to, void *from,
-					unsigned long n)
+unsigned long __kvmhv_copy_tofrom_guest_radix(int lpid, int pid,
+					      gva_t eaddr, void *to, void *from,
+					      unsigned long n)
 {
 	unsigned long quadrant, ret = n;
 	int old_pid, old_lpid;
@@ -82,6 +82,7 @@ static unsigned long __kvmhv_copy_tofrom_guest_radix(int lpid, int pid,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(__kvmhv_copy_tofrom_guest_radix);
 
 static long kvmhv_copy_tofrom_guest_radix(struct kvm_vcpu *vcpu, gva_t eaddr,
 					  void *to, void *from, unsigned long n)
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index e7233499e063..e2e15722584a 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -995,7 +995,11 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 		if (nesting_enabled(vcpu->kvm))
 			ret = kvmhv_do_nested_tlbie(vcpu);
 		break;
-
+	case H_COPY_TOFROM_GUEST:
+		ret = H_FUNCTION;
+		if (nesting_enabled(vcpu->kvm))
+			ret = kvmhv_copy_tofrom_guest_nested(vcpu);
+		break;
 	default:
 		return RESUME_HOST;
 	}
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index 991f40ce4eea..f54301fcfbe4 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -462,6 +462,81 @@ long kvmhv_set_partition_table(struct kvm_vcpu *vcpu)
 }
 
 /*
+ * Handle the H_COPY_TOFROM_GUEST hcall.
+ * r4 = L1 lpid of nested guest
+ * r5 = pid
+ * r6 = eaddr to access
+ * r7 = to buffer (L1 gpa)
+ * r8 = from buffer (L1 gpa)
+ * r9 = n bytes to copy
+ */
+long kvmhv_copy_tofrom_guest_nested(struct kvm_vcpu *vcpu)
+{
+	struct kvm_nested_guest *gp;
+	int l1_lpid = kvmppc_get_gpr(vcpu, 4);
+	int pid = kvmppc_get_gpr(vcpu, 5);
+	gva_t eaddr = kvmppc_get_gpr(vcpu, 6);
+	void *gp_to = (void *) kvmppc_get_gpr(vcpu, 7);
+	void *gp_from = (void *) kvmppc_get_gpr(vcpu, 8);
+	void *buf;
+	unsigned long n = kvmppc_get_gpr(vcpu, 9);
+	bool is_load = !!gp_to;
+	long rc;
+
+	if (gp_to && gp_from) /* One must be NULL to determine the direction */
+		return H_PARAMETER;
+
+	if (eaddr & (0xFFFUL << 52))
+		return H_PARAMETER;
+
+	buf = kzalloc(n, GFP_KERNEL);
+	if (!buf)
+		return H_NO_MEM;
+
+	gp = kvmhv_get_nested(vcpu->kvm, l1_lpid, false);
+	if (!gp) {
+		rc = H_PARAMETER;
+		goto out_free;
+	}
+
+	mutex_lock(&gp->tlb_lock);
+
+	if (is_load) {
+		/* Load from the nested guest into our buffer */
+		rc = __kvmhv_copy_tofrom_guest_radix(gp->shadow_lpid, pid,
+						     eaddr, buf, NULL, n);
+		if (rc)
+			goto not_found;
+
+		/* Write what was loaded into our buffer back to the L1 guest */
+		rc = kvmppc_st(vcpu, (ulong *) &gp_to, n, buf, true);
+		if (rc)
+			goto not_found;
+	} else {
+		/* Load the data to be stored from the L1 guest into our buf */
+		rc = kvmppc_ld(vcpu, (ulong *) &gp_from, n, buf, true);
+		if (rc)
+			goto not_found;
+
+		/* Store from our buffer into the nested guest */
+		rc = __kvmhv_copy_tofrom_guest_radix(gp->shadow_lpid, pid,
+						     eaddr, NULL, buf, n);
+		if (rc)
+			goto not_found;
+	}
+
+out_unlock:
+	mutex_unlock(&gp->tlb_lock);
+	kvmhv_put_nested(gp);
+out_free:
+	kfree(buf);
+	return rc;
+not_found:
+	rc = H_NOT_FOUND;
+	goto out_unlock;
+}
+
+/*
  * Reload the partition table entry for a guest.
  * Caller must hold gp->tlb_lock.
  */
-- 
2.13.6

