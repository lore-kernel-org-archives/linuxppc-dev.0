Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJr7t5mVczDqdx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 20:58:34 +1000 (AEST)
Received: from pps.filterd (m0048827.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u4VAsfQa034749
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 06:58:33 -0400
Message-Id: <201605311058.u4VAsfQa034749@mx0a-001b2d01.pphosted.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2395qdx366-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 06:58:32 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Tue, 31 May 2016 20:58:29 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id CC6132CE805E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 20:58:15 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4VAw0ZZ459022
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 20:58:00 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4VAuwMp030135
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 20:56:59 +1000
From: Anju T <anju@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: anju@linux.vnet.ibm.com, ananth@in.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, hemant@linux.vnet.ibm.com,
 mahesh@linux.vnet.ibm.com, mhiramat@kernel.org, anjutsudhakar@gmail.com
Subject: [RFC PATCH v4 3/3] arch/powerpc : Enable optprobes support in powerpc
Date: Tue, 31 May 2016 16:26:31 +0530
In-Reply-To: <1464692191-1167-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1464692191-1167-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Anju T <anju@linux.vnet.ibm.com>
---
 Documentation/features/debug/optprobes/arch-support.txt | 2 +-
 arch/powerpc/Kconfig                                    | 1 +
 arch/powerpc/kernel/Makefile                            | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/features/debug/optprobes/arch-support.txt b/Documentation/features/debug/optprobes/arch-support.txt
index b8999d8..45bc99d 100644
--- a/Documentation/features/debug/optprobes/arch-support.txt
+++ b/Documentation/features/debug/optprobes/arch-support.txt
@@ -27,7 +27,7 @@
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
-    |     powerpc: | TODO |
+    |     powerpc: |  ok  |
     |        s390: | TODO |
     |       score: | TODO |
     |          sh: | TODO |
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 7cd32c0..a87c9b1 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -104,6 +104,7 @@ config PPC
 	select HAVE_IOREMAP_PROT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !CPU_LITTLE_ENDIAN
 	select HAVE_KPROBES
+	select HAVE_OPTPROBES
 	select HAVE_ARCH_KGDB
 	select HAVE_KRETPROBES
 	select HAVE_ARCH_TRACEHOOK
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 2da380f..7994e22 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -99,6 +99,7 @@ endif
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
+obj-$(CONFIG_OPTPROBES)		+= optprobes.o optprobes_head.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o
 obj-$(CONFIG_PPC_UDBG_16550)	+= legacy_serial.o udbg_16550.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
-- 
2.1.0
