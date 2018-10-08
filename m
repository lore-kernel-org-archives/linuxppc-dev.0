Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DE9C00449
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 06:47:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A4232087C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 06:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="hVGjMfCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4232087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42T9sM300FzF3Bb
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 17:47:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="hVGjMfCM";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42T8BF1fP9zF37f
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 16:32:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="hVGjMfCM"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42T8BD55wBz9sjH; Mon,  8 Oct 2018 16:32:04 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42T8BC6Xr0zB4PV;
 Mon,  8 Oct 2018 16:32:03 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538976724; bh=EPTJ3Adf7sIlGA7pylC0GstGtR39ya+BvGeXF+potR0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hVGjMfCMPI2hu7MvcE0erGeC945BjVYhTmBS5ZdQZkUt4hVVrc/6+wKu0KItvBgoQ
 rV9rJX8M65BkA4+P7kKaI7LLlwIhqCaKFWoCvKDzCkm8lDcJfXTbtEOqbSeCKnl7p8
 VrNSUn8tO4wyLb8wFpzr8F8L+SUm7DJeED5xylSwZcr/XUQ+f0a0YxpKjaKSJEAHxh
 pHUauJ4W6Dk6FLnVawBTjGjdaoHdWitHPEac+yylAqdE+0EKENCUS8VtKRKmWAhe5Y
 v197MF52pMU4Gs24zbs91vX1LBt2xDsI5fylIXqqj0o7e6eTvMmy3nmxyQQDbbYaG6
 BFHibjZd134hg==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v5 31/33] KVM: PPC: Book3S HV: Add nested shadow page tables
 to debugfs
Date: Mon,  8 Oct 2018 16:31:17 +1100
Message-Id: <1538976679-1363-32-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
References: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
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
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This adds a list of valid shadow PTEs for each nested guest to
the 'radix' file for the guest in debugfs.  This can be useful for
debugging.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_book3s_64.h |  1 +
 arch/powerpc/kvm/book3s_64_mmu_radix.c   | 39 +++++++++++++++++++++++++++++---
 arch/powerpc/kvm/book3s_hv_nested.c      | 15 ++++++++++++
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 83d4def..6d29814 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -120,6 +120,7 @@ struct rmap_nested {
 struct kvm_nested_guest *kvmhv_get_nested(struct kvm *kvm, int l1_lpid,
 					  bool create);
 void kvmhv_put_nested(struct kvm_nested_guest *gp);
+int kvmhv_nested_next_lpid(struct kvm *kvm, int lpid);
 
 /* Encoding of first parameter for H_TLB_INVALIDATE */
 #define H_TLBIE_P1_ENC(ric, prs, r)	(___PPC_RIC(ric) | ___PPC_PRS(prs) | \
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index ae0e3ed..43b21e8 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -1002,6 +1002,7 @@ struct debugfs_radix_state {
 	struct kvm	*kvm;
 	struct mutex	mutex;
 	unsigned long	gpa;
+	int		lpid;
 	int		chars_left;
 	int		buf_index;
 	char		buf[128];
@@ -1043,6 +1044,7 @@ static ssize_t debugfs_radix_read(struct file *file, char __user *buf,
 	struct kvm *kvm;
 	unsigned long gpa;
 	pgd_t *pgt;
+	struct kvm_nested_guest *nested;
 	pgd_t pgd, *pgdp;
 	pud_t pud, *pudp;
 	pmd_t pmd, *pmdp;
@@ -1077,10 +1079,39 @@ static ssize_t debugfs_radix_read(struct file *file, char __user *buf,
 	}
 
 	gpa = p->gpa;
-	pgt = kvm->arch.pgtable;
-	while (len != 0 && gpa < RADIX_PGTABLE_RANGE) {
+	nested = NULL;
+	pgt = NULL;
+	while (len != 0 && p->lpid >= 0) {
+		if (gpa >= RADIX_PGTABLE_RANGE) {
+			gpa = 0;
+			pgt = NULL;
+			if (nested) {
+				kvmhv_put_nested(nested);
+				nested = NULL;
+			}
+			p->lpid = kvmhv_nested_next_lpid(kvm, p->lpid);
+			p->hdr = 0;
+			if (p->lpid < 0)
+				break;
+		}
+		if (!pgt) {
+			if (p->lpid == 0) {
+				pgt = kvm->arch.pgtable;
+			} else {
+				nested = kvmhv_get_nested(kvm, p->lpid, false);
+				if (!nested) {
+					gpa = RADIX_PGTABLE_RANGE;
+					continue;
+				}
+				pgt = nested->shadow_pgtable;
+			}
+		}
+		n = 0;
 		if (!p->hdr) {
-			n = scnprintf(p->buf, sizeof(p->buf),
+			if (p->lpid > 0)
+				n = scnprintf(p->buf, sizeof(p->buf),
+					      "\nNested LPID %d: ", p->lpid);
+			n += scnprintf(p->buf + n, sizeof(p->buf) - n,
 				      "pgdir: %lx\n", (unsigned long)pgt);
 			p->hdr = 1;
 			goto copy;
@@ -1146,6 +1177,8 @@ static ssize_t debugfs_radix_read(struct file *file, char __user *buf,
 		}
 	}
 	p->gpa = gpa;
+	if (nested)
+		kvmhv_put_nested(nested);
 
  out:
 	mutex_unlock(&p->mutex);
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index 3f21f78..401d2ec 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -1274,3 +1274,18 @@ long int kvmhv_nested_page_fault(struct kvm_vcpu *vcpu)
 	mutex_unlock(&gp->tlb_lock);
 	return ret;
 }
+
+int kvmhv_nested_next_lpid(struct kvm *kvm, int lpid)
+{
+	int ret = -1;
+
+	spin_lock(&kvm->mmu_lock);
+	while (++lpid <= kvm->arch.max_nested_lpid) {
+		if (kvm->arch.nested_guests[lpid]) {
+			ret = lpid;
+			break;
+		}
+	}
+	spin_unlock(&kvm->mmu_lock);
+	return ret;
+}
-- 
2.7.4

