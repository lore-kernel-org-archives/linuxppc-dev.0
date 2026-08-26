Return-Path: <linuxppc-dev+bounces-26104-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE23C5DF97
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2026 09:26:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVK502xxFz3c1w;
	Wed, 26 Aug 2026 19:25:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.225
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787736340;
	cv=none; b=Vw5IVUMl0nRVQKCHWsZaA+ij54R3u+Qjl4ym8GDrh0L8Qgk5cnrqO2SKhDcxUsGweRW6jf9ZuNtSDsl02/oW/FgRrF8Oiej0dz0Y/tPe/Voa8OPeowx92/y1zkgEH9DyN1fuzGSsp3Jzelwe8Fy2DLcwd1BnFDE+noW5AAoHFZswEuhiDMRBWsn53i1qwOPeIjW04j+Uph3jfWiFbzgFgZ7ld8PA7kwuoPADuf1rAxotyGxmzeGlSrj/fURKMrp2tEcEcUtHX3r0VxaatQKSy/cNXdsyW8cLQjvCsDoxMrd/npdCdQnmhluWq1tXLf1moqIW/p9N6Gs0cud3j9B2XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787736340; c=relaxed/relaxed;
	bh=KafofVQEPWxjkKkXavgX1N/QAvKy21rncyT7kiECYKY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VoPBDt+jONk0AZoHUwg/ceYQOgF9UWWIp6HUY0UfCwqLSy1MamnK3DmnrKDbpiEd0dSpt8Y1eIeEUAIkHOsyu8v8K3QgpSnROntQ4qryP9D+M/ogQl/bPD+/v+Dtz7fkBWlB00qsh2MgsYQlQmH3bu+ChUEBzk/AVh2sJsk1mhtYnzn+gn3H4UB6uazCK7oS7ExOdrB6auzmbkgW56y6LJHa75yo6kFUmgIzg9JftGXg9tdNA7Qq+EI8PCrzCtu8n7yRuaIryeSV4pjOER5xzYr0dco49Gtb6n+VSBG5e52wclYjWT+k2/1xw2qmCQzUeSDx35DrIW/Q/wkYS46L4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ZJrMcXmw; dkim-atps=neutral; spf=pass (client-ip=113.46.200.225; helo=canpmsgout10.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ZJrMcXmw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.225; helo=canpmsgout10.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVK4z0nGLz2yfH
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2026 19:25:39 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=KafofVQEPWxjkKkXavgX1N/QAvKy21rncyT7kiECYKY=;
	b=ZJrMcXmwPlgzadHtphWXfa6syHPyy8XhgReWZ7UmfF+ftCT3E/BT8h8jt/WPwO9Gl7FX0Gdce
	FpBge1xJOiNT4y51fY4AFonznIyQJqB8mR//FJpoYo4ihkvBHHjsaciISJu+jrSzckYhIAuxH6G
	okgGEcDZkqcaw6iUFcDeVKY=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4hVJrQ6Fxpz1K96b;
	Wed, 26 Aug 2026 17:14:46 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id A22634057C;
	Wed, 26 Aug 2026 17:25:32 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 26 Aug
 2026 17:25:30 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <rppt@kernel.org>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <ruirui.yang@linux.dev>, <kees@kernel.org>,
	<thuth@redhat.com>, <gshan@redhat.com>, <jic23@kernel.org>,
	<james.morse@arm.com>, <ardb@kernel.org>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <sourabhjain@linux.ibm.com>, <coxu@redhat.com>,
	<tangyouling@kylinos.cn>, <hbathini@linux.ibm.com>, <adityag@linux.ibm.com>,
	<ionut.nechita@windriver.com>, <liaoyuanhong@vivo.com>, <seanjc@google.com>,
	<fuqiang.wang@easystack.cn>, <makb@juniper.net>, <piliu@redhat.com>,
	<ebiggers@kernel.org>, <jbouron@amazon.com>, <mclapinski@google.com>,
	<me@linux.beauty>, <graf@amazon.com>, <bgwin@google.com>, <robh@kernel.org>,
	<takahiro.akashi@linaro.org>, <palmer@rivosinc.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v3 10/17] elf: Introduce elf64_phdr_size() helper
Date: Wed, 26 Aug 2026 17:25:34 +0800
Message-ID: <20260826092541.3905933-11-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826092541.3905933-1-ruanjinjie@huawei.com>
References: <20260826092541.3905933-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Add a common helper to compute the total size of an ELF64 header
(Ehdr + program headers) from the number of program headers.
Replace open-coded calculations in powerpc, x86, vmcore,
and crash_core.

On ppc64, struct elfhdr maps to elf64_hdr, so the powerpc change
is a pure cleanup.

No functional change intended.

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Dave Young <ruirui.yang@linux.dev>
Cc: Kees Cook <kees@kernel.org>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/powerpc/kexec/crash.c                 | 2 +-
 arch/powerpc/platforms/powernv/opal-core.c | 3 +--
 arch/x86/kernel/crash.c                    | 3 +--
 fs/proc/vmcore.c                           | 6 ++----
 include/linux/elf.h                        | 4 ++++
 kernel/crash_core.c                        | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
index 775895f31037..fc0105c7af4c 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -478,7 +478,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
 	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		phdr_cnt += CONFIG_CRASH_MAX_MEMORY_RANGES;
 
-	return sizeof(struct elfhdr) + (phdr_cnt * sizeof(Elf64_Phdr));
+	return elf64_phdr_size(phdr_cnt);
 }
 
 /**
diff --git a/arch/powerpc/platforms/powernv/opal-core.c b/arch/powerpc/platforms/powernv/opal-core.c
index 32662d30d70f..fc0aad61504b 100644
--- a/arch/powerpc/platforms/powernv/opal-core.c
+++ b/arch/powerpc/platforms/powernv/opal-core.c
@@ -309,8 +309,7 @@ static int __init create_opalcore(void)
 	char *bufp;
 
 	/* Get size of header & CPU notes for OPAL core */
-	hdr_size = (sizeof(Elf64_Ehdr) +
-		    ((oc_conf->ptload_cnt + 1) * sizeof(Elf64_Phdr)));
+	hdr_size = elf64_phdr_size(oc_conf->ptload_cnt + 1);
 	cpu_notes_size = ((oc_conf->num_cpus * (CRASH_CORE_NOTE_HEAD_BYTES +
 			  CRASH_CORE_NOTE_NAME_BYTES +
 			  CRASH_CORE_NOTE_DESC_BYTES)) +
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 8f8c0e592849..a3bf786286d4 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -374,8 +374,7 @@ int crash_load_segments(struct kimage *image)
 		pnum += 2 + CONFIG_NR_CPUS;
 
 	if (pnum < (unsigned long)PN_XNUM) {
-		kbuf.memsz = pnum * sizeof(Elf64_Phdr);
-		kbuf.memsz += sizeof(Elf64_Ehdr);
+		kbuf.memsz = elf64_phdr_size(pnum);
 
 		image->elfcorehdr_index = image->nr_segments;
 
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 44d15436439f..ff324969d798 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1238,8 +1238,7 @@ static int __init parse_crash_elf64_headers(void)
 	}
 
 	/* Read in all elf headers. */
-	elfcorebuf_sz_orig = sizeof(Elf64_Ehdr) +
-				ehdr.e_phnum * sizeof(Elf64_Phdr);
+	elfcorebuf_sz_orig = elf64_phdr_size(ehdr.e_phnum);
 	elfcorebuf_sz = elfcorebuf_sz_orig;
 	elfcorebuf = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
 					      get_order(elfcorebuf_sz_orig));
@@ -1605,8 +1604,7 @@ static int vmcore_add_device_ram_elf64(struct list_head *list, size_t count)
 	}
 
 	/* elfcorebuf_sz must always cover full pages. */
-	new_size = sizeof(Elf64_Ehdr) +
-		   (ehdr->e_phnum + count) * sizeof(Elf64_Phdr);
+	new_size = elf64_phdr_size(ehdr->e_phnum + count);
 	new_size = roundup(new_size, PAGE_SIZE);
 
 	/*
diff --git a/include/linux/elf.h b/include/linux/elf.h
index 5c402788da19..400f58a13d92 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -109,4 +109,8 @@ static inline int arch_elf_adjust_prot(int prot,
 }
 #endif
 
+static inline unsigned long elf64_phdr_size(unsigned long phdr_cnt)
+{
+	return phdr_cnt * sizeof(Elf64_Phdr) + sizeof(Elf64_Ehdr);
+}
 #endif /* _LINUX_ELF_H */
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 05a2a8be083d..bd3f82b62751 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -193,7 +193,7 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 	 */
 
 	nr_phdr++;
-	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
+	elf_sz = elf64_phdr_size(nr_phdr);
 	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
 
 	buf = vzalloc(elf_sz);
-- 
2.34.1


