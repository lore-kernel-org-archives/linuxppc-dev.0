Date: Tue, 13 Feb 2001 18:29:40 -0600 (CST)
From: Grant Erickson <erick205@umn.edu>
To: Mark Hatle <fray@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Patch for Soft-Float Problems w/ Glibc & Gcc?
In-Reply-To: <3A8974B8.D197FEC9@mvista.com>
Message-Id: <Pine.SOL.4.20.0102131818490.5715-100000@garnet.tc.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 13 Feb 2001, Mark Hatle wrote:
> Grant Erickson wrote:
> > For some time I've noted but have never bothered chasing down the *printf
> > problems associated with using -msoft-float/-D_SOFT_FLOAT on Linux/PPC.
> >
> > Needing to remedy the issue, I started chasing it down using the code
> > samples below. When compiled using just '$(CROSS_COMPILE)gcc -o pi-test
> > *.c' everything works fine:
> >
> > ...
>
> I believe we fixed this problem around CDK 1.2 time.  Unfortunatly I
> don't remember what we did to fix the problem.  I am almost sure it has
> to do with the spec file for gcc.  (not rpm spec, but the
> ...lib/gcc-lib/2.95.2/spec.
>
> Give the CDK 1.2 compiler a try on that code and see if it fixes the
> problem you are having.  (Keep in mind that you will also need to use
> the glibc provided.  The floating point printf fix effects both glibc
> and gcc.)

The one patch that makes the difference is the following:

diff -urN gcc-2.95.2.orig/gcc/config/rs6000/linux-nfp.h gcc-2.95.2/gcc/config/rs6000/linux-nfp.h
--- gcc-2.95.2.orig/gcc/config/rs6000/linux-nfp.h       Wed Dec 31 16:00:00 1969
+++ gcc-2.95.2/gcc/config/rs6000/linux-nfp.h    Tue May 30 18:34:05 2000
@@ -0,0 +1,34 @@
+/* Target definitions for GNU compiler for PowerPC running System V.4
+   Copyright (C) 1995, 1996, 1997, 1998, 1999 Free Software Foundation,
Inc.
+   Contributed by Cygnus Support.
+
+Default to soft floating point.
+
+This file is part of GNU CC.
+
+GNU CC is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 2, or (at your option)
+any later version.
+
+GNU CC is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with GNU CC; see the file COPYING.  If not, write to
+the Free Software Foundation, 59 Temple Place - Suite 330,
+Boston, MA 02111-1307, USA.  */
+
+#include "linux.h"
+
+#undef CPP_SYSV_SPEC
+#define CPP_SYSV_SPEC \
+"%{mrelocatable*: -D_RELOCATABLE} \
+%{fpic: -D__PIC__=1 -D__pic__=1} \
+%{!fpic: %{fPIC: -D__PIC__=2 -D__pic__=2}} \
+%{mcall-sysv: -D_CALL_SYSV} %{mcall-nt: -D_CALL_NT} \
+%{mcall-aix: -D_CALL_AIX} %{mcall-aixdesc: -D_CALL_AIX -D_CALL_AIXDESC} \
+%{!mcall-sysv: %{!mcall-aix: %{!mcall-aixdesc: %{!mcall-nt: %(cpp_sysv_default) }}}} \
+%{!mhard-float: -D_SOFT_FLOAT} %{mcpu=403: -D_SOFT_FLOAT}"
diff -urN gcc-2.95.2.orig/gcc/configure gcc-2.95.2/gcc/configure
--- gcc-2.95.2.orig/gcc/configure       Wed Oct 13 00:58:02 1999
+++ gcc-2.95.2/gcc/configure    Tue May 30 18:27:12 2000
@@ -5127,7 +5127,12 @@
                fi
                ;;
        powerpc-*-linux-gnu*)
-               tm_file=rs6000/linux.h
+               if test x$with_fp = xno
+               then
+                       tm_file=rs6000/linux-nfp.h
+               else
+                       tm_file=rs6000/linux.h
+               fi
                xm_file="xm-siglist.h rs6000/xm-sysv4.h"
                xm_defines="USG ${xm_defines}"
                out_file=rs6000/rs6000.c

This is included with all of the other non-FPU patches typically applied
for the 4xx or 8xx processors. The one single difference that this has is
on the spec file produced for gcc. What was:

*cpp_sysv:
[ ... some stuff ... ] {msoft-float: -D_SOFT_FLOAT} [ ... more stuff ... ]

changes to:

*cpp_sysv:
[ ... some stuff ... ] {!mhard-float: -D_SOFT_FLOAT} [ ... more stuff ... ]

After regenerating gcc 2.95.3-test3 and glibc 2.1.3, the results are
promising:

	grant@stcroix% ./pi-test-hard
	The value of Pi is approximately: 3.142857

	grant@stcroix% ./pi-test-soft
	The value of Pi is approximately: 3.142857

Thanks a lot to those who offered suggestions over the course of the day!

Best regards,

Grant Erickson


--
 Grant Erickson                       University of Minnesota Alumni
  o mail:erick205@umn.edu                                 1996 BSEE
  o http://www.umn.edu/~erick205                          1998 MSEE


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
