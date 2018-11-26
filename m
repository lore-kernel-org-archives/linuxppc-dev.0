Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7883AC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 14:37:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3C820817
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 14:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3C820817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433TzF5KYTzDqVn
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 01:37:45 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 433TwN5P1czDqTw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 01:35:16 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAQESt1l018275
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 09:35:14 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p0jh58n0k-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 09:35:14 -0500
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 26 Nov 2018 14:35:13 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
 by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 26 Nov 2018 14:35:10 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAQEZAe236962370
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 26 Nov 2018 14:35:10 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D850DAE05F;
 Mon, 26 Nov 2018 14:35:09 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59A1FAE060;
 Mon, 26 Nov 2018 14:35:07 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.72.64])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 26 Nov 2018 14:35:06 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, Michael Neuling <mikey@neuling.org>
Subject: [PATCH] powerpc/mm/hash: Hand user access of kernel address gracefully
Date: Mon, 26 Nov 2018 20:05:04 +0530
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18112614-0060-0000-0000-000002D8E63C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010124; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01123048; UDB=6.00582970; IPR=6.00903177; 
 MB=3.00024337; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-26 14:35:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112614-0061-0000-0000-00004752D0DF
Message-Id: <20181126143504.30996-1-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-26_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=732 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811260131
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

With commit 2865d08dd9ea ("powerpc/mm: Move the DSISR_PROTFAULT sanity check")
we moved the protection fault access check before vma lookup. That means we
hit that WARN_ON when user space access a kernel address.  Before the commit
this was handled by find_vma() not finding vma for the kernel address and
considering that access as bad area access.

Avoid the confusing WARN_ON and convert that to a ratelimited printk.
With the patch we now get

for load:
[  187.700294] a.out[5997]: User access of kernel address (c00000000000dea0) - exploit attempt? (uid: 1000)
[  187.700344] a.out[5997]: segfault (11) at c00000000000dea0 nip 1317c0798 lr 7fff80d6441c code 1 in a.out[1317c0000+10000]
[  187.700429] a.out[5997]: code: 60000000 60420000 3c4c0002 38427790 4bffff20 3c4c0002 38427784 fbe1fff8
[  187.700435] a.out[5997]: code: f821ffc1 7c3f0b78 60000000 e9228030 <89290000> 993f002f 60000000 383f0040

for exec:
[  225.100903] a.out[6067]: User access of kernel address (c00000000000dea0) - exploit attempt? (uid: 1000)
[  225.100938] a.out[6067]: segfault (11) at c00000000000dea0 nip c00000000000dea0 lr 129d507b0 code 1
[  225.100943] a.out[6067]: Bad NIP, not dumping instructions.

Fixes: 2865d08dd9ea ("powerpc/mm: Move the DSISR_PROTFAULT sanity check")
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/mm/fault.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 1697e903bbf2..46f280068c45 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -342,8 +342,21 @@ static inline void cmo_account_page_fault(void) { }
 #endif /* CONFIG_PPC_SMLPAR */
 
 #ifdef CONFIG_PPC_STD_MMU
-static void sanity_check_fault(bool is_write, unsigned long error_code)
+static void sanity_check_fault(bool is_write, bool is_user,
+			       unsigned long error_code, unsigned long address)
 {
+	/*
+	 * userspace trying to access kernel address, we get PROTFAULT for that.
+	 */
+	if (is_user && address >= TASK_SIZE) {
+		printk_ratelimited(KERN_CRIT "%s[%d]: "
+				   "User access of kernel address (%lx) - "
+				   "exploit attempt? (uid: %d)\n",
+				   current->comm, current->pid, address,
+				   from_kuid(&init_user_ns, current_uid()));
+		return;
+	}
+
 	/*
 	 * For hash translation mode, we should never get a
 	 * PROTFAULT. Any update to pte to reduce access will result in us
@@ -373,11 +386,17 @@ static void sanity_check_fault(bool is_write, unsigned long error_code)
 	 * For radix, we can get prot fault for autonuma case, because radix
 	 * page table will have them marked noaccess for user.
 	 */
-	if (!radix_enabled() && !is_write)
-		WARN_ON_ONCE(error_code & DSISR_PROTFAULT);
+	if (radix_enabled() || is_write)
+		return;
+
+	WARN_ON_ONCE(error_code & DSISR_PROTFAULT);
 }
 #else
-static void sanity_check_fault(bool is_write, unsigned long error_code) { }
+static void sanity_check_fault(bool is_write, bool is_user,
+			       unsigned long error_code, unsigned long address)
+{
+
+}
 #endif /* CONFIG_PPC_STD_MMU */
 
 /*
@@ -435,7 +454,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	}
 
 	/* Additional sanity check(s) */
-	sanity_check_fault(is_write, error_code);
+	sanity_check_fault(is_write, is_user, error_code, address);
 
 	/*
 	 * The kernel should never take an execute fault nor should it
-- 
2.19.1

