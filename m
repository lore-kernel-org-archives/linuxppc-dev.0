Subject: proposed patch for cross compiling from Solaris 2.8
From: Jean-Christophe Dubois <jdubois@mc.com>
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain
Message-Id: <1089105643.31278.228.camel@fr-jdubois1.ad.mc.com>
Mime-Version: 1.0
Date: Tue, 06 Jul 2004 11:20:51 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I got into several issues while trying to cross-compile a Linux 2.6 PPC
kernel from a Solaris 2.8 host (beside getting a valid cross compilation
chain). Mainly some programs compiled on the host are not planned to be
compiled on anything but Linux (The host has to run Linux).

While I understand that it makes more sense to use Linux to (cross)
compile Linux, there are case/companies where this is not (yet) an
option.

So here are few minor modifications (against 2.6.7 from kernel.org) I
had to do to get things going. I guess all of these are not PPC
specific. It just happens I am working with PPC targets.

Regards

JC

--- linux-2.6.7/arch/ppc/boot/utils/mkbugboot.c Wed Jun 16 01:19:36 2004
+++ linux-2.6.7.work/arch/ppc/boot/utils/mkbugboot.c    Tue Jul  6
03:27:50 2004
@@ -49,10 +49,12 @@
 /* size of read buffer */
 #define SIZE 0x1000

+#ifdef __linux__
 /* typedef long int32_t; */
 typedef unsigned long uint32_t;
 typedef unsigned short uint16_t;
 typedef unsigned char uint8_t;
+#endif

 /* PPCBUG ROM boot header */
 typedef struct bug_boot_header {
--- linux-2.6.7/scripts/genksyms/genksyms.c     Wed Jun 16 01:19:23 2004
+++ linux-2.6.7.work/scripts/genksyms/genksyms.c        Mon Jul  5
17:03:19 2004
@@ -27,7 +27,9 @@
 #include <unistd.h>
 #include <assert.h>
 #include <stdarg.h>
+#ifdef __linux__
 #include <getopt.h>
+#endif

 #include "genksyms.h"

@@ -516,6 +518,7 @@
 {
   int o;

+#ifdef __linux__
   struct option long_opts[] = {
     {"debug", 0, 0, 'd'},
     {"warnings", 0, 0, 'w'},
@@ -528,6 +531,9 @@

   while ((o = getopt_long(argc, argv, "dwqVDk:p:",
                          &long_opts[0], NULL)) != EOF)
+#else
+  while ((o = getopt(argc, argv, "dwqVDk:p:")) != EOF)
+#endif
     switch (o)
       {
       case 'd':
--- linux-2.6.7/scripts/sumversion.c    Wed Jun 16 01:19:43 2004
+++ linux-2.6.7.work/scripts/sumversion.c       Mon Jul  5 17:06:20 2004
@@ -1,5 +1,7 @@
 #include <netinet/in.h>
+#ifdef __linux__
 #include <stdint.h>
+#endif
 #include <ctype.h>
 #include <errno.h>
 #include <string.h>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
