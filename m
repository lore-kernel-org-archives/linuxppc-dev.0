Return-Path: <linuxppc-dev+bounces-27703-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D5EC982DC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 10:05:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmSsF5LJ1z3bfV;
	Fri, 18 Sep 2026 20:04:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789725873;
	cv=none; b=k7UYukntCRzOdrOgY/+kT9aLp03EgAX1JK8cCSBzitgrcwBkp/5NkQbn/0r4Yubb5XaciIUKBrRUg1q+WSmxOBq0Q1G2dEpgBhxaqW9UMuhOYHQMByiP+I2RzAjHsUNKyMz1yLOJiQQWsBCYIJJbOfKIcN+TVbwfx8hPm+LjjcuVdf/SQGF75vl6pidXX0fraUXQ/1Aa+JIJ58uRJep8e1265u9Yw/ZWdwTdSx020Ehl+RDH9IyESUMZfP/FSsLozVldKUernjrwUipzRyuu2bfrWaO4+aOm1EcBiX0whE/S22GQSsMHu9tDGujkc3mMYFiNoBog8m/UyA5Qeo92zg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789725873; c=relaxed/relaxed;
	bh=gl9dOVAVG56ScS9MwUOL4momh5UtqrFy6pN1ShFcuZM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5yS6u4LyEUD+MdgOFNzRQOpH2+vVI4YyXwF5GzSTe8mKa1OcrgwXzCb25Hhr566gk3EtSGS8VDxK6rw5utZe/wSk/4JllMFgxPe8pULknr6kbZTjcM7g+8CvuLokcU70GP3akIrpZjGSfyYAndTvRUFGgidNUMxKacbtcbYTYN6uetRJZczfusp2Pvg4NypqWvaSJC5Vf2hNoFEmrNTPrrZoXXvoAmmXmU0mdGSvxJnbStCLNDhSCTDn+lxWsffHvNV+yc1Q7ZzsM0E7r0MYFSVnUDuLUiOVyZ54AItrD406gqrAEFnCGuAlJUAistQet6lZrgO40keYb6qHcEHtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=wVs/Hs9G; dkim-atps=neutral; spf=pass (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=wVs/Hs9G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmSsB0fjXz30YZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 20:04:30 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gl9dOVAVG56ScS9MwUOL4momh5UtqrFy6pN1ShFcuZM=;
	b=wVs/Hs9Gq6VG/cWAMpWvzJmy/oIAMsdmFRrHLaMN8dhT/208NNm+Jy57C8JdLMxP37J0PUlpB
	GvTnqbaNF3Y1buLGfFQc0tAbMgmC9XUKdLppSMLKPgLCRodGAQm9QZNfIEVZADGVfpSUfrMTgAo
	355Yjh2Bx4bZrE0WgEv0YQ0=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4hmScL1T4gzmVWY;
	Fri, 18 Sep 2026 17:53:22 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 492124048B;
	Fri, 18 Sep 2026 18:04:22 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 18:04:20 +0800
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
Subject: [PATCH v5 09/17] x86/crash: Fix massive out-of-bounds write on 32-bit Highmem
Date: Fri, 18 Sep 2026 18:04:34 +0800
Message-ID: <20260918100442.3841135-10-ruanjinjie@huawei.com>
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

On 32-bit x86 systems with HIGHMEM, kmap_local_page() only maps a single
4KB page. However, the elfcorehdr segment can span several pages (up to
hundreds of kilobytes).

The original code blindly copies 'elfsz' bytes at once via
memcpy_flushcache(), overwriting adjacent fixmap entries or critical
virtual addresses.

Fix this by copying the new elfcorehdr page by page.

Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Chao Gao <chao.gao@intel.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Eric DeVolder <eric.devolder@oracle.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: stable@vger.kernel.org
Fixes: ea53ad9cf73b ("x86/crash: add x86 crash hotplug support")
Link: https://sashiko.dev/#/patchset/20260907125404.922123-1-ruanjinjie%40huawei.com
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/x86/kernel/crash.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index e681ec9cf1dc..3c9f4fbbe7ff 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -447,9 +447,10 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
  */
 void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 {
-	void *elfbuf = NULL, *old_elfcorehdr;
 	unsigned long mem, memsz;
 	unsigned long elfsz = 0;
+	void *elfbuf = NULL;
+	unsigned long done;
 
 	/*
 	 * As crash_prepare_elf64_headers() has already described all
@@ -484,21 +485,20 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 
 	/*
 	 * Copy new elfcorehdr over the old elfcorehdr at destination.
-	 */
-	old_elfcorehdr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
-	if (!old_elfcorehdr) {
-		pr_err("mapping elfcorehdr segment failed\n");
-		goto out;
-	}
-
-	/*
-	 * Temporarily invalidate the crash image while the
-	 * elfcorehdr is updated.
+	 * The segment is physically contiguous but can span several pages.
+	 * On 32-bit Highmem architectures, kmap_local_page() maps only a
+	 * single page at a time, so copy page by page.
 	 */
 	xchg(&kexec_crash_image, NULL);
-	memcpy_flushcache(old_elfcorehdr, elfbuf, elfsz);
+	for (done = 0; done < elfsz; ) {
+		size_t chunk = min_t(size_t, PAGE_SIZE, elfsz - done);
+		void *dst = kmap_local_page(pfn_to_page((mem + done) >> PAGE_SHIFT));
+
+		memcpy_flushcache(dst, elfbuf + done, chunk);
+		kunmap_local(dst);
+		done += chunk;
+	}
 	xchg(&kexec_crash_image, image);
-	kunmap_local(old_elfcorehdr);
 	pr_debug("updated elfcorehdr\n");
 
 out:
-- 
2.34.1


