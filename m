Message-ID: <20021106152213.37134.qmail@web14307.mail.yahoo.com>
Date: Wed, 6 Nov 2002 07:22:13 -0800 (PST)
From: "Usman S. Ansari" <uansari@yahoo.com>
Subject: Linux Kernel Debugging
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am trying to setup Linux kernel for debugging.

Linux is running on PPC 8xx, The most luck I have is with following setup.

- ppcboot is installed
- pImage is installed
- root filesystem is mounted on NFS

When not debugging, system comes up fine, etc.

When debugging. I connect my bdi2000,

- start bdi, start ppc
- BDI>load
Loading pImage , please wait ....
Loading program file passed
BDI>go
- TARGET: target has entered debug mode

- start minicom on serial, see messages from ppcboot and Linux kernel upto
.
.
.
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX

Start gdb as (see below)
ppc_8xx-gdb vmlinux
target remote bdi:2001

I get

Remote debugging using bdi:2001
0xc0004d8c in kernel_thread () at time.c:464
464     }

After that if I try to set breakpoint
(gdb) b send_signal
Breakpoint 1 at 0xc0019128: file signal.c, line 403.
(gdb)c
Continuing.
warning: Cannot insert breakpoint 1:
Error accessing memory address 0xc0019128: Operation not permitted.

Questions:
(1) Why is my breakpoint not working ?
(2) If I remove breakpoint, and "cont", it seems like nothing is happening. I do not see any
    progree on minicom screen for kernel boot up and than loading of modules and application. If
    I ctrl-c on gdb, I get

Program received signal SIGSTOP, Stopped (signal).
0xc0003eac in idled () at idle.c:70
70                      if (!current->need_resched && htab_reclaim_on)

I know it is in idle thread, but not very usefull, since I cannot proceed. No telnet window, no
minicom window.

I am missing a step or so, any ideas what is it ?

Thanks for reading this far.

Please cc me, as I am not subscribed to this list.

Usman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
