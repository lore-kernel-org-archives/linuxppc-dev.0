Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63524C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 05:09:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D821420700
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 05:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D821420700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YgKJ6MQszDq5Z
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 16:09:08 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Yfwz37C9zDqPM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 15:51:31 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x084mr0A082816
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Jan 2019 23:51:29 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pvhhasknd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Jan 2019 23:51:28 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 8 Jan 2019 04:51:28 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
 by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 8 Jan 2019 04:51:25 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x084pO509175264
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 8 Jan 2019 04:51:24 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29CCFB2068;
 Tue,  8 Jan 2019 04:51:24 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BFC58B2065;
 Tue,  8 Jan 2019 04:51:20 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.75.199])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  8 Jan 2019 04:51:20 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: akpm@linux-foundation.org, Michal Hocko <mhocko@kernel.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Andrea Arcangeli <aarcange@redhat.com>, mpe@ellerman.id.au
Subject: [PATCH V6 1/4] mm/cma: Add PF flag to force non cma alloc
Date: Tue,  8 Jan 2019 10:21:07 +0530
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108045110.28597-1-aneesh.kumar@linux.ibm.com>
References: <20190108045110.28597-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19010804-0040-0000-0000-000004AE3492
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010364; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000273; SDB=6.01143337; UDB=6.00593882; IPR=6.00923595; 
 MB=3.00025025; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-08 04:51:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010804-0041-0000-0000-000008B9376D
Message-Id: <20190108045110.28597-2-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-08_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=951 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901080036
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch add PF_MEMALLOC_NOCMA which make sure any allocation in that context
is marked non movable and hence cannot be satisfied by CMA region.

This is useful with get_user_pages_cma_migrate where we take a page pin by
migrating pages from CMA region. Marking the section PF_MEMALLOC_NOCMA ensures
that we avoid uncessary page migration later.

Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/sched.h    |  1 +
 include/linux/sched/mm.h | 36 ++++++++++++++++++++++++++++--------
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 89541d248893..047c8c469774 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1406,6 +1406,7 @@ extern struct pid *cad_pid;
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
 #define PF_MEMSTALL		0x01000000	/* Stalled due to lack of memory */
+#define PF_MEMALLOC_NOCMA	0x02000000	/* All allocation request will have _GFP_MOVABLE cleared */
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_allowed */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MUTEX_TESTER		0x20000000	/* Thread belongs to the rt mutex tester */
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 3bfa6a0cbba4..b336e7e2ca49 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -148,17 +148,24 @@ static inline bool in_vfork(struct task_struct *tsk)
  * Applies per-task gfp context to the given allocation flags.
  * PF_MEMALLOC_NOIO implies GFP_NOIO
  * PF_MEMALLOC_NOFS implies GFP_NOFS
+ * PF_MEMALLOC_NOCMA implies no allocation from CMA region.
  */
 static inline gfp_t current_gfp_context(gfp_t flags)
 {
-	/*
-	 * NOIO implies both NOIO and NOFS and it is a weaker context
-	 * so always make sure it makes precedence
-	 */
-	if (unlikely(current->flags & PF_MEMALLOC_NOIO))
-		flags &= ~(__GFP_IO | __GFP_FS);
-	else if (unlikely(current->flags & PF_MEMALLOC_NOFS))
-		flags &= ~__GFP_FS;
+	if (unlikely(current->flags &
+		     (PF_MEMALLOC_NOIO | PF_MEMALLOC_NOFS | PF_MEMALLOC_NOCMA))) {
+		/*
+		 * NOIO implies both NOIO and NOFS and it is a weaker context
+		 * so always make sure it makes precedence
+		 */
+		if (current->flags & PF_MEMALLOC_NOIO)
+			flags &= ~(__GFP_IO | __GFP_FS);
+		else if (current->flags & PF_MEMALLOC_NOFS)
+			flags &= ~__GFP_FS;
+
+		if (current->flags & PF_MEMALLOC_NOCMA)
+			flags &= ~__GFP_MOVABLE;
+	}
 	return flags;
 }
 
@@ -248,6 +255,19 @@ static inline void memalloc_noreclaim_restore(unsigned int flags)
 	current->flags = (current->flags & ~PF_MEMALLOC) | flags;
 }
 
+static inline unsigned int memalloc_nocma_save(void)
+{
+	unsigned int flags = current->flags & PF_MEMALLOC_NOCMA;
+
+	current->flags |= PF_MEMALLOC_NOCMA;
+	return flags;
+}
+
+static inline void memalloc_nocma_restore(unsigned int flags)
+{
+	current->flags = (current->flags & ~PF_MEMALLOC_NOCMA) | flags;
+}
+
 #ifdef CONFIG_MEMCG
 /**
  * memalloc_use_memcg - Starts the remote memcg charging scope.
-- 
2.20.1

