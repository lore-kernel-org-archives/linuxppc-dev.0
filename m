Return-Path: <vaibhav@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4268Pd3M5DzF3SM
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2018 17:36:04 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w877Zm9m029261
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Sep 2018 03:36:02 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mbhbeyg1c-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Sep 2018 03:35:58 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.ibm.com>;
 Fri, 7 Sep 2018 08:35:00 +0100
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>,
 "Oliver O'Halloran" <oohall@gmail.com>
Subject: [PATCH v3] powerpc/powernv: Make possible for user to force a full
 ipl cec reboot
Date: Fri,  7 Sep 2018 13:04:48 +0530
Message-Id: <20180907073448.6908-1-vaibhav@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ever since fast reboot is enabled by default in opal,
opal_cec_reboot() will use fast-reset instead of full IPL to perform
system reboot. This leaves the user with no direct way to force a full
IPL reboot except changing an nvram setting that persistently disables
fast-reset for all subsequent reboots.

This patch provides a more direct way for the user to force a one-shot
full IPL reboot by passing the command line argument 'full' to the
reboot command. So the user will be able to tweak the reboot behavior
via:

  $ sudo reboot full	# Force a full ipl reboot skipping fast-reset

  or
  $ sudo reboot  	# default reboot path (usually fast-reset)

The reboot command passes the un-parsed command argument to the kernel
via the 'Reboot' syscall which is then passed on to the arch function
pnv_restart(). The patch updates pnv_restart() to handle this cmd-arg
and issues opal_cec_reboot2 with OPAL_REBOOT_FULL_IPL to force a full
IPL reset.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Change-log:

v3	-> Re-factored the code to make it more readable [Andrew]
	   Handle return of OPAL_SUCCESS from cec_reboot variants
	   [Vasant]

v2	-> Updated the code to handle case when opal_cec_reboot2() is
	   not supported by opal. [Andrew]

	-> Force a call to opal_cec_reboot() is opal_cec_reboot2()
           fails or the action verb 'cmd' is not recognized.
---
 arch/powerpc/include/asm/opal-api.h    |  1 +
 arch/powerpc/platforms/powernv/setup.c | 36 +++++++++++++++++++++-----
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 8365353330b4..870fb7b239ea 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -1050,6 +1050,7 @@ enum OpalSysCooling {
 enum {
 	OPAL_REBOOT_NORMAL		= 0,
 	OPAL_REBOOT_PLATFORM_ERROR	= 1,
+	OPAL_REBOOT_FULL_IPL		= 2,
 };
 
 /* Argument to OPAL_PCI_TCE_KILL */
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index adddde023622..79fd839faa2d 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -219,17 +219,41 @@ static void pnv_prepare_going_down(void)
 
 static void  __noreturn pnv_restart(char *cmd)
 {
-	long rc = OPAL_BUSY;
+	long rc;
 
 	pnv_prepare_going_down();
 
-	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
-		rc = opal_cec_reboot();
-		if (rc == OPAL_BUSY_EVENT)
-			opal_poll_events(NULL);
+	do {
+		if (!cmd)
+			rc = opal_cec_reboot();
+		else if (strcmp(cmd, "full") == 0)
+			rc = opal_cec_reboot2(OPAL_REBOOT_FULL_IPL, NULL);
 		else
+			rc = OPAL_UNSUPPORTED;
+
+		if (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
+			/* Opal is busy wait for some time and retry */
+			opal_poll_events(NULL);
 			mdelay(10);
-	}
+
+		} else	if (cmd && rc) {
+			/* Unknown error while issuing reboot */
+			if (rc == OPAL_UNSUPPORTED)
+				pr_err("Unsupported '%s' reboot.\n", cmd);
+			else
+				pr_err("Unable to issue '%s' reboot. Err=%ld\n",
+				       cmd, rc);
+			pr_info("Forcing a cec-reboot\n");
+			cmd = NULL;
+			rc = OPAL_BUSY;
+
+		} else if (rc != OPAL_SUCCESS) {
+			/* Unknown error while issuing cec-reboot */
+			pr_err("Unable to reboot. Err=%ld\n", rc);
+		}
+
+	} while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT);
+
 	for (;;)
 		opal_poll_events(NULL);
 }
-- 
2.17.1
