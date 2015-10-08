Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A33C1A0279
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 08:09:21 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: thuth@redhat.com
Subject: [PATCH 1/6] powerpc/kconfig: Move NR_IRQS into "Kernel Options"
Date: Fri,  9 Oct 2015 08:09:12 +1100
Message-Id: <1444338557-14988-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the NR_IRQS option sits at the top level, which is ugly in
menuconfig. It's not something users will commonly need to worry about
so move it into "Kernel Options".

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9a7057ec2154..c6f1aa1e8d4c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -33,16 +33,6 @@ config HAVE_SETUP_PER_CPU_AREA
 config NEED_PER_CPU_EMBED_FIRST_CHUNK
 	def_bool PPC64
 
-config NR_IRQS
-	int "Number of virtual interrupt numbers"
-	range 32 32768
-	default "512"
-	help
-	  This defines the number of virtual interrupt numbers the kernel
-	  can manage. Virtual interrupt numbers are what you see in
-	  /proc/interrupts. If you configure your system to have too few,
-	  drivers will fail to load or worse - handle with care.
-
 config STACKTRACE_SUPPORT
 	bool
 	default y
@@ -321,6 +311,16 @@ config HIGHMEM
 	bool "High memory support"
 	depends on PPC32
 
+config NR_IRQS
+	int "Number of virtual interrupt numbers"
+	range 32 32768
+	default "512"
+	help
+	  This defines the number of virtual interrupt numbers the kernel
+	  can manage. Virtual interrupt numbers are what you see in
+	  /proc/interrupts. If you configure your system to have too few,
+	  drivers will fail to load or worse - handle with care.
+
 source kernel/Kconfig.hz
 source kernel/Kconfig.preempt
 source "fs/Kconfig.binfmt"
-- 
2.1.4
