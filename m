Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 24C101A0C62
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Dec 2014 02:14:40 +1100 (AEDT)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Fri, 5 Dec 2014 15:14:37 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0522B1B08049
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 15:14:55 +0000 (GMT)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB5FEaah57802950
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Dec 2014 15:14:36 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB5FEZOg002654
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Dec 2014 08:14:35 -0700
Subject: [PATCH 2 1/4] powerpc: drop the ability to tweak SMT mode at boot time
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 05 Dec 2014 16:14:35 +0100
Message-ID: <20141205151341.11028.47570.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20141205150405.11028.27445.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <20141205150405.11028.27445.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The smt-enabled kernel parameter basically leaves unwanted cpus executing
in firmware or wherever they happen to be. The very same applies to the
ibm,smt-enabled DT property which is no more used by anything known. These
are hacks that shoudn't be used in a production environment.

Quoting mpe, "there are better ways for firmware to disable SMT".

It also has an evil side effect on the split-core feature for powernv. The
code needs all the cpus to participate to the split mode update: it relies
on smp_send_reschedule() to get offline ones to do so. This doesn't work with
cpus that haven't come up... The consequence is a kernel hang on powernv when
trying to limit the number of hw threads at boot time (e.g. smt-enabled to
anything but 8 on POWER8).

This patch simply removes both the smt-enabled kernel parameter and the
ibm,smt-enabled property for all platforms. The new default is to start
all hw threads. That leaves /sys the only supported API to change SMT
settings.

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---

v2: also drop ibm,smt-enabled

 arch/powerpc/kernel/setup_64.c |   46 ----------------------------------------
 1 file changed, 46 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 49f553b..29c1845 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -131,57 +131,11 @@ static void setup_tlb_core_data(void)
 
 #ifdef CONFIG_SMP
 
-static char *smt_enabled_cmdline;
-
-/* Look for ibm,smt-enabled OF option */
 static void check_smt_enabled(void)
 {
-	struct device_node *dn;
-	const char *smt_option;
-
 	/* Default to enabling all threads */
 	smt_enabled_at_boot = threads_per_core;
-
-	/* Allow the command line to overrule the OF option */
-	if (smt_enabled_cmdline) {
-		if (!strcmp(smt_enabled_cmdline, "on"))
-			smt_enabled_at_boot = threads_per_core;
-		else if (!strcmp(smt_enabled_cmdline, "off"))
-			smt_enabled_at_boot = 0;
-		else {
-			int smt;
-			int rc;
-
-			rc = kstrtoint(smt_enabled_cmdline, 10, &smt);
-			if (!rc)
-				smt_enabled_at_boot =
-					min(threads_per_core, smt);
-		}
-	} else {
-		dn = of_find_node_by_path("/options");
-		if (dn) {
-			smt_option = of_get_property(dn, "ibm,smt-enabled",
-						     NULL);
-
-			if (smt_option) {
-				if (!strcmp(smt_option, "on"))
-					smt_enabled_at_boot = threads_per_core;
-				else if (!strcmp(smt_option, "off"))
-					smt_enabled_at_boot = 0;
-			}
-
-			of_node_put(dn);
-		}
-	}
-}
-
-/* Look for smt-enabled= cmdline option */
-static int __init early_smt_enabled(char *p)
-{
-	smt_enabled_cmdline = p;
-	return 0;
 }
-early_param("smt-enabled", early_smt_enabled);
 
 #else
 #define check_smt_enabled()
