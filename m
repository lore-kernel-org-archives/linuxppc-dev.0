Return-Path: <linuxppc-dev+bounces-27709-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D9FC982DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 10:06:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmSsP0Tsqz3cH4;
	Fri, 18 Sep 2026 20:04:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789725881;
	cv=none; b=GX21Lc53OEvXlOTMANx7sMH3qYTrll/1p/hAa/yUhY2wjV5IoXBCiIQjgSGXHiqu6LWNeJhHObve+eKeua1zm/RovDhwyV9wqaW/hNY352abmtbIKpANAiUwqOCl741JXQtTNfC2XUCWksBWEksifNCIyHhZ04TL9dduupoloPTmWkHq5PaFOVr2EB0lS/EnU+8zQCh+d8pJ1zLgyTfjPFjeM20XemE5T0KziDzTEh3hqUmTeYyJpPRulLxsXbvP1BFpk4U3k8v1rLVRPFyAK+K5SL00ieE2ItekK/Il9IydtD7famCHKNvHwd0uJ+gI4k3sWSuddJZVfn4H4mQl9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789725881; c=relaxed/relaxed;
	bh=xY6MkLtAML0NhdwFhEh6HEFrtMWS+BaF8Jv6SYbylCI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nljhWXgLpFcP23sinzHxnNLVW/g98SRBLBIpyo3IOHqA5oe70ySuMfdHcHbDFXUfEh1y98ZQzpzkgyFPNACkvGAInU+XO0Py6t+HXzhbQOm8lEAzBk/5gtjad65T2wWqrMr79yWL0I61tIqk5v8KZNB2yvP9zAOeg0+cjl/BF8xWgWWh/nwchSvHz7/P1ZvjfhXKr9m/d2/kEwPLQAqdUyDqDofXaLmtlbHkaIh5Li9j0DNVVVWSzHIDkyG+Q61AVS7T1QkcZKxzlP/i9gZRsHU6zINqnGTLpABcNmWr+eGx3CY7PimDYWctp/56y0k2BQIjVTERRfBjfetFsw4Dwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=C2eZF9Mr; dkim-atps=neutral; spf=pass (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=C2eZF9Mr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmSsN0KRpz3cFq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 20:04:39 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xY6MkLtAML0NhdwFhEh6HEFrtMWS+BaF8Jv6SYbylCI=;
	b=C2eZF9MriTz09Fyd6sSJRN6eb3mHxLBMVzS2eueaGbQwfruJTStfHmzacHg2EphpPC7IEogVN
	vKy7HEOXjk8HJKqpXYqJT2TzYh11n9eTIQIYH9HAE08ba7TuLwPVwJITDWlXJ6ajgI17Ju7r/zg
	o/XgABw9N1BRe9NbOBaj9iM=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hmScM61twz12LHv;
	Fri, 18 Sep 2026 17:53:23 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id CF0FE20333;
	Fri, 18 Sep 2026 18:04:30 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 18:04:29 +0800
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
Subject: [PATCH v5 15/17] crash: Introduce crash_extra_elfcorehdr_size() helper
Date: Fri, 18 Sep 2026 18:04:40 +0800
Message-ID: <20260918100442.3841135-16-ruanjinjie@huawei.com>
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

Extract the elfcorehdr extra space calculation from powerpc into a
generic helper crash_extra_elfcorehdr_size() for use by other
architectures like arm64.

Strengthen the original powerpc check: instead of only checking
the loose CONFIG_CRASH_MAX_MEMORY_RANGES, the new helper enforces
a strict compile-time BUILD_BUG_ON() to guarantee that the absolute
maximum theoretical number of ELF Program Headers will never exceed
the ELF physical limit of PN_XNUM. This ensures absolute safety across
all architectures with zero runtime overhead.

The helper also provides a zero-size stub when crash memory hotplug
is disabled.

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Dave Young <ruirui.yang@linux.dev>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/powerpc/kexec/file_load_64.c | 15 +--------------
 include/linux/crash_core.h        | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index bd80c5fb1b1f..d3512c85ea83 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -374,19 +374,6 @@ static int load_backup_segment(struct kimage *image, struct kexec_buf *kbuf)
 	return 0;
 }
 
-static unsigned int kdump_extra_elfcorehdr_size(struct crash_mem *cmem)
-{
-#if defined(CONFIG_CRASH_HOTPLUG) && defined(CONFIG_MEMORY_HOTPLUG)
-	if (CONFIG_CRASH_MAX_MEMORY_RANGES > (unsigned int)PN_XNUM)
-		pr_warn("Number of Phdrs %u exceeds max\n", CONFIG_CRASH_MAX_MEMORY_RANGES);
-	else if (cmem->nr_ranges >= CONFIG_CRASH_MAX_MEMORY_RANGES)
-		pr_warn("Configured crash mem ranges may not be enough\n");
-	else
-		return (CONFIG_CRASH_MAX_MEMORY_RANGES - cmem->nr_ranges) * sizeof(Elf64_Phdr);
-#endif
-	return 0;
-}
-
 /**
  * load_elfcorehdr_segment - Setup crash memory ranges and initialize elfcorehdr
  *                           segment needed to load kdump kernel.
@@ -424,7 +411,7 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
 	 * Account for extra space required to accommodate additional memory
 	 * ranges in elfcorehdr due to memory hotplug events.
 	 */
-	kbuf->memsz = headers_sz + kdump_extra_elfcorehdr_size(cmem);
+	kbuf->memsz = headers_sz + crash_extra_elfcorehdr_size(cmem->nr_ranges);
 	kbuf->top_down = false;
 
 	ret = kexec_add_buffer(kbuf);
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 1296a9b29974..aee2449f343b 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -107,4 +107,24 @@ ssize_t dm_crypt_keys_read(char *buf, size_t count, u64 *ppos);
 static inline int crash_load_dm_crypt_keys(struct kimage *image) {return 0; }
 #endif
 
+#if defined(CONFIG_CRASH_HOTPLUG) && defined(CONFIG_MEMORY_HOTPLUG)
+static inline unsigned int crash_extra_elfcorehdr_size(unsigned int nr_mem_ranges)
+{
+	BUILD_BUG_ON((2 + CONFIG_NR_CPUS + CONFIG_CRASH_MAX_MEMORY_RANGES) >=
+		     (unsigned int)PN_XNUM);
+
+	if (nr_mem_ranges >= CONFIG_CRASH_MAX_MEMORY_RANGES) {
+		pr_warn_once("Configured crash mem ranges may not be enough\n");
+		return 0;
+	}
+
+	return (CONFIG_CRASH_MAX_MEMORY_RANGES - nr_mem_ranges) * sizeof(Elf64_Phdr);
+}
+#else
+static inline unsigned int crash_extra_elfcorehdr_size(unsigned int nr_mem_ranges)
+{
+	return 0;
+}
+#endif
+
 #endif /* LINUX_CRASH_CORE_H */
-- 
2.34.1


