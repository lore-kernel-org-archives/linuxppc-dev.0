Return-Path: <mjw@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 400E1DDF9A
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 09:40:18 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e37.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n3MNdhKn022011
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 17:39:43 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n3MNeEZ3083386
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 17:40:14 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n3MNeEot020987
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 17:40:14 -0600
Received: from [9.65.10.142] (sig-9-65-10-142.mts.ibm.com [9.65.10.142])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	n3MNeDg0020916
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 17:40:13 -0600
Subject: [PATCH] powerpc: adjust oprofile_cpu_type
From: Mike Wolf <mjw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Wed, 22 Apr 2009 18:40:12 -0500
Message-Id: <1240443612.27209.2.camel@mx3>
Mime-Version: 1.0
Reply-To: mjw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Resending.  the patch was munged last time.


Oprofile is changing the naming it is using for the compatibility modes.
Instead of having compat-power<x>, oprofile will go to family naming
convention and use compat-v<x>.  Currently only compat-v1 will be
defined.

Signed-off-by: Mike Wolf <mjw@linux.vnet.ibm.com>

----
--- mainline.orig/arch/powerpc/kernel/cputable.c	2009-04-16 09:47:49.000000000 -0500
+++ mainline/arch/powerpc/kernel/cputable.c	2009-04-16 14:28:28.000000000 -0500
@@ -382,7 +382,8 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.machine_check		= machine_check_generic,
-		.oprofile_cpu_type	= "ppc64/compat-power5+",
+		.oprofile_cpu_type	= "ppc64/compat-v1",
+		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.platform		= "power5+",
 	},
 	{	/* Power6 */
@@ -416,7 +417,8 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.machine_check		= machine_check_generic,
-		.oprofile_cpu_type	= "ppc64/compat-power6",
+		.oprofile_cpu_type	= "ppc64/compat-v1",
+		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.platform		= "power6",
 	},
 	{	/* 2.06-compliant processor, i.e. Power7 "architected" mode */
@@ -429,7 +431,8 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.machine_check		= machine_check_generic,
-		.oprofile_cpu_type	= "ppc64/compat-power7",
+		.oprofile_type		= PPC_OPROFILE_POWER4,
+		.oprofile_cpu_type	= "ppc64/compat-v1",
 		.platform		= "power7",
 	},
 	{	/* Power7 */
@@ -1833,8 +1836,10 @@
 		 * and, in that case, keep the current value for
 		 * oprofile_cpu_type.
 		 */
-		if (old.oprofile_cpu_type == NULL)
+		if (old.oprofile_cpu_type == NULL) {
 			t->oprofile_cpu_type = s->oprofile_cpu_type;
+			t->oprofile_type = s->oprofile_type;
+		}
 	}
 
 	*PTRRELOC(&cur_cpu_spec) = &the_cpu_spec;
