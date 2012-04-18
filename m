Return-Path: <anton@samba.org>
Date: Wed, 18 Apr 2012 15:16:48 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, shangw@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Use WARN instead of dump_stack when printing EEH
 error backtrace
Message-ID: <20120418151648.3106b963@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


When we get an EEH error we just print a backtrace with dump_stack
which is rather cryptic. We really should print something before
spewing out the backtrace.

Also switch from dump_stack to WARN so we get more information about
the fail - what modules were loaded, what process was running etc.
This was useful information when debugging a recent EEH subsystem bug.

The standard WARN output should also get picked up by monitoring
tools like kerneloops.

The register dump is of questionable value here but I figured it was
better to use something standard and not roll my own.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-build.orig/arch/powerpc/platforms/pseries/eeh.c	2012-04-13 10:29:53.576534339 +1000
+++ linux-build/arch/powerpc/platforms/pseries/eeh.c	2012-04-13 10:51:22.592822459 +1000
@@ -489,7 +489,7 @@ int eeh_dn_check_failure(struct device_n
 	 * a stack trace will help the device-driver authors figure
 	 * out what happened.  So print that out.
 	 */
-	dump_stack();
+	WARN(1, "EEH: failure detected\n");
 	return 1;
 
 dn_unlock:
