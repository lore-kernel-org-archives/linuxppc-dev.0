Message-ID: <20030122091532.1705.qmail@web41202.mail.yahoo.com>
Date: Wed, 22 Jan 2003 01:15:32 -0800 (PST)
From: Prakash kanthi <pkanthi@yahoo.com>
Subject: Linux Kernel hangs after execve("/bin/sh")
To: "PPC-Linux list (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20030122055708.ED27DC608E@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi FOlks,

I finally reached the last step (hopefully) of linux
kernel booting process. Kernel gets stuck after doing
a 'execve("/bin/sh")'. I tried using different
ramdisks, still no difference.

I added few printk's in the source, following the
function call path from 'execve' call. Following is
the output. You can see that, execve goes through
without any file permission problems and subsequently
it tries to open /lib/ld.so.1 flawlessly. After that i
see nothing on the terminal.

---------
init:Trying to bring /bin/sh up.
do_execve:enter for /bin/sh
open_exec:enter for /bin/sh.
open_exec:Permission error=0.
dentry_open:enter.
dentry_open: after file->f_op->open. 0
open_exec:enter for /lib/ld.so.1.
open_exec:Permission error=0.
dentry_open:enter.
dentry_open: after file->f_op->open. 0
do_execve: after search_binary_handler. retval=0
-----------


I wrote a small standalone program hello.c to test, if
i can dynamically load it from init() instead of
loading /bin/sh. I compiled the program added it to my
ramdisk and called from init(). Following is the
output. You can see that, it did all of it that it did
for /bin/sh and also tried to open /etc/ld.so.preload
and /etc/ld.so.cache and failed. But again towards the
end, it tries to open /lib/libc.so.6 and succeds but
still no output is displayed that hello.c is trying to
print.

---------
init:Trying to bring /bin/hello up.
do_execve:enter for /bin/hello
open_exec:enter for /bin/hello.
open_exec:Permission error=0.
dentry_open:enter.
dentry_open: after file->f_op->open. 0
open_exec:enter for /lib/ld.so.1.
open_exec:Permission error=0.
dentry_open:enter.
dentry_open: after file->f_op->open. 0
do_execve: after search_binary_handler. retval=0
sys_open:enter for /etc/ld.so.preload.
sys_open:unused_fd=3.
filp_open:enter for /etc/ld.so.preload.
filp_open:open_namei error -2.
sys_open:enter for /etc/ld.so.cache.
sys_open:unused_fd=3.
filp_open:enter for /etc/ld.so.cache.
filp_open:open_namei error -2.
sys_open:enter for /lib/libc.so.6.
sys_open:unused_fd=3.
filp_open:enter for /lib/libc.so.6.
filp_open:open_namei error 0.
dentry_open:enter.
dentry_open: after file->f_op->open. 0
-----------

Can someone please throw some light on this?

Thanks,
Prakash


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
