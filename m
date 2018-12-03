Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ACFC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 20:45:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0146F20850
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 20:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0146F20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437xpR2SbdzDqXX
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 07:45:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=us.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=us.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=linuxram@us.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=us.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437xmB4XdFzDqWr
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 07:43:38 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB3Kc56T118028
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Dec 2018 15:43:36 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p5b0asvp0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 15:43:35 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Mon, 3 Dec 2018 20:43:35 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 3 Dec 2018 20:43:30 -0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB3KhSA822216724
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 3 Dec 2018 20:43:28 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3342C7805F;
 Mon,  3 Dec 2018 20:43:28 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B7BF78063;
 Mon,  3 Dec 2018 20:43:26 +0000 (GMT)
Received: from ram.oc3035372033.ibm.com.com (unknown [9.85.171.204])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon,  3 Dec 2018 20:43:25 +0000 (GMT)
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH] powerpc/pkeys: copy pkey-tracking-information at fork()
Date: Mon,  3 Dec 2018 12:43:22 -0800
X-Mailer: git-send-email 1.7.1
X-TM-AS-GCONF: 00
x-cbid: 18120320-0004-0000-0000-000014BC9727
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010165; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01126524; UDB=6.00585060; IPR=6.00906658; 
 MB=3.00024430; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-03 20:43:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120320-0005-0000-0000-000089BA55D2
Message-Id: <1543869802-15372-1-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-03_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=865 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812030188
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
Cc: fweimer@redhat.com, Ulrich.Weigand@de.ibm.com, dave.hansen@linux.intel.com,
 linuxram@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

At fork(), the pkey tracking information is not copied over
to the mm_struct of the child. This can cause the child to erroneously
allocate keys that were already allocated. Any allocated execute-only
key is lost aswell.

Add code; called by dup_mmap(), to copy the pkey state from
parent to child explicitly.

This problem was originally found by Dave Hansen on x86, which turns
out to be a problem on powerpc aswell.

Testing:
	Passes the new selftest added by Dave Hansen. I have temporarily
	captured that selftest at
	https://github.com/rampai/memorykeys/ -b memkey.v15-rc6

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/mmu_context.h |   15 +++++++++------
 arch/powerpc/mm/pkeys.c                |    7 +++++++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/=
asm/mmu_context.h
index 0381394..cb16146 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -217,12 +217,6 @@ static inline void enter_lazy_tlb(struct mm_struct *mm,
 #endif
 }
=20
-static inline int arch_dup_mmap(struct mm_struct *oldmm,
-				struct mm_struct *mm)
-{
-	return 0;
-}
-
 #ifndef CONFIG_PPC_BOOK3S_64
 static inline void arch_exit_mmap(struct mm_struct *mm)
 {
@@ -247,6 +241,7 @@ static inline void arch_bprm_mm_init(struct mm_struct *=
mm,
 #ifdef CONFIG_PPC_MEM_KEYS
 bool arch_vma_access_permitted(struct vm_area_struct *vma, bool write,
 			       bool execute, bool foreign);
+void arch_dup_pkeys(struct mm_struct *oldmm, struct mm_struct *mm);
 #else /* CONFIG_PPC_MEM_KEYS */
 static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
 		bool write, bool execute, bool foreign)
@@ -259,6 +254,7 @@ static inline bool arch_vma_access_permitted(struct vm_=
area_struct *vma,
 #define thread_pkey_regs_save(thread)
 #define thread_pkey_regs_restore(new_thread, old_thread)
 #define thread_pkey_regs_init(thread)
+#define arch_dup_pkeys(oldmm, mm)
=20
 static inline u64 pte_to_hpte_pkey_bits(u64 pteflags)
 {
@@ -267,5 +263,12 @@ static inline u64 pte_to_hpte_pkey_bits(u64 pteflags)
=20
 #endif /* CONFIG_PPC_MEM_KEYS */
=20
+static inline int arch_dup_mmap(struct mm_struct *oldmm,
+				struct mm_struct *mm)
+{
+	arch_dup_pkeys(oldmm, mm);
+	return 0;
+}
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_POWERPC_MMU_CONTEXT_H */
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index b271b28..5d65c47 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -414,3 +414,10 @@ bool arch_vma_access_permitted(struct vm_area_struct *=
vma, bool write,
=20
 	return pkey_access_permitted(vma_pkey(vma), write, execute);
 }
+
+void arch_dup_pkeys(struct mm_struct *oldmm, struct mm_struct *mm)
+{
+	/* Duplicate the oldmm pkey state in mm: */
+	mm_pkey_allocation_map(mm) =3D mm_pkey_allocation_map(oldmm);
+	mm->context.execute_only_pkey =3D oldmm->context.execute_only_pkey;
+}
--=20
1.7.1

