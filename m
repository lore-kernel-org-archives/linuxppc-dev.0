Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC535C169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 22:57:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D30F2083B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 22:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EG0ZXxRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D30F2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43z1Qm60ghzDqXr
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 09:57:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=156.151.31.85; helo=userp2120.oracle.com;
 envelope-from=daniel.m.jordan@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="EG0ZXxRI"; 
 dkim-atps=neutral
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43z19J2MXFzDqXm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 09:46:11 +1100 (AEDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1BMhV8N079558;
 Mon, 11 Feb 2019 22:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=8MbdNDL3CBMqXq9cKy6Blm5jHVV6AhFQ5tncilAoYP0=;
 b=EG0ZXxRIiRONLX+NDCb7AU32LV8AKND2VEChzN77taJ7iEGUuI1z4OoUMuQpnZicawWe
 RXogTQPXYeYaXWw3MQUOEFU7gL1zAD2Ly8l/sIUldPQdQPyEW3RIW/4wAuYoavKVlWHU
 Y2rrABeTstBOJEOlT0RlbS8RAkrfdCFJMFS+J5b+K7Zo4RkNB1ReF/V2w6BHsqRkDykn
 Mssyo/lzb7IEt0LAlz/bGhphSCrT7nJe17mf3n30G8KdVDWwDt8P3O+iLjqbtOvrBcmk
 fBm5gS0hG0WZBzuHwkJytEj2gdnYfXVTzUyWnxy8cbaVmOZFgHqQqlGzGOKFSxmz9wuU dQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by userp2120.oracle.com with ESMTP id 2qhredrqvs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Feb 2019 22:44:56 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1BMitAb031041
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Feb 2019 22:44:55 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1BMisBM026862;
 Mon, 11 Feb 2019 22:44:54 GMT
Received: from localhost.localdomain (/73.60.114.248)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 11 Feb 2019 14:44:54 -0800
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: jgg@ziepe.ca
Subject: [PATCH 5/5] kvm/book3s: use pinned_vm instead of locked_vm to account
 pinned pages
Date: Mon, 11 Feb 2019 17:44:37 -0500
Message-Id: <20190211224437.25267-6-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9164
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902110162
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
Cc: dave@stgolabs.net, jack@suse.cz, kvm@vger.kernel.org, atull@kernel.org,
 aik@ozlabs.ru, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, daniel.m.jordan@oracle.com, linux-mm@kvack.org,
 alex.williamson@redhat.com, mdf@kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, cl@linux.com, hao.wu@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Memory used for TCE tables in kvm_vm_ioctl_create_spapr_tce is currently
accounted to locked_vm because it stays resident and its allocation is
directly triggered from userspace as explained in f8626985c7c2 ("KVM:
PPC: Account TCE-containing pages in locked_vm").

However, since the memory comes straight from the page allocator (and to
a lesser extent unreclaimable slab) and is effectively pinned, it should
be accounted with pinned_vm (see bc3e53f682d9 ("mm: distinguish between
mlocked and pinned pages")).

pinned_vm recently became atomic and so no longer relies on mmap_sem
held as writer: delete.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 arch/powerpc/kvm/book3s_64_vio.c | 35 ++++++++++++++------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 532ab79734c7..2f8d7c051e4e 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -56,39 +56,34 @@ static unsigned long kvmppc_stt_pages(unsigned long tce_pages)
 	return tce_pages + ALIGN(stt_bytes, PAGE_SIZE) / PAGE_SIZE;
 }
 
-static long kvmppc_account_memlimit(unsigned long stt_pages, bool inc)
+static long kvmppc_account_memlimit(unsigned long pages, bool inc)
 {
 	long ret = 0;
+	s64 pinned_vm;
 
 	if (!current || !current->mm)
 		return ret; /* process exited */
 
-	down_write(&current->mm->mmap_sem);
-
 	if (inc) {
-		unsigned long locked, lock_limit;
+		unsigned long lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 
-		locked = current->mm->locked_vm + stt_pages;
-		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
+		pinned_vm = atomic64_add_return(pages, &current->mm->pinned_vm);
+		if (pinned_vm > lock_limit && !capable(CAP_IPC_LOCK)) {
 			ret = -ENOMEM;
-		else
-			current->mm->locked_vm += stt_pages;
+			atomic64_sub(pages, &current->mm->pinned_vm);
+		}
 	} else {
-		if (WARN_ON_ONCE(stt_pages > current->mm->locked_vm))
-			stt_pages = current->mm->locked_vm;
+		pinned_vm = atomic64_read(&current->mm->pinned_vm);
+		if (WARN_ON_ONCE(pages > pinned_vm))
+			pages = pinned_vm;
 
-		current->mm->locked_vm -= stt_pages;
+		atomic64_sub(pages, &current->mm->pinned_vm);
 	}
 
-	pr_debug("[%d] RLIMIT_MEMLOCK KVM %c%ld %ld/%ld%s\n", current->pid,
-			inc ? '+' : '-',
-			stt_pages << PAGE_SHIFT,
-			current->mm->locked_vm << PAGE_SHIFT,
-			rlimit(RLIMIT_MEMLOCK),
-			ret ? " - exceeded" : "");
-
-	up_write(&current->mm->mmap_sem);
+	pr_debug("[%d] RLIMIT_MEMLOCK KVM %c%lu %ld/%lu%s\n", current->pid,
+			inc ? '+' : '-', pages << PAGE_SHIFT,
+			atomic64_read(&current->mm->pinned_vm) << PAGE_SHIFT,
+			rlimit(RLIMIT_MEMLOCK), ret ? " - exceeded" : "");
 
 	return ret;
 }
-- 
2.20.1

