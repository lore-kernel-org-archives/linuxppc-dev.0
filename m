Message-ID: <3C8A9DF8.CE2BA33C@kegel.com>
Date: Sat, 09 Mar 2002 15:42:48 -0800
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
MIME-Version: 1.0
To: "libtool@gnu.org" <libtool@gnu.org>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: [patch] make libtool1.4d work when cross-compiling
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The patch
 http://www.kegel.com/libtool-cross-2.patch
appears to fix libtool1.4d so it sets sys_lib_search_path_spec properly,
which is probably required for cross-compiling programs that use libtool.

To test it, I created dummy cross-compiler mycc and linker myld which are just
trivial wrappers around cc and ld, except that mycc --print-search-dirs
prints paths that refer to /old instead of /,
e.g.
   libraries: =/old/usr/lib/gcc-lib/i386-redhat-linux/2.96/:...:/old/usr/lib/
(/old on my machine is an old installation of linux.)

To configure libtool, I created a small configure.in and
Makefile.in, ran libtoolize, copied libtool.m4 to aclocal.m4 as instructed,
ran automake --add-missing just to get install-sh etc.,
ran autoconf, and configured with
   CC=`pwd`/mycc LD=`pwd`/myld ./configure --build=pentium-unknown-linux --host=ppc-unknown-linux
(the exact value for host doesn't matter as long as the processor is different).
To verify whether libtool is configured properly, I run
   ./libtool --config | egrep 'LD|CC|sys_lib_search_path_spec'

Before applying my patch, libtool1.4d --config outputs
   CC="/home/dank/foo/mycc"
   LD="/home/dank/foo/myld"
   sys_lib_search_path_spec="/lib /usr/lib /usr/local/lib"
In other words, the current libtool 1.4d searches the
system libraries instead of the libraries used by the specified compiler.

After applying an earlier version of my patch,
  http://www.kegel.com/libtool-cross.patch,
rerunning autoconf and configure, rerunning libtool --config | grep sys_lib
output
  sys_lib_search_path_spec=" =/old/usr/lib/gcc-lib/i386-redhat-linux/2.96/ ... /old/usr/lib
which looks correct except for that odd = in front.
(There might be a similar bug in the mingw support in libtool, which also uses --print-search-dirs.)

I poked around a bit, and that = appears to be present in the output
of 'gcc --print-search-dirs' on gcc's after 2.95.  Is it a bug in gcc,
or just a strange feature?

I modified the patch a bit to strip the = off.  The resulting patch is
  http://www.kegel.com/libtool-cross-2.patch

I'd appreciate hearing from anyone who's been trying to
cross-compile programs built with libtool about whether
this patch helps them.

Thanks,
Dan

p.s. Here's the patch inline for convenience:

--- libtool.m4.orig     Sat Mar  9 07:28:58 2002
+++ libtool.m4  Sat Mar  9 15:30:52 2002
@@ -984,7 +984,20 @@
 version_type=none
 dynamic_linker="$host_os ld.so"
 sys_lib_dlsearch_path_spec="/lib /usr/lib"
-sys_lib_search_path_spec="/lib /usr/lib /usr/local/lib"
+if test "$GCC" = yes; then
+  sys_lib_search_path_spec=`$CC -print-search-dirs | grep "^libraries:" | sed -e "s/^libraries: *=*//"`
+  if echo "$sys_lib_search_path_spec" | egrep ';' >/dev/null ; then
+    # if the path contains ";" then we assume it to be the separator
+    # otherwise default to the standard path separator (i.e. ":") - it is
+    # assumed that no part of a normal pathname contains ";" but that should
+    # okay in the real world where ";" in dirpaths is itself problematic.
+    sys_lib_search_path_spec=`echo "$sys_lib_search_path_spec" | sed -e 's/;/ /g'`
+  else
+    sys_lib_search_path_spec=`echo "$sys_lib_search_path_spec" | sed  -e "s/$PATH_SEPARATOR/ /g"`
+  fi
+else
+  sys_lib_search_path_spec="/lib /usr/lib /usr/local/lib"
+fi
 need_lib_prefix=unknown
 hardcode_into_libs=no

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
