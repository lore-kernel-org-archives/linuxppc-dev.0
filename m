Subject: Re: proposed patch for cross compiling from Solaris 2.8
From: Jean-Christophe Dubois <jdubois@mc.com>
To: Bret Indrelee <Bret.Indrelee@qlogic.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <1089125860.18578.12.camel@fr-jdubois1.ad.mc.com>
References: <Pine.LNX.4.44.0407060823120.2040-100000@spider.ancor.com>
	 <1089121664.31278.264.camel@fr-jdubois1.ad.mc.com>
	 <1089125860.18578.12.camel@fr-jdubois1.ad.mc.com>
Content-Type: text/plain
Message-Id: <1089279330.18578.2175.camel@fr-jdubois1.ad.mc.com>
Mime-Version: 1.0
Date: Thu, 08 Jul 2004 11:35:31 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I rewrote my patches to be a little more well behaved in regards to non
linux systems.

Any feedback is welcome. Once again this is just to enable Solaris 2.8
(and others?) to be a valid host to cross-compile the 2.6 Linux Kernel
(for PPC).

Regards

JC

--- linux-2.6.7/arch/ppc/boot/utils/mkbugboot.c Wed Jun 16 01:19:36 2004
+++ linux-2.6.7.work/arch/ppc/boot/utils/mkbugboot.c    Wed Jul  7
05:45:55 2004
@@ -21,6 +21,7 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <inttypes.h>

 #ifdef __i386__
 #define cpu_to_be32(x) le32_to_cpu(x)
@@ -48,11 +49,6 @@

 /* size of read buffer */
 #define SIZE 0x1000
-
-/* typedef long int32_t; */
-typedef unsigned long uint32_t;
-typedef unsigned short uint16_t;
-typedef unsigned char uint8_t;

 /* PPCBUG ROM boot header */
 typedef struct bug_boot_header {
--- linux-2.6.7/scripts/genksyms/genksyms.c     Wed Jun 16 01:19:23 2004
+++ linux-2.6.7.work/scripts/genksyms/genksyms.c        Wed Jul  7
05:58:24 2004
@@ -27,7 +27,9 @@
 #include <unistd.h>
 #include <assert.h>
 #include <stdarg.h>
+#ifdef __GNU_LIBRARY__
 #include <getopt.h>
+#endif // __GNU_LIBRARY__

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
+#else // __GNU_LIBRARY__
+             "  -d                    Increment the debug level
(repeatable)\n"
+             "  -D                    Dump expanded symbol defs (for
debugging only)\n"
+             "  -w                    Enable warnings\n"
+             "  -q                    Disable warnings (default)\n"
+             "  -h                    Print this message\n"
+             "  -V                    Print the release version\n"
+#endif // __GNU_LIBRARY__
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
+#else // __GNU_LIBRARY__
+  while ((o = getopt(argc, argv, "dwqVDk:p:")) != EOF)
+#endif // __GNU_LIBRARY__
     switch (o)
       {
       case 'd':
--- linux-2.6.7/scripts/sumversion.c    Wed Jun 16 01:19:43 2004
+++ linux-2.6.7.work/scripts/sumversion.c       Wed Jul  7 05:52:12 2004
@@ -1,5 +1,5 @@
 #include <netinet/in.h>
-#include <stdint.h>
+#include <inttypes.h>
 #include <ctype.h>
 #include <errno.h>
 #include <string.h>


On Tue, 2004-07-06 at 16:57, Jean-Christophe Dubois wrote:
> On Tue, 2004-07-06 at 15:47, Jean-Christophe Dubois wrote:
> > Sorry but stdint.h is not present on my Solaris 2.8 system. There is
> > little I can do about this. So maybe Solaris doesn't respect the
> > standard somewhere but ...
> >
>
> I guess the problem here is that Solaris 2.8 is not necessarily
> compliant with "The Open Group Base Specifications Issue 6"/IEEE Std
> 1003.1-2001-conforming systems. But should it disqualify it as an host
> platform?
>
> http://www.opengroup.org/onlinepubs/009695399/basedefs/stdint.h.html
>
> On the other hand Solaris 2.8 does support <inttypes.h> which could do
> the trick
>
> http://www.opengroup.org/onlinepubs/009695399/basedefs/inttypes.h.html
>
> > > Even
> > > the getopt changes shouldn't be required, you should be using the
> > > version of getopt that came with your package.
> >
> > Same here getopt.h is not part of solaris headers. Solaris does not seem
> > to support getopt_long() and getopt() prototype is part of stdio.h,
> > stdlib.h or unistd.h. But no getopt.h on the horizon ... Should use one
> > of the other mentioned files.
>
> getopt_long() is not part of any IEEE standard (AFAIK) and getopt.h is
> not part of IEEE Std 1003.1-2001-conforming systems. This seems to be
> very GNU specific and not part of Solaris base system (so far).
>
> http://www.opengroup.org/onlinepubs/009695399/functions/getopt.html
>
> >
> > >
> > > Are you sure that you've specified -nostdinc -nostdlib and given the
> > > proper list of locations for the cross-compile system includes when
> > > compiling?
> >
> > For what I understand these programs (the ones build from the source I
> > modified) should not be cross-compiled but build for the host platform
> > (here Solaris) with the native compiler. Am I wrong?
> >
> > Oh and I didn't specify any particular -nostdinc -nostdlib flag
> > anywhere. I am just using the standard Linux 2.6.7 Makefile. The command
> > used is:
> >
> > make ARCH=ppc CROSS_COMPILE=powerpc-7400-linux-gnu-
> >
> > JC
> >
> > >
> > > -Bret
> >
> >
> --
> Jean-Christophe Dubois <jdubois@mc.com>
> Mercury Computer Systems
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
