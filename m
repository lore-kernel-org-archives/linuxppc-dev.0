Message-ID: <37584905.8886A497@vanderbilt.edu>
Date: Fri, 04 Jun 1999 16:45:41 -0500
From: "Marcus H. Mendenhall" <marcus.h.mendenhall@vanderbilt.edu>
MIME-Version: 1.0
To: contribute@opendx.org, linuxppc-dev@lists.linuxppc.org
Subject: DX on LinuxPPC (working, sort of!)
Content-Type: multipart/mixed;
 boundary="------------080C4F3150513BF1F17FB24B"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------080C4F3150513BF1F17FB24B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I have sort of got a running copy of DX on my LinuxPPC R4 system on a
Powermac G3/300 running.  There are some bizarre user interface bugs
(buttons keep getting bigger everytime a panel updates), but the diffs
attached below are at least enough to make it compile and run.  For some
reason, I also have to manually start the server (dxexec -r &) and then
connect to port 1900 to get things working.  A major problem was that
libpthreads breaks some internal handling of the errno global variable,
so I disabled it in the configure.in script for linuxppc.

If anyone else out there is working on this, please let me know.

Marcus Mendenhall
Vanderbilt University
--------------080C4F3150513BF1F17FB24B
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="43574945";
 name="dx.19990604.diff"
Content-Description: Unknown Document
Content-Disposition: inline;
 filename="dx.19990604.diff"
Content-Transfer-Encoding: 7bit

diff -r -U4 -x Makefile -x *.o -x *.a -x *.so dx-4.0.1/aclocal.m4 dx-4.0.1.mhm/aclocal.m4
--- dx-4.0.1/aclocal.m4	Thu May 27 15:43:09 1999
+++ dx-4.0.1.mhm/aclocal.m4	Fri Jun  4 15:20:02 1999
@@ -285,15 +285,18 @@
     if test $unameS = "CYGWIN_95-4.0" ; then
     	ARCH=cygwin
     fi
     if test $unameS = "Linux" ; then
-	isit=`echo $unameM | egrep "i.86"`
-	if test ! -z "$isit" ; then
-	    ARCH=linux86 
-	else
-	    ARCH=unknown 
-	fi
-    fi
+        isit=`echo $unameM | egrep "i.86"`
+        if test ! -z "$isit" ; then
+            ARCH=linux86
+        elif test $unameM = "ppc" ; then
+            ARCH="linuxppc"
+        else
+            ARCH=unknown
+        fi
+    fi  
+
     if test $unameS = "IRIX" || test $unameS = "IRIX64" ; then
     	ARCH=sgi
     fi
     if test $unameS = "AIX" ; then

diff -r -U4 -x Makefile -x *.o -x *.a -x *.so dx-4.0.1/bin/dx.workerscript dx-4.0.1.mhm/bin/dx.workerscript
--- dx-4.0.1/bin/dx.workerscript	Wed Mar 24 09:17:20 1999
+++ dx-4.0.1.mhm/bin/dx.workerscript	Wed Jun  2 09:54:52 1999
@@ -109,10 +109,15 @@
 
     breaksw
 
   case Linux:
-    set exarch=linux86
-    set uiarch=linux86
+	if ($thismach == "ppc") then
+		set exarch="linuxppc"
+		set uiarch="linuxppc"
+	else
+	    set exarch=linux86
+	    set uiarch=linux86
+	endif
 
     set remote=/usr/bin/rsh
 
     breaksw
@@ -1438,8 +1443,9 @@
   case solaris:
   case aviion:
   case alphax:
   case linux86:
+  case linuxppc:
     breaksw
   
   default:
     echo "DX user interface does not run on this architecture"
     if test $unameS = "Linux" ; then

diff -r -U4 -x Makefile -x *.o -x *.a -x *.so dx-4.0.1/configure.in dx-4.0.1.mhm/configure.in
--- dx-4.0.1/configure.in	Thu May 27 15:32:01 1999
+++ dx-4.0.1.mhm/configure.in	Fri Jun  4 15:19:56 1999
@@ -88,9 +88,13 @@
 dnl A couple libs for cygwin
 AC_CHECK_LIB(ICE, IceConnectionNumber)
 AC_CHECK_LIB(SM, SmcSetProperties)
 AC_CHECK_LIB(REXP, regcomp)
+
+if test "$ARCH" != "linuxppc" ; then
 AC_CHECK_LIB(pthread, pthread_getspecific)
+fi
+
 
 DX_CHECK_HEADERS(fcntl.h limits.h malloc.h strings.h sys/file.h sys/ioctl.h sys/time.h unistd.h sys/types.h sys/sysconfig.h sys/un.h values.h wait.h sys/wait.h sys/utsname.h signal.h sys/signal.h process.h sys/filio.h CC/osfcn.h CC/libc.h )
 AC_CHECK_FUNCS(getcwd gethostname gettimeofday mkdir mkfifo mktime putenv re_comp regcmp select socket strcspn strdup strerror strspn strstr strtod strtol strtoul uname popen vfork trunc _popen spawnvp _spawnvp regcomp sysmp sysconf)
 
diff -r -U4 -x Makefile -x *.o -x *.a -x *.so dx-4.0.1/include/dx/arch.h dx-4.0.1.mhm/include/dx/arch.h
--- dx-4.0.1/include/dx/arch.h	Mon May 10 10:45:10 1999
+++ dx-4.0.1.mhm/include/dx/arch.h	Wed Jun  2 09:26:40 1999
@@ -106,9 +106,9 @@
 
 /* program to run for remote shell */
 #define RSH "/usr/bin/rsh"
 
-#ifdef linux86
+#if defined(linux86) || defined(linuxppc)
 
 #undef F_CHAR_READY
 #define F_CHAR_READY(fp) ((fp)->_IO_read_ptr < (fp)->_IO_read_end)
 
diff -r -U4 -x Makefile -x *.o -x *.a -x *.so dx-4.0.1/src/exec/dpexec/lex.c dx-4.0.1.mhm/src/exec/dpexec/lex.c
--- dx-4.0.1/src/exec/dpexec/lex.c	Wed May 19 12:07:18 1999
+++ dx-4.0.1.mhm/src/exec/dpexec/lex.c	Wed Jun  2 09:26:40 1999
@@ -9,9 +9,9 @@
 #include <dxconfig.h>
 
 
 /* this has to be before stdio.h gets included. */
-#if !defined(os2) && !defined(linux86)
+#if !defined(os2) && !defined(linux86) && !defined(linuxppc)
 #ifdef GETC
 #undef GETC
 #endif
 #define GETC	getc
diff -r -U4 -x Makefile -x *.o -x *.a -x *.so dx-4.0.1/src/exec/dpexec/loader.c dx-4.0.1.mhm/src/exec/dpexec/loader.c
--- dx-4.0.1/src/exec/dpexec/loader.c	Thu May 20 10:14:43 1999
+++ dx-4.0.1.mhm/src/exec/dpexec/loader.c	Wed Jun  2 09:26:40 1999
@@ -84,9 +84,9 @@
 
 #endif /* hp700 */
 
 
-#if defined(sun4) || defined(solaris) || defined(sgi) || defined(alphax) || defined(aviion) || defined(linux86) || defined(cygwin)
+#if defined(sun4) || defined(solaris) || defined(sgi) || defined(alphax) || defined(aviion) || defined(linux86) || defined(cygwin) || defined(linuxppc)
 
 #include <dlfcn.h>
 typedef void *Handle;
 #define __HANDLE_DEF
@@ -101,9 +101,9 @@
 #define dlerror _dlerror
 #endif
 
 
-#endif /* sun4 or solaris or sgi or alpha or aviion of linux86 */
+#endif /* sun4 or solaris or sgi or alpha or aviion or linux86 or linuxppc  */
 
 
 /* default for unsupported platforms */
 #ifndef __HANDLE_DEF
@@ -573,9 +573,9 @@
 
 #endif  /* hp700 */
 
 
-#if defined(sun4) || defined(solaris) || defined(sgi) || defined(alphax) || defined(aviion) || defined(linux86) || defined(cygwin)
+#if defined(sun4) || defined(solaris) || defined(sgi) || defined(alphax) || defined(aviion) || defined(linux86) || defined(cygwin) || defined(linuxppc)
 
 
 #define __ROUTINES_DEF
 
diff -r -U4 -x Makefile -x *.o -x *.a -x *.so dx-4.0.1/src/exec/dxmods/_compoper1.c dx-4.0.1.mhm/src/exec/dxmods/_compoper1.c
--- dx-4.0.1/src/exec/dxmods/_compoper1.c	Mon May 10 10:45:17 1999
+++ dx-4.0.1.mhm/src/exec/dxmods/_compoper1.c	Wed Jun  2 09:26:40 1999
@@ -456,8 +456,11 @@
 #endif
 #ifdef cygwin
 #   define trunc(x) ((float)((int)(x)))
 #endif
+#ifdef linuxppc
+#   define trunc(x) ((float)((int)(x)))
+#endif
 #ifdef linux86
 #   define trunc(x) ((float)((int)(x)))
 #endif
 #ifdef aviion
diff -r -U4 -x Makefile -x *.o -x *.a -x *.so dx-4.0.1/src/exec/libdx/memory.c dx-4.0.1.mhm/src/exec/libdx/memory.c
--- dx-4.0.1/src/exec/libdx/memory.c	Thu May 27 10:53:48 1999
+++ dx-4.0.1.mhm/src/exec/libdx/memory.c	Wed Jun  2 09:26:40 1999
@@ -1017,8 +1017,21 @@
 #define SMALL(x) ((int)x<(int)large)
 #define LARGE(x) ((int)x>=(int)large)
 #endif
 
+#ifdef	linuxppc
+#define initvalues
+#define SMALL_BASE    0               /* use data segment */
+#define SMALL_GET     _dxfgetmem      /* expand by using DosSetMem */
+#define LARGE_GET     _dxfgetmem      /* expand by using DosSetMem */
+#define LARGE_INIT    2 MEG           /* doesn't matter; consistent w/ sgi */
+#define LARGE_INCR    2 MEG           /* doesn't matter; consistent w/ sgi */
+#define SIZE_ROUND    2 MEG           /* doesn't matter; consistent w/ sgi */
+#define MALLOC_NONE   1               /* provide malloc from global arena */
+#define SMALL(x) ((int)x<(int)large)
+#define LARGE(x) ((int)x>=(int)large)
+#endif
+
 #ifdef	DXD_WIN
 #define initvalues
 #define SMALL_BASE    0               /* use data segment */
 #define SMALL_GET     _dxfgetmem      /* expand by using DosSetMem */
diff -r -U4 -x Makefile -x *.o -x *.a -x *.so dx-4.0.1/src/exec/libdx/message.c dx-4.0.1.mhm/src/exec/libdx/message.c
--- dx-4.0.1/src/exec/libdx/message.c	Mon May 10 10:45:45 1999
+++ dx-4.0.1.mhm/src/exec/libdx/message.c	Wed Jun  2 09:26:40 1999
@@ -270,9 +270,9 @@
 void
 DXPrintError(char *s)
 {
     extern int sys_nerr;
-#ifndef linux86
+#if !HAVE_SYS_ERRLIST
     extern char *sys_errlist[];
 #endif
     char *msg, *errnomsg;
     static int been_here = 0;
diff -r -U4 -x Makefile -x *.o -x *.a -x *.so dx-4.0.1/src/ui++/dxuilib/Network.C dx-4.0.1.mhm/src/ui++/dxuilib/Network.C
--- dx-4.0.1/src/ui++/dxuilib/Network.C	Tue May 25 19:38:25 1999
+++ dx-4.0.1.mhm/src/ui++/dxuilib/Network.C	Wed Jun  2 09:26:40 1999
@@ -1184,9 +1184,9 @@
 {
 extern
 FILE* yyin;			/* parser input stream	  */
 
-#if defined(linux86)  || defined(cygwin)
+#if defined(linux86)  || defined(cygwin) || defined(linuxppc)
 int yylineno;
 #else
 extern int yylineno;			/* lexer line number      */
 #endif
diff -r -U4 -x Makefile -x *.o -x *.a -x *.so dx-4.0.1/src/ui++/dxuilib/PacketIF.C dx-4.0.1.mhm/src/ui++/dxuilib/PacketIF.C
--- dx-4.0.1/src/ui++/dxuilib/PacketIF.C	Mon May 10 10:46:16 1999
+++ dx-4.0.1.mhm/src/ui++/dxuilib/PacketIF.C	Wed Jun  2 09:26:40 1999
@@ -21,9 +21,9 @@
 
 #include "Application.h"
 #include "ErrorDialogManager.h"
 
-#if defined(linux86) || defined(cygwin)
+#if defined(linux86) || defined(cygwin) || defined(linuxppc)
 extern "C" {
 #include <errno.h>
 }
 #else
@@ -1361,9 +1361,9 @@
     ushort port;
     int fd;
     int sts;
     int oldPort;
-#if !defined(linux86) && !defined(cygwin)
+#if !defined(linux86) && !defined(cygwin) && !defined(linuxppc)
     extern int errno;
 #endif
     int tries;
     fd_set fds;
diff -r -U4 -x Makefile -x *.o -x *.a -x *.so dx-4.0.1/src/ui++/startup/StartupWindow.C dx-4.0.1.mhm/src/ui++/startup/StartupWindow.C
--- dx-4.0.1/src/ui++/startup/StartupWindow.C	Mon May 10 10:46:29 1999
+++ dx-4.0.1.mhm/src/ui++/startup/StartupWindow.C	Wed Jun  2 09:26:40 1999
@@ -64,9 +64,9 @@
 // went away and that it's ok to start another one when the user asks.
 // On these platforms, the pipe doesn't work that way so we'll make a
 // polling loop that runs once every few seconds and checks the child pid.
 //
-#if defined(ibm6000) || defined(hp700) || defined(alphax) || defined(sun4) || defined(linux86) || defined(cygwin)
+#if defined(ibm6000) || defined(hp700) || defined(alphax) || defined(sun4) || defined(linux86) || defined(cygwin) || defined(linuxppc)
 #define USE_WAIT3 1
 #endif
 
 #if USE_WAIT3

--------------080C4F3150513BF1F17FB24B--


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
