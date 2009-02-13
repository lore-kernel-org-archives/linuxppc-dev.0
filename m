Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4057ADDDA1
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Feb 2009 07:45:38 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n1DKhNu8022340
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 15:43:23 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n1DKjZND186946
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 15:45:35 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n1DKjYo0009484
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 15:45:34 -0500
Subject: [PATCH] powerpc: New cpu type shows up as "unknown" even when
	logical PVR is recognized
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Fri, 13 Feb 2009 14:45:28 -0600
Message-Id: <1234557928.10378.8.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When identify_cpu() is called a second time with a logical PVR, it only
copies a subset of the cpu_spec structure to avoid overwriting the
performance monitor fields that were initialized based on the real PVR.

If the real PVR is not recognized, the structure is initialized with
default data in which the pvr_mask field is zero.  Overriding the default
definition with the one based on the logical PVR does not update the
pvr_mask field.  Since the pvr_mask field remains zero, show_cpuinfo()
reports the cpu as "unknown".

identify_cpu() should update the pvr_mask, so that show_cpuinfo() reports
the logical cpu name, as it would if the kernel recognized the real PVR.

For completeness, this patch also updates pvr_value, although its only
use appears to be in booke_wdt_init() setting ident.firmware_version.  I'm
not sure which value (the real or logical) is the most useful here, if it
matters at all.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 923f87a..a216fad 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1780,6 +1780,8 @@ struct cpu_spec * __init identify_cpu(unsigned long offset, unsigned int pvr)
 			 * performance monitor fields.
 			 */
 			if (t->num_pmcs && !s->num_pmcs) {
+				t->pvr_mask = s->pvr_mask;
+				t->pvr_value = s->pvr_value;
 				t->cpu_name = s->cpu_name;
 				t->cpu_features = s->cpu_features;
 				t->cpu_user_features = s->cpu_user_features;

-- 
David Kleikamp
IBM Linux Technology Center
