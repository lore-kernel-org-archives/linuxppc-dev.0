Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5628DC10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 10:17:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDB6020652
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 10:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB6020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44k1WG5NjyzDqB7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 20:16:58 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44k1Jh6jlCzDqFv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 20:07:48 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3G9ws33104883
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 06:07:46 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rwb3xdqj3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 06:07:46 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 16 Apr 2019 11:07:45 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
 by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 16 Apr 2019 11:07:42 +0100
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3GA7fL818481388
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2019 10:07:41 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A3EF4AC060;
 Tue, 16 Apr 2019 10:07:41 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E3D0AC05B;
 Tue, 16 Apr 2019 10:07:40 +0000 (GMT)
Received: from skywalker.in.ibm.com (unknown [9.124.31.209])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 16 Apr 2019 10:07:39 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH v3 4/8] powerpc/mm: Drop the unnecessary region check
Date: Tue, 16 Apr 2019 15:37:18 +0530
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416100722.10324-1-aneesh.kumar@linux.ibm.com>
References: <20190416100722.10324-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041610-0052-0000-0000-000003ACD624
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010937; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01189843; UDB=6.00623449; IPR=6.00970634; 
 MB=3.00026465; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-16 10:07:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041610-0053-0000-0000-00006084DF7E
Message-Id: <20190416100722.10324-5-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-16_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904160069
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

All the regions are now mapped with top nibble 0xc. Hence the region id
check is not needed for virt_addr_valid()

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/page.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 918228f2205b..748f5db2e2b7 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -132,19 +132,7 @@ static inline bool pfn_valid(unsigned long pfn)
 #define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 
-#ifdef CONFIG_PPC_BOOK3S_64
-/*
- * On hash the vmalloc and other regions alias to the kernel region when passed
- * through __pa(), which virt_to_pfn() uses. That means virt_addr_valid() can
- * return true for some vmalloc addresses, which is incorrect. So explicitly
- * check that the address is in the kernel region.
- */
-/* may be can drop get_region_id */
-#define virt_addr_valid(kaddr) (get_region_id((unsigned long)kaddr) == KERNEL_REGION_ID && \
-				pfn_valid(virt_to_pfn(kaddr)))
-#else
 #define virt_addr_valid(kaddr)	pfn_valid(virt_to_pfn(kaddr))
-#endif
 
 /*
  * On Book-E parts we need __va to parse the device tree and we can't
-- 
2.20.1

