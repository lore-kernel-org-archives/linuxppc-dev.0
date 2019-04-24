Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46644C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 06:35:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 616CC218D3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 06:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ezl0obkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616CC218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44prCg1xl4zDqTl
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 16:35:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=kernelfans@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ezl0obkM"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pr9n6w4YzDqNf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 16:33:33 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id y13so8751152pfm.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 23:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=rRlxu7N8hh5xmQuGaWtAPwwzwkjSE7ZjtdBUkUzkFjg=;
 b=Ezl0obkMUXLsojuUPwA01naDDy0yKrnepNBLd4lPd2ogj9s6xLk3A2TjDLuz2fenG7
 ic1ncquBHMQISfz0siFBdqAup/62d5eoVdl/a8pyn1Nnkj78+P4mjteyTe0Oy7bvYqH6
 oYBEpBiwZHmMP8q/Y0OJ0bm0LYCN7/Wz5zJwZf8X6m/na4fWB2ed/Dos/tObiXWj5Qeu
 WmrqQlNUzxaEOUpos42bqrOoLI/LeFQSUCiO80alacHQfFejy/JMechtkfzMhThVPQBj
 cNNNPLp9A8YO2srFP15cERNQmHcL6QHsgJESTIyo3er5LezRZxTzcoexgDOG+j6n8+0j
 xmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=rRlxu7N8hh5xmQuGaWtAPwwzwkjSE7ZjtdBUkUzkFjg=;
 b=Ci00voAWhgTk/pYU8pU2RS/4cx+og+kB0HWfp5z5OpeIgX3T0PYfjxK5mpeUnyLgkj
 li16mm3phsAdS5gCS1QY+7eJU3OIYk8R/pd/D1ddx6zLhRs9lPufr/8T5whVqlT74efx
 30WqqK//qRXqHTWIXtTDSAII2jE8XyW0zhZIDy8axmq3vSAQvVgs+SjGmxWGM1Hlh7pT
 QKlSSIjouIdfrqnIoF5AXWrnaK5eidMfkTos4ee8bvZbuZXafsyYodfuwneIhl97Tur1
 qJkl+stxZEKPqr+AgFWVTVyfOeOWg0+vxOuodoZ+K54HmEKH/0BEB5Q6Inygx4uU0omt
 WNAw==
X-Gm-Message-State: APjAAAXf80IcpMBQtfMUjDgFkjVunrVOi/w+6eOLtaVXnONvLzIwDsC1
 IJw+gmmAwFoR8EubhsufvQ==
X-Google-Smtp-Source: APXvYqzQlHbnH5HCXIk8ZMzLqSw4EkgMnJ1gk/Twyi27YfBVratB8NIesvJpC7AnOuBzfoxS8N/8Sw==
X-Received: by 2002:a63:1702:: with SMTP id x2mr28734847pgl.448.1556087610281; 
 Tue, 23 Apr 2019 23:33:30 -0700 (PDT)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id i15sm24448356pfr.8.2019.04.23.23.33.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Apr 2019 23:33:29 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCHv2] kernel/crash: make parse_crashkernel()'s return value more
 indicant
Date: Wed, 24 Apr 2019 14:33:01 +0800
Message-Id: <1556087581-14513-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 Julien Thierry <julien.thierry@arm.com>, Yangtao Li <tiny.windzz@gmail.com>,
 Palmer Dabbelt <palmer@sifive.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 x86@kernel.org, Pingfan Liu <kernelfans@gmail.com>, linux-mips@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-s390@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 Dave Young <dyoung@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Will Deacon <will.deacon@arm.com>, linuxppc-dev@lists.ozlabs.org,
 Borislav Petkov <bp@alien8.de>, Stefan Agner <stefan@agner.ch>,
 Thomas Gleixner <tglx@linutronix.de>, Hari Bathini <hbathini@linux.ibm.com>,
 Jens Axboe <axboe@kernel.dk>, Tony Luck <tony.luck@intel.com>,
 Baoquan He <bhe@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 Thomas Bogendoerfer <tbogendoerfer@suse.de>,
 Paul Burton <paul.burton@mips.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Logan Gunthorpe <logang@deltatee.com>, Greg Hackmann <ghackmann@android.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

At present, both return and crash_size should be checked to guarantee the
success of parse_crashkernel().

Take a close look at the cases, which causes crash_size=0. Beside syntax
error, three cases cause parsing to get crash_size=0.
-1st. in parse_crashkernel_mem(), the demanded crash size is bigger than
 system ram.
-2nd. in parse_crashkernel_mem(), the system ram size does not match any
 item in the range list.
-3rd. "crashkernel=0MB", which is impractical.

All these cases can be treated as invalid argument.

By this way, only need a simple check on return value of
parse_crashkernel().

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Greg Hackmann <ghackmann@android.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: x86@kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
---
v1 -> v2: On error, return -EINVAL for all failure cases

 arch/arm/kernel/setup.c             |  2 +-
 arch/arm64/mm/init.c                |  2 +-
 arch/ia64/kernel/setup.c            |  2 +-
 arch/mips/kernel/setup.c            |  2 +-
 arch/powerpc/kernel/fadump.c        |  2 +-
 arch/powerpc/kernel/machine_kexec.c |  2 +-
 arch/s390/kernel/setup.c            |  2 +-
 arch/sh/kernel/machine_kexec.c      |  2 +-
 arch/x86/kernel/setup.c             |  4 ++--
 kernel/crash_core.c                 | 10 +++++++++-
 10 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 5d78b6a..2feab13 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -997,7 +997,7 @@ static void __init reserve_crashkernel(void)
 	total_mem = get_total_mem();
 	ret = parse_crashkernel(boot_command_line, total_mem,
 				&crash_size, &crash_base);
-	if (ret)
+	if (ret < 0)
 		return;
 
 	if (crash_base <= 0) {
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 6bc1350..240918c 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -79,7 +79,7 @@ static void __init reserve_crashkernel(void)
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 				&crash_size, &crash_base);
 	/* no crashkernel= or invalid value specified */
-	if (ret || !crash_size)
+	if (ret < 0)
 		return;
 
 	crash_size = PAGE_ALIGN(crash_size);
diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index 583a374..3bbb58b 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -277,7 +277,7 @@ static void __init setup_crashkernel(unsigned long total, int *n)
 
 	ret = parse_crashkernel(boot_command_line, total,
 			&size, &base);
-	if (ret == 0 && size > 0) {
+	if (!ret) {
 		if (!base) {
 			sort_regions(rsvd_region, *n);
 			*n = merge_regions(rsvd_region, *n);
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 8d1dc6c..168571b 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -715,7 +715,7 @@ static void __init mips_parse_crashkernel(void)
 	total_mem = get_total_mem();
 	ret = parse_crashkernel(boot_command_line, total_mem,
 				&crash_size, &crash_base);
-	if (ret != 0 || crash_size <= 0)
+	if (ret < 0)
 		return;
 
 	if (!memory_region_available(crash_base, crash_size)) {
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 45a8d0b..3571504 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -376,7 +376,7 @@ static inline unsigned long fadump_calculate_reserve_size(void)
 	 */
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 				&size, &base);
-	if (ret == 0 && size > 0) {
+	if (!ret) {
 		unsigned long max_size;
 
 		if (fw_dump.reserve_bootvar)
diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index 63f5a93..1697ad2 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -122,7 +122,7 @@ void __init reserve_crashkernel(void)
 	/* use common parsing */
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 			&crash_size, &crash_base);
-	if (ret == 0 && crash_size > 0) {
+	if (!ret) {
 		crashk_res.start = crash_base;
 		crashk_res.end = crash_base + crash_size - 1;
 	}
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 2c642af..d4bd61b 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -671,7 +671,7 @@ static void __init reserve_crashkernel(void)
 
 	crash_base = ALIGN(crash_base, KEXEC_CRASH_MEM_ALIGN);
 	crash_size = ALIGN(crash_size, KEXEC_CRASH_MEM_ALIGN);
-	if (rc || crash_size == 0)
+	if (rc < 0)
 		return;
 
 	if (memblock.memory.regions[0].size < crash_size) {
diff --git a/arch/sh/kernel/machine_kexec.c b/arch/sh/kernel/machine_kexec.c
index 63d63a3..3c03240 100644
--- a/arch/sh/kernel/machine_kexec.c
+++ b/arch/sh/kernel/machine_kexec.c
@@ -157,7 +157,7 @@ void __init reserve_crashkernel(void)
 
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 			&crash_size, &crash_base);
-	if (ret == 0 && crash_size > 0) {
+	if (!ret) {
 		crashk_res.start = crash_base;
 		crashk_res.end = crash_base + crash_size - 1;
 	}
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3d872a5..592d5ad 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -526,11 +526,11 @@ static void __init reserve_crashkernel(void)
 
 	/* crashkernel=XM */
 	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
-	if (ret != 0 || crash_size <= 0) {
+	if (ret < 0) {
 		/* crashkernel=X,high */
 		ret = parse_crashkernel_high(boot_command_line, total_mem,
 					     &crash_size, &crash_base);
-		if (ret != 0 || crash_size <= 0)
+		if (ret < 0)
 			return;
 		high = true;
 	}
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 093c9f9..83ee4a9 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -108,8 +108,10 @@ static int __init parse_crashkernel_mem(char *cmdline,
 				return -EINVAL;
 			}
 		}
-	} else
+	} else {
 		pr_info("crashkernel size resulted in zero bytes\n");
+		return -EINVAL;
+	}
 
 	return 0;
 }
@@ -139,6 +141,8 @@ static int __init parse_crashkernel_simple(char *cmdline,
 		pr_warn("crashkernel: unrecognized char: %c\n", *cur);
 		return -EINVAL;
 	}
+	if (*crash_size == 0)
+		return -EINVAL;
 
 	return 0;
 }
@@ -181,6 +185,8 @@ static int __init parse_crashkernel_suffix(char *cmdline,
 		pr_warn("crashkernel: unrecognized char: %c\n", *cur);
 		return -EINVAL;
 	}
+	if (*crash_size == 0)
+		return -EINVAL;
 
 	return 0;
 }
@@ -266,6 +272,8 @@ static int __init __parse_crashkernel(char *cmdline,
 /*
  * That function is the entry point for command line parsing and should be
  * called from the arch-specific code.
+ * On success 0. On error for either syntax error or crash_size=0, -EINVAL is
+ * returned.
  */
 int __init parse_crashkernel(char *cmdline,
 			     unsigned long long system_ram,
-- 
2.7.4

