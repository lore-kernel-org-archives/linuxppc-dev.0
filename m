Message-ID: <386C3615.E14AE6DD@ctam.com.au>
Date: Fri, 31 Dec 1999 15:50:29 +1100
From: Brendan J Simon <Brendan.Simon@ctam.com.au>
Reply-To: Brendan.Simon@ctam.com.au
MIME-Version: 1.0
To: linux-embedded <linux-embedded@waste.org>,
        Cross-GCC <crossgcc@sourceware.cygnus.com>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: cross-compiling & debugging embedded-linux apps
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



I have a powerpc embedded system (MPC860, 4MB Flash, 16MB RAM, ethernet,
rs232).  I have compiled the kernel and can boot it using a root
filesystem via initrd or nfs.  The root filesystem is a minimal one that
was on the linuxppc-embedded ftp site.  It basically has /bin/sh,
/bin/ls and a few libraries in /lib.

I NEED to be able to compile apps from the sources.  I have managed to
cross-compile ncurses and bash.  I can't get bash to run at all (even a
statically compiled version).  I get segmentaion faults.  I'm currently
using SASH which I have cross-compiled as a static binary.  I compiled a
test app (bjs1.c) which outputs a string every second.  It is compiled
as a static binary (bjs1-static) and a shared binary (bjs1-shared).  The
static binary works but the shared one does not.  I assume it is some
library problem but I can't figure out what.  The output of the sash
session is below.

Stand-alone shell (version 1.0)
> ./bjs1-static
BJS1: Brendan was here
BJS1: Brendan was here
BJS1: Brendan was here
pid 7: killed (signal 2)
>
> ./bjs1-shared
pid 8: killed (signal 11)
>

I have all the libraries on the root filesystem.  The rpc.nfsd daemon
seems to read the entire file but sash says the process is killed with
signal 11 (segmentation fault).  I have no idea how to debug this.  I
don't think there is a simulator for the mpc860 as part of gdb.  Is
there a way of debugging this on the target with powerpc-gdb and an
ethernet or serial connection ?

How does the kernel know where to look for libraries ?  I assume there
are some default locations like /lib.  I haven't got an ld.so.conf setup
nor do I have ldconfig.

It can't be that hard to get a simple 10 line program to execute as a
shared binary.  It must be something really simple that I am missing.

Thanks for any help,
Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
