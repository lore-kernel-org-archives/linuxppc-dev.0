Return-Path: <olof@lixom.net>
Date: Thu, 3 Nov 2005 11:49:27 -0800
To: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Message-ID: <20051103194927.GC8515@pb15.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Olof Johansson <olof@lixom.net>
Cc: akpm@osdl.org
Subject: [PATCH] POWERPC/PPC64: Fix CONFIG_SMP=n build for ppc64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Below is against 2.6.14-git5:

---

Two CONFIG_SMP=n build fixes due to missing <asm/smp.h> includes.

Signed-off-by: Olof Johansson <olof@lixom.net>

Index: 2.6/arch/ppc64/kernel/sysfs.c
===================================================================
--- 2.6.orig/arch/ppc64/kernel/sysfs.c	2005-11-03 10:33:42.000000000 -0800
+++ 2.6/arch/ppc64/kernel/sysfs.c	2005-11-03 10:33:51.000000000 -0800
@@ -20,6 +20,7 @@
 #include <asm/paca.h>
 #include <asm/lppaca.h>
 #include <asm/machdep.h>
+#include <asm/smp.h>
 
 static DEFINE_PER_CPU(struct cpu, cpu_devices);
 
Index: 2.6/arch/powerpc/kernel/time.c
===================================================================
--- 2.6.orig/arch/powerpc/kernel/time.c	2005-11-03 10:45:43.000000000 -0800
+++ 2.6/arch/powerpc/kernel/time.c	2005-11-03 10:49:52.000000000 -0800
@@ -69,6 +69,7 @@
 #include <asm/iSeries/ItLpQueue.h>
 #include <asm/iSeries/HvCallXm.h>
 #endif
+#include <asm/smp.h>
 
 /* keep track of when we need to update the rtc */
 time_t last_rtc_update;
