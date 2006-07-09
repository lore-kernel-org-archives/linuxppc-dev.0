Return-Path: <haren@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 41F4667B32
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Jul 2006 11:29:08 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k691T461001334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Sat, 8 Jul 2006 21:29:04 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k691SHY9307186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Sat, 8 Jul 2006 19:28:17 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k691T3J9010323
	for <linuxppc-dev@ozlabs.org>; Sat, 8 Jul 2006 19:29:03 -0600
Message-ID: <44B05BD0.304@us.ibm.com>
Date: Sat, 08 Jul 2006 18:28:48 -0700
From: Haren Myneni <haren@us.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org
Subject: [PATCH] powerpc: EOI and clear IPI fix in xics_teardown_cpu()
Content-Type: multipart/mixed; boundary="------------020309070703050406090605"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020309070703050406090605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

If OK, please sent this patch to upstream.

Thanks
Haren

When invoked kdump boot, plpar_eoi() call is getting failed and calling 
panic().
Kernel panic - not syncing: bad return code EOI - rc = -4, value=ff000000

The issue is with the desc->chip->eoi(XICS_IPI) in xics_teardown_cpu(). 
Instead of passing the virq to desc->chip->eoi(), XICS_IPI is used. 
Also, clear IPI in xics_teardown_cpu() got removed recently (in 
2.6.17-git25).  Noticed in some crash dump cases (Ex: initiate kdump 
boot using soft-reset and xmon is enabled), IPI is not cleared for some 
CPU(s) before starting the kdump boot. Hence, causing the kdump boot 
failure.

Signed-off-by: Haren Myneni <haren@us.ibm.com>


 


--------------020309070703050406090605
Content-Type: text/x-patch;
 name="ppc64-kdump-fix-eoi-IPI.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc64-kdump-fix-eoi-IPI.patch"

--- 2618-rc1/arch/powerpc/platforms/pseries/xics.c.orig	2006-07-08 11:47:58.000000000 -0700
+++ 2618-rc1/arch/powerpc/platforms/pseries/xics.c	2006-07-08 11:47:07.000000000 -0700
@@ -783,6 +783,14 @@ void xics_teardown_cpu(int secondary)
 	xics_set_cpu_priority(cpu, 0);
 
 	/*
+	 * Clear IPI
+	 */
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		lpar_qirr_info(cpu, 0xff);
+	else
+		direct_qirr_info(cpu, 0xff);
+
+	/*
 	 * we need to EOI the IPI if we got here from kexec down IPI
 	 *
 	 * probably need to check all the other interrupts too
@@ -795,7 +803,7 @@ void xics_teardown_cpu(int secondary)
 		return;
 	desc = get_irq_desc(ipi);
 	if (desc->chip && desc->chip->eoi)
-		desc->chip->eoi(XICS_IPI);
+		desc->chip->eoi(ipi);
 
 	/*
 	 * Some machines need to have at least one cpu in the GIQ,

--------------020309070703050406090605--
