Return-Path: <SRS0=klx1=BW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981E3C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2020 01:22:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 410D720678
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2020 01:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AGgpD52d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410D720678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BRBkb36qvzDqVZ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2020 11:21:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=nathanl@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=AGgpD52d; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BRBhc6STMzDqLF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2020 11:20:16 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07C139LN120571; Tue, 11 Aug 2020 21:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=HaOpnaPMFzUdjc2+lugKxGvdbWOuESQSlXt6iLzS0bc=;
 b=AGgpD52di8/i2IdFKaGJwrhKyYLhV4bEFWe+ZKT68RO1+BzwtmZZTMcNmFAnPfccnTVi
 NAkr0XZCjqUEOImNkhM5UXCzB3YcvrK+sgww74Tjtms5mWcpAa+mQ+zmo2Nm2Df1tcQr
 v+w4W+LIyPkcFbxtiX+hIDuJRsZjtg4wLIKXydXeAonQJ/fkVXPVnSgXlG3m8LzDMsvd
 na5tCxlfSl7goDybNTTi5Q7UHovQBwz3K7LhQnyKVkRY/O2ovfKtNl7UVUmVF/QjcjGh
 N6mf3oHergEsgMFNn3tfXqUFSmFIKsqAgCdL2bVcR/m9uRmn/FIxmqBtV7RaqbwJHGeA vA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32urdp183c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2020 21:20:09 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07C1F9aO009495;
 Wed, 12 Aug 2020 01:20:08 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma03dal.us.ibm.com with ESMTP id 32skp958ps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2020 01:20:08 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07C1K42v20120034
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2020 01:20:04 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D35B16E052;
 Wed, 12 Aug 2020 01:20:06 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 997436E050;
 Wed, 12 Aug 2020 01:20:06 +0000 (GMT)
Received: from localhost (unknown [9.65.223.18])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 12 Aug 2020 01:20:06 +0000 (GMT)
From: Nathan Lynch <nathanl@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/pseries: explicitly reschedule during drmem_lmb
 list traversal
Date: Tue, 11 Aug 2020 20:20:05 -0500
Message-Id: <20200812012005.1919255-1-nathanl@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-11_19:2020-08-11,
 2020-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 adultscore=0 suspectscore=1 bulkscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008120003
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
Cc: tyreld@linux.ibm.com, cheloha@linux.ibm.com, ldufour@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The drmem lmb list can have hundreds of thousands of entries, and
unfortunately lookups take the form of linear searches. As long as
this is the case, traversals have the potential to monopolize the CPU
and provoke lockup reports, workqueue stalls, and the like unless
they explicitly yield.

Rather than placing cond_resched() calls within various
for_each_drmem_lmb() loop blocks in the code, put it in the iteration
expression of the loop macro itself so users can't omit it.

Call cond_resched() on every 20th element. Each iteration of the loop
in DLPAR code paths can involve around ten RTAS calls which can each
take up to 250us, so this ensures the check is performed at worst
every few milliseconds.

Fixes: 6c6ea53725b3 ("powerpc/mm: Separate ibm, dynamic-memory data from DT format")
Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
---
 arch/powerpc/include/asm/drmem.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

Changes since v1:
* Add bounds assertions in drmem_lmb_next().
* Call cond_resched() in the iterator on only every 20th element
  instead of on every iteration, to reduce overhead in tight loops.

diff --git a/arch/powerpc/include/asm/drmem.h b/arch/powerpc/include/asm/drmem.h
index 17ccc6474ab6..583277e30dd2 100644
--- a/arch/powerpc/include/asm/drmem.h
+++ b/arch/powerpc/include/asm/drmem.h
@@ -8,6 +8,9 @@
 #ifndef _ASM_POWERPC_LMB_H
 #define _ASM_POWERPC_LMB_H
 
+#include <linux/bug.h>
+#include <linux/sched.h>
+
 struct drmem_lmb {
 	u64     base_addr;
 	u32     drc_index;
@@ -26,8 +29,21 @@ struct drmem_lmb_info {
 
 extern struct drmem_lmb_info *drmem_info;
 
+static inline struct drmem_lmb *drmem_lmb_next(struct drmem_lmb *lmb)
+{
+	const unsigned int resched_interval = 20;
+
+	BUG_ON(lmb < drmem_info->lmbs);
+	BUG_ON(lmb >= drmem_info->lmbs + drmem_info->n_lmbs);
+
+	if ((lmb - drmem_info->lmbs) % resched_interval == 0)
+		cond_resched();
+
+	return ++lmb;
+}
+
 #define for_each_drmem_lmb_in_range(lmb, start, end)		\
-	for ((lmb) = (start); (lmb) < (end); (lmb)++)
+	for ((lmb) = (start); (lmb) < (end); lmb = drmem_lmb_next(lmb))
 
 #define for_each_drmem_lmb(lmb)					\
 	for_each_drmem_lmb_in_range((lmb),			\
-- 
2.25.4

