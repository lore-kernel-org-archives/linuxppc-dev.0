Return-Path: <kevcorry@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 63592DDDFF
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 06:19:56 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6VKJqdS025188
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 16:19:52 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6VKJqo5264828
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 14:19:52 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6VKJqWx012857
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 14:19:52 -0600
From: Kevin Corry <kevcorry@us.ibm.com>
To: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] PowerPC: Fix num_cpus calculation in smp_call_function_map()
Date: Tue, 31 Jul 2007 15:19:46 -0500
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707311519.48359.kevcorry@us.ibm.com>
Cc: Carl Love <carll@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[POWERPC]: Fix num_cpus calculation in smp_call_function_map().

In smp_call_function_map(), num_cpus is set to the number of online CPUs minus
one. However, if the CPU mask does not include all CPUs (except the one we're
running on), the routine will hang in the first while() loop until the 8 second
timeout occurs.

The num_cpus should be set to the number of CPUs specified in the mask passed
into the routine, after we've made any modifications to the mask. With this
change, we can also get rid of the call to cpus_empty() and avoid adding
another pass through the bitmask.

Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>
Signed-off-by: Carl Love <carll@us.ibm.com>

Index: linux-2.6.23-rc1/arch/powerpc/kernel/smp.c
===================================================================
--- linux-2.6.23-rc1.orig/arch/powerpc/kernel/smp.c
+++ linux-2.6.23-rc1/arch/powerpc/kernel/smp.c
@@ -212,11 +212,6 @@ int smp_call_function_map(void (*func) (
 		atomic_set(&data.finished, 0);
 
 	spin_lock(&call_lock);
-	/* Must grab online cpu count with preempt disabled, otherwise
-	 * it can change. */
-	num_cpus = num_online_cpus() - 1;
-	if (!num_cpus)
-		goto done;
 
 	/* remove 'self' from the map */
 	if (cpu_isset(smp_processor_id(), map))
@@ -224,7 +219,9 @@ int smp_call_function_map(void (*func) (
 
 	/* sanity check the map, remove any non-online processors. */
 	cpus_and(map, map, cpu_online_map);
-	if (cpus_empty(map))
+
+	num_cpus = cpus_weight(map);
+	if (!num_cpus)
 		goto done;
 
 	call_data = &data;
