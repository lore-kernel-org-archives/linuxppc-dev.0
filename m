Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3FDEC481.2010708@iti.fi>
Date: Tue, 16 Dec 2003 10:38:25 +0200
From: Kate Alhola <kate@iti.fi>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: ELDK and suse 9.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have user eldk a lot with Redhat 9 but after they discontinued it, i
decided to change to
suse 9 but looks a like that least standard eldk 2.1.0 install does not
work with suse9

May be i just need to build the rpm packages included in eldk with suse
from
sources but i have yet not have time to look out how they differ from
standard rpm
that comes with suse. Least symlinking eldk:s own rpm eith system rpm
does not work.
It gives just too many error messages about conflicts and dependensies.

I have tried tp get ELDK installed to suse 9.0 but it looks a like that
rpm program cpming with it
gives segmentetion fault when it uses build in rpm command. I have tried
it with two
diferent Suse 9.0 systems with exactly same results.


There is some debug traces:

install runs and does not give any error messages bus just ends. Running
it with strace
indicates that /opt/eldk/bin/rpm gives segmentation fault and running it by
strace indicates that that command fails with following log:


Kate

----- Debug traces comes here ------------
[root@katerinaii eldk-ppc-linux-x86]# cat debugout
trinity:/katerinaii/kate/denx/eldk-ppc-linux-x86 # ./install -v -d
/opt/eldk ppc_82xx


Do you really want to install into /opt/eldk directory[y/n]?: y

Installing cross RPMs

/opt/eldk/bin/rpm -ihv --nodeps  ./RPMS/rpm-4.0.3-1.03b_2.i386.rpm
Preparing...                ###########################################
[100%]
trinity:/katerinaii/kate/denx/eldk-ppc-linux-x86 # strace
/opt/eldk/bin/rpm -ihv --nodeps  ./RPMS/rpm-4.0.3-1.03b_2.i386.rpm

----- lots of lines deleted -----

open("/lib/libc.so.6", O_RDONLY)        = 7
read(7, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0^\1\000"...,
1024) = 1024
fstat64(7, {st_mode=S_IFREG|0755, st_size=1470060, ...}) = 0
old_mmap(NULL, 1269380, PROT_READ|PROT_EXEC, MAP_PRIVATE, 7, 0) = 0x40244000
mprotect(0x40373000, 28292, PROT_NONE)  = 0
old_mmap(0x40373000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
7, 0x12e000) = 0x40373000
old_mmap(0x40378000, 7812, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40378000
close(7)                                = 0
open("/lib/ld-linux.so.2", O_RDONLY)    = 7
read(7, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\n\0\000"...,
1024) = 1024
fstat64(7, {st_mode=S_IFREG|0755, st_size=101556, ...}) = 0
old_mmap(NULL, 88440, PROT_READ|PROT_EXEC, MAP_PRIVATE, 7, 0) = 0x4037a000
mprotect(0x4038f000, 2424, PROT_NONE)   = 0
old_mmap(0x4038f000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
7, 0x15000) = 0x4038f000
close(7)                                = 0
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++
[root@katerinaii eldk-ppc-linux-x86]#


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
