Return-Path: <lnxtorez@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DCED2DE176
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 06:43:53 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6HKk5gk009078
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 16:46:05 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6HKg9XW209352
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 16:42:09 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6HKg8Ac014710
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 16:42:09 -0400
Message-ID: <487FAE9F.20707@linux.vnet.ibm.com>
Date: Thu, 17 Jul 2008 15:42:07 -0500
From: Torez Smith <lnxtorez@linux.vnet.ibm.com>
MIME-Version: 1.0
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: indicate oprofile counters to use while in compat
	mode
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Description:
While running on a system with new hardware and a kernel where the 
cpu_specs[] table does not recognize the new hardware, the identify_cpu() 
routine will select the default case as it searches through cpu_specs[]
in an attempt to match the real PVR. Once the default case is selected,
non of the oprofile counters and/or fields have been set up or defined.

When identify_cpu() is called once more with the logical PVR, some of
the cpu specific fields are replaced with the exception of the oprofile
related ones. However, in the case where we have actually taken the
default case while searching for the real PVR, we need to tell 
oprofile that we are now running in compatibility mode so it can pick up
the correct counters. We do this by setting the oprofile_cpu_type field 
to be that taken from the cpu_specs[] for the cpu we are now emulating.

This change will detect that we are now altering the real PVR and determine
if we also need to update the oprofile_cpu_type field.


Testing:
Tested on Power 5++ in compatibility mode by editing out the pvr_value for
Power5++ inside cpu_specs[] so the kernel did not match the first time
through, and, was forced to take the default case. Verified fields for 
"the_cpu_spec" were set up as expected.


Signed-off-by: Torez Smith  lnxtorez@linux.vnet.ibm.com



Patch:
+++++++++++++++++++++
diff -uprN -X powerpc.orig/Documentation/dontdiff powerpc.orig/arch/powerpc/kernel/cputable.c powerpc/arch/powerpc/kernel/cputable.c
--- powerpc.orig/arch/powerpc/kernel/cputable.c	2008-07-15 18:19:19.000000000 -0500
+++ powerpc/arch/powerpc/kernel/cputable.c	2008-07-16 11:46:09.000000000 -0500
@@ -355,6 +355,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.machine_check		= machine_check_generic,
+		.oprofile_cpu_type	= "ppc64/compat-power5+",
 		.platform		= "power5+",
 	},
 	{	/* Power6 */
@@ -386,6 +387,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.machine_check		= machine_check_generic,
+		.oprofile_cpu_type	= "ppc64/compat-power6",
 		.platform		= "power6",
 	},
 	{	/* 2.06-compliant processor, i.e. Power7 "architected" mode */
@@ -397,6 +399,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.machine_check		= machine_check_generic,
+		.oprofile_cpu_type	= "ppc64/compat-power7",
 		.platform		= "power7",
 	},
 	{	/* Power7 */
@@ -1629,6 +1632,23 @@ struct cpu_spec * __init identify_cpu(un
 				t->cpu_setup = s->cpu_setup;
 				t->cpu_restore = s->cpu_restore;
 				t->platform = s->platform;
+				/*
+				 * If we have passed through this logic once
+				 * before and have pulled the default case
+				 * because the real PVR was not found inside
+				 * cpu_specs[], then we are possibly running in
+				 * compatibility mode. In that case, let the 
+				 * oprofiler know which set of compatibility
+				 * counters to pull from by making sure the 
+				 * oprofile_cpu_type string is set to that of
+				 * compatibility mode. If the oprofile_cpu_type
+				 * already has a value, then we are possibly
+				 * overriding a real PVR with a logical one, and,
+				 * in that case, keep the current value for
+				 * oprofile_cpu_type.
+				 */
+				if (t->oprofile_cpu_type == NULL)
+					t->oprofile_cpu_type = s->oprofile_cpu_type;
 			} else
 				*t = *s;
 			*PTRRELOC(&cur_cpu_spec) = &the_cpu_spec;
