Return-Path: <linuxppc-dev+bounces-21105-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57017CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 08:51:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJs332Mkvz3bsq;
	Mon, 18 May 2026 18:50:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779094255;
	cv=none; b=ckqC7Z49xGzVCYAJaK0v9b6QD0HNZ4DNUbyrLx3fyf99roNaXZ0KO3e9QccGSRMxQ7XSBEz+3YSXiaheYz+dD0+h6GX6tesTH24y9LgWgGCtSILKzlrqDaRjxfXTT4obtTawc2K80/FfsQ/Q2szHyW4DA43Oblgk86rGDWkMnIAyWXb19fqfhedcEMlzbVmaeAWYm+MhopslGniexfgV12ectcr1NiI0ygxxDOWIhSJ+rL3aSyTgH5UpeyMlyf87QqP6Opis9Yz9Y1tTLHGVc7vvZcHwfPam+ZdTyMKbOUjGNYyu9SiWtUnPIfi5FVhe1ZkDxTLhcR+g0FshRYZIaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779094255; c=relaxed/relaxed;
	bh=OfwkogOixf5GMwu+2dp6NmTbHKTViLblOsXgNerkr74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJn3Suf4jrhYElOaiWR8P34d/UQsRtT1kfmmPGzqNAxMiZVmVy/6lukR8SiXCCHMflmeauz7+Ud6SuB475HESwImbwExZSkZmh+UzTwmxnBqcvUIINNkJUQgrL6chxUr+59TCfp0OZkJRcPlqUwPU67GIclhSHaLjOgKoxK4NbsOQBnuoSX3I7guh8MZr+nK2P5bwh6q+hEWvYE0z3pwsbB91C3YvR+CQsT7VfrpjR8mXi3JqWvYHBaAy4+Ar+pqf41tqEMO0hMllyl8ylvyXtC1bM6bscpew7friAlsyRUTCjOCl9zV6oSxAppjAmMdDo80g46Hp3sK5Xum9DHoSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pr6VCI95; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=tianruidong@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pr6VCI95;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=tianruidong@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJs2r1npFz3bsY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 18:50:43 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779094219; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=OfwkogOixf5GMwu+2dp6NmTbHKTViLblOsXgNerkr74=;
	b=pr6VCI95EuAxzdpeizUu+L0ByS6rVHwQFGpTkJoX9E/T4JMRLmaR+nst8rLP0MwdZujK09B89g59WnN0I7T7PSsocDmUG637qotiGY60Rm7No7v8uv2HHnIsuPi1p/iTFqTtQmt+OzxFdU/3gFDVtbHXuV3eVEN8058dXASf3mE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=30;SR=0;TI=SMTPD_---0X3647Lr_1779094212;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0X3647Lr_1779094212 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 16:50:13 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	rafael@kernel.org,
	tony.luck@intel.com,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com,
	tongtiangen@huawei.com,
	james.morse@arm.com,
	robin.murphy@arm.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com,
	tglx@linutronix.de,
	mingo@redhat.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	tianruidong@linux.alibaba.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v14 4/8] mm/hwpoison: return -EFAULT when copy fail in copy_mc_[user]_highpage()
Date: Mon, 18 May 2026 16:49:48 +0800
Message-ID: <20260518084956.2538442-5-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260518084956.2538442-1-tianruidong@linux.alibaba.com>
References: <20260518084956.2538442-1-tianruidong@linux.alibaba.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tong Tiangen <tongtiangen@huawei.com>

Currently, copy_mc_[user]_highpage() returns zero on success, or in case
of failures, the number of bytes that weren't copied.

While tracking the number of not copied works fine for x86 and PPC, There
are some difficulties in doing the same thing on ARM64 because there is no
available caller-saved register in copy_page()(lib/copy_page.S) to save
"bytes not copied", and the following copy_mc_page() will also encounter
the same problem.

Consider the caller of copy_mc_[user]_highpage() cannot do any processing
on the remaining data(The page has hardware errors), they only check if
copy was succeeded or not, make the interface more generic by using an
error code when copy fails (-EFAULT) or return zero on success.

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/highmem.h | 8 ++++----
 mm/khugepaged.c         | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index af03db851a1d..18dc4aca4aa1 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -427,8 +427,8 @@ static inline void copy_highpage(struct page *to, struct page *from)
 /*
  * If architecture supports machine check exception handling, define the
  * #MC versions of copy_user_highpage and copy_highpage. They copy a memory
- * page with #MC in source page (@from) handled, and return the number
- * of bytes not copied if there was a #MC, otherwise 0 for success.
+ * page with #MC in source page (@from) handled, and return -EFAULT if there
+ * was a #MC, otherwise 0 for success.
  */
 static inline int copy_mc_user_highpage(struct page *to, struct page *from,
 					unsigned long vaddr, struct vm_area_struct *vma)
@@ -447,7 +447,7 @@ static inline int copy_mc_user_highpage(struct page *to, struct page *from,
 	if (ret)
 		memory_failure_queue(page_to_pfn(from), 0);
 
-	return ret;
+	return ret ? -EFAULT : 0;
 }
 
 static inline int copy_mc_highpage(struct page *to, struct page *from)
@@ -466,7 +466,7 @@ static inline int copy_mc_highpage(struct page *to, struct page *from)
 	if (ret)
 		memory_failure_queue(page_to_pfn(from), 0);
 
-	return ret;
+	return ret ? -EFAULT : 0;
 }
 #else
 static inline int copy_mc_user_highpage(struct page *to, struct page *from,
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b8452dbdb043..cf1b78eed3c3 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -810,7 +810,7 @@ static enum scan_result __collapse_huge_page_copy(pte_t *pte, struct folio *foli
 			continue;
 		}
 		src_page = pte_page(pteval);
-		if (copy_mc_user_highpage(page, src_page, src_addr, vma) > 0) {
+		if (copy_mc_user_highpage(page, src_page, src_addr, vma)) {
 			result = SCAN_COPY_MC;
 			break;
 		}
@@ -2143,7 +2143,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 		}
 
 		for (i = 0; i < nr_pages; i++) {
-			if (copy_mc_highpage(dst, folio_page(folio, i)) > 0) {
+			if (copy_mc_highpage(dst, folio_page(folio, i))) {
 				result = SCAN_COPY_MC;
 				goto rollback;
 			}
-- 
2.39.3


