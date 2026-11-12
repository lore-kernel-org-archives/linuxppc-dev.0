Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDA0606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 13:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=NpzGw6+M
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQLx433dDz30dj;
	Fri, 13 Nov 2026 00:35:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794490520;
	cv=none; b=e6OtPb2g4MvymRvVoDMlTqOc5n0e7MyELn60ipBgQWNdjQtOb5fBxfxF52Uoyy68nPxVj54x9QcxD+wDXSgBMtnD9Gvp0qEZx7gE9GV9fyjtJcJx+3HvfyzIrbvQ1gHI6d9vpogZy5jVyhVLSugU2SMl9tEg7Y51SIRex+1r/TxZsCWhIay84YsldbGnoonutxnM98QSMJajah8wYYu7wClBsbQftsbJWBDQi7zogX4W5lgebisa5NxmkqbzEFW8f+tcDO8axB6Y9EO1JLLskxUW0znFHOfs43cUsUE6w00NBpGtKrq9TQwlyKGMjvS3/4fjp+LKrSNL+vd+jodpHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794490520; c=relaxed/relaxed;
	bh=HVSl6b5c2ppW1s1gs/r7uBuxxOLF4+FVkqsE8xMgcNA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L+C2oxAxw9laRO4ncnFK11tI8j2ii7VoQN527QCi8EBqNYog5kCM0gCJI24rEeLB+xaO3lQppN0A63EkI2SvOZJnXfLAPPai8j0T4NE04iW3BjBg/8yDtTwh7A5EibXpp7O3JdiqXsbnOaWqLurYdBMSscAzgpYUSkrMjU4ABhe0tVlfmMq68/NLOROwdR3azTodKs4ZWHawWAQWyXzp2+YW2RkOK3sltBCvZXOk1EftoCSgLOpSQQuYQ6XcBXzt8Iwtd8fXSBDOar4AXMK8CL61EYjcwkKKJpzN2VZ/NTjArQFB05/XjhexNZ43pEo+JPerrsxMTNUK6FdgwmjPmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=NpzGw6+M; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=NpzGw6+M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQLx322fSz30WQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 00:35:18 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HVSl6b5c2ppW1s1gs/r7uBuxxOLF4+FVkqsE8xMgcNA=;
	b=NpzGw6+Maniy/c5MFunJnf7wYcJsTElQBOF11nkTDHOYpouatcIxn5TFiqapwtGxM9OjZyrR1
	TjAEvlfSdFw+Eht4lbqYKdx5cVBPVpmFaS4uJrWbfyerOyiQmo7VA/zEJ3wsz3dYt2x3UKAuBRS
	2WydvfmGfe+/sQQ/ctn39Lw=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4jQLw32kDZzKm5V;
	Thu, 12 Nov 2026 21:34:27 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 1616940586;
	Thu, 12 Nov 2026 21:34:38 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 12 Nov
 2026 21:34:36 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <rppt@kernel.org>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <ruanjinjie@huawei.com>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <mpilaniy@redhat.com>, <robh@kernel.org>,
	<coiby.xu@gmail.com>, <Yeking@Red54.com>, <prudo@redhat.com>,
	<brads@mainlining.org>, <sourabhjain@linux.ibm.com>, <mkchauras@gmail.com>,
	<blum@kernel.org>, <adityag@linux.ibm.com>, <qirui.001@bytedance.com>,
	<hui.wang@canonical.com>, <sohammetha01@gmail.com>, <guoren@kernel.org>,
	<gaohan@iscas.ac.cn>, <ionut.nechita@windriver.com>,
	<vishal.l.verma@intel.com>, <seanjc@google.com>, <ardb@kernel.org>,
	<richard.lyu@suse.com>, <arnd@arndb.de>, <tzimmermann@suse.de>,
	<rick.p.edgecombe@intel.com>, <kai.huang@intel.com>, <kas@kernel.org>,
	<piliu@redhat.com>, <thuth@redhat.com>, <shradhagupta@linux.microsoft.com>,
	<ebiggers@kernel.org>, <jbouron@amazon.com>, <me@linux.beauty>,
	<mclapinski@google.com>, <graf@amazon.com>, <tangyouling@kylinos.cn>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<kexec@lists.infradead.org>
Subject: [PATCH v8 01/11] kexec: Free the elf core header in kimage_file_post_load_cleanup()
Date: Thu, 12 Nov 2026 21:34:08 +0800
Message-ID: <20261112133418.4044428-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261112133418.4044428-1-ruanjinjie@huawei.com>
References: <20261112133418.4044428-1-ruanjinjie@huawei.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The elf core header buffer is generic state, but arm64, LoongArch,
RISC-V, x86 and powerpc each free it in their post-load cleanup.  Move
it into the generic cleanup, which also gives the loader a helper to
release it on error.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/machine_kexec_file.c     | 4 ----
 arch/loongarch/kernel/machine_kexec_file.c | 4 ----
 arch/powerpc/kexec/file_load_64.c          | 4 ----
 arch/riscv/kernel/machine_kexec_file.c     | 4 ----
 arch/x86/kernel/machine_kexec_64.c         | 4 ----
 kernel/kexec_file.c                        | 9 +++++++++
 6 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 14f453dd0946..097ee397e949 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -32,10 +32,6 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	kvfree(image->arch.dtb);
 	image->arch.dtb = NULL;
 
-	vfree(image->elf_headers);
-	image->elf_headers = NULL;
-	image->elf_headers_sz = 0;
-
 	return kexec_image_post_load_cleanup_default(image);
 }
 
diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
index 0fe60907b97f..f16d9ab14726 100644
--- a/arch/loongarch/kernel/machine_kexec_file.c
+++ b/arch/loongarch/kernel/machine_kexec_file.c
@@ -28,10 +28,6 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
 
 int arch_kimage_file_post_load_cleanup(struct kimage *image)
 {
-	vfree(image->elf_headers);
-	image->elf_headers = NULL;
-	image->elf_headers_sz = 0;
-
 	return kexec_image_post_load_cleanup_default(image);
 }
 
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index bd80c5fb1b1f..0cf03cee35a7 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -841,10 +841,6 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	vfree(image->arch.backup_buf);
 	image->arch.backup_buf = NULL;
 
-	vfree(image->elf_headers);
-	image->elf_headers = NULL;
-	image->elf_headers_sz = 0;
-
 	kvfree(image->arch.fdt);
 	image->arch.fdt = NULL;
 
diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
index 26cd2a8bd0cd..1d67fb42617a 100644
--- a/arch/riscv/kernel/machine_kexec_file.c
+++ b/arch/riscv/kernel/machine_kexec_file.c
@@ -29,10 +29,6 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	kvfree(image->arch.fdt);
 	image->arch.fdt = NULL;
 
-	vfree(image->elf_headers);
-	image->elf_headers = NULL;
-	image->elf_headers_sz = 0;
-
 	return kexec_image_post_load_cleanup_default(image);
 }
 
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index c3f4a389992d..0a66cc268ee7 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -600,10 +600,6 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 
 int arch_kimage_file_post_load_cleanup(struct kimage *image)
 {
-	vfree(image->elf_headers);
-	image->elf_headers = NULL;
-	image->elf_headers_sz = 0;
-
 	return kexec_image_post_load_cleanup_default(image);
 }
 #endif /* CONFIG_KEXEC_FILE */
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index b668ce8d68ee..1f128c6e6fa3 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -102,6 +102,13 @@ int kexec_image_post_load_cleanup_default(struct kimage *image)
 	return image->fops->cleanup(image->image_loader_data);
 }
 
+static void kexec_free_elf_headers(struct kimage *image)
+{
+	vfree(image->elf_headers);
+	image->elf_headers = NULL;
+	image->elf_headers_sz = 0;
+}
+
 /*
  * Free up memory used by kernel, initrd, and command line. This is temporary
  * memory allocation which is not needed any more after these buffers have
@@ -120,6 +127,8 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	kfree(image->cmdline_buf);
 	image->cmdline_buf = NULL;
 
+	kexec_free_elf_headers(image);
+
 	vfree(pi->purgatory_buf);
 	pi->purgatory_buf = NULL;
 
-- 
2.34.1


