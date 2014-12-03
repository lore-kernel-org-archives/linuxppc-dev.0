Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6EDEC1A09DB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 00:58:26 +1100 (AEDT)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Wed, 3 Dec 2014 13:58:22 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6A6451B08061
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 13:58:37 +0000 (GMT)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB3DwJFo57540858
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Dec 2014 13:58:19 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB38tDHr031090
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Dec 2014 03:55:14 -0500
Subject: [PATCH] powerpc: remove the smt-enabled kernel parameter
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 03 Dec 2014 14:58:13 +0100
Message-ID: <20141203135812.4126.85795.stgit@bahia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This parameter basically leaves unwanted cpus executing in firmware or
wherever they happen to be. This is a hack that shoudn't be used in a
production environment.

It also has an evil side effect on the split-core feature for powernv. The
code needs all the cpus to participate to the split mode update: it relies
on smp_send_reschedule() to get offline ones to do so. This doesn't work with
cpus that haven't come up... The consequence is a kernel hang at boot time
on powernv when smt-enabled is used to limit the number of threads.

This patch simply removes the smt-enabled kernel parameter for all platforms.
>From now on, SMT mode should be set by userspace.

I see there also is a ibm,smt-enabled property but I could not find any
piece of information about it. Since it does the very same thing as the
kernel parameter, it is tempting to drop it alike... This would possibly
allow more simplification like killing the cpu_bootable hook.

Please give advice anyone.

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/setup_64.c |   51 +++++++++-------------------------------
 1 file changed, 12 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 4f3cfe1..62c7602 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -131,8 +131,6 @@ static void setup_tlb_core_data(void)
 
 #ifdef CONFIG_SMP
 
-static char *smt_enabled_cmdline;
-
 /* Look for ibm,smt-enabled OF option */
 static void check_smt_enabled(void)
 {
@@ -142,46 +140,21 @@ static void check_smt_enabled(void)
 	/* Default to enabling all threads */
 	smt_enabled_at_boot = threads_per_core;
 
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
+	dn = of_find_node_by_path("/options");
+	if (dn) {
+		smt_option = of_get_property(dn, "ibm,smt-enabled",
+					     NULL);
+
+		if (smt_option) {
+			if (!strcmp(smt_option, "on"))
+				smt_enabled_at_boot = threads_per_core;
+			else if (!strcmp(smt_option, "off"))
+				smt_enabled_at_boot = 0;
 		}
-	}
-}
 
-/* Look for smt-enabled= cmdline option */
-static int __init early_smt_enabled(char *p)
-{
-	smt_enabled_cmdline = p;
-	return 0;
+		of_node_put(dn);
+	}
 }
-early_param("smt-enabled", early_smt_enabled);
 
 #else
 #define check_smt_enabled()
