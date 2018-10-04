Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DAEC64EBC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 13:34:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36BD620877
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 13:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="USJD8pZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36BD620877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Qv4H1HKjzF3LZ
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 23:34:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="USJD8pZO";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Qrvq74pmzF3Js
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 21:56:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="USJD8pZO"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42Qrvq0yYjz9sj8; Thu,  4 Oct 2018 21:56:39 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42Qrvp2LxNz9s8T;
 Thu,  4 Oct 2018 21:56:38 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538654198; bh=kenggwt4yOBy0HXR45vaxLG7rZ/mUqjRuor2PlF30p0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=USJD8pZOVvlMUISXW2TKYLcpBrBVsINuaD9FTOkDTfb9fpX03kob0ifdauBm2vtNd
 EYGLaMTfqfn6eDjEZmq6CR0TiK11s4C/+I+GRuIMm3RI1n457GNDXTQLsrIg0ipZeM
 V4zTgbTe89h+sdetCZ8x8ArKgcCs9kQeJBhmjmFTAqhV81ygzfRbsa2Li1/UmGWS64
 RS2GQbEl2ZqPiDE7tNLpUdgBRUL6jjn4kD0BMnEC7mxKDi996FPgkro9qwSDJaMFzL
 /Weizb9U0TeLjm3Kf9ZXcH1KI/i4AWlUl6m1SMt54WbtOYSa8GZp2imoHzu4CINZhs
 CURWQjc95ZgvA==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v4 31/32] KVM: PPC: Book3S HV: Add nested shadow page tables
 to debugfs
Date: Thu,  4 Oct 2018 21:56:08 +1000
Message-Id: <1538654169-15602-32-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538654169-15602-1-git-send-email-paulus@ozlabs.org>
References: <1538654169-15602-1-git-send-email-paulus@ozlabs.org>
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
index 1e96027..d11f73c 100644
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
index 8c0da00..75b461d0 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -1263,3 +1263,18 @@ long int kvmhv_nested_page_fault(struct kvm_vcpu *vcpu)
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

