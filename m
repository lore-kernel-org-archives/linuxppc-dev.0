Return-Path: <moilanen@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 345C0DDF80
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 07:30:36 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l57LUXRx023955
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Jun 2007 17:30:33 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l57LUXud514748
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Jun 2007 17:30:33 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l57LUXkx025013
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Jun 2007 17:30:33 -0400
Subject: [PATCH 2/2] Donate dedicated CPU cycles
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18022.14166.83442.173369@cargo.ozlabs.ibm.com>
References: <1180638885.5756.11.camel@goblue>
	<18022.14166.83442.173369@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 16:30:32 -0500
Message-Id: <1181251832.5835.19.camel@goblue>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A Power6 can give up CPU cycles on a dedicated CPU (as opposed to a
shared CPU) to other shared processors if the administrator asks for it
(via the HMC).

This patch enables that to work properly on P6.

This just involves setting a bit in the CAS structure as well as the
VPA.  To donate cycles, a CPU has to have all SMT threads idle and w/
donate bit set in the VPA.  Then call H_CEDE.

The reason why shared processors just aren't used is because dedicated
CPUs are guaranteed an actual processor, yet the system is still able to
increase the capacity of the shared CPU pool.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

--

 arch/powerpc/kernel/prom_init.c        |    4 +++-
 arch/powerpc/platforms/pseries/setup.c |    2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

Index: powerpc/arch/powerpc/kernel/prom_init.c
===================================================================
--- powerpc.orig/arch/powerpc/kernel/prom_init.c
+++ powerpc/arch/powerpc/kernel/prom_init.c
@@ -635,6 +635,7 @@ static void __init early_cmdline_parse(v
 /* ibm,dynamic-reconfiguration-memory property supported */
 #define OV5_DRCONF_MEMORY	0x20
 #define OV5_LARGE_PAGES		0x10	/* large pages supported */
+#define OV5_DONATE_DEDICATE_CPU 0x02	/* donate dedicated CPU support */
 /* PCIe/MSI support.  Without MSI full PCIe is not supported */
 #ifdef CONFIG_PCI_MSI
 #define OV5_MSI			0x01	/* PCIe/MSI support */
@@ -685,7 +686,8 @@ static unsigned char ibm_architecture_ve
 	/* option vector 5: PAPR/OF options */
 	3 - 2,				/* length */
 	0,				/* don't ignore, don't halt */
-	OV5_LPAR | OV5_SPLPAR | OV5_LARGE_PAGES | OV5_DRCONF_MEMORY | OV5_MSI,
+	OV5_LPAR | OV5_SPLPAR | OV5_LARGE_PAGES | OV5_DRCONF_MEMORY |
+	OV5_DONATE_DEDICATE_CPU | OV5_MSI,
 };
 
 /* Old method - ELF header with PT_NOTE sections */
Index: powerpc/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/setup.c
+++ powerpc/arch/powerpc/platforms/pseries/setup.c
@@ -399,6 +399,7 @@ static void pseries_dedicated_idle_sleep
 	 * a good time to find other work to dispatch.
 	 */
 	get_lppaca()->idle = 1;
+	get_lppaca()->donate_dedicated_cpu = 1;
 
 	/*
 	 * We come in with interrupts disabled, and need_resched()
@@ -431,6 +432,7 @@ static void pseries_dedicated_idle_sleep
 
 out:
 	HMT_medium();
+	get_lppaca()->donate_dedicated_cpu = 0;
 	get_lppaca()->idle = 0;
 }
 
