Return-Path: <SRS0+273ff7d6ec6624edc474+755+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6FCED680F3
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Sep 2005 21:27:26 +1000 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: ppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Sat, 17 Sep 2005 12:27:17 +0100
Message-Id: <1126956437.4171.20.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: Davide Libenzi <davidel@xmailserver.org>, viro@ftp.linux.org.uk
Subject: Repeated corruption of file->f_ep_lock
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For a while I've been seeing occasional deadlocks on one CPU of a PPC
SMP machine:

_spin_lock(c8cbf250) CPU#1 NIP c02bb740 holder: cpu 2305 pc 00000000 (lock 24000484)

Further debugging shows that it's always due to file->f_ep_lock being
corrupted, and the deadlock happens when epoll is used on such a file.
The owner_cpu field is almost always 2305. However, it's not due to the
epoll code itself -- I've turned all three of the epoll syscalls into
sys_ni_syscall and it's still happening. I also added sanity checks for
(file->f_ep_lock.owner_cpu > 1) throughout fs/file_table.c, and I see it
happen ten or twenty times during a kernel compile.

The previous and next members of 'struct file', which are f_ep_list and
f_mapping respectively, are always fine. It's just f_ep_lock which is
scribbled upon, and the scribble is fairly repeatable: 'owner_cpu' is
almost always set to 0x901 but occasionally 0x501, and the 'lock' field
has values like 20282484, 24042884, 28022484, 24042084, 22000424 (hex).
Do those numbers seem meaningful to anyone? Any clues as to where they
might be coming from?

During a kernel compile, the corruption is mostly detected in fget()
from vfs_fstat(), but also I've seen it once or twice in vfs_read() from
do_execve():

 File cb2f5b40 (fops d107c980) has corrupted f_epoll_lock!
 lock 24002484, owner_pc 0, owner_cpu 901
 f->private_data 00000000, f->f_ep_links (cb2f5bc8, cb2f5bc8), f->f_mapping cc21c1c8
 f->f_mapping->a_ops d107cad8
 Pid 16648, comm gcc
 File is /usr/bin/gcc
 Badness in dumpbadfile at fs/file_table.c:133
 Call trace:
  [c00059b8] check_bug_trap+0xa8/0x120
  [c0005c94] ProgramCheckException+0x264/0x4e0
  [c00050a8] ret_from_except_full+0x0/0x4c
  [c0080bb4] dumpbadfile+0x114/0x160
  [c007f9f0] vfs_read+0xa0/0x1c0
  [c008ef7c] kernel_read+0x3c/0x60
  [c0091810] do_execve+0x1e0/0x280
  [c0008594] sys_execve+0x64/0xd0
  [c0004980] ret_from_syscall+0x0/0x44

This is the Fedora Core kernel (currently 2.6.12.5). The 'owner_cpu > 1'
sanity check isn't applicable to 2.6.13, so I haven't yet tried to
reproduce the problem there.

-- 
dwmw2
