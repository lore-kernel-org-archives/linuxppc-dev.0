Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 44BD767A79
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jul 2005 23:55:31 +1000 (EST)
Date: Wed, 13 Jul 2005 15:55:25 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Message-ID: <20050713135525.GA18144@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [PATCH] use Kconfig.hz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


use new Kconfig.hz on ppc/ppc64, use also Kconfig.preempt for ppc

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/ppc/Kconfig   |   12 ++----------
 arch/ppc64/Kconfig |    1 +
 2 files changed, 3 insertions(+), 10 deletions(-)

Index: linux-2.6.13-rc3-olh/arch/ppc/Kconfig
===================================================================
--- linux-2.6.13-rc3-olh.orig/arch/ppc/Kconfig
+++ linux-2.6.13-rc3-olh/arch/ppc/Kconfig
@@ -935,19 +935,11 @@ config NR_CPUS
 	depends on SMP
 	default "4"
 
-config PREEMPT
-	bool "Preemptible Kernel"
-	help
-	  This option reduces the latency of the kernel when reacting to
-	  real-time or interactive events by allowing a low priority process to
-	  be preempted even if it is in kernel mode executing a system call.
-
-	  Say Y here if you are building a kernel for a desktop, embedded
-	  or real-time system.  Say N if you are unsure.
-
 config HIGHMEM
 	bool "High memory support"
 
+source kernel/Kconfig.hz
+source kernel/Kconfig.preempt
 source "mm/Kconfig"
 
 source "fs/Kconfig.binfmt"
Index: linux-2.6.13-rc3-olh/arch/ppc64/Kconfig
===================================================================
--- linux-2.6.13-rc3-olh.orig/arch/ppc64/Kconfig
+++ linux-2.6.13-rc3-olh/arch/ppc64/Kconfig
@@ -288,6 +288,7 @@ config SCHED_SMT
 	  overhead in some places. If unsure say N here.
 
 source "kernel/Kconfig.preempt"
+source kernel/Kconfig.hz
 
 config EEH
 	bool "PCI Extended Error Handling (EEH)" if EMBEDDED
