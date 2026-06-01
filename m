Return-Path: <linuxppc-dev+bounces-21788-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CCCCD6E60
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jun 2026 09:49:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTTgY5VTxz2ysW;
	Mon, 01 Jun 2026 19:48:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780307337;
	cv=none; b=CEd1cTOd+94uYaqh5lP/qYX50R+vnTm1kOhpyedWvDm+kgkApVXmgSRHxb2Orap4kkebfo3FsK93JTXLFnwmPJLawEn10dVgCaX3MH+Xid54AJVgxoIm+HlTxJxTYJqBGc4tFkNGCGpUIXvI+MjLxFBZlpHh/uJgUbQyGf2fP0DgXCm9eCYoJMkcZLmw4H0M2qLnASnG57Q/R7fYNfyzgXwMTCSh83o2aIa9JUoEVm+ZegSydhAjJsJyo8zfUmzrcmPIBaG2oGclx6s/UoZZund8ti3gMOshA5HWHqN34BsER4S99tfCy6lG/wbfsGki/4IMEabT8z3YnM6yK8hB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780307337; c=relaxed/relaxed;
	bh=dtc4/NrtG2M2/NTu9Dfj4w1EdTwFqK3w2EGmJt3YJfk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2QqY/uFNgxPgfmTCLtvaX5k1bvBmkCTyf2acIrv/RIyiEG6Av1ZxH07RaVV35KMMqYqYPsfBwwQ6mltKSnX6Y0C6PZIr/a5aE3/VE5XLsTCkDG2/3lu3YmIMnKQAmBc4jvpWIiBaE7cSAhtev315yUwXl4lofsIj5U84uIrY9l/cph/+IJ+A/eeakgXJrm+NXfl/du3B1RlnVQ76LaNWA6RHVVUu1J01uL8xgBoTrewnmOe8BIFJeUaUIsGW2uEIM44Ln1+nfUgOjGTt4qKpO/cmaPwgp3nAl4dBmia1eZiiqvQdKzbUizSIDxh4yLfuMLK8IZ09xYqGUkHg88JAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=LSORrdH1; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=LSORrdH1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTTgX5Zdyz2ytj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 19:48:56 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dtc4/NrtG2M2/NTu9Dfj4w1EdTwFqK3w2EGmJt3YJfk=;
	b=LSORrdH1lNoFWXXQS9gOPZ3GNVa3ecvXGMA9ld+M6rLgHx2sr5j7Fq2G0Wi2rHMgU+0UGbsOM
	dS8uEqVPnjdLyyFxwclLxewkwC9sqLElnsjtJmnFBkcp9voEWnKOmHq5Vy30shiuwvA3BSKUFr0
	oyz/nZ4BOYaUsS8XJXrrKsw=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gTTVQ4JpJz1prM3;
	Mon,  1 Jun 2026 17:41:02 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id CD07140561;
	Mon,  1 Jun 2026 17:48:53 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 1 Jun
 2026 17:48:49 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <rppt@kernel.org>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <ruirui.yang@linux.dev>,
	<rdunlap@infradead.org>, <feng.tang@linux.alibaba.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<kuba@kernel.org>, <lirongqing@baidu.com>, <ebiggers@kernel.org>,
	<paulmck@kernel.org>, <sourabhjain@linux.ibm.com>, <thuth@redhat.com>,
	<ardb@kernel.org>, <masahiroy@kernel.org>, <gshan@redhat.com>,
	<james.morse@arm.com>, <maz@kernel.org>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <coxu@redhat.com>, <suzuki.poulose@arm.com>,
	<cfsworks@gmail.com>, <osandov@fb.com>, <jbohac@suse.cz>,
	<ryan.roberts@arm.com>, <tangyouling@kylinos.cn>, <ritesh.list@gmail.com>,
	<adityag@linux.ibm.com>, <hbathini@linux.ibm.com>, <bjorn@rivosinc.com>,
	<songshuaishuai@tinylab.org>, <vishal.moola@gmail.com>,
	<junhui.liu@pigmoral.tech>, <djordje.todorovic@htecgroup.com>,
	<austin.kim@lge.com>, <namcao@linutronix.de>, <djbw@kernel.org>,
	<chao.gao@intel.com>, <seanjc@google.com>, <fuqiang.wang@easystack.cn>,
	<liaoyuanhong@vivo.com>, <makb@juniper.net>, <graf@amazon.com>,
	<piliu@redhat.com>, <rafael.j.wysocki@intel.com>,
	<mario.limonciello@amd.com>, <jbouron@amazon.com>, <chenjiahao16@huawei.com>,
	<guoren@kernel.org>, <bauerman@linux.ibm.com>, <bgwin@google.com>,
	<takahiro.akashi@linaro.org>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v15 05/23] powerpc/crash: sort crash memory ranges before preparing elfcorehdr
Date: Mon, 1 Jun 2026 17:47:47 +0800
Message-ID: <20260601094805.2928614-6-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260601094805.2928614-1-ruanjinjie@huawei.com>
References: <20260601094805.2928614-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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
index a520f851c3a6..d634db67becc 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -493,7 +493,7 @@ static void update_crash_elfcorehdr(struct kimage *image, struct memory_notify *
 	struct crash_mem *cmem = NULL;
 	struct kexec_segment *ksegment;
 	void *ptr, *mem, *elfbuf = NULL;
-	unsigned long elfsz, memsz, base_addr, size;
+	unsigned long elfsz, memsz, base_addr, size, end;
 
 	ksegment = &image->segment[image->elfcorehdr_index];
 	mem = (void *) ksegment->mem;
@@ -512,7 +512,8 @@ static void update_crash_elfcorehdr(struct kimage *image, struct memory_notify *
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
index eb45e89502ca..b2fb78562cdc 100644
--- a/arch/powerpc/kexec/ranges.c
+++ b/arch/powerpc/kexec/ranges.c
@@ -551,7 +551,7 @@ int get_usable_memory_ranges(struct crash_mem **mem_ranges)
 #endif /* CONFIG_KEXEC_FILE */
 
 #ifdef CONFIG_CRASH_DUMP
-static int crash_exclude_mem_range_guarded(struct crash_mem **mem_ranges,
+int crash_exclude_mem_range_guarded(struct crash_mem **mem_ranges,
 					   unsigned long long mstart,
 					   unsigned long long mend)
 {
@@ -639,89 +639,4 @@ int get_crash_memory_ranges(struct crash_mem **mem_ranges)
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


