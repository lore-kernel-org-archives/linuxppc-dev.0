Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 17C182C01B2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 04:20:30 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 12 Aug 2013 04:12:14 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 762DC2CE804C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 04:20:25 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7BIKEL32621872
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 04:20:14 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7BIKOUH018575
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 04:20:24 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc/kvm: Handle the boundary condition correctly
Date: Sun, 11 Aug 2013 23:50:20 +0530
Message-Id: <1376245220-20527-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

We should be able to copy upto count bytes

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 710d313..0ae6bb6 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -1362,7 +1362,7 @@ static ssize_t kvm_htab_read(struct file *file, char __user *buf,
 	lbuf = (unsigned long __user *)buf;
 
 	nb = 0;
-	while (nb + sizeof(hdr) + HPTE_SIZE < count) {
+	while (nb + sizeof(hdr) + HPTE_SIZE <= count) {
 		/* Initialize header */
 		hptr = (struct kvm_get_htab_header __user *)buf;
 		hdr.n_valid = 0;
@@ -1385,7 +1385,7 @@ static ssize_t kvm_htab_read(struct file *file, char __user *buf,
 		/* Grab a series of valid entries */
 		while (i < kvm->arch.hpt_npte &&
 		       hdr.n_valid < 0xffff &&
-		       nb + HPTE_SIZE < count &&
+		       nb + HPTE_SIZE <= count &&
 		       record_hpte(flags, hptp, hpte, revp, 1, first_pass)) {
 			/* valid entry, write it out */
 			++hdr.n_valid;
-- 
1.8.1.2
