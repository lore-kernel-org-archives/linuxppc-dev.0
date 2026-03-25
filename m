Return-Path: <linuxppc-dev+bounces-18752-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9058D103A9A1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2026 02:58:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgWmM02Wpz2yvH;
	Wed, 25 Mar 2026 13:57:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774407458;
	cv=none; b=mX5wK2qoN4afBrUWU0aJKVnsX89iuAK7foppPheoO5EkO8A174NSJkqzJKzQhxvRjvujilwCrG4PprnStpV17Sf4Ub7e+IBpw0QsJH9VONDd8xBAJLikGYFmaxPz67qy4NZGnMajTG/3DpFpY6Gn/PP3yNF/d0uSn4S8gDj9YPOpiKnrVLP9P9SOcrvPx1YYrgi6NS0axS3yYJXCFpgXaOvhwk7nXWdtR+zPkH2SEZ0I/B8rsFJdbcehWqfkO8+AWrLfg9JI+FHC+Ltv67r4Q90e8AZU892XHgpnmAZ3LtKAAvkIK+pTJyajQp4RD1h7LcpNU/ETVvmDeMikQdG7Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774407458; c=relaxed/relaxed;
	bh=mH5xa0k0KfAE+yqW3TlLqLufhfqy/QhiIK3/DmDZssU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JATeQY1vp40mOesVR1NJCnkUnjJQgf3PbUz3ojTI+I3Rrrki6ZnYE8EOk32G6ZMNPkKhQLwVvFWaD1wruGxvErR3w6BNYqoA8rbu1ZLPqCi8X2G6pzmRFcgZ9pybmNWZzPlzLTfrsiyLF70qeZAerHt5viTubS2cUrBGwWZjVdJKQuwBb1zjC3xdIoVrERLs4H58NFrRPs8dJIQa7h31yP1dgTwxuaJvmSM/6Z5YPQ9mHIJJvIbR6eAbyfU9RxYKq1r22iKt305ChJZFkqlVWTjqV4hxNaAuDYVF7XyXZWRcWT5KKiJaugwOlTDKrQC8bLMg9W60P8XpTzr9h2apEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=XEAgqoBE; dkim-atps=neutral; spf=pass (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=XEAgqoBE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgWmK5qDMz2yr8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 13:57:37 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mH5xa0k0KfAE+yqW3TlLqLufhfqy/QhiIK3/DmDZssU=;
	b=XEAgqoBEkj59aYI7vQ5RaEeKLTe/jZsZesG5JLzpXJ0qI2GPKi8BiUJzOOP0tYgrmKHcKVBlx
	U/okL1hUaCtoysujw1Dm6bS5zev2+maeujxjDy+JN5GgectHJNIOTEQKZry16R6IZ+gIocxNism
	szk6pLlJIIOB4emN35QCN3k=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fgWdV4CZXzcb0r;
	Wed, 25 Mar 2026 10:51:42 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id E5DF54056A;
	Wed, 25 Mar 2026 10:57:33 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Mar
 2026 10:57:30 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>, <rdunlap@infradead.org>, <peterz@infradead.org>,
	<pawan.kumar.gupta@linux.intel.com>, <feng.tang@linux.alibaba.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<paulmck@kernel.org>, <lirongqing@baidu.com>, <ruanjinjie@huawei.com>,
	<rppt@kernel.org>, <ardb@kernel.org>, <leitao@debian.org>, <osandov@fb.com>,
	<cfsworks@gmail.com>, <tangyouling@kylinos.cn>, <sourabhjain@linux.ibm.com>,
	<ritesh.list@gmail.com>, <eajames@linux.ibm.com>,
	<songshuaishuai@tinylab.org>, <kevin.brodsky@arm.com>,
	<samuel.holland@sifive.com>, <vishal.moola@gmail.com>,
	<junhui.liu@pigmoral.tech>, <coxu@redhat.com>, <liaoyuanhong@vivo.com>,
	<jbohac@suse.cz>, <fuqiang.wang@easystack.cn>, <guoren@kernel.org>,
	<chenjiahao16@huawei.com>, <hbathini@linux.ibm.com>, <james.morse@arm.com>,
	<takahiro.akashi@linaro.org>, <lizhengyu3@huawei.com>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <kexec@lists.infradead.org>
Subject: [PATCH v10 3/8] powerpc/crash: sort crash memory ranges before preparing elfcorehdr
Date: Wed, 25 Mar 2026 10:58:59 +0800
Message-ID: <20260325025904.2811960-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325025904.2811960-1-ruanjinjie@huawei.com>
References: <20260325025904.2811960-1-ruanjinjie@huawei.com>
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
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)

From: Sourabh Jain <sourabhjain@linux.ibm.com>

During a memory hot-remove event, the elfcorehdr is rebuilt to exclude
the removed memory. While updating the crash memory ranges for this
operation, the crash memory ranges array can become unsorted. This
happens because remove_mem_range() may split a memory range into two
parts and append the higher-address part as a separate range at the end
of the array.

So far, no issues have been observed due to the unsorted crash memory
ranges. However, this could lead to problems once crash memory range
removal is handled by generic code, as introduced in the upcoming
patches in this series.

Currently, powerpc uses a platform-specific function,
remove_mem_range(), to exclude hot-removed memory from the crash memory
ranges. This function performs the same task as the generic
crash_exclude_mem_range() in crash_core.c. The generic helper also
ensures that the crash memory ranges remain sorted. So remove the
redundant powerpc-specific implementation and instead call
crash_exclude_mem_range_guarded() (which internally calls
crash_exclude_mem_range()) to exclude the hot-removed memory ranges.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan he <bhe@redhat.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org
Acked-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/powerpc/include/asm/kexec_ranges.h |  4 +-
 arch/powerpc/kexec/crash.c              |  5 +-
 arch/powerpc/kexec/ranges.c             | 87 +------------------------
 3 files changed, 7 insertions(+), 89 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec_ranges.h b/arch/powerpc/include/asm/kexec_ranges.h
index 14055896cbcb..ad95e3792d10 100644
--- a/arch/powerpc/include/asm/kexec_ranges.h
+++ b/arch/powerpc/include/asm/kexec_ranges.h
@@ -7,7 +7,9 @@
 void sort_memory_ranges(struct crash_mem *mrngs, bool merge);
 struct crash_mem *realloc_mem_ranges(struct crash_mem **mem_ranges);
 int add_mem_range(struct crash_mem **mem_ranges, u64 base, u64 size);
-int remove_mem_range(struct crash_mem **mem_ranges, u64 base, u64 size);
+int crash_exclude_mem_range_guarded(struct crash_mem **mem_ranges,
+				    unsigned long long mstart,
+				    unsigned long long mend);
 int get_exclude_memory_ranges(struct crash_mem **mem_ranges);
 int get_reserved_memory_ranges(struct crash_mem **mem_ranges);
 int get_crash_memory_ranges(struct crash_mem **mem_ranges);
diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
index 1d12cef8e1e0..1426d2099bad 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -431,7 +431,7 @@ static void update_crash_elfcorehdr(struct kimage *image, struct memory_notify *
 	struct crash_mem *cmem = NULL;
 	struct kexec_segment *ksegment;
 	void *ptr, *mem, *elfbuf = NULL;
-	unsigned long elfsz, memsz, base_addr, size;
+	unsigned long elfsz, memsz, base_addr, size, end;
 
 	ksegment = &image->segment[image->elfcorehdr_index];
 	mem = (void *) ksegment->mem;
@@ -450,7 +450,8 @@ static void update_crash_elfcorehdr(struct kimage *image, struct memory_notify *
 	if (image->hp_action == KEXEC_CRASH_HP_REMOVE_MEMORY) {
 		base_addr = PFN_PHYS(mn->start_pfn);
 		size = mn->nr_pages * PAGE_SIZE;
-		ret = remove_mem_range(&cmem, base_addr, size);
+		end = base_addr + size - 1;
+		ret = crash_exclude_mem_range_guarded(&cmem, base_addr, end);
 		if (ret) {
 			pr_err("Failed to remove hot-unplugged memory from crash memory ranges\n");
 			goto out;
diff --git a/arch/powerpc/kexec/ranges.c b/arch/powerpc/kexec/ranges.c
index 867135560e5c..6c58bcc3e130 100644
--- a/arch/powerpc/kexec/ranges.c
+++ b/arch/powerpc/kexec/ranges.c
@@ -553,7 +553,7 @@ int get_usable_memory_ranges(struct crash_mem **mem_ranges)
 #endif /* CONFIG_KEXEC_FILE */
 
 #ifdef CONFIG_CRASH_DUMP
-static int crash_exclude_mem_range_guarded(struct crash_mem **mem_ranges,
+int crash_exclude_mem_range_guarded(struct crash_mem **mem_ranges,
 					   unsigned long long mstart,
 					   unsigned long long mend)
 {
@@ -641,89 +641,4 @@ int get_crash_memory_ranges(struct crash_mem **mem_ranges)
 		pr_err("Failed to setup crash memory ranges\n");
 	return ret;
 }
-
-/**
- * remove_mem_range - Removes the given memory range from the range list.
- * @mem_ranges:    Range list to remove the memory range to.
- * @base:          Base address of the range to remove.
- * @size:          Size of the memory range to remove.
- *
- * (Re)allocates memory, if needed.
- *
- * Returns 0 on success, negative errno on error.
- */
-int remove_mem_range(struct crash_mem **mem_ranges, u64 base, u64 size)
-{
-	u64 end;
-	int ret = 0;
-	unsigned int i;
-	u64 mstart, mend;
-	struct crash_mem *mem_rngs = *mem_ranges;
-
-	if (!size)
-		return 0;
-
-	/*
-	 * Memory range are stored as start and end address, use
-	 * the same format to do remove operation.
-	 */
-	end = base + size - 1;
-
-	for (i = 0; i < mem_rngs->nr_ranges; i++) {
-		mstart = mem_rngs->ranges[i].start;
-		mend = mem_rngs->ranges[i].end;
-
-		/*
-		 * Memory range to remove is not part of this range entry
-		 * in the memory range list
-		 */
-		if (!(base >= mstart && end <= mend))
-			continue;
-
-		/*
-		 * Memory range to remove is equivalent to this entry in the
-		 * memory range list. Remove the range entry from the list.
-		 */
-		if (base == mstart && end == mend) {
-			for (; i < mem_rngs->nr_ranges - 1; i++) {
-				mem_rngs->ranges[i].start = mem_rngs->ranges[i+1].start;
-				mem_rngs->ranges[i].end = mem_rngs->ranges[i+1].end;
-			}
-			mem_rngs->nr_ranges--;
-			goto out;
-		}
-		/*
-		 * Start address of the memory range to remove and the
-		 * current memory range entry in the list is same. Just
-		 * move the start address of the current memory range
-		 * entry in the list to end + 1.
-		 */
-		else if (base == mstart) {
-			mem_rngs->ranges[i].start = end + 1;
-			goto out;
-		}
-		/*
-		 * End address of the memory range to remove and the
-		 * current memory range entry in the list is same.
-		 * Just move the end address of the current memory
-		 * range entry in the list to base - 1.
-		 */
-		else if (end == mend)  {
-			mem_rngs->ranges[i].end = base - 1;
-			goto out;
-		}
-		/*
-		 * Memory range to remove is not at the edge of current
-		 * memory range entry. Split the current memory entry into
-		 * two half.
-		 */
-		else {
-			size = mem_rngs->ranges[i].end - end + 1;
-			mem_rngs->ranges[i].end = base - 1;
-			ret = add_mem_range(mem_ranges, end + 1, size);
-		}
-	}
-out:
-	return ret;
-}
 #endif /* CONFIG_CRASH_DUMP */
-- 
2.34.1


