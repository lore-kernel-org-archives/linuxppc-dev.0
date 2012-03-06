Return-Path: <mylinux@10.ap.freescale.net>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe004.messaging.microsoft.com [213.199.154.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 53C27B6FA1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 14:00:16 +1100 (EST)
Received: from mail6-db3 (localhost [127.0.0.1])	by mail6-db3-R.bigfish.com
 (Postfix) with ESMTP id 10A3E20487	for <linuxppc-dev@lists.ozlabs.org>; Tue,
 6 Mar 2012 03:00:10 +0000 (UTC)
Received: from DB3EHSMHS015.bigfish.com (unknown [10.3.81.251])	by
 mail6-db3.bigfish.com (Postfix) with ESMTP id 116DF380045	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 03:00:08 +0000 (UTC)
Received: from 10.ap.freescale.net ([10.213.130.145])	by
 az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id q263024u011797	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Mar 2012 21:00:03 -0600 (CST)
From: Liu Gang <Gang.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <Alexandre.Bounine@idt.com>
Subject: [PATCH] powerpc/srio: Fix the relocation errors when building with
 64bit
Date: Tue, 6 Mar 2012 10:58:12 +0800
Message-ID: <1331002692-9061-1-git-send-email-Gang.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: r58472@freescale.com, linux-kernel@vger.kernel.org, r61911@freescale.com,
 paul.gortmaker@windriver.com, Liu Gang <Gang.Liu@freescale.com>,
 scottwood@freescale.com, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For the file "arch/powerpc/sysdev/fsl_rio.c", there will be some relocation
errors while using the corenet64_smp_defconfig:

WARNING: modpost: Found 6 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=y'
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/powerpc/sysdev/built-in.o:(__ex_table+0x0):
	relocation truncated to fit: R_PPC64_ADDR16 against `.text'+3208
arch/powerpc/sysdev/built-in.o:(__ex_table+0x2):
	relocation truncated to fit: R_PPC64_ADDR16 against `.fixup'
arch/powerpc/sysdev/built-in.o:(__ex_table+0x4):
	relocation truncated to fit: R_PPC64_ADDR16 against `.text'+3230
arch/powerpc/sysdev/built-in.o:(__ex_table+0x6):
	relocation truncated to fit: R_PPC64_ADDR16 against `.fixup'+c
arch/powerpc/sysdev/built-in.o:(__ex_table+0x8):
	relocation truncated to fit: R_PPC64_ADDR16 against `.text'+3250
arch/powerpc/sysdev/built-in.o:(__ex_table+0xa):
	relocation truncated to fit: R_PPC64_ADDR16 against `.fixup'+18

Rewrote the corresponding code with the support of 64bit building.

Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
---
 arch/powerpc/sysdev/fsl_rio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index a4c4f4a..5b6f556 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -66,8 +66,8 @@
 		"	li %0,%3\n"			\
 		"	b 2b\n"				\
 		".section __ex_table,\"a\"\n"		\
-		"	.align 2\n"			\
-		"	.long 1b,3b\n"			\
+			PPC_LONG_ALIGN "\n"		\
+			PPC_LONG "1b,3b\n"		\
 		".text"					\
 		: "=r" (err), "=r" (x)			\
 		: "b" (addr), "i" (-EFAULT), "0" (err))
-- 
1.7.0.4
