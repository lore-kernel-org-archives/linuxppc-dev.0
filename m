Return-Path: <nfont@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E2937B7CC1
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jan 2010 06:46:30 +1100 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0EJb97S016131
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2010 14:37:09 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0EJk0IV127106
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2010 14:46:26 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o0EJk0oH003561
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2010 17:46:00 -0200
Received: from [9.53.40.155] (mudbug-009053040155.austin.ibm.com [9.53.40.155])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	o0EJk0Qu003531
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2010 17:46:00 -0200
Message-ID: <4B4F7476.7060001@austin.ibm.com>
Date: Thu, 14 Jan 2010 13:45:58 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Move /proc/ppc64 to /proc/powerpc update
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It looks like the previous patch sent out to move RTAS and
other items from /proc/ppc64 to /proc/powerpc missed a few
files needed for RAS and DLPAR functionality.

Original Patch here:
http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-September/076096.html

This patch updates the remaining files to be created under /proc/powerpc.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---
 arch/powerpc/kernel/rtas-proc.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: powerpc/arch/powerpc/kernel/rtas-proc.c
===================================================================
--- powerpc.orig/arch/powerpc/kernel/rtas-proc.c	2009-12-18 09:21:51.000000000 -0600
+++ powerpc/arch/powerpc/kernel/rtas-proc.c	2010-01-14 12:25:22.000000000 -0600
@@ -262,19 +262,19 @@
 	if (rtas_node == NULL)
 		return -ENODEV;
 
-	proc_create("ppc64/rtas/progress", S_IRUGO|S_IWUSR, NULL,
+	proc_create("powerpc/rtas/progress", S_IRUGO|S_IWUSR, NULL,
 		    &ppc_rtas_progress_operations);
-	proc_create("ppc64/rtas/clock", S_IRUGO|S_IWUSR, NULL,
+	proc_create("powerpc/rtas/clock", S_IRUGO|S_IWUSR, NULL,
 		    &ppc_rtas_clock_operations);
-	proc_create("ppc64/rtas/poweron", S_IWUSR|S_IRUGO, NULL,
+	proc_create("powerpc/rtas/poweron", S_IWUSR|S_IRUGO, NULL,
 		    &ppc_rtas_poweron_operations);
-	proc_create("ppc64/rtas/sensors", S_IRUGO, NULL,
+	proc_create("powerpc/rtas/sensors", S_IRUGO, NULL,
 		    &ppc_rtas_sensors_operations);
-	proc_create("ppc64/rtas/frequency", S_IWUSR|S_IRUGO, NULL,
+	proc_create("powerpc/rtas/frequency", S_IWUSR|S_IRUGO, NULL,
 		    &ppc_rtas_tone_freq_operations);
-	proc_create("ppc64/rtas/volume", S_IWUSR|S_IRUGO, NULL,
+	proc_create("powerpc/rtas/volume", S_IWUSR|S_IRUGO, NULL,
 		    &ppc_rtas_tone_volume_operations);
-	proc_create("ppc64/rtas/rmo_buffer", S_IRUSR, NULL,
+	proc_create("powerpc/rtas/rmo_buffer", S_IRUSR, NULL,
 		    &ppc_rtas_rmo_buf_ops);
 	return 0;
 }
