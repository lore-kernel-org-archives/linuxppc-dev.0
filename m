Message-ID: <3F4D3E2D.2080704@kegel.com>
Date: Wed, 27 Aug 2003 16:26:37 -0700
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: crosstool-0.22: fixes for arm, sh4, and gcc-3.4
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


crosstool is a set of scripts for building and testing cross-compilers
based on gcc/glibc/linux.

A new release is ready, and can be downloaded from
      http://kegel.com/crosstool

Changelog:
0.22 26 Aug 2003 "towards userspace -- and beyond!"

      glibc-2.2.5 and glibc-2.3.2 now build on arm with gcc-3.3.x thanks to
      glibc-2.2.5-patches/dl-machine-arm.patch,
      glibc-2.2.5-patches/arm-asm-clobber.patch, and
      glibc-2.3.2-patches/arm-asm-clobber.patch

      crosstest.sh now invokes the gcc-3.4-20030813 libstdc++ testsuite properly.

      crosstool.sh and crosstest.sh now work even if PATH contains a space
      (as it often does on Cygwin).

      doc/crosstool-howto.html now mentions the need for gcc-3.2 or higher to
      compile a recent toolchain

      doc/crosstool-howto.html now suggests setting tcp_tw_recycle both
      locally and on target to allow lots of rsh sessions, and has a harsher
      test for whether rsh is in fact configured to allow lots of sessions.
      doc/chroot-login-howto.html now has instructions for configuring xinetd
      to allow lots of rsh sessions.  (Hmm, seems like the rsh configuration
      doc should be in one place, not in two... fixme)  Thanks to Michael
      LeBlanc for xinetd config info.

      Deleted glibc-2.3.2-patches/sh-fpscr-libc-kludge.patch, and
      added back to sh4.dat the line GLIBC_CONFIGPARMS="no-z-defs=yes",
      to fix the following gcc tests that fail with that patch:
       20000605-1.c 20020411-1.c 930603-1.c complex-6.c conversion.c gofast.c
       ieee/{20010114-2.c, inf-1.c, rbug.c}
      (no-z-defs is only needed for gcc-3.4-*/glibc-2.3.2, but shouldn't hurt older versions.).
      This means I can't run my old binaries on sh4, but that's ok.

      all.sh now takes an optional --builduserspace flag.
      If this is set, all.sh uses ptx.sh to build busybox, and crosstest.sh
      uses this busybox instead of the target's normal shell.
      This is useful if you can't run the target's normal shell with
      the new toolchain.
      (e.g. when the target's old /bin/sh is linked against a newer glibc,
      or when the target's old /bin/sh and libc used a different shared
      library interface).
      Thanks to Pengutronix for PTXdist.
      I plan to use it to build things like ncurses and libreadline
      in the next release; ncurses-5.3 already builds, but I commented that
      line out of ptx.config as it's not needed for testing toolchains.
      Eventually crosstool and PTXdist may merge somehow.
      Caution: if you use --builduserspace, you must install the graphviz package (see
      http://www.research.att.com/sw/tools/graphviz/), else the
      build will fail in ptx.sh with 'dot: command not found'.
      This is a usability problem with ptxdist; it shouldn't require graphviz by default.

      Discovered why the libstdc++ 27_io testcases fail when run remotely:
      it's a bug in the testcase driver, which needs to use dejagnu's remote
      file operations during test setup and evaluation.  Updated http://gcc.gnu.org/PR11610

      Likewise, the testcase g++-bprob-1 fails when run remotely due
      to a similar bug in the testcase driver.  Filed http://gcc.gnu.org/PR12055


--
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
