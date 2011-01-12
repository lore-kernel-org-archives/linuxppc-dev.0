Return-Path: <anton@samba.org>
Date: Wed, 12 Jan 2011 23:12:43 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 1/2] powerpc: Disable mcount tracers in pseries config
Message-ID: <20110112231243.71c71291@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


IRQSOFF_TRACER and STACK_TRACER force the kernel to be built with -pg
which is a substantial overhead.
 
Signed-off-by: Anton Blanchard <anton@samba.org> 
---     

Index: powerpc.git/arch/powerpc/configs/pseries_defconfig
===================================================================
--- powerpc.git.orig/arch/powerpc/configs/pseries_defconfig	2011-01-11 14:34:38.890639046 +1100
+++ powerpc.git/arch/powerpc/configs/pseries_defconfig	2011-01-12 23:06:28.770355258 +1100
@@ -311,9 +311,7 @@ CONFIG_DEBUG_KERNEL=y
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_LATENCYTOP=y
 CONFIG_SYSCTL_SYSCALL_CHECK=y
-CONFIG_IRQSOFF_TRACER=y
 CONFIG_SCHED_TRACER=y
-CONFIG_STACK_TRACER=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_DEBUG_STACK_USAGE=y
