To: "RAJESH.B.V" <rajeshbv@trinc.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: cross compiling of bash for 8xx
References: <3.0.1.32.20000520100736.006c7434@pop.mail.yahoo.com>
From: Marcus Sundberg <marcus@cendio.se>
Date: 20 May 2000 22:04:56 +0200
In-Reply-To: "RAJESH.B.V"'s message of "Sat, 20 May 2000 10:07:36 +0500"
Message-ID: <veln15asyf.fsf@lipta.cendio.se>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-=-=

"RAJESH.B.V" <rajeshbv@trinc.com> writes:

> Hi All,
> I'm a newbie entered into this Linux world and working on mbx860...
> i'm able to build the kernel and succeeded in running it.
> But when i try to compile the applications like Bash and all i'm getting
> some problem with shared libraries.
> i'm using the compiler  powerpc-linux-gcc with version 2.95.2 and glibc
> with version 1.99
> if i compile with static libraries it is fine.
> When compiling   Bash-2.03 when i try to configure with the command
> " CC=powerpc-linux-gcc ./configure --target=860 " it is giving error when
> it is searching to configure for  "getpgrep".
> so the configure is exiting..

--target is wrong here.

--build is the environment you are compiling on.
--host is the environment the program(s) will run on.
--target is afaik only applicable for binutils, gcc and gdb, and
specifies the system to generate code for (debug in the case of gdb).

> And when i compile the ping application it is compiling well and when i try
> to run it on my mbx860 board it is displaying an error that
> "shared library libc.s0.6 is not found. failed to open libc.so.6"
> but actually that lib file is there in the /lib path.
>
> can any one suggest me the solutions for the above..
> Is there any site providing  the minimal root file system Disk Image with
> libc-6 to download.

The ping problem sounds like either a broken development environment
and/or a broken runtime environment, hard to tell what the problem
is there. strace and LD_DEBUG=help are your friends.

As for cross compiling bash and other autoconf using applications
I've been using a handy little wrapper script for configure. It's
attached to this mail.

//Marcus


--=-=-=
Content-Type: application/x-sh
Content-Disposition: attachment; filename=acwppc

#!/bin/sh

#
# acwppc - cross-compile wrapper for autoconf configure scripts
#
# Copyright 1999-2000 Marcus Sundberg	[marcus@cendio.se]
#
# You may distribute and use this script under any Open Source
# compliant license.
#
#
# This script assumes you are compiling for Linux with glibc >= 2.1
#

SYSTEM=ppc-linux
SYSFLAGS="-mcpu=505"

usage () {
    echo "Usage: $0 SCRIPT [OPTIONS...]"
}

version () {
    echo "acwppc 0.9 by Marcus Sundberg [marcus@cendio.se]"
}


# General Linux stuff
export ac_cv_header_stdc=yes
export ac_cv_func_closedir_void=no
export kb_cv_func_putenv_malloc=no
export ac_cv_func_vfork=yes
export ac_cv_func_setvbuf_reversed=no
export ac_cv_func_mmap=yes
export ac_cv_func_setpgrp_void=yes
export ac_cv_func_getpgrp_void=yes
export ac_cv_sys_restartable_syscalls=yes
export ac_cv_func_strcoll_works=yes
export ac_cv_func_wait3_rusage=yes

# For pdksh
export ksh_cv_dev_fd=yes
export ksh_cv_dup2_clexec_ok=yes
export ksh_cv_func_memmove=yes
export ksh_cv_func_times_ok=yes
export ksh_cv_opendir_ok=yes
export ksh_cv_pgrp_check=posix

# For bash
export bash_cv_func_sigsetjmp=present
export bash_cv_job_control_missing=present
export bash_cv_sys_named_pipes=present
export bash_cv_sys_siglist=yes
export bash_cv_ulimit_maxfds=yes
export bash_cv_under_sys_siglist=yes
export bash_cv_type_rlimit=long

#
# PPC specific configure variables
#
export ac_cv_c_bigendian=yes
export ac_cv_c_char_unsigned=no
export ac_cv_sizeof_long_long=8
export ac_cv_sizeof_long=4
export ac_cv_sizeof_int=4
export ac_cv_sizeof_short=2
export ac_cv_sizeof_unsigned_long=4
export ac_cv_sizeof_unsigned_int=4


BUILD="`uname -m`-`uname -s | tr [A-Z] [a-z]`"
CC="$SYSTEM-gcc $SYSFLAGS"
CXX="$SYSTEM-g++ $SYSFLAGS"
HOSTCC=gcc
HOST_CC=gcc
BUILD_CC=gcc
#if test "x$CFLAGS" = "x"; then
#  CFLAGS="-O2"
#fi

AR="$SYSTEM-ar"
RANLIB="$SYSTEM-ranlib"
export CC CXX CFLAGS AR RANLIB HOSTCC HOST_CC BUILD_CC



if [ "$#" = "0" ]; then
    usage
    exit 1
fi
if [ "x$1" = "x-h" -o "x$1" = "x--help" ]; then
    usage
    exit 0
fi
if [ "x$1" = "x-v" -o "x$1" = "x--version" ]; then
    version
    exit 0
fi


echo CC="$CC" CXX="$CXX" CFLAGS="$CFLAGS" AR="$AR" RANLIB="$RANLIB" HOSTCC="$HOSTCC" HOST_CC="$HOST_CC" BUILD_CC="$BUILD_CC" "$@" --host="$SYSTEM" --build="$BUILD"
exec "$@" --host="$SYSTEM" --build="$BUILD"

--=-=-=

--
-------------------------------+-----------------------------------
        Marcus Sundberg        |       Phone: +46 707 452062
  Embedded Systems Consultant  |      Email: marcus@cendio.se
       Cendio Systems AB       |       http://www.cendio.com

--=-=-=--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
