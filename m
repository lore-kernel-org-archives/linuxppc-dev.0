Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CD29C2C00ED
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Sep 2013 04:55:22 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Fri, 6 Sep 2013 00:13:32 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id D4618394004D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Sep 2013 00:24:58 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r85It8ai47906854
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Sep 2013 00:25:08 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r85ItA7u007758
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Sep 2013 00:25:10 +0530
Date: Fri, 6 Sep 2013 00:25:06 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2] powerpc: Default arch idle could cede processor on pseries
Message-ID: <20130905185506.GA29978@dirshya.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Reply-To: svaidy@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Idle routines on pseries were rearranged so that cpuidle can do an
optimized idle state selection.  However, until cpuidle takes over
during boot, the idle loop spins for a short while.  This actually
affected bootup time since spinning idle sibling threads slows down
master cpu that executes bootup code.

The following patch enables pseries system to yield to hypervisor and
stop spinning by calling cede_processor() until cpuidle can take over
and do optimal idle state selection.

Bootup time can be reduced to half on small guest where most of the
time is spend before device init.

Thanks Ben for the review and suggestions.

--Vaidy

    powerpc: Default arch idle could cede processor on pseries
    
    When adding cpuidle support to pSeries, we introduced two
    regressions:
    
      - The new cpuidle backend driver only works under hypervisors
        supporting the "SLPLAR" option, which isn't the case of the
        old POWER4 hypervisor and the HV "light" used on js2x blades
    
      - The cpuidle driver registers fairly late, meaning that for
        a significant portion of the boot process, we end up having
        all threads spinning. This slows down the boot process and
        increases the overall resource usage if the hypervisor has
        shared processors.
    
    This fixes it by implementing a "default" idle that will cede
    to the hypervisor when possible, in a very simple way without
    all the bells and whisles of cpuidle.
    
    Reported-by: Paul Mackerras <paulus@samba.org>
    Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
    Acked-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index c11c823..54b998f 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -354,7 +354,7 @@ static int alloc_dispatch_log_kmem_cache(void)
 }
 early_initcall(alloc_dispatch_log_kmem_cache);
 
-static void pSeries_idle(void)
+static void pseries_lpar_idle(void)
 {
 	/* This would call on the cpuidle framework, and the back-end pseries
 	 * driver to  go to idle states
@@ -362,10 +362,22 @@ static void pSeries_idle(void)
 	if (cpuidle_idle_call()) {
 		/* On error, execute default handler
 		 * to go into low thread priority and possibly
-		 * low power mode.
+		 * low power mode by cedeing processor to hypervisor
 		 */
-		HMT_low();
-		HMT_very_low();
+
+		/* Indicate to hypervisor that we are idle. */
+		get_lppaca()->idle = 1;
+
+		/*
+		 * Yield the processor to the hypervisor.  We return if
+		 * an external interrupt occurs (which are driven prior
+		 * to returning here) or if a prod occurs from another
+		 * processor. When returning here, external interrupts
+		 * are enabled.
+		 */
+		cede_processor();
+
+		get_lppaca()->idle = 0;
 	}
 }
 
@@ -456,15 +468,14 @@ static void __init pSeries_setup_arch(void)
 
 	pSeries_nvram_init();
 
-	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
+	if (firmware_has_feature(FW_FEATURE_LPAR)) {
 		vpa_init(boot_cpuid);
-		ppc_md.power_save = pSeries_idle;
-	}
-
-	if (firmware_has_feature(FW_FEATURE_LPAR))
+		ppc_md.power_save = pseries_lpar_idle;
 		ppc_md.enable_pmcs = pseries_lpar_enable_pmcs;
-	else
+	} else {
+		/* No special idle routine */
 		ppc_md.enable_pmcs = power4_enable_pmcs;
+	}
 
 	ppc_md.pcibios_root_bridge_prepare = pseries_root_bridge_prepare;
 
