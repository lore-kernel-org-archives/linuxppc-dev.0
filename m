Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: horms@verge.net.au
MIME-Version: 1.0
Subject: [PATCH] kexec ppc64: fix misaligned cmdline
Date: Mon, 04 Jun 2007 17:23:45 +1000
Message-ID: <25445.1180941825@neuling.org>
Cc: kexec@lists.infradead.org, miltonm@bga.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If the cmdline changes between boots, we can get misalignment of the
bootargs entry, which in turn corrupts our device tree blob and hence
kills our kexec boot.  

Specifically, if the cmdline length was >= 8 before and the new cmdline
length is < 8, we can get corruption.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 kexec/arch/ppc64/fs2dt.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Index: kexec-tools-testing/kexec/arch/ppc64/fs2dt.c
===================================================================
--- kexec-tools-testing.orig/kexec/arch/ppc64/fs2dt.c
+++ kexec-tools-testing/kexec/arch/ppc64/fs2dt.c
@@ -197,6 +197,7 @@ static void putprops(char *fn, struct di
 	struct dirent *dp;
 	int i = 0, fd, len;
 	struct stat statbuf;
+	int dt_realigned = 0;
 
 	for (i = 0; i < numlist; i++) {
 		dp = nlist[i];
@@ -243,8 +244,10 @@ static void putprops(char *fn, struct di
 		*dt++ = len;
 		*dt++ = propnum(fn);
 
-		if ((len >= 8) && ((unsigned long)dt & 0x4))
+		if ((len >= 8) && ((unsigned long)dt & 0x4)){
 			dt++;
+			dt_realigned = 1;
+		}
 
 		fd = open(pathname, O_RDONLY);
 		if (fd == -1)
@@ -283,6 +286,8 @@ static void putprops(char *fn, struct di
 			strcat(local_cmdline, " ");
 			cmd_len = strlen(local_cmdline);
 			cmd_len = cmd_len + 1;
+			if (dt_realigned && cmd_len < 8)
+				dt--;
 			memcpy(dt, local_cmdline,cmd_len);
 			len = cmd_len;
 			*dt_len = cmd_len;
