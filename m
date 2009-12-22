Return-Path: <nfont@austin.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2187BB7BDB
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Dec 2009 01:45:43 +1100 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nBMEckKr025042
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Dec 2009 09:38:46 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBMEjdOj132890
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Dec 2009 09:45:39 -0500
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nBMEjZx6025653
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Dec 2009 07:45:35 -0700
Message-ID: <4B30DB8B.3030305@austin.ibm.com>
Date: Tue, 22 Dec 2009 08:45:31 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Make cpu hotplug driver lock part of ppc_md
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andreas Schwab <schwab@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The recently introduced cpu_hotplug_driver_lock used to serialize
cpu hotplug operations, namely for the pseries platform, causes a build
issue for other platforms.  The base cpu hotplug code attempts
to take this lock, but it may not be needed for all platforms.  This patch
moves the lock/unlock routines to be part of the ppc_md structure
so that platforms needing the lock can take it.  This also makes the
previous cpu_hotplug_driver_lock, defined in pseries code, pseries specific.

The past failure without this patch was seen when building pmac and may
be present in other platform builds.  The error is included below for reference.

drivers/built-in.o: In function `.store_online':
cpu.c:(.ref.text+0xf5c): undefined reference to `.cpu_hotplug_driver_lock'
cpu.c:(.ref.text+0xfc8): undefined reference to `.cpu_hotplug_driver_unlock'
make: *** [.tmp_vmlinux1] Error 1

Signed-of-by: Nathan Fontenot <nfont@austin.ibm.com>
---
 arch/powerpc/include/asm/machdep.h     |    2 ++
 arch/powerpc/kernel/smp.c              |   14 ++++++++++++++
 arch/powerpc/platforms/pseries/dlpar.c |    6 ++++--
 3 files changed, 20 insertions(+), 2 deletions(-)

Index: powerpc/arch/powerpc/include/asm/machdep.h
===================================================================
--- powerpc.orig/arch/powerpc/include/asm/machdep.h	2009-12-21 20:51:49.000000000 -0600
+++ powerpc/arch/powerpc/include/asm/machdep.h	2009-12-21 21:07:40.000000000 -0600
@@ -270,6 +270,8 @@
 #ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
 	ssize_t (*cpu_probe)(const char *, size_t);
 	ssize_t (*cpu_release)(const char *, size_t);
+	void (*cpu_hotplug_driver_lock)(void);
+	void (*cpu_hotplug_driver_unlock)(void);
 #endif
 };
 
Index: powerpc/arch/powerpc/platforms/pseries/dlpar.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/dlpar.c	2009-12-21 20:51:49.000000000 -0600
+++ powerpc/arch/powerpc/platforms/pseries/dlpar.c	2009-12-21 21:26:23.000000000 -0600
@@ -346,12 +346,12 @@
 
 static DEFINE_MUTEX(pseries_cpu_hotplug_mutex);
 
-void cpu_hotplug_driver_lock()
+static void pseries_cpu_hotplug_driver_lock(void)
 {
 	mutex_lock(&pseries_cpu_hotplug_mutex);
 }
 
-void cpu_hotplug_driver_unlock()
+static void pseries_cpu_hotplug_driver_unlock(void)
 {
 	mutex_unlock(&pseries_cpu_hotplug_mutex);
 }
@@ -550,6 +550,8 @@
 {
 	ppc_md.cpu_probe = dlpar_cpu_probe;
 	ppc_md.cpu_release = dlpar_cpu_release;
+	ppc_md.cpu_hotplug_driver_lock = pseries_cpu_hotplug_driver_lock;
+	ppc_md.cpu_hotplug_driver_unlock = pseries_cpu_hotplug_driver_unlock;
 
 	return 0;
 }
Index: powerpc/arch/powerpc/kernel/smp.c
===================================================================
--- powerpc.orig/arch/powerpc/kernel/smp.c	2009-12-21 20:51:49.000000000 -0600
+++ powerpc/arch/powerpc/kernel/smp.c	2009-12-21 21:24:23.000000000 -0600
@@ -619,4 +619,18 @@
 	if (smp_ops->cpu_die)
 		smp_ops->cpu_die(cpu);
 }
+
+#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
+void cpu_hotplug_driver_lock(void)
+{
+	if (ppc_md.cpu_hotplug_driver_lock)
+		ppc_md.cpu_hotplug_driver_lock();
+}
+
+void cpu_hotplug_driver_unlock(void)
+{
+	if (ppc_md.cpu_hotplug_driver_unlock)
+		ppc_md.cpu_hotplug_driver_unlock();
+}
 #endif
+#endif /* CONFIG_HOTPLUG_CPU */
