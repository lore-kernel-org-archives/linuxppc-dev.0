Return-Path: <mikey@ozlabs.org>
From: Michael Neuling <mikey@neuling.org>
To: linuxppc-dev@ozlabs.org, Fastboot mailing list <fastboot@lists.osdl.org>
MIME-Version: 1.0
Subject: [PATCH] kexec ppc64: fix segv when missing root= on cmdline
Date: Tue, 30 May 2006 15:02:08 +1000
Sender: mikey@ozlabs.org
Message-Id: <20060530050325.389A367A5C@ozlabs.org>
Cc: miltonm@bga.com
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If the first kernel command line or the --command-line parameter doesn't
have a 'root=', we seg fault on ppc64.

Patch below is against Maneesh's kexec-tools-1.101-kdump8 patches.  

Signed-off-by: Michael Neuling <mikey@neuling.org>

--
 kexec/arch/ppc64/fs2dt.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

Index: kexec-tools-1.101/kexec/arch/ppc64/fs2dt.c
===================================================================
--- kexec-tools-1.101.orig/kexec/arch/ppc64/fs2dt.c
+++ kexec-tools-1.101/kexec/arch/ppc64/fs2dt.c
@@ -267,10 +267,12 @@ void putprops(char *fn, struct dirent **
 					char *old_param;
 					memcpy(temp_cmdline, dt, len);
 					param = strstr(temp_cmdline, "root=");
-					old_param = strtok(param, " ");
-					if (cmd_len != 0)
-						strcat(local_cmdline, " ");
-					strcat(local_cmdline, old_param);
+					if (param) {
+						old_param = strtok(param, " ");
+						if (cmd_len != 0)
+							strcat(local_cmdline, " ");
+						strcat(local_cmdline, old_param);
+					}
 				}
 				strcat(local_cmdline, " ");
 				cmd_len = strlen(local_cmdline);
