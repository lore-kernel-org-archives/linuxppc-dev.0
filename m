Return-Path: <nfont@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 62A6DB7CEB
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jan 2010 06:53:26 +1100 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0EJnbAs027043
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2010 14:49:37 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0EJqlsa1151082
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2010 14:52:47 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o0EJqkXl012550
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2010 14:52:47 -0500
Message-ID: <4B4F760C.4000507@austin.ibm.com>
Date: Thu, 14 Jan 2010 13:52:44 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Move cpu hotplug driver lock from pseries to powerpc
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

Move the defintion and lock helper routines for the cpu hotplug driver
lock from pseries to powerpc code to avoid build breaks for platforms 
other than pseries that use cpu hotplug.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---
 arch/powerpc/kernel/smp.c              |   12 ++++++++++++
 arch/powerpc/platforms/pseries/dlpar.c |   12 ------------
 2 files changed, 12 insertions(+), 12 deletions(-)

Index: powerpc/arch/powerpc/kernel/smp.c
===================================================================
--- powerpc.orig/arch/powerpc/kernel/smp.c	2010-01-11 12:19:06.000000000 -0600
+++ powerpc/arch/powerpc/kernel/smp.c	2010-01-14 09:44:35.000000000 -0600
@@ -619,4 +619,16 @@
 	if (smp_ops->cpu_die)
 		smp_ops->cpu_die(cpu);
 }
+
+static DEFINE_MUTEX(powerpc_cpu_hotplug_driver_mutex);
+
+void cpu_hotplug_driver_lock()
+{
+	mutex_lock(&powerpc_cpu_hotplug_driver_mutex);
+}
+
+void cpu_hotplug_driver_unlock()
+{
+	mutex_unlock(&powerpc_cpu_hotplug_driver_mutex);
+}
 #endif
Index: powerpc/arch/powerpc/platforms/pseries/dlpar.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/dlpar.c	2010-01-14 09:37:48.000000000 -0600
+++ powerpc/arch/powerpc/platforms/pseries/dlpar.c	2010-01-14 09:42:50.000000000 -0600
@@ -344,18 +344,6 @@
 
 #ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
 
-static DEFINE_MUTEX(pseries_cpu_hotplug_mutex);
-
-void cpu_hotplug_driver_lock()
-{
-	mutex_lock(&pseries_cpu_hotplug_mutex);
-}
-
-void cpu_hotplug_driver_unlock()
-{
-	mutex_unlock(&pseries_cpu_hotplug_mutex);
-}
-
 static int dlpar_online_cpu(struct device_node *dn)
 {
 	int rc = 0;
