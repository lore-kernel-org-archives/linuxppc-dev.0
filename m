Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20030114184236.43688.qmail@web41211.mail.yahoo.com>
Date: Tue, 14 Jan 2003 10:42:36 -0800 (PST)
From: Prakash kanthi <pkanthi@yahoo.com>
Subject: ramdisk mount problem
To: Wolfgang Denk <wd@denx.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20030113075515.9E61AC608E@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Folks,

I am trying to use 2MB ramdisk image from denx as my
linux filesystem. Linux kernel fails to mount the
'ext2' type file system from initrd. I pin pointed the
problem.

Looks like the problem is in 'do_mounts.c ->
mount_block_root' function where a call is made to
sys_mount as follows:

'int err = sys_mount(name, "/root", p, flags,
root_mount_data);'

In my case name="/dev/root", p="ext2", flags=32768 and
root_mount_data=<NULL>.

The result of this call is EINVAL, i.e. invalid
argument. Can anyone help me out find which one of the
arguements could be invalid? If 'root_mount_data' is
the culprit, why is it null? I see that it's value is
set in one of the __setup functions. When are these
functions supposed be executed? I know that all
__initcalls are executed from dO_initcalls.

This failure causes Kernel Panic, complaing about
"Unable to mount root fs at 01:00".


Thanks,
Prakash


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
