Message-ID: <200005232238.SAA24884@hoover.gilbarco.com>
From: "Banks, Kelly" <kelly_banks@gilbarco.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: MontaVista HardHat gdb on the MPC860....
Date: Tue, 23 May 2000 18:38:01 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Has anyone been able to use gdb (MontaVista / HHL) on the 8xx platform?

I have been, thus far, unable to use MontaVista's gdb load even with Monta
vista's Libraries.


Using the pre-pack builds, I get the following:

=============================================================
init-2.03# gdb
GNU gdb 4.17.0.11 with Linux support
Copyright 1998 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "powerpc-linux".
(gdb) file hello
Reading symbols from hello...Segmentation fault
init-2.03#
=============================================================
gdb launches just fine, but fails when selecting the file hello_world (c/cpp
static/dynamic).





Attempting to link statically returns the following:

=============================================================
/usr/lib/libc.a(regex.o): In function `init_syntax_once':
/usr/src/rh61_build/glibc/BUILD/glibc-2.1/posix/regex.c:253: multiple
definition of `re_max_failures'
libgdb.a(gnu-regex.o):/home/kellyb/gdb+dejagnu-20000424/gdb/gnu-regex.c:164:
first defined here
=============================================================



Linking dynamically, I have been unable to find a suitable libc.

 - Using MontaVista's HHL Libraries, I get the following:

=============================================================
gdb: error in loading shared libraries:
/usr/local/crossgcc/tools/target/powerpc-linux-gnu/lib/libncurses.so.4:
symbol __register_frame_info, version GLIBC_2.0 not defined in file
libc.so.6 with link time reference
=============================================================


 - Using libc-2.1.3.so, I get a segfault just as above, which I traced into
a call to memset(~).
Not always the SAME call to memset, but usually (it moves sometimes when I
add more printf()s.
Once in a While, I actually get an ILLEGAL INSTRUCTION!


I have heard of certian memset() problems with certian libc builds for the
ppc...  Which may be contributing to this issue.
Someone mentioned something about ppc specific assembly code...  Maybe it's
not calculating byte/hword/word boundries properly.

Can anyone point me to a complete set of tools which may allow gdb native to
function properly?

After I get through this, I will likely be implementing threads into
gdbserver for remote operation! ;o)

Thanx in advance for your help,
Kelly

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
