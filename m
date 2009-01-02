Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 29721DE0B6
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jan 2009 08:04:54 +1100 (EST)
From: Milton Miller <miltonm@bga.com>
To: Simon Horman <horms@verge.net.au>, <kexec@lists.infradead.org> 
Message-Id: <kexec-29-1-5r.miltonm@bga.com>
In-Reply-To: <kexec-29-1.miltonm@bga.com>
Subject: [PATCH kexec-tools 5/5] entry wants to be void *
Date: Fri, 02 Jan 2009 15:04:51 -0600
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The kexec info struct defines entry to be a void *, so pass around the
user supplied value as one.

This fixes the following warning:

gcc -g -O2 -fno-strict-aliasing -Wall -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ -I./kexec/arch/ppc64/include  -c -MD -o kexec/kexec.o kexec/kexec.c
kexec/kexec.c: In function ‘my_load’:
kexec/kexec.c:773: warning: assignment makes pointer from integer without a cast

Signed-off-by: Milton Miller <miltonm@bga.com>
---

Index: kexec-tools/kexec/kexec.c
===================================================================
--- kexec-tools.orig/kexec/kexec.c	2009-01-02 02:54:37.000000000 -0600
+++ kexec-tools/kexec/kexec.c	2009-01-02 02:55:06.000000000 -0600
@@ -666,7 +666,7 @@ static void update_purgatory(struct kexe
  *	Load the new kernel
  */
 static int my_load(const char *type, int fileind, int argc, char **argv,
-		   unsigned long kexec_flags, unsigned long entry)
+		   unsigned long kexec_flags, void *entry)
 {
 	char *kernel;
 	char *kernel_buf;
@@ -846,23 +846,20 @@ static int my_exec(void)
 
 static int kexec_loaded(void);
 
-static int load_jump_back_helper_image(unsigned long kexec_flags,
-				       unsigned long entry)
+static int load_jump_back_helper_image(unsigned long kexec_flags, void *entry)
 {
 	int result;
 	struct kexec_segment seg;
 
 	memset(&seg, 0, sizeof(seg));
-	result = kexec_load((void *)entry, 1, &seg,
-			    kexec_flags);
+	result = kexec_load(entry, 1, &seg, kexec_flags);
 	return result;
 }
 
 /*
  *	Jump back to the original kernel
  */
-static int my_load_jump_back_helper(unsigned long kexec_flags,
-				    unsigned long entry)
+static int my_load_jump_back_helper(unsigned long kexec_flags, void *entry)
 {
 	int result;
 
@@ -1036,7 +1033,7 @@ int main(int argc, char *argv[])
 	int do_ifdown = 0;
 	int do_unload = 0;
 	int do_reuse_initrd = 0;
-	unsigned long entry = 0;
+	void *entry = 0;
 	char *type = 0;
 	char *endptr;
 	int opt;
@@ -1096,7 +1093,7 @@ int main(int argc, char *argv[])
 			kexec_flags = KEXEC_PRESERVE_CONTEXT;
 			break;
 		case OPT_ENTRY:
-			entry = strtoul(optarg, &endptr, 0);
+			entry = (void *)strtoul(optarg, &endptr, 0);
 			if (*endptr) {
 				fprintf(stderr,
 					"Bad option value in --load-jump-back-helper=%s\n",
