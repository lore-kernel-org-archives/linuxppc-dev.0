Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC8AC10F00
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 21:06:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C92B2084B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 21:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1Db4i7+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C92B2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YhbK4J6FzDqCw
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 08:06:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=141.146.126.78; helo=aserp2120.oracle.com;
 envelope-from=daniel.m.jordan@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="1Db4i7+5"; 
 dkim-atps=neutral
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YhYS3gnnzDqGl
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 08:04:59 +1100 (AEDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x32Kd3or163977;
 Tue, 2 Apr 2019 20:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=fAYAxmDQUAFF/V4uXClSMnViHRm6i0GISHNgrEn8/T0=;
 b=1Db4i7+5QTdvuvzmOABCOx/rKduKmOFCPGRVprrFpS4dMFTzLojfS7ykp8TBYOzgp6zY
 8P35z5ZLaWeBPaHuenEidBxoo2DL5tmyrNWrdyFhv4XeDZAq5KtPCKKdaA2NY1HjuW0b
 UuvnV3+uYld/y+6agytQUQm2fU3HwT7sOULBUeaR5XyYYSJrmn85pitVdxeCDkBtHkan
 Eejglhyb4LcN/RILi+Mo3LVfwShqb//q1rCvklXxwVJuxd0TCmDsWlN0sCjdC000J1cN
 BT8XsWnEWY+bD0/jjXtxx7WlF8eSrJlpiSlwZhHMb1njCz6VzdqdcpH6zqpx3ASn5w7L 6w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2rj0dnm0cb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 02 Apr 2019 20:44:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x32KfgSY004926;
 Tue, 2 Apr 2019 20:42:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2rm8f4qkf5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 02 Apr 2019 20:42:30 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x32KgN95019599;
 Tue, 2 Apr 2019 20:42:28 GMT
Received: from localhost.localdomain (/73.60.114.248)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 02 Apr 2019 13:42:23 -0700
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: akpm@linux-foundation.org
Subject: [PATCH 5/6] powerpc/mmu: drop mmap_sem now that locked_vm is atomic
Date: Tue,  2 Apr 2019 16:41:57 -0400
Message-Id: <20190402204158.27582-6-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=29
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904020138
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=29
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904020138
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
Cc: Davidlohr Bueso <dave@stgolabs.net>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, daniel.m.jordan@oracle.com, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, Christoph Lameter <cl@linux.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

With locked_vm now an atomic, there is no need to take mmap_sem as
writer.  Delete and refactor accordingly.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: <linux-mm@kvack.org>
Cc: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>
---
 arch/powerpc/mm/mmu_context_iommu.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index 8038ac24a312..a4ef22b67c07 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -54,34 +54,29 @@ struct mm_iommu_table_group_mem_t {
 static long mm_iommu_adjust_locked_vm(struct mm_struct *mm,
 		unsigned long npages, bool incr)
 {
-	long ret = 0, locked, lock_limit;
+	long ret = 0;
+	unsigned long lock_limit;
 	s64 locked_vm;
 
 	if (!npages)
 		return 0;
 
-	down_write(&mm->mmap_sem);
-	locked_vm = atomic64_read(&mm->locked_vm);
 	if (incr) {
-		locked = locked_vm + npages;
 		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
+		locked_vm = atomic64_add_return(npages, &mm->locked_vm);
+		if (locked_vm > lock_limit && !capable(CAP_IPC_LOCK)) {
 			ret = -ENOMEM;
-		else
-			atomic64_add(npages, &mm->locked_vm);
+			atomic64_sub(npages, &mm->locked_vm);
+		}
 	} else {
-		if (WARN_ON_ONCE(npages > locked_vm))
-			npages = locked_vm;
-		atomic64_sub(npages, &mm->locked_vm);
+		locked_vm = atomic64_sub_return(npages, &mm->locked_vm);
+		WARN_ON_ONCE(locked_vm < 0);
 	}
 
-	pr_debug("[%d] RLIMIT_MEMLOCK HASH64 %c%ld %ld/%ld\n",
-			current ? current->pid : 0,
-			incr ? '+' : '-',
-			npages << PAGE_SHIFT,
-			atomic64_read(&mm->locked_vm) << PAGE_SHIFT,
+	pr_debug("[%d] RLIMIT_MEMLOCK HASH64 %c%lu %lld/%lu\n",
+			current ? current->pid : 0, incr ? '+' : '-',
+			npages << PAGE_SHIFT, locked_vm << PAGE_SHIFT,
 			rlimit(RLIMIT_MEMLOCK));
-	up_write(&mm->mmap_sem);
 
 	return ret;
 }
-- 
2.21.0

