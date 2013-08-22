Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 739922C00C0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 21:38:20 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 22 Aug 2013 21:31:09 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id AC35E2BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 21:38:11 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7MBc0MQ5374426
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 21:38:00 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7MBcAaK012706
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 21:38:10 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, agraf@suse.de
Subject: [PATCH] powerpc/kvm: Handle the boundary condition correctly
Date: Thu, 22 Aug 2013 17:07:59 +0530
Message-Id: <1377171479-25738-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org
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
