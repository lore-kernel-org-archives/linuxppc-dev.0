Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2517C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 16:50:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4302320645
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 16:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4302320645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XW0Z2NSLzF3BV
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 03:50:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XVyW5jm6zF3BZ
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 03:48:35 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9DGibdM084490
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 12:48:33 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n3d7kugvh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 12:48:33 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Sat, 13 Oct 2018 10:48:32 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sat, 13 Oct 2018 10:48:29 -0600
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9DGmSR740960200
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 13 Oct 2018 09:48:28 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AEB73136053;
 Sat, 13 Oct 2018 10:48:28 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C846C13604F;
 Sat, 13 Oct 2018 10:48:25 -0600 (MDT)
Received: from skywalker.ibmuc.com (unknown [9.85.75.68])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Sat, 13 Oct 2018 10:48:25 -0600 (MDT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, Christophe LEROY <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm: Fix WARN_ON with THP NUMA migration
Date: Sat, 13 Oct 2018 22:18:15 +0530
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 18101316-0016-0000-0000-00000941D1DA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009872; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01102137; UDB=6.00570372; IPR=6.00882183; 
 MB=3.00023743; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-13 16:48:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101316-0017-0000-0000-000040B16A2D
Message-Id: <20181013164815.8858-1-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-13_12:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=781 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810130157
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

 WARNING: CPU: 12 PID: 4322 at /arch/powerpc/mm/pgtable-book3s64.c:76 set_pmd_at+0x4c/0x2b0
 Modules linked in:
 CPU: 12 PID: 4322 Comm: qemu-system-ppc Tainted: G        W         4.19.0-rc3-00758-g8f0c636b0542 #36
 NIP:  c0000000000872fc LR: c000000000484eec CTR: 0000000000000000
 REGS: c000003fba876fe0 TRAP: 0700   Tainted: G        W          (4.19.0-rc3-00758-g8f0c636b0542)
 MSR:  900000010282b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR: 24282884  XER: 00000000
 CFAR: c000000000484ee8 IRQMASK: 0
 GPR00: c000000000484eec c000003fba877268 c000000001f0ec00 c000003fbd229f80
 GPR04: 00007c8fe8e00000 c000003f864c5a38 860300853e0000c0 0000000000000080
 GPR08: 0000000080000000 0000000000000001 0401000000000080 0000000000000001
 GPR12: 0000000000002000 c000003fffff5400 c000003fce292000 00007c9024570000
 GPR16: 0000000000000000 0000000000ffffff 0000000000000001 c000000001885950
 GPR20: 0000000000000000 001ffffc0004807c 0000000000000008 c000000001f49d05
 GPR24: 00007c8fe8e00000 c0000000020f2468 ffffffffffffffff c000003fcd33b090
 GPR28: 00007c8fe8e00000 c000003fbd229f80 c000003f864c5a38 860300853e0000c0
 NIP [c0000000000872fc] set_pmd_at+0x4c/0x2b0
 LR [c000000000484eec] do_huge_pmd_numa_page+0xb1c/0xc20
 Call Trace:
 [c000003fba877268] [c00000000045931c] mpol_misplaced+0x1bc/0x230 (unreliable)
 [c000003fba8772c8] [c000000000484eec] do_huge_pmd_numa_page+0xb1c/0xc20
 [c000003fba877398] [c00000000040d344] __handle_mm_fault+0x5e4/0x2300
 [c000003fba8774d8] [c00000000040f400] handle_mm_fault+0x3a0/0x420
 [c000003fba877528] [c0000000003ff6f4] __get_user_pages+0x2e4/0x560
 [c000003fba877628] [c000000000400314] get_user_pages_unlocked+0x104/0x2a0
 [c000003fba8776c8] [c000000000118f44] __gfn_to_pfn_memslot+0x284/0x6a0
 [c000003fba877748] [c0000000001463a0] kvmppc_book3s_radix_page_fault+0x360/0x12d0
 [c000003fba877838] [c000000000142228] kvmppc_book3s_hv_page_fault+0x48/0x1300
 [c000003fba877988] [c00000000013dc08] kvmppc_vcpu_run_hv+0x1808/0x1b50
 [c000003fba877af8] [c000000000126b44] kvmppc_vcpu_run+0x34/0x50
 [c000003fba877b18] [c000000000123268] kvm_arch_vcpu_ioctl_run+0x288/0x2d0
 [c000003fba877b98] [c00000000011253c] kvm_vcpu_ioctl+0x1fc/0x8c0
 [c000003fba877d08] [c0000000004e9b24] do_vfs_ioctl+0xa44/0xae0
 [c000003fba877db8] [c0000000004e9c44] ksys_ioctl+0x84/0xf0
 [c000003fba877e08] [c0000000004e9cd8] sys_ioctl+0x28/0x80

We removed the pte_protnone check earlier with the understanding that we
mark the pte invalid before the set_pte/set_pmd usage. But the huge pmd
autonuma still use the set_pmd_at directly. This is ok because a protnone pte
won't have translation cache in TLB.

Fixes: da7ad366b497 ("powerpc/mm/book3s: Update pmd_present to look at _PAGE_PRESENT bit")
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/mm/pgtable-book3s64.c | 3 ++-
 arch/powerpc/mm/pgtable.c          | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 43e99e1d947b..9f93c9f985c5 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -73,7 +73,8 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 	 * Make sure hardware valid bit is not set. We don't do
 	 * tlb flush for this update.
 	 */
-	WARN_ON(pte_val(pmd_pte(*pmdp)) & _PAGE_PRESENT);
+
+	WARN_ON(pte_hw_valid(pmd_pte(*pmdp)) && !pte_protnone(pmd_pte(*pmdp)));
 	assert_spin_locked(pmd_lockptr(mm, pmdp));
 	WARN_ON(!(pmd_large(pmd) || pmd_devmap(pmd)));
 #endif
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index ca4b1f7ac39d..010e1c616cb2 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -184,7 +184,7 @@ void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 	 * Make sure hardware valid bit is not set. We don't do
 	 * tlb flush for this update.
 	 */
-	VM_WARN_ON(pte_hw_valid(*ptep));
+	VM_WARN_ON(pte_hw_valid(*ptep) && !pte_protnone(*ptep));
 
 	/* Add the pte bit when trying to set a pte */
 	pte = pte_mkpte(pte);
-- 
2.17.1

