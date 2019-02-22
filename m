Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4A6C10F00
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 17:27:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70CBA2070B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 17:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70CBA2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445dZF3GH5zDqXX
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 04:27:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445dXW2Tx9zDqT6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Feb 2019 04:25:47 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1MHOCHt139255
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 12:25:43 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qtjsahusq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 12:25:43 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 22 Feb 2019 17:25:42 -0000
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
 by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Feb 2019 17:25:39 -0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1MHPcUd27590800
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Feb 2019 17:25:38 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31ACFBE054;
 Fri, 22 Feb 2019 17:25:38 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C6F08BE04F;
 Fri, 22 Feb 2019 17:25:35 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.39.126])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 22 Feb 2019 17:25:35 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Subject: [PATCH v2] powerpc/hugetlb: Don't do runtime allocation of 16G pages
 in LPAR configuration
Date: Fri, 22 Feb 2019 22:55:31 +0530
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022217-0020-0000-0000-00000EBFB319
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010644; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01164822; UDB=6.00608312; IPR=6.00945410; 
 MB=3.00025699; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-22 17:25:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022217-0021-0000-0000-000064E1E39C
Message-Id: <20190222172531.16369-1-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-22_12:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902220122
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

We added runtime allocation of 16G pages in
commit 4ae279c2c96a ("powerpc/mm/hugetlb: Allow runtime allocation of 16G.")
That was done to enable 16G allocation on PowerNV and KVM config. In case of KVM
config, we mostly would have the entire guest RAM backed by 16G hugetlb pages for
this to work. PAPR do support partial backing of guest RAM with hugepages via
ibm,expected#pages node of memory node in the device tree. This means rest of the
guest RAM won't be backed by 16G contiguous pages in the host and hence a hash page
table insertion can fail in such case.

An example error message will look like

hash-mmu: mm: Hashing failure ! EA=0x7efc00000000 access=0x8000000000000006 current=readback
hash-mmu:     trap=0x300 vsid=0x67af789 ssize=1 base psize=14 psize 14 pte=0xc000000400000386
readback[12260]: unhandled signal 7 at 00007efc00000000 nip 00000000100012d0 lr 000000001000127c code 2

This patch address that by preventing runtime allocation of 16G hugepages in
LPAR config. To allocate 16G hugetlb one need to kernel command line
hugepagesz=16G hugepages=<number of 16G pages>

With radix translation mode we don't run into this issue.

This change will prevent runtime allocation of 16G hugetlb pages on kvm with
hash translation mode. However, with the current upstream it was observed that
16G hugetlbfs backed guest doesn't boot at all.

We observe boot failure with the below message.
[131354.647546] KVM: map_vrma at 0 failed, ret=-4

That means this patch is not resulting in an observable regression. Once we fix
the boot issue with 16G hugetlb backed memory, we need to use ibm,expected#pages
memory node attribute to indicate 16G page reservation to the guest. This will
also enable partial backing of guest RAM with 16G pages.

Fixes: 4ae279c2c96a ("powerpc/mm/hugetlb: Allow runtime allocation of 16G.")
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---

Changes from V1:
* update commit message to indicate kvm failure

 arch/powerpc/include/asm/book3s/64/hugetlb.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
index 5b0177733994..cd3f2ae0e1e4 100644
--- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
+++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
@@ -35,6 +35,13 @@ static inline int hstate_get_psize(struct hstate *hstate)
 #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
 static inline bool gigantic_page_supported(void)
 {
+	/*
+	 * We used gigantic page reservation with hypervisor assist in some case.
+	 * We cannot use runtime allocation of gigantic pages in those platforms
+	 * This is hash translation mode LPARs.
+	 */
+	if (firmware_has_feature(FW_FEATURE_LPAR) && !radix_enabled())
+		return false;
 	return true;
 }
 #endif
-- 
2.20.1

