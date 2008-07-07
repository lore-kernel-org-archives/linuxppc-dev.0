Return-Path: <lnxtorez@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AAEA0DE735
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 05:01:40 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m67J0iLw008466
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 15:00:44 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m67J0iS4236648
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 15:00:44 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m67J0iWr002463
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 15:00:44 -0400
Message-ID: <487267D8.5010605@linux.vnet.ibm.com>
Date: Mon, 07 Jul 2008 14:00:40 -0500
From: torez <lnxtorez@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: indications for oprofile in compact mode
Content-Type: multipart/mixed; boundary="------------010007030702060403000402"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010007030702060403000402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------010007030702060403000402
Content-Type: text/plain;
 name="Indications oprofile in compact mode.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Indications oprofile in compact mode.txt"

This patch allows Performance monitoring driver to detect when
operating in PowerPC compliance mode.

use patch -p0 to apply.

==========================================================================
diff -urN linux-2.6.26-rc7.orig/arch/powerpc/kernel/cputable.c linux-2.6.26-rc7/arch/powerpc/kernel/cputable.c
--- linux-2.6.26-rc7.orig/arch/powerpc/kernel/cputable.c	2008-07-07 11:37:40.000000000 -0500
+++ linux-2.6.26-rc7/arch/powerpc/kernel/cputable.c	2008-07-07 11:27:09.000000000 -0500
@@ -352,6 +352,7 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.machine_check		= machine_check_generic,
+		.oprofile_cpu_type	= "ppc64/compat-power5+",
 		.platform		= "power5+",
 	},
 	{	/* Power6 */
@@ -383,6 +384,7 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.machine_check		= machine_check_generic,
+		.oprofile_cpu_type	= "ppc64/compat-power6",
 		.platform		= "power6",
 	},
 	{	/* 2.06-compliant processor, i.e. Power7 "architected" mode */
@@ -394,6 +396,7 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.machine_check		= machine_check_generic,
+		.oprofile_cpu_type	= "ppc64/compat-power7",
 		.platform		= "power7",
 	},
 	{	/* Power7 */
@@ -1593,6 +1596,12 @@
 			 * from the real PVR with a new value obtained
 			 * using a logical PVR value, don't modify the
 			 * performance monitor fields.
+			 * The performance monitor sub-system needs to have
+			 * access to the values from the real PVR, but, at 
+			 * the same time it needs to be aware it may be running
+			 * in compatibility mode. We we are changing the values
+			 * for the real PVR to those of the compatibility PVR,
+			 * change the oprofile_cpu_type field as well.
 			 */
 			if (t->num_pmcs && !s->num_pmcs) {
 				t->cpu_name = s->cpu_name;
@@ -1603,6 +1612,8 @@
 				t->cpu_setup = s->cpu_setup;
 				t->cpu_restore = s->cpu_restore;
 				t->platform = s->platform;
+				if (t->oprofile_cpu_type == NULL)
+					t->oprofile_cpu_type = s->oprofile_cpu_type;
 			} else
 				*t = *s;
 			*PTRRELOC(&cur_cpu_spec) = &the_cpu_spec;

--------------010007030702060403000402--
