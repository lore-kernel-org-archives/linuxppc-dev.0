Return-Path: <linuxppc-dev+bounces-17456-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2F9FEE4F5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Feb 2026 18:48:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fNZ2n3ZyNz30BR;
	Sun, 01 Mar 2026 05:48:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772304497;
	cv=none; b=FO70muDPN1w2GDI+V8o7odq7xn840zQ6N7MUxM4E7WHod7/adJCzTiU3GsP4h9NeqX9n6ByF9IWh4pvpki6Mr4jLdB+BlnLTgGdew2+DHeu6u3EmktX9PiwWDOt42ToJIr2UqvFCOHw7t33uc0p9nnFTy5Ob4dW3Q2+Qer+lErzYhqZrKbl+vZgKOf4CryOl1k3UMPTVShq7dTVVtCCGCabuYYT+CcCDN1RrbLz18Y8cKrZo3dxGQSiCwKXwSu/Ag1M8/3XqbYoVUgYxnYzuPC91vYC2BXIigNepoPNO+zdkaASGahGjleSOghoteSHxcGW1qJBUoy3EcKk5pnlyrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772304497; c=relaxed/relaxed;
	bh=H74amec8CzfoXlkOB0wYAzjTcma3Xj5McSUr/wEvuqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=epcN+BOx1DzYtyOdU64IFNs5s9EbFgMGVcgWtDtS5HXaztZk+t5ctU4zF5FE3ydIVAAUqQttYjAhDUkDaPxwxW77w5t4o/yCGokTjQZblLV3CwuOzO8BrGFnyz2O5uqRjSlQQ4KvYzwGIgPt17jJ7uhSY8OP29MzZNG5Hsod3epAyyi8WVaypLq1oAi9G8T1a23nEXDz4C5Pv78Ii2+ZSIZV4ote+ELq/8vUghkQqU77ElvSAl2gVyj9z5JyevdKD25ipaUKEIuMtKcPEcUUgiOb887L09Ov2ToUlG0wz+GzlQ7ZNmFkegMWh0sc6hY15VlfWpbrqxj9CBIHGomlQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RDJG2oL3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RDJG2oL3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fNZ2m5KcKz2xjh
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Mar 2026 05:48:15 +1100 (AEDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2ad617d5b80so20642785ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2026 10:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772304493; x=1772909293; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H74amec8CzfoXlkOB0wYAzjTcma3Xj5McSUr/wEvuqA=;
        b=RDJG2oL3QUJyDZhRNMuWVj5Dw/+TmlBhzX5i8ONtG0qTYxjUy+hx86VrM+d/HLYy8B
         1Z5ziU1pC8ntUZdqulg9M/OA1nb6KW/FCj5JS5DS5WtGqoSQC2mrZBFO5kkN1eTtQ9RH
         rdRs5wWMIEFfMUzPbBFFXSUmTchA5JTdcZm+AxQSezNjLOdBcr9LNQtnFefEHxMTPsxf
         aj9Flbj5wBXaaw0BYppeTt25yVHpeiHX5Ik2oiUU+dEit+OBEpEtm8eHGUL+/2Tuj6d+
         UQT/Mnu8plRrH4SSN5ajSVy7X3QRzJ4NDDoMPLmY2QIhboTkNQFZe7C0HnEzDlcjfD/2
         0w0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772304493; x=1772909293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H74amec8CzfoXlkOB0wYAzjTcma3Xj5McSUr/wEvuqA=;
        b=vHjppWnWZ/woiTs9LXvJfUO+scwFbALsE7K3RGnwMMreXjAcbdewEnILhPcE5dI174
         yysE9YoOkZbsXTHPYklXMxVIMx4yahLiOtwYl4HejEXaRu18Y790Nc0znmF5JunuM8+Y
         /4xwmL2WhI9kmjs8elY+U3VQU7HBtKMM3UEt+TAMKxlUyEZ6jPSWX6FV5F4R3uzhtcCp
         bM1fNWvzSogCrLgHUfmLA78wjuBIjxYCLfPWcbg9LHPEeNBO+HU+/J7m54S3Ih2gpzi4
         a8+gz3/9W5mETi7iJ0yCW1/M1EXA7VRKTF0lcsWaXi7K7aQeIMo9XuoEMPFFxDHuQPYJ
         M7Mg==
X-Gm-Message-State: AOJu0Yyzazj4l9nAFTKoh3gOz638M2KO2V0RSmTFzoUNkZZEvqm3mKuK
	3a1r2hAQnZSf//9Q6U5t7g970sNTUNuYza2nXBHsEEmdx1E5WEHOhyXm6fMlgw==
X-Gm-Gg: ATEYQzxuu0bQQvADyrpEiYJ5wHkDSZXkKi3boPqACvFUYQkivyE0gURFmM7NuYhGHOD
	lhaib+rXc/YBBgQqOvgKJAzNB96oyMyV9o7t2S5sb3/FQSbFQgdxDCoF0khggXRgnfVHGlFf6MR
	kT3D1/bKNlR1vZbEU+C7Dwvf5WEJyyPCbbZ9BYOdEgXtBAvb5Qayu7C4jcD8+GNOkmwld3zXOmP
	4ispc5VExe2ZX98OKISmZwPgvYi3+ETpil5SSk0K1nYa6gZCj0uxJCBKs/bWY34BzsYEViZHNOu
	LbU26UUK2rYxuWRQdEpDv/OV9UCegvlQUDlL+8i8hzg6SiRhkV38MDqDM8xoL7nSax2aMFFX0cR
	TupD1RFJcZiibHN+6DNnZkjKmPCypfgS6lslB1jkoJ0cm3EEGGvyvOjasrn5UHUFl0Nr0YuB6LW
	88J5w5k95lbKw276CVYJuqkJ1lZpIiSg==
X-Received: by 2002:a17:902:cec2:b0:2ad:9326:3c3d with SMTP id d9443c01a7336-2ae2e4e2dbfmr73522225ad.54.1772304492646;
        Sat, 28 Feb 2026 10:48:12 -0800 (PST)
Received: from dw-tp.ibmuc.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69f996sm89975365ad.50.2026.02.28.10.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 10:48:12 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Donet Tom <donettom@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH] powerpc/mem: Move CMA reservations to arch_mm_preinit
Date: Sun,  1 Mar 2026 00:17:59 +0530
Message-ID: <6e532cf0db5be99afbe20eed699163d5e86cd71f.1772303986.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.53.0
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

commit 4267739cabb8 ("arch, mm: consolidate initialization of SPARSE memory model"),
changed the initialization order of "pageblock_order" from...
start_kernel()
    - setup_arch()
       - initmem_init()
         - sparse_init()
           - set_pageblock_order();  // this sets the pageblock_order
       - xxx_cma_reserve();

to...
start_kernel()
    - setup_arch()
       - xxx_cma_reserve();
    - mm_core_init_early()
       - free_area_init()
          - sparse_init()
             - set_pageblock_order() // this sets the pageblock_order.

So this means, pageblock_order is not initialized before these cma
reservation function calls, hence we are seeing CMA failures like...

[    0.000000] kvm_cma_reserve: reserving 3276 MiB for global area
[    0.000000] cma: pageblock_order not yet initialized. Called during early boot?
[    0.000000] cma: Failed to reserve 3276 MiB
....
[    0.000000][    T0] cma: pageblock_order not yet initialized. Called during early boot?
[    0.000000][    T0] cma: Failed to reserve 1024 MiB

This patch moves these CMA reservations to arch_mm_preinit() which
happens in mm_core_init() (which happens after pageblock_order is
initialized), but before the memblock moves the free memory to buddy.

Fixes: 4267739cabb8 ("arch, mm: consolidate initialization of SPARSE memory model")
Suggested-by: Mike Rapoport <rppt@kernel.org>
Reported-and-tested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Closes: https://lore.kernel.org/linuxppc-dev/4c338a29-d190-44f3-8874-6cfa0a031f0b@linux.ibm.com/
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kernel/setup-common.c | 10 ----------
 arch/powerpc/mm/mem.c              | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index cb5b73adc250..b1761909c23f 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -35,7 +35,6 @@
 #include <linux/of_irq.h>
 #include <linux/hugetlb.h>
 #include <linux/pgtable.h>
-#include <asm/kexec.h>
 #include <asm/io.h>
 #include <asm/paca.h>
 #include <asm/processor.h>
@@ -995,15 +994,6 @@ void __init setup_arch(char **cmdline_p)

 	initmem_init();

-	/*
-	 * Reserve large chunks of memory for use by CMA for kdump, fadump, KVM and
-	 * hugetlb. These must be called after initmem_init(), so that
-	 * pageblock_order is initialised.
-	 */
-	fadump_cma_init();
-	kdump_cma_reserve();
-	kvm_cma_reserve();
-
 	early_memtest(min_low_pfn << PAGE_SHIFT, max_low_pfn << PAGE_SHIFT);

 	if (ppc_md.setup_arch)
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index a985fc96b953..b7982d0243d4 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -30,6 +30,10 @@
 #include <asm/setup.h>
 #include <asm/fixmap.h>

+#include <asm/fadump.h>
+#include <asm/kexec.h>
+#include <asm/kvm_ppc.h>
+
 #include <mm/mmu_decl.h>

 unsigned long long memory_limit __initdata;
@@ -268,6 +272,16 @@ void __init paging_init(void)

 void __init arch_mm_preinit(void)
 {
+
+	/*
+	 * Reserve large chunks of memory for use by CMA for kdump, fadump, KVM
+	 * and hugetlb. These must be called after pageblock_order is
+	 * initialised.
+	 */
+	fadump_cma_init();
+	kdump_cma_reserve();
+	kvm_cma_reserve();
+
 	/*
 	 * book3s is limited to 16 page sizes due to encoding this in
 	 * a 4-bit field for slices.
--
2.53.0


