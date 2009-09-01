Return-Path: <arun@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [59.145.155.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp08.in.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 99B83B7B75
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Sep 2009 21:40:50 +1000 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp08.in.ibm.com (8.14.3/8.13.1) with ESMTP id n81Bd1pS027787
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Sep 2009 17:09:01 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n81Bedr52453528
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Sep 2009 17:10:39 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n81BecYA007867
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Sep 2009 21:40:39 +1000
Date: Tue, 1 Sep 2009 17:10:36 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Joel Schopp <jschopp@austin.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>,
	Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
	Dipankar Sarma <dipankar@in.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
	Gautham R Shenoy <ego@in.ibm.com>, Arun Bharadwaj <arun@linux.vnet.ibm.com>
Subject: [v4 PATCH 3/5]: pSeries: Incorporate registering of idle loop for
	pSeries.
Message-ID: <20090901114036.GJ7599@linux.vnet.ibm.com>
References: <20090901113704.GG7599@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20090901113704.GG7599@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Reply-To: arun@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-09-01 17:07:04]:

Platform needs to register its idle function via register_idle_function()
in order to provide a clean way of handling the ppc_md.power_save

Signed-off-by: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/setup.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

Index: linux.trees.git/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/platforms/pseries/setup.c
+++ linux.trees.git/arch/powerpc/platforms/pseries/setup.c
@@ -280,6 +280,8 @@ static struct notifier_block pci_dn_reco
 
 static void __init pSeries_setup_arch(void)
 {
+	struct idle_function_desc pseries_idle_desc;
+
 	/* Discover PIC type and setup ppc_md accordingly */
 	pseries_discover_pic();
 
@@ -305,10 +307,17 @@ static void __init pSeries_setup_arch(vo
 		vpa_init(boot_cpuid);
 		if (get_lppaca()->shared_proc) {
 			printk(KERN_DEBUG "Using shared processor idle loop\n");
-			ppc_md.power_save = pseries_shared_idle_sleep;
+			//snprintf(pseries_idle_desc.name, 16, "shared_loop");
+			pseries_idle_desc.name = "shared_loop";
+			pseries_idle_desc.idle_func = pseries_shared_idle_sleep;
+			register_idle_function(&pseries_idle_desc);
 		} else {
 			printk(KERN_DEBUG "Using dedicated idle loop\n");
-			ppc_md.power_save = pseries_dedicated_idle_sleep;
+			//snprintf(pseries_idle_desc.name, 16, "dedicated_loop");
+			pseries_idle_desc.name = "dedicated_loop";
+			pseries_idle_desc.idle_func =
+						pseries_dedicated_idle_sleep;
+			register_idle_function(&pseries_idle_desc);
 		}
 	} else {
 		printk(KERN_DEBUG "Using default idle loop\n");
