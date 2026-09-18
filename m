Return-Path: <linuxppc-dev+bounces-27702-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54D6C982DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 10:05:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmSsF2GRRz3bf2;
	Fri, 18 Sep 2026 20:04:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789725872;
	cv=none; b=h1m1TBZUAqvY33WlkkgUDbk5MXZtvd6vHwfL46jXjtXEAvHfh5OCVeQkHdwnRi6hXRCQDVn+ZPmBghf37DeyaipTQayDmOSgX4qS/oAqDFR+owRILjRhN4AUggCAL2QWuUu5J4LpYO0mIPx3B1+isup0XHXKJLIDS5pf65zVk5FpmHjJhWHeNmXUpCB6D4o1irHA2qEmikehHcxgQJA9FkKu4FT3o9cxFizIn7WrobWkLrAEuT2FJPpDpphLeKWjjrGUqP1hB5jfkKVitca04Vgm28G5vtGTvO25OwqXEDtUVqzPaOmfZRkQs+W/GekFyLILzBcNaUZuQQgRv4aLXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789725872; c=relaxed/relaxed;
	bh=QWRwGA8IIWGqEmgXFHVo35ysA7ES/LPOJVNWp6AUBps=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n5ZFNEsJN2OxqJAaH0huZXDp84o+qf1ZokwPSs7sjlGYr58PA5PWyIg/6H2S0JuHeBcMDqqA7dd/F1CL6I8n3/g+Kg/jegarTInog/S89jsiEYumUIOQjLFkUys641EvH1M0ngFlVMhnuyIklpc9hdiRSUYoWVuLuUb7R7GO+jVH7PCYRNeNO49hemy/147VPtQl1GnNyveUwV8XfB7FthdYA2xvNTtwjYAOfq3eOBojERbyJs3BPSEKkKSeKdFyUpoinJf7Ts/BA5lD+uDE4+eHnxv9EmJMOJTbNEkZNGU1W5S6qKCxD7zVsgGVGIxmmb8XhUvLaMafTOAgWAWdiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=zvyDPHtM; dkim-atps=neutral; spf=pass (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=zvyDPHtM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmSs83czjz30VM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 20:04:28 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QWRwGA8IIWGqEmgXFHVo35ysA7ES/LPOJVNWp6AUBps=;
	b=zvyDPHtMXrIlKFMijCNSGV93POHhDpPEWLDf6NcDHeY4LQlngXcrut7XT/+zJayfwCPKA+CjB
	rIjWb7CcBTXVBn1eLuOcyP5UPmoRPnG64cslN+lcdwQdBUwDiDN+pGdNJR2HL+wQjqIhN5D0E/5
	lx7RD09w72DQURnUsPZ6Wmk=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hmSbS0pcszpSyG;
	Fri, 18 Sep 2026 17:52:36 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 36D4240572;
	Fri, 18 Sep 2026 18:04:25 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 18:04:23 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <kees@kernel.org>, <thuth@redhat.com>,
	<ruanjinjie@huawei.com>, <gshan@redhat.com>, <ardb@kernel.org>,
	<james.morse@arm.com>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<sourabhjain@linux.ibm.com>, <robh@kernel.org>, <coxu@redhat.com>,
	<tangyouling@kylinos.cn>, <liukexin@kylinos.cn>, <guodongtai@kylinos.cn>,
	<maqianga@uniontech.com>, <zhangtianyang@loongson.cn>, <blum@kernel.org>,
	<adityag@linux.ibm.com>, <chao.gao@intel.com>, <kas@kernel.org>,
	<vishal.l.verma@intel.com>, <seanjc@google.com>, <piliu@redhat.com>,
	<jbouron@amazon.com>, <me@linux.beauty>, <mclapinski@google.com>,
	<graf@amazon.com>, <bgwin@google.com>, <eric.devolder@oracle.com>,
	<hbathini@linux.ibm.com>, <takahiro.akashi@linaro.org>,
	<lizhengyu3@huawei.com>, <palmer@rivosinc.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<driver-core@lists.linux.dev>, <kexec@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v5 11/17] crash: Normalize the kexec_load elfcorehdr at load time
Date: Fri, 18 Sep 2026 18:04:36 +0800
Message-ID: <20260918100442.3841135-12-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918100442.3841135-1-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
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
 kwepemk200008.china.huawei.com (7.202.194.74)

For kexec_load() the kernel does not build the elfcorehdr, so it is only
rewritten by the first crash hotplug event.  CPU hotplug events do not
change the elfcorehdr, but they may run without device_hotplug_lock
(e.g. CPU offlining during suspend), so they cannot perform that rewrite
without racing with memory hotplug.

Normalize the elfcorehdr once when the crash image is installed, while
device_hotplug_lock can still be taken safely, and let the hotplug paths
skip CPU events entirely.

The elfcorehdr segment is located by scanning the segments for the ELF
magic.  Factor that scan out into crash_find_elfcorehdr() and reuse it
from crash_handle_hotplug_event().  Architectures that do not need the
rewrite (e.g. powerpc) treat KEXEC_CRASH_HP_NONE as a no-op.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/powerpc/kexec/crash.c |  1 +
 arch/x86/kernel/crash.c    |  5 ++--
 include/linux/crash_core.h |  1 +
 kernel/crash_core.c        | 58 +++++++++++++++++++++++++++-----------
 kernel/kexec.c             |  4 +++
 5 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
index 775895f31037..8ede33740fc0 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -638,6 +638,7 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 	struct memory_notify *mn;
 
 	switch (image->hp_action) {
+	case KEXEC_CRASH_HP_NONE:
 	case KEXEC_CRASH_HP_REMOVE_CPU:
 		return;
 
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 3c9f4fbbe7ff..f34fa8dba028 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -457,9 +457,8 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 	 * possible CPUs, there is no need to update the elfcorehdr
 	 * for additional CPU changes.
 	 */
-	if ((image->file_mode || image->elfcorehdr_updated) &&
-		((image->hp_action == KEXEC_CRASH_HP_ADD_CPU) ||
-		(image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU)))
+	if (image->hp_action == KEXEC_CRASH_HP_ADD_CPU ||
+	    image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
 		return;
 
 	/*
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index b1c816e98143..a740757dff35 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -39,6 +39,7 @@ static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *a
 #endif
 
 int crash_check_hotplug_support(void);
+void crash_hotplug_prepare_elfcorehdr(struct kimage *image);
 
 #ifndef arch_crash_hotplug_support
 static inline int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags)
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 406b68d2adfd..47a4579eb97e 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -647,6 +647,28 @@ int crash_check_hotplug_support(void)
 	return rc;
 }
 
+static void crash_find_elfcorehdr(struct kimage *image)
+{
+	unsigned char *ptr;
+	unsigned long mem;
+	unsigned int n;
+
+	if (image->elfcorehdr_index >= 0)
+		return;
+
+	for (n = 0; n < image->nr_segments; n++) {
+		mem = image->segment[n].mem;
+		ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+		if (!ptr)
+			continue;
+
+		/* The segment containing elfcorehdr */
+		if (memcmp(ptr, ELFMAG, SELFMAG) == 0)
+			image->elfcorehdr_index = (int)n;
+		kunmap_local(ptr);
+	}
+}
+
 /*
  * To accurately reflect hot un/plug changes of CPU and Memory resources
  * (including onling and offlining of those resources), the relevant
@@ -702,22 +724,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
 	 * is allocated. Find the segment containing the elfcorehdr,
 	 * if not already found.
 	 */
-	if (image->elfcorehdr_index < 0) {
-		unsigned long mem;
-		unsigned char *ptr;
-		unsigned int n;
-
-		for (n = 0; n < image->nr_segments; n++) {
-			mem = image->segment[n].mem;
-			ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
-			if (ptr) {
-				/* The segment containing elfcorehdr */
-				if (memcmp(ptr, ELFMAG, SELFMAG) == 0)
-					image->elfcorehdr_index = (int)n;
-				kunmap_local(ptr);
-			}
-		}
-	}
+	crash_find_elfcorehdr(image);
 
 	if (image->elfcorehdr_index < 0) {
 		pr_err("unable to locate elfcorehdr segment");
@@ -747,6 +754,25 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
 	crash_hotplug_unlock();
 }
 
+void crash_hotplug_prepare_elfcorehdr(struct kimage *image)
+{
+	if (!image || !image->hotplug_support || image->file_mode)
+		return;
+
+	crash_find_elfcorehdr(image);
+	if (image->elfcorehdr_index < 0)
+		return;
+
+	/*
+	 * kexec_load() images are not normalized at load, so do it here while
+	 * the lock is still free to take.  hp_action is KEXEC_CRASH_HP_NONE,
+	 * which the arch handler treats as "just rebuild the elfcorehdr".
+	 */
+	lock_device_hotplug();
+	arch_crash_handle_hotplug_event(image, NULL);
+	unlock_device_hotplug();
+}
+
 static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *arg)
 {
 	switch (val) {
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 90756dc6339b..ea9ba00bc786 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -166,6 +166,10 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	/* Install the new kernel and uninstall the old */
 	image = xchg(dest_image, image);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	if ((flags & KEXEC_ON_CRASH) && kexec_crash_image)
+		crash_hotplug_prepare_elfcorehdr(kexec_crash_image);
+#endif
 out:
 #ifdef CONFIG_CRASH_DUMP
 	if ((flags & KEXEC_ON_CRASH) && kexec_crash_image)
-- 
2.34.1


