Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39387C169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 22:54:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA2872184E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 22:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0ANS8qxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2872184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43z1LL5wqjzDqbr
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 09:54:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=156.151.31.86; helo=userp2130.oracle.com;
 envelope-from=daniel.m.jordan@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="0ANS8qxu"; 
 dkim-atps=neutral
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43z19H6mRnzDqbw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 09:46:11 +1100 (AEDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1BMhX6S072792;
 Mon, 11 Feb 2019 22:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=TgUKT8mxeCnG73KFILQS5yx+gXU/1gCSnq77DsUA3Jw=;
 b=0ANS8qxu8TUrSovIxqwwoe9wU2/vLFPDYfYCtTSQUkAD9qLOpgMzZevM/x0UcMlhK49Z
 7aIjfLZEMOusmCpnPd7YQ31hCy9VcXSDJiZZskRnJmzG7fIiL7CrWmf0TPps/G8H56L6
 pKN8SS+SgWvazK/god5fAnt2HFhSt6tp281BNStRPuBg8jPGY3z0TjRy+iinS9R5eVEA
 5JtKnNRRE89P2LS14sT7f/TuTPjdcNU2+zW0EmPcFQRmAOptWifW9G9c17HgjQ1ebW5l
 sRJbXxCq2H0Ra5R5NNQ4XeDzlr3cdF3L+POvvYoQLjhrrMX9gPW7g3olX5OMeoWlyTis Vg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by userp2130.oracle.com with ESMTP id 2qhrek8q85-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Feb 2019 22:44:56 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1BMipfj030923
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Feb 2019 22:44:51 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1BMio0A006609;
 Mon, 11 Feb 2019 22:44:50 GMT
Received: from localhost.localdomain (/73.60.114.248)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 11 Feb 2019 14:44:50 -0800
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: jgg@ziepe.ca
Subject: [PATCH 3/5] fpga/dlf/afu: use pinned_vm instead of locked_vm to
 account pinned pages
Date: Mon, 11 Feb 2019 17:44:35 -0500
Message-Id: <20190211224437.25267-4-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9164
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
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

Beginning with bc3e53f682d9 ("mm: distinguish between mlocked and pinned
pages"), locked and pinned pages are accounted separately.  The FPGA AFU
driver accounts pinned pages to locked_vm; use pinned_vm instead.

pinned_vm recently became atomic and so no longer relies on mmap_sem
held as writer: delete.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 drivers/fpga/dfl-afu-dma-region.c | 50 ++++++++++++++-----------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
index e18a786fc943..a9a6b317fe2e 100644
--- a/drivers/fpga/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -32,47 +32,43 @@ void afu_dma_region_init(struct dfl_feature_platform_data *pdata)
 }
 
 /**
- * afu_dma_adjust_locked_vm - adjust locked memory
+ * afu_dma_adjust_pinned_vm - adjust pinned memory
  * @dev: port device
  * @npages: number of pages
- * @incr: increase or decrease locked memory
  *
- * Increase or decrease the locked memory size with npages input.
+ * Increase or decrease the pinned memory size with npages input.
  *
  * Return 0 on success.
- * Return -ENOMEM if locked memory size is over the limit and no CAP_IPC_LOCK.
+ * Return -ENOMEM if pinned memory size is over the limit and no CAP_IPC_LOCK.
  */
-static int afu_dma_adjust_locked_vm(struct device *dev, long npages, bool incr)
+static int afu_dma_adjust_pinned_vm(struct device *dev, long pages)
 {
-	unsigned long locked, lock_limit;
+	unsigned long lock_limit;
+	s64 pinned_vm;
 	int ret = 0;
 
 	/* the task is exiting. */
-	if (!current->mm)
+	if (!current->mm || !pages)
 		return 0;
 
-	down_write(&current->mm->mmap_sem);
-
-	if (incr) {
-		locked = current->mm->locked_vm + npages;
+	if (pages > 0) {
 		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-
-		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
+		pinned_vm = atomic64_add_return(pages, &current->mm->pinned_vm);
+		if (pinned_vm > lock_limit && !capable(CAP_IPC_LOCK)) {
 			ret = -ENOMEM;
-		else
-			current->mm->locked_vm += npages;
+			atomic64_sub(pages, &current->mm->pinned_vm);
+		}
 	} else {
-		if (WARN_ON_ONCE(npages > current->mm->locked_vm))
-			npages = current->mm->locked_vm;
-		current->mm->locked_vm -= npages;
+		pinned_vm = atomic64_read(&current->mm->pinned_vm);
+		if (WARN_ON_ONCE(pages > pinned_vm))
+			pages = pinned_vm;
+		atomic64_sub(pages, &current->mm->pinned_vm);
 	}
 
-	dev_dbg(dev, "[%d] RLIMIT_MEMLOCK %c%ld %ld/%ld%s\n", current->pid,
-		incr ? '+' : '-', npages << PAGE_SHIFT,
-		current->mm->locked_vm << PAGE_SHIFT, rlimit(RLIMIT_MEMLOCK),
-		ret ? "- exceeded" : "");
-
-	up_write(&current->mm->mmap_sem);
+	dev_dbg(dev, "[%d] RLIMIT_MEMLOCK %c%ld %lld/%lu%s\n", current->pid,
+		(pages > 0) ? '+' : '-', pages << PAGE_SHIFT,
+		(s64)atomic64_read(&current->mm->pinned_vm) << PAGE_SHIFT,
+		rlimit(RLIMIT_MEMLOCK), ret ? "- exceeded" : "");
 
 	return ret;
 }
@@ -92,7 +88,7 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
 	struct device *dev = &pdata->dev->dev;
 	int ret, pinned;
 
-	ret = afu_dma_adjust_locked_vm(dev, npages, true);
+	ret = afu_dma_adjust_pinned_vm(dev, npages);
 	if (ret)
 		return ret;
 
@@ -121,7 +117,7 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
 free_pages:
 	kfree(region->pages);
 unlock_vm:
-	afu_dma_adjust_locked_vm(dev, npages, false);
+	afu_dma_adjust_pinned_vm(dev, -npages);
 	return ret;
 }
 
@@ -141,7 +137,7 @@ static void afu_dma_unpin_pages(struct dfl_feature_platform_data *pdata,
 
 	put_all_pages(region->pages, npages);
 	kfree(region->pages);
-	afu_dma_adjust_locked_vm(dev, npages, false);
+	afu_dma_adjust_pinned_vm(dev, -npages);
 
 	dev_dbg(dev, "%ld pages unpinned\n", npages);
 }
-- 
2.20.1

