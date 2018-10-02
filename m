Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9880C004D2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 12:58:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28CBA20684
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 12:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="qwex6hE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28CBA20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PfNJ06HNzF3HK
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 22:58:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="qwex6hE+";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PcSd2KpxzF39y
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 21:32:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="qwex6hE+"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42PcSc6MtFz9t0G; Tue,  2 Oct 2018 21:32:16 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42PcSc3ZCYz9t54;
 Tue,  2 Oct 2018 21:32:16 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538479936; bh=lF1Jz9p1mmhFkVXQhbCMuxrZvxtOILC7JIDT+rgchdI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qwex6hE+rAHznSLhypTKXTBOGo6BY2Hv1eB94XZujYjrRN2M4vLcrMmgdBTk5C6PK
 vA6UOiO7wA5r1UqlnvtUbm0pZMSlkwcscEWtXNPIM3WUjqPjwqbNHhT9IIwoJezcR4
 gAyRcgoLj/sUOSyuT894kaFk77RUUiL7bXTXOKKDe/xez3NhnXg+AUaQweN/2IjD4K
 noOo74tbGbJmntXzdFC9QCqnGE89XHWIsvQOYoFogtmsNQZSj9R+eYJgcI3obCBq2w
 QI52RwI10KZ2/bPKIBMc50nF5Sx8mxbgqZ5dVYZ5rqqplQHjjvj7KYx59QsJ0LsTcl
 BVWvvM9zb9ZYQ==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v3 31/33] KVM: PPC: Book3S HV: Add nested shadow page tables
 to debugfs
Date: Tue,  2 Oct 2018 21:31:30 +1000
Message-Id: <1538479892-14835-32-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
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
index 399ccbc..f0fa14c 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -119,6 +119,7 @@ struct rmap_nested {
 struct kvm_nested_guest *kvmhv_get_nested(struct kvm *kvm, int l1_lpid,
 					  bool create);
 void kvmhv_put_nested(struct kvm_nested_guest *gp);
+int kvmhv_nested_next_lpid(struct kvm *kvm, int lpid);
 
 /* Power architecture requires HPT is at least 256kiB, at most 64TiB */
 #define PPC_MIN_HPT_ORDER	18
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 4f0fae2..b74abdd 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -978,6 +978,7 @@ struct debugfs_radix_state {
 	struct kvm	*kvm;
 	struct mutex	mutex;
 	unsigned long	gpa;
+	int		lpid;
 	int		chars_left;
 	int		buf_index;
 	char		buf[128];
@@ -1019,6 +1020,7 @@ static ssize_t debugfs_radix_read(struct file *file, char __user *buf,
 	struct kvm *kvm;
 	unsigned long gpa;
 	pgd_t *pgt;
+	struct kvm_nested_guest *nested;
 	pgd_t pgd, *pgdp;
 	pud_t pud, *pudp;
 	pmd_t pmd, *pmdp;
@@ -1053,10 +1055,39 @@ static ssize_t debugfs_radix_read(struct file *file, char __user *buf,
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
@@ -1122,6 +1153,8 @@ static ssize_t debugfs_radix_read(struct file *file, char __user *buf,
 		}
 	}
 	p->gpa = gpa;
+	if (nested)
+		kvmhv_put_nested(nested);
 
  out:
 	mutex_unlock(&p->mutex);
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index 228dc11..914ca78 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -1301,3 +1301,18 @@ long int kvmhv_nested_page_fault(struct kvm_vcpu *vcpu)
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

