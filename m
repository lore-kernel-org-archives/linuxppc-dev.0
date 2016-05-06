Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r1VV61TNBzDqcf
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 21:51:10 +1000 (AEST)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3r1VV60DT9z9snm
 for <linuxppc-dev@ozlabs.org>; Fri,  6 May 2016 21:51:10 +1000 (AEST)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 6 May 2016 21:51:08 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id BE49E2CE8054
 for <linuxppc-dev@ozlabs.org>; Fri,  6 May 2016 21:51:04 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u46BouFf6554072
 for <linuxppc-dev@ozlabs.org>; Fri, 6 May 2016 21:51:04 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u46BoWOl014692
 for <linuxppc-dev@ozlabs.org>; Fri, 6 May 2016 21:50:32 +1000
Received: from hbathini.in.ibm.com (hbathini.in.ibm.com [9.184.79.239] (may be
 forged))
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u46BoVVG014210
 for <linuxppc-dev@ozlabs.org>; Fri, 6 May 2016 21:50:32 +1000
Subject: [PATCH 1/3] powerpc/fadump: set an upper limit for the default
 memory reserved for fadump
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Fri, 06 May 2016 17:20:07 +0530
Message-ID: <20160506115007.26330.89135.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When boot memory size for fadump is not specified, memory is reserved
for fadump based on system RAM size. As the system RAM size increases,
the memory reserved for fadump increases as well. This patch sets an
upper limit on the memory reserved for fadump, to avoid reserving
excess memory.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/fadump.h |    6 ++++++
 arch/powerpc/kernel/fadump.c      |    4 ++++
 2 files changed, 10 insertions(+)

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index b4407d0..2c3cb32 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -43,6 +43,12 @@
 #define MIN_BOOT_MEM	(((RMA_END < (0x1UL << 28)) ? (0x1UL << 28) : RMA_END) \
 			+ (0x1UL << 26))
 
+/*
+ * Maximum memory needed for fadump to boot up successfully. Use this as
+ * an upper limit for fadump so we don't endup reserving excess memory.
+ */
+#define MAX_BOOT_MEM	(0x1UL << 32)
+
 #define memblock_num_regions(memblock_type)	(memblock.memblock_type.cnt)
 
 #ifndef ELF_CORE_EFLAGS
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 3cb3b02a..d0af58b 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -225,6 +225,10 @@ static inline unsigned long fadump_calculate_reserve_size(void)
 	/* round it down in multiples of 256 */
 	size = size & ~0x0FFFFFFFUL;
 
+	/* Set an upper limit on the memory to be reserved */
+	if (size > MAX_BOOT_MEM)
+		size = MAX_BOOT_MEM;
+
 	/* Truncate to memory_limit. We don't want to over reserve the memory.*/
 	if (memory_limit && size > memory_limit)
 		size = memory_limit;
