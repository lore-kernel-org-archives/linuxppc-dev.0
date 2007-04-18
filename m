Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Fastboot mailing list <fastboot@lists.osdl.org>
MIME-Version: 1.0
Subject: [PATCH] kexec-tools: remove initrd_found
Date: Wed, 18 Apr 2007 17:02:01 +1000
Message-ID: <24736.1176879721@neuling.org>
Cc: linuxppc-dev@ozlabs.org, horms@verge.net.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

initrd_found is not used, so remove it.  Minor cleanup. 

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
Horms: this applies to your testing tree.

 kexec/arch/ppc64/fs2dt.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

Index: kexec-tools-testing/kexec/arch/ppc64/fs2dt.c
===================================================================
--- kexec-tools-testing.orig/kexec/arch/ppc64/fs2dt.c
+++ kexec-tools-testing/kexec/arch/ppc64/fs2dt.c
@@ -43,7 +43,6 @@ static char propnames[NAMESPACE] = { 0 }
 static unsigned dtstruct[TREEWORDS], *dt;
 static unsigned long long mem_rsrv[2*MEMRESERVE] = { 0, 0 };
 
-static int initrd_found = 0;
 static int crash_param = 0;
 static char local_cmdline[COMMAND_LINE_SIZE] = { "" };
 static unsigned *dt_len; /* changed len of modified cmdline
@@ -343,10 +342,8 @@ static void putnode(void)
 
 	putprops(dn, namelist, numlist);
 
-	/* Add initrd entries to the second kernel if first kernel does not
-	 * have and second kernel needs.
-	 */
-	if (initrd_base && !initrd_found && !strcmp(basename,"/chosen/")) {
+	/* Add initrd entries to the second kernel */
+	if (initrd_base && !strcmp(basename,"/chosen/")) {
 		int len = 8;
 		unsigned long long initrd_end;
 		*dt++ = 3;
