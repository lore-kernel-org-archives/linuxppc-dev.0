Message-ID: <3CEAAEFF.3D274083@kegel.com>
Date: Tue, 21 May 2002 13:33:03 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: khttpd crash verified with vanilla linuxppc_2_4_devel
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I can crash khttpd at will on a totally vanilla
linuxppc_2_4_devel kernel as of changeset 1.749
using an open source load generator, with or without
the patch that fixes a khttpd crash on x86
( http://www.kegel.com/linux/khttpd/khttpd-unbork.patch ).

This crash is not present on the imac with current kernels, nor
in Hard Hat 2.0 on this same board, nor on the PC with current kernels.
I believe it's a bug in the linuxppc_2_4_devel trunk.

Now that I've got it happening with 1.749, I'll try earlier versions
in hopes I find an older version that doesn't oops, and narrow
down the cause.

Kernel: circa 2.4.17-pre6 fetched with
bk clone -r1.749 bk://ppc.bkserver.net/linuxppc_2_4_devel

Sample oops #1:
>>???; c0044358 <sys_select+3fc/48c>   <=====
Trace; c00442a4 <sys_select+348/48c>
Trace; c00081fc <ppc_select+a0/b0>
Trace; c00028dc <ret_from_syscall_1+0/b4>

Sample oops #2:
>>???; c003eaa4 <link_path_walk+7e4/990>   <=====
Trace; c003e958 <link_path_walk+698/990>
Trace; c003ec68 <path_walk+18/28>
Trace; c003f3f8 <open_namei+a8/660>
Trace; c0031f2c <filp_open+58/84>
Trace; c0032394 <sys_open+4c/fc>
Trace; c00028dc <ret_from_syscall_1+0/b4>

The oops tracebacks are not terribly helpful.

Script to reproduce:
#!/bin/sh
set -x
insmod khttpd
echo 1 > /proc/sys/net/khttpd/stop
sleep 2
echo 16 > /proc/sys/net/khttpd/threads
echo `pwd` > /proc/sys/net/khttpd/documentroot
echo 80 > /proc/sys/net/khttpd/clientport
echo 8080 > /proc/sys/net/khttpd/serverport
echo http://127.0.0.1:8080/128k.html > urls
# place a 128KB-ish file here, e.g.
# cp http_load 128k.html
# chmod 644 128k.html
while /bin/true; do
    echo 1 > /proc/sys/net/khttpd/start
    ./http_load -checksum -parallel 10 -seconds 6 urls
    echo 1 > /proc/sys/net/khttpd/stop
    sleep 1
done

Let that run for a few iterations, then stop it,
and run http_load a few times by hand.

http_load is from http://www.acme.com/software/http_load/http_load-04jan2002.tar.gz

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
