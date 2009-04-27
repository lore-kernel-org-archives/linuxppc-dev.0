Return-Path: <mjw@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A92ABDDE2A
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 02:18:00 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n3RGERSX022210
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 12:14:27 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n3RGHtUe081260
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 12:17:55 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n3RGG77N008212
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 12:16:07 -0400
Received: from [9.10.86.126] (dandaleyt60.rchland.ibm.com [9.10.86.126] (may
	be forged))
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	n3RGG6HX008160
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 12:16:06 -0400
Subject: [PATCH] powerpc adjust oprofile_cpu_type version 3
From: Mike Wolf <mjw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Mon, 27 Apr 2009 11:17:54 -0500
Message-Id: <1240849074.10947.4.camel@mx3>
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

Oprofile is changing the naming it is using for the compatibility modes.
Instead of having compat-power<x>, oprofile will go to family naming
convention and use ibm-compat-v<x>.  Currently only ibm-compat-v1 will
be defined.
The notion of compatibility events just started with POWER6. So there is
no way that any other tool could exist that is using these
oprofile_cpu_type strings we want to change.

Signed-off-by: Mike Wolf <mjw@linux.vnet.ibm.com>

---
--- mainline.orig/arch/powerpc/kernel/cputable.c	2009-04-16 09:47:49.000000000 -0500
+++ mainline/arch/powerpc/kernel/cputable.c	2009-04-27 10:28:03.000000000 -0500
@@ -382,7 +382,8 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.machine_check		= machine_check_generic,
-		.oprofile_cpu_type	= "ppc64/compat-power5+",
+		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
+		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.platform		= "power5+",
 	},
 	{	/* Power6 */
@@ -416,7 +417,8 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.machine_check		= machine_check_generic,
-		.oprofile_cpu_type	= "ppc64/compat-power6",
+		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
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
+		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
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
