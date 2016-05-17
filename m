Return-Path: <anju@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r8TjR4wDVzDqFy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 06:40:11 +1000 (AEST)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Tue, 17 May 2016 14:40:09 -0600
From: Anju T <anju@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: anju@linux.vnet.ibm.com, ananth@in.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com, paulus@samba.org,
 masami.hiramatsu.pt@hitachi.com, jkenisto@us.ibm.com,
 srikar@linux.vnet.ibm.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, hemant@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com
Subject: [RFC PATCH 3/3] arch/powerpc : Enable optprobes support in powerpc
Date: Wed, 18 May 2016 02:09:38 +0530
Message-Id: <1463517578-27760-4-git-send-email-anju@linux.vnet.ibm.com>
In-Reply-To: <1463517578-27760-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1463517578-27760-1-git-send-email-anju@linux.vnet.ibm.com>
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
