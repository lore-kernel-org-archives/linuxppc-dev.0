Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F40FC282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 17:54:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1641120881
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 17:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1641120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pHLj2PCbzDqPG
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 04:54:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=arbab@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pGs40ZSnzDqMv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 04:31:51 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0SHOLoq074007
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 12:31:49 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qa4pbw52a-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 12:31:48 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.ibm.com>;
 Mon, 28 Jan 2019 17:31:47 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
 by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 28 Jan 2019 17:31:45 -0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0SHViRI23003220
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Jan 2019 17:31:44 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4BEC56E050;
 Mon, 28 Jan 2019 17:31:44 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31E166E04E;
 Mon, 28 Jan 2019 17:31:44 +0000 (GMT)
Received: from arbab-laptop.localdomain (unknown [9.53.179.210])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 28 Jan 2019 17:31:44 +0000 (GMT)
Received: by arbab-laptop.localdomain (Postfix, from userid 152845)
 id 9811E4605FF; Mon, 28 Jan 2019 11:31:42 -0600 (CST)
From: Reza Arbab <arbab@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/mm: Add _PAGE_SAO to _PAGE_CACHE_CTL mask
Date: Mon, 28 Jan 2019 11:31:42 -0600
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19012817-0036-0000-0000-00000A823591
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010494; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01153071; UDB=6.00601127; IPR=6.00933433; 
 MB=3.00025326; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-28 17:31:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012817-0037-0000-0000-00004A838CB7
Message-Id: <1548696702-20686-1-git-send-email-arbab@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-28_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=853 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901280131
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
Cc: Charles Johns <crjohns@us.ibm.com>, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In htab_convert_pte_flags(), _PAGE_CACHE_CTL is used to check for the
_PAGE_SAO flag:

  else if ((pteflags & _PAGE_CACHE_CTL) == _PAGE_SAO)
          rflags |= (HPTE_R_W | HPTE_R_I | HPTE_R_M);

But, it isn't defined to include that flag:

  #define _PAGE_CACHE_CTL (_PAGE_NON_IDEMPOTENT | _PAGE_TOLERANT)

This happens to work, but only because of the flag values:

  #define _PAGE_SAO               0x00010 /* Strong access order */
  #define _PAGE_NON_IDEMPOTENT    0x00020 /* non idempotent memory */
  #define _PAGE_TOLERANT          0x00030 /* tolerant memory, cache inhibited */

To prevent any issues if these particulars ever change, add _PAGE_SAO to
the mask.

Suggested-by: Charles Johns <crjohns@us.ibm.com>
Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 2e6ada2..1d97a28 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -811,7 +811,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 	return hash__set_pte_at(mm, addr, ptep, pte, percpu);
 }
 
-#define _PAGE_CACHE_CTL	(_PAGE_NON_IDEMPOTENT | _PAGE_TOLERANT)
+#define _PAGE_CACHE_CTL	(_PAGE_SAO | _PAGE_NON_IDEMPOTENT | _PAGE_TOLERANT)
 
 #define pgprot_noncached pgprot_noncached
 static inline pgprot_t pgprot_noncached(pgprot_t prot)
-- 
1.8.3.1

