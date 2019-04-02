Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE975C4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 20:52:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D2012082C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 20:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="myGa/v1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2012082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YhGn61blzDqMh
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 07:52:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=141.146.126.78; helo=aserp2120.oracle.com;
 envelope-from=daniel.m.jordan@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="myGa/v1+"; 
 dkim-atps=neutral
X-Greylist: delayed 365 seconds by postgrey-1.36 at bilbo;
 Wed, 03 Apr 2019 07:50:33 AEDT
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YhDn3M6yzDqQ3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 07:50:33 +1100 (AEDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x32Kd5vJ164029;
 Tue, 2 Apr 2019 20:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=QrP2gOWfQDscn5FJYkHkueLx9eSDmR294rMG9/wfMMc=;
 b=myGa/v1+cXj9m6AltRx8x8N/Ns8VESUwT2Hc85+ihYiT5eC9brN+i+WnjTDEwVy1pYLn
 reN1Et2KHRyu3dwotNeaDwjahLaZ8mNrnn7GRFzF9B/j+MgAc7woMB4xsARkV/Yh0WAj
 5AiIL7M3X+jgYeyLklCN86BBH0o1K06JROTDOe+CT7WdsmmgIzc0VVmKRoMa8tx3BEMv
 siJcvxFym81a3hQr36vYyL2jdIKr/FStDIeU+nJsAxTll+TOOM22gWMA7onCf9nEQ5Q5
 5LE6WU5aUdfUl8VBml2GiCpsHLnB2fHhWdbddvvlT0XzudJEaCFeAxRI9CzOEoqTAd42 2w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2rj0dnm18u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 02 Apr 2019 20:48:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x32KfJvu103109;
 Tue, 2 Apr 2019 20:42:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2rm9mhp3mn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 02 Apr 2019 20:42:18 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x32KgFHa030189;
 Tue, 2 Apr 2019 20:42:15 GMT
Received: from localhost.localdomain (/73.60.114.248)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 02 Apr 2019 13:42:14 -0700
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: akpm@linux-foundation.org
Subject: [PATCH 1/6] mm: change locked_vm's type from unsigned long to
 atomic64_t
Date: Tue,  2 Apr 2019 16:41:53 -0400
Message-Id: <20190402204158.27582-2-daniel.m.jordan@oracle.com>
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
Cc: Davidlohr Bueso <dave@stgolabs.net>, kvm@vger.kernel.org,
 Alan Tull <atull@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, daniel.m.jordan@oracle.com, linux-mm@kvack.org,
 Alex Williamson <alex.williamson@redhat.com>, Moritz Fischer <mdf@kernel.org>,
 Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org,
 Wu Hao <hao.wu@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Taking and dropping mmap_sem to modify a single counter, locked_vm, is
overkill when the counter could be synchronized separately.

Make mmap_sem a little less coarse by changing locked_vm to an atomic,
the 64-bit variety to avoid issues with overflow on 32-bit systems.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Alan Tull <atull@kernel.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Moritz Fischer <mdf@kernel.org>
Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: Wu Hao <hao.wu@intel.com>
Cc: <linux-mm@kvack.org>
Cc: <kvm@vger.kernel.org>
Cc: <kvm-ppc@vger.kernel.org>
Cc: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-fpga@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
---
 arch/powerpc/kvm/book3s_64_vio.c    | 14 ++++++++------
 arch/powerpc/mm/mmu_context_iommu.c | 15 ++++++++-------
 drivers/fpga/dfl-afu-dma-region.c   | 18 ++++++++++--------
 drivers/vfio/vfio_iommu_spapr_tce.c | 17 +++++++++--------
 drivers/vfio/vfio_iommu_type1.c     | 10 ++++++----
 fs/proc/task_mmu.c                  |  2 +-
 include/linux/mm_types.h            |  2 +-
 kernel/fork.c                       |  2 +-
 mm/debug.c                          |  5 +++--
 mm/mlock.c                          |  4 ++--
 mm/mmap.c                           | 18 +++++++++---------
 mm/mremap.c                         |  6 +++---
 12 files changed, 61 insertions(+), 52 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index f02b04973710..e7fdb6d10eeb 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -59,32 +59,34 @@ static unsigned long kvmppc_stt_pages(unsigned long tce_pages)
 static long kvmppc_account_memlimit(unsigned long stt_pages, bool inc)
 {
 	long ret = 0;
+	s64 locked_vm;
 
 	if (!current || !current->mm)
 		return ret; /* process exited */
 
 	down_write(&current->mm->mmap_sem);
 
+	locked_vm = atomic64_read(&current->mm->locked_vm);
 	if (inc) {
 		unsigned long locked, lock_limit;
 
-		locked = current->mm->locked_vm + stt_pages;
+		locked = locked_vm + stt_pages;
 		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 			ret = -ENOMEM;
 		else
-			current->mm->locked_vm += stt_pages;
+			atomic64_add(stt_pages, &current->mm->locked_vm);
 	} else {
-		if (WARN_ON_ONCE(stt_pages > current->mm->locked_vm))
-			stt_pages = current->mm->locked_vm;
+		if (WARN_ON_ONCE(stt_pages > locked_vm))
+			stt_pages = locked_vm;
 
-		current->mm->locked_vm -= stt_pages;
+		atomic64_sub(stt_pages, &current->mm->locked_vm);
 	}
 
 	pr_debug("[%d] RLIMIT_MEMLOCK KVM %c%ld %ld/%ld%s\n", current->pid,
 			inc ? '+' : '-',
 			stt_pages << PAGE_SHIFT,
-			current->mm->locked_vm << PAGE_SHIFT,
+			atomic64_read(&current->mm->locked_vm) << PAGE_SHIFT,
 			rlimit(RLIMIT_MEMLOCK),
 			ret ? " - exceeded" : "");
 
diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index e7a9c4f6bfca..8038ac24a312 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -55,30 +55,31 @@ static long mm_iommu_adjust_locked_vm(struct mm_struct *mm,
 		unsigned long npages, bool incr)
 {
 	long ret = 0, locked, lock_limit;
+	s64 locked_vm;
 
 	if (!npages)
 		return 0;
 
 	down_write(&mm->mmap_sem);
-
+	locked_vm = atomic64_read(&mm->locked_vm);
 	if (incr) {
-		locked = mm->locked_vm + npages;
+		locked = locked_vm + npages;
 		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 			ret = -ENOMEM;
 		else
-			mm->locked_vm += npages;
+			atomic64_add(npages, &mm->locked_vm);
 	} else {
-		if (WARN_ON_ONCE(npages > mm->locked_vm))
-			npages = mm->locked_vm;
-		mm->locked_vm -= npages;
+		if (WARN_ON_ONCE(npages > locked_vm))
+			npages = locked_vm;
+		atomic64_sub(npages, &mm->locked_vm);
 	}
 
 	pr_debug("[%d] RLIMIT_MEMLOCK HASH64 %c%ld %ld/%ld\n",
 			current ? current->pid : 0,
 			incr ? '+' : '-',
 			npages << PAGE_SHIFT,
-			mm->locked_vm << PAGE_SHIFT,
+			atomic64_read(&mm->locked_vm) << PAGE_SHIFT,
 			rlimit(RLIMIT_MEMLOCK));
 	up_write(&mm->mmap_sem);
 
diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
index e18a786fc943..08132fd9b6b7 100644
--- a/drivers/fpga/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -45,6 +45,7 @@ void afu_dma_region_init(struct dfl_feature_platform_data *pdata)
 static int afu_dma_adjust_locked_vm(struct device *dev, long npages, bool incr)
 {
 	unsigned long locked, lock_limit;
+	s64 locked_vm;
 	int ret = 0;
 
 	/* the task is exiting. */
@@ -53,24 +54,25 @@ static int afu_dma_adjust_locked_vm(struct device *dev, long npages, bool incr)
 
 	down_write(&current->mm->mmap_sem);
 
+	locked_vm = atomic64_read(&current->mm->locked_vm);
 	if (incr) {
-		locked = current->mm->locked_vm + npages;
+		locked = locked_vm + npages;
 		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 
 		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 			ret = -ENOMEM;
 		else
-			current->mm->locked_vm += npages;
+			atomic64_add(npages, &current->mm->locked_vm);
 	} else {
-		if (WARN_ON_ONCE(npages > current->mm->locked_vm))
-			npages = current->mm->locked_vm;
-		current->mm->locked_vm -= npages;
+		if (WARN_ON_ONCE(npages > locked_vm))
+			npages = locked_vm;
+		atomic64_sub(npages, &current->mm->locked_vm);
 	}
 
-	dev_dbg(dev, "[%d] RLIMIT_MEMLOCK %c%ld %ld/%ld%s\n", current->pid,
+	dev_dbg(dev, "[%d] RLIMIT_MEMLOCK %c%ld %lld/%lu%s\n", current->pid,
 		incr ? '+' : '-', npages << PAGE_SHIFT,
-		current->mm->locked_vm << PAGE_SHIFT, rlimit(RLIMIT_MEMLOCK),
-		ret ? "- exceeded" : "");
+		(s64)atomic64_read(&current->mm->locked_vm) << PAGE_SHIFT,
+		rlimit(RLIMIT_MEMLOCK), ret ? "- exceeded" : "");
 
 	up_write(&current->mm->mmap_sem);
 
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 8dbb270998f4..e7d787e5d839 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -36,7 +36,8 @@ static void tce_iommu_detach_group(void *iommu_data,
 
 static long try_increment_locked_vm(struct mm_struct *mm, long npages)
 {
-	long ret = 0, locked, lock_limit;
+	long ret = 0, lock_limit;
+	s64 locked;
 
 	if (WARN_ON_ONCE(!mm))
 		return -EPERM;
@@ -45,16 +46,16 @@ static long try_increment_locked_vm(struct mm_struct *mm, long npages)
 		return 0;
 
 	down_write(&mm->mmap_sem);
-	locked = mm->locked_vm + npages;
+	locked = atomic64_read(&mm->locked_vm) + npages;
 	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 	if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 		ret = -ENOMEM;
 	else
-		mm->locked_vm += npages;
+		atomic64_add(npages, &mm->locked_vm);
 
 	pr_debug("[%d] RLIMIT_MEMLOCK +%ld %ld/%ld%s\n", current->pid,
 			npages << PAGE_SHIFT,
-			mm->locked_vm << PAGE_SHIFT,
+			atomic64_read(&mm->locked_vm) << PAGE_SHIFT,
 			rlimit(RLIMIT_MEMLOCK),
 			ret ? " - exceeded" : "");
 
@@ -69,12 +70,12 @@ static void decrement_locked_vm(struct mm_struct *mm, long npages)
 		return;
 
 	down_write(&mm->mmap_sem);
-	if (WARN_ON_ONCE(npages > mm->locked_vm))
-		npages = mm->locked_vm;
-	mm->locked_vm -= npages;
+	if (WARN_ON_ONCE(npages > atomic64_read(&mm->locked_vm)))
+		npages = atomic64_read(&mm->locked_vm);
+	atomic64_sub(npages, &mm->locked_vm);
 	pr_debug("[%d] RLIMIT_MEMLOCK -%ld %ld/%ld\n", current->pid,
 			npages << PAGE_SHIFT,
-			mm->locked_vm << PAGE_SHIFT,
+			atomic64_read(&mm->locked_vm) << PAGE_SHIFT,
 			rlimit(RLIMIT_MEMLOCK));
 	up_write(&mm->mmap_sem);
 }
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 73652e21efec..5b2878697286 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -270,18 +270,19 @@ static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
 	if (!ret) {
 		if (npage > 0) {
 			if (!dma->lock_cap) {
+				s64 locked_vm = atomic64_read(&mm->locked_vm);
 				unsigned long limit;
 
 				limit = task_rlimit(dma->task,
 						RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 
-				if (mm->locked_vm + npage > limit)
+				if (locked_vm + npage > limit)
 					ret = -ENOMEM;
 			}
 		}
 
 		if (!ret)
-			mm->locked_vm += npage;
+			atomic64_add(npage, &mm->locked_vm);
 
 		up_write(&mm->mmap_sem);
 	}
@@ -401,6 +402,7 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 	long ret, pinned = 0, lock_acct = 0;
 	bool rsvd;
 	dma_addr_t iova = vaddr - dma->vaddr + dma->iova;
+	atomic64_t *locked_vm = &current->mm->locked_vm;
 
 	/* This code path is only user initiated */
 	if (!current->mm)
@@ -418,7 +420,7 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 	 * pages are already counted against the user.
 	 */
 	if (!rsvd && !vfio_find_vpfn(dma, iova)) {
-		if (!dma->lock_cap && current->mm->locked_vm + 1 > limit) {
+		if (!dma->lock_cap && atomic64_read(locked_vm) + 1 > limit) {
 			put_pfn(*pfn_base, dma->prot);
 			pr_warn("%s: RLIMIT_MEMLOCK (%ld) exceeded\n", __func__,
 					limit << PAGE_SHIFT);
@@ -445,7 +447,7 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 
 		if (!rsvd && !vfio_find_vpfn(dma, iova)) {
 			if (!dma->lock_cap &&
-			    current->mm->locked_vm + lock_acct + 1 > limit) {
+			    atomic64_read(locked_vm) + lock_acct + 1 > limit) {
 				put_pfn(pfn, dma->prot);
 				pr_warn("%s: RLIMIT_MEMLOCK (%ld) exceeded\n",
 					__func__, limit << PAGE_SHIFT);
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 92a91e7816d8..61da4b24d0e0 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -58,7 +58,7 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
 	swap = get_mm_counter(mm, MM_SWAPENTS);
 	SEQ_PUT_DEC("VmPeak:\t", hiwater_vm);
 	SEQ_PUT_DEC(" kB\nVmSize:\t", total_vm);
-	SEQ_PUT_DEC(" kB\nVmLck:\t", mm->locked_vm);
+	SEQ_PUT_DEC(" kB\nVmLck:\t", atomic64_read(&mm->locked_vm));
 	SEQ_PUT_DEC(" kB\nVmPin:\t", atomic64_read(&mm->pinned_vm));
 	SEQ_PUT_DEC(" kB\nVmHWM:\t", hiwater_rss);
 	SEQ_PUT_DEC(" kB\nVmRSS:\t", total_rss);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 7eade9132f02..5059b99a0827 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -410,7 +410,7 @@ struct mm_struct {
 		unsigned long hiwater_vm;  /* High-water virtual memory usage */
 
 		unsigned long total_vm;	   /* Total pages mapped */
-		unsigned long locked_vm;   /* Pages that have PG_mlocked set */
+		atomic64_t    locked_vm;   /* Pages that have PG_mlocked set */
 		atomic64_t    pinned_vm;   /* Refcount permanently increased */
 		unsigned long data_vm;	   /* VM_WRITE & ~VM_SHARED & ~VM_STACK */
 		unsigned long exec_vm;	   /* VM_EXEC & ~VM_WRITE & ~VM_STACK */
diff --git a/kernel/fork.c b/kernel/fork.c
index 9dcd18aa210b..56be8cdc7b4a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -979,7 +979,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm->core_state = NULL;
 	mm_pgtables_bytes_init(mm);
 	mm->map_count = 0;
-	mm->locked_vm = 0;
+	atomic64_set(&mm->locked_vm, 0);
 	atomic64_set(&mm->pinned_vm, 0);
 	memset(&mm->rss_stat, 0, sizeof(mm->rss_stat));
 	spin_lock_init(&mm->page_table_lock);
diff --git a/mm/debug.c b/mm/debug.c
index eee9c221280c..b9cd71927d3c 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -136,7 +136,7 @@ void dump_mm(const struct mm_struct *mm)
 #endif
 		"mmap_base %lu mmap_legacy_base %lu highest_vm_end %lu\n"
 		"pgd %px mm_users %d mm_count %d pgtables_bytes %lu map_count %d\n"
-		"hiwater_rss %lx hiwater_vm %lx total_vm %lx locked_vm %lx\n"
+		"hiwater_rss %lx hiwater_vm %lx total_vm %lx locked_vm %llx\n"
 		"pinned_vm %llx data_vm %lx exec_vm %lx stack_vm %lx\n"
 		"start_code %lx end_code %lx start_data %lx end_data %lx\n"
 		"start_brk %lx brk %lx start_stack %lx\n"
@@ -167,7 +167,8 @@ void dump_mm(const struct mm_struct *mm)
 		atomic_read(&mm->mm_count),
 		mm_pgtables_bytes(mm),
 		mm->map_count,
-		mm->hiwater_rss, mm->hiwater_vm, mm->total_vm, mm->locked_vm,
+		mm->hiwater_rss, mm->hiwater_vm, mm->total_vm,
+		(u64)atomic64_read(&mm->locked_vm),
 		(u64)atomic64_read(&mm->pinned_vm),
 		mm->data_vm, mm->exec_vm, mm->stack_vm,
 		mm->start_code, mm->end_code, mm->start_data, mm->end_data,
diff --git a/mm/mlock.c b/mm/mlock.c
index 080f3b36415b..e492a155c51a 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -562,7 +562,7 @@ static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
 		nr_pages = -nr_pages;
 	else if (old_flags & VM_LOCKED)
 		nr_pages = 0;
-	mm->locked_vm += nr_pages;
+	atomic64_add(nr_pages, &mm->locked_vm);
 
 	/*
 	 * vm_flags is protected by the mmap_sem held in write mode.
@@ -687,7 +687,7 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
 	if (down_write_killable(&current->mm->mmap_sem))
 		return -EINTR;
 
-	locked += current->mm->locked_vm;
+	locked += atomic64_read(&current->mm->locked_vm);
 	if ((locked > lock_limit) && (!capable(CAP_IPC_LOCK))) {
 		/*
 		 * It is possible that the regions requested intersect with
diff --git a/mm/mmap.c b/mm/mmap.c
index 41eb48d9b527..03576c1d530c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1339,7 +1339,7 @@ static inline int mlock_future_check(struct mm_struct *mm,
 	/*  mlock MCL_FUTURE? */
 	if (flags & VM_LOCKED) {
 		locked = len >> PAGE_SHIFT;
-		locked += mm->locked_vm;
+		locked += atomic64_read(&mm->locked_vm);
 		lock_limit = rlimit(RLIMIT_MEMLOCK);
 		lock_limit >>= PAGE_SHIFT;
 		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
@@ -1825,7 +1825,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 					vma == get_gate_vma(current->mm))
 			vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
 		else
-			mm->locked_vm += (len >> PAGE_SHIFT);
+			atomic64_add(len >> PAGE_SHIFT, &mm->locked_vm);
 	}
 
 	if (file)
@@ -2301,7 +2301,7 @@ static int acct_stack_growth(struct vm_area_struct *vma,
 	if (vma->vm_flags & VM_LOCKED) {
 		unsigned long locked;
 		unsigned long limit;
-		locked = mm->locked_vm + grow;
+		locked = atomic64_read(&mm->locked_vm) + grow;
 		limit = rlimit(RLIMIT_MEMLOCK);
 		limit >>= PAGE_SHIFT;
 		if (locked > limit && !capable(CAP_IPC_LOCK))
@@ -2395,7 +2395,7 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 				 */
 				spin_lock(&mm->page_table_lock);
 				if (vma->vm_flags & VM_LOCKED)
-					mm->locked_vm += grow;
+					atomic64_add(grow, &mm->locked_vm);
 				vm_stat_account(mm, vma->vm_flags, grow);
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_end = address;
@@ -2475,7 +2475,7 @@ int expand_downwards(struct vm_area_struct *vma,
 				 */
 				spin_lock(&mm->page_table_lock);
 				if (vma->vm_flags & VM_LOCKED)
-					mm->locked_vm += grow;
+					atomic64_add(grow, &mm->locked_vm);
 				vm_stat_account(mm, vma->vm_flags, grow);
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_start = address;
@@ -2796,11 +2796,11 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	/*
 	 * unlock any mlock()ed ranges before detaching vmas
 	 */
-	if (mm->locked_vm) {
+	if (atomic64_read(&mm->locked_vm)) {
 		struct vm_area_struct *tmp = vma;
 		while (tmp && tmp->vm_start < end) {
 			if (tmp->vm_flags & VM_LOCKED) {
-				mm->locked_vm -= vma_pages(tmp);
+				atomic64_sub(vma_pages(tmp), &mm->locked_vm);
 				munlock_vma_pages_all(tmp);
 			}
 
@@ -3043,7 +3043,7 @@ static int do_brk_flags(unsigned long addr, unsigned long len, unsigned long fla
 	mm->total_vm += len >> PAGE_SHIFT;
 	mm->data_vm += len >> PAGE_SHIFT;
 	if (flags & VM_LOCKED)
-		mm->locked_vm += (len >> PAGE_SHIFT);
+		atomic64_add(len >> PAGE_SHIFT, &mm->locked_vm);
 	vma->vm_flags |= VM_SOFTDIRTY;
 	return 0;
 }
@@ -3115,7 +3115,7 @@ void exit_mmap(struct mm_struct *mm)
 		up_write(&mm->mmap_sem);
 	}
 
-	if (mm->locked_vm) {
+	if (atomic64_read(&mm->locked_vm)) {
 		vma = mm->mmap;
 		while (vma) {
 			if (vma->vm_flags & VM_LOCKED)
diff --git a/mm/mremap.c b/mm/mremap.c
index e3edef6b7a12..9a4046bb2875 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -422,7 +422,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	}
 
 	if (vm_flags & VM_LOCKED) {
-		mm->locked_vm += new_len >> PAGE_SHIFT;
+		atomic64_add(new_len >> PAGE_SHIFT, &mm->locked_vm);
 		*locked = true;
 	}
 
@@ -473,7 +473,7 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
 
 	if (vma->vm_flags & VM_LOCKED) {
 		unsigned long locked, lock_limit;
-		locked = mm->locked_vm << PAGE_SHIFT;
+		locked = atomic64_read(&mm->locked_vm) << PAGE_SHIFT;
 		lock_limit = rlimit(RLIMIT_MEMLOCK);
 		locked += new_len - old_len;
 		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
@@ -679,7 +679,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 
 			vm_stat_account(mm, vma->vm_flags, pages);
 			if (vma->vm_flags & VM_LOCKED) {
-				mm->locked_vm += pages;
+				atomic64_add(pages, &mm->locked_vm);
 				locked = true;
 				new_addr = addr;
 			}
-- 
2.21.0

