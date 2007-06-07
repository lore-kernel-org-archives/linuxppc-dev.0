Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org,
	horms@verge.net.au, kexec@lists.infradead.org,
	Santhosh Rao <sonny@burdell.org>
Subject: [PATCH] kexec ppc64: fix misaligned cmdline 
In-reply-to: <26608.1180950136@neuling.org> 
References: <25445.1180941825@neuling.org>
	<8f5d8a214e9042b0c556ac7256928a52@bga.com>
	<26608.1180950136@neuling.org>
Date: Thu, 07 Jun 2007 11:19:22 +1000
Message-ID: <10188.1181179162@neuling.org>
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
kills our kexec boot.  Also, if there was no /chosen/bootargs
previously, we'd never add a new one. 

This ignores the bootargs while parsing the tree and inserts it later. 

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
This hopefully address issues raised by Milton.  

 kexec/arch/ppc64/fs2dt.c |   95 +++++++++++++++++++++++++++++++----------------
 1 file changed, 63 insertions(+), 32 deletions(-)

Index: kexec-tools-testing/kexec/arch/ppc64/fs2dt.c
===================================================================
--- kexec-tools-testing.orig/kexec/arch/ppc64/fs2dt.c
+++ kexec-tools-testing/kexec/arch/ppc64/fs2dt.c
@@ -18,6 +18,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#define _GNU_SOURCE
 #include <sys/types.h>
 #include <sys/stat.h>
 
@@ -233,6 +234,12 @@ static void putprops(char *fn, struct di
 		    !reuse_initrd)
 				continue;
 
+		/* This property will be created later in putnode() So
+		 * ignore it now.
+		 */
+		if (!strcmp(dp->d_name, "bootargs"))
+			continue;
+
 		if (! S_ISREG(statbuf.st_mode))
 			continue;
 
@@ -257,38 +264,6 @@ static void putprops(char *fn, struct di
 
 		checkprop(fn, dt, len);
 
-		/* Get the cmdline from the device-tree and modify it */
-		if (!strcmp(dp->d_name, "bootargs")) {
-			int cmd_len;
-			char temp_cmdline[COMMAND_LINE_SIZE] = { "" };
-			char *param = NULL;
-			cmd_len = strlen(local_cmdline);
-			if (cmd_len != 0) {
-				param = strstr(local_cmdline, "crashkernel=");
-				if (param)
-					crash_param = 1;
-				param = strstr(local_cmdline, "root=");
-			}
-			if (!param) {
-				char *old_param;
-				memcpy(temp_cmdline, dt, len);
-				param = strstr(temp_cmdline, "root=");
-				if (param) {
-					old_param = strtok(param, " ");
-					if (cmd_len != 0)
-						strcat(local_cmdline, " ");
-					strcat(local_cmdline, old_param);
-				}
-			}
-			strcat(local_cmdline, " ");
-			cmd_len = strlen(local_cmdline);
-			cmd_len = cmd_len + 1;
-			memcpy(dt, local_cmdline,cmd_len);
-			len = cmd_len;
-			*dt_len = cmd_len;
-			fprintf(stderr, "Modified cmdline:%s\n", local_cmdline);
-		}
-
 		dt += (len + 3)/4;
 		if (!strcmp(dp->d_name, "reg") && usablemem_rgns.size)
 			add_usable_mem_property(fd, len);
@@ -385,6 +360,62 @@ static void putnode(void)
 		reserve(initrd_base, initrd_size);
 	}
 
+	/* Add cmdline to the second kernel.  Check to see if the new
+	 * cmdline has a root=.  If not, use the old root= cmdline.  */
+	if (!strcmp(basename,"/chosen/")) {
+		size_t cmd_len = 0;
+		char *param = NULL;
+
+		cmd_len = strlen(local_cmdline);
+		if (cmd_len != 0) {
+			param = strstr(local_cmdline, "crashkernel=");
+			if (param)
+				crash_param = 1;
+			/* does the new cmdline have a root= ? ... */
+			param = strstr(local_cmdline, "root=");
+		}
+
+		/* ... if not, grab root= from the old command line */
+		if (!param) {
+			char filename[MAXPATH];
+			FILE *fp;
+			char *last_cmdline = NULL;
+			char *old_param;
+
+			strcpy(filename, pathname);
+			strcat(filename, "bootargs");
+			fp = fopen(filename, "r");
+			if (fp) {
+				if (getline(&last_cmdline, &cmd_len, fp) == -1)
+					die("unable to read %s\n", filename);
+
+				param = strstr(last_cmdline, "root=");
+				if (param) {
+					old_param = strtok(param, " ");
+					if (cmd_len != 0)
+						strcat(local_cmdline, " ");
+					strcat(local_cmdline, old_param);
+				}
+			}
+			if (last_cmdline)
+				free(last_cmdline);
+		}
+		strcat(local_cmdline, " ");
+		cmd_len = strlen(local_cmdline);
+		cmd_len = cmd_len + 1;
+
+		/* add new bootargs */
+		*dt++ = 3;
+		*dt++ = cmd_len;
+		*dt++ = propnum("bootargs");
+		if ((cmd_len >= 8) && ((unsigned long)dt & 0x4))
+			dt++;
+		memcpy(dt, local_cmdline,cmd_len);
+		dt += (cmd_len + 3)/4;
+
+		fprintf(stderr, "Modified cmdline:%s\n", local_cmdline);
+	}
+
 	for (i=0; i < numlist; i++) {
 		dp = namelist[i];
 		strcpy(dn, dp->d_name);
