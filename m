Subject: Re: proposed patch for cross compiling from Solaris 2.8
From: Jean-Christophe Dubois <jdubois@mc.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Bret Indrelee <Bret.Indrelee@qlogic.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20040709014853.GQ23135@smtp.west.cox.net>
References: <Pine.LNX.4.44.0407060823120.2040-100000@spider.ancor.com>
	 <1089121664.31278.264.camel@fr-jdubois1.ad.mc.com>
	 <1089125860.18578.12.camel@fr-jdubois1.ad.mc.com>
	 <1089279330.18578.2175.camel@fr-jdubois1.ad.mc.com>
	 <20040709014853.GQ23135@smtp.west.cox.net>
Content-Type: text/plain
Message-Id: <1089363994.1947.43.camel@fr-jdubois1.ad.mc.com>
Mime-Version: 1.0
Date: Fri, 09 Jul 2004 11:06:34 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2004-07-09 at 03:48, Tom Rini wrote:
> Sadly, it looks like Cygwin (the other odd host to build a linux kernel on)
> lacks <inttypes.h>.

too bad :(

So here is another shot at it:

--- linux-2.6.7/scripts/sumversion.c    Wed Jun 16 01:19:43 2004
+++ 2.6/scripts/sumversion.c    Fri Jul  9 04:10:27 2004
@@ -1,5 +1,9 @@
 #include <netinet/in.h>
+#ifdef __sun__
+#include <inttypes.h>
+#else // __sun__
 #include <stdint.h>
+#endif // __sun__
 #include <ctype.h>
 #include <errno.h>
 #include <string.h>
--- linux-2.6.7/scripts/genksyms/genksyms.c     Wed Jun 16 01:19:23 2004
+++ 2.6/scripts/genksyms/genksyms.c     Thu Jul  8 11:04:04 2004
@@ -27,7 +27,9 @@
 #include <unistd.h>
 #include <assert.h>
 #include <stdarg.h>
+#ifdef __GNU_LIBRARY__
 #include <getopt.h>
+#endif /* __GNU_LIBRARY__ */

 #include "genksyms.h"

@@ -502,12 +504,21 @@
        fputs("Usage:\n"
              "genksyms [-dDwqhV] > /path/to/.tmp_obj.ver\n"
              "\n"
+#ifdef __GNU_LIBRARY__
              "  -d, --debug           Increment the debug level
(repeatable)\n"
              "  -D, --dump            Dump expanded symbol defs (for
debugging only)\n"
              "  -w, --warnings        Enable warnings\n"
              "  -q, --quiet           Disable warnings (default)\n"
              "  -h, --help            Print this message\n"
              "  -V, --version         Print the release version\n"
+#else  /* __GNU_LIBRARY__ */
+             "  -d                    Increment the debug level
(repeatable)\n"
+             "  -D                    Dump expanded symbol defs (for
debugging only)\n"
+             "  -w                    Enable warnings\n"
+             "  -q                    Disable warnings (default)\n"
+             "  -h                    Print this message\n"
+             "  -V                    Print the release version\n"
+#endif /* __GNU_LIBRARY__ */
              , stderr);
 }

@@ -516,6 +527,7 @@
 {
   int o;

+#ifdef __GNU_LIBRARY__
   struct option long_opts[] = {
     {"debug", 0, 0, 'd'},
     {"warnings", 0, 0, 'w'},
@@ -528,6 +540,9 @@

   while ((o = getopt_long(argc, argv, "dwqVDk:p:",
                          &long_opts[0], NULL)) != EOF)
+#else  /* __GNU_LIBRARY__ */
+  while ((o = getopt(argc, argv, "dwqVDk:p:")) != EOF)
+#endif /* __GNU_LIBRARY__ */
     switch (o)
       {
       case 'd':
--- linux-2.6.7/arch/ppc/boot/utils/mkbugboot.c Wed Jun 16 01:19:36 2004
+++ 2.6/arch/ppc/boot/utils/mkbugboot.c Fri Jul  9 04:11:43 2004
@@ -21,6 +21,11 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <fcntl.h>
+#ifdef __sun__
+#include <inttypes.h>
+#else // __sun__
+#include <stdint.h>
+#endif // __sun__

 #ifdef __i386__
 #define cpu_to_be32(x) le32_to_cpu(x)
@@ -48,11 +53,6 @@

 /* size of read buffer */
 #define SIZE 0x1000
-
-/* typedef long int32_t; */
-typedef unsigned long uint32_t;
-typedef unsigned short uint16_t;
-typedef unsigned char uint8_t;

 /* PPCBUG ROM boot header */
 typedef struct bug_boot_header {


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
