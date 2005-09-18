Return-Path: <paubert@iram.es>
Received: from gra-vd1.iram.es (gra-vd1.iram.es [150.214.224.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 111FB6832B
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Sep 2005 09:24:16 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Mon, 19 Sep 2005 01:23:56 +0200
To: David Woodhouse <dwmw2@infradead.org>
Message-ID: <20050918232356.GA4500@iram.es>
References: <1126956437.4171.20.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1126956437.4171.20.camel@baythorne.infradead.org>
Cc: ppc-dev list <linuxppc-dev@ozlabs.org>,
	Davide Libenzi <davidel@xmailserver.org>, viro@ftp.linux.org.uk
Subject: Re: Repeated corruption of file->f_ep_lock
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Sep 17, 2005 at 12:27:17PM +0100, David Woodhouse wrote:
> For a while I've been seeing occasional deadlocks on one CPU of a PPC
> SMP machine:
> 
> _spin_lock(c8cbf250) CPU#1 NIP c02bb740 holder: cpu 2305 pc 00000000 (lock 24000484)
> 
> Further debugging shows that it's always due to file->f_ep_lock being
> corrupted, and the deadlock happens when epoll is used on such a file.
> The owner_cpu field is almost always 2305. However, it's not due to the
> epoll code itself -- I've turned all three of the epoll syscalls into
> sys_ni_syscall and it's still happening. I also added sanity checks for
> (file->f_ep_lock.owner_cpu > 1) throughout fs/file_table.c, and I see it
> happen ten or twenty times during a kernel compile.
> 
> The previous and next members of 'struct file', which are f_ep_list and
> f_mapping respectively, are always fine. It's just f_ep_lock which is
> scribbled upon, and the scribble is fairly repeatable: 'owner_cpu' is
> almost always set to 0x901 but occasionally 0x501, and the 'lock' field
> has values like 20282484, 24042884, 28022484, 24042084, 22000424 (hex).
> Do those numbers seem meaningful to anyone? Any clues as to where they
> might be coming from?

As Paul mentioned, these ones furiously look like the contents of 
a condition register, which is not saved and restored very often:
- on every exception/interrupt
- in some stack frames, when GCC decides that it needs to use some
of the 3 CR fields (out of 8) that must be preserved across function
calls. This is rather infrequent.

> 
> During a kernel compile, the corruption is mostly detected in fget()
> from vfs_fstat(), but also I've seen it once or twice in vfs_read() from
> do_execve():
> 
>  File cb2f5b40 (fops d107c980) has corrupted f_epoll_lock!
>  lock 24002484, owner_pc 0, owner_cpu 901
>  f->private_data 00000000, f->f_ep_links (cb2f5bc8, cb2f5bc8), f->f_mapping cc21c1c8
>  f->f_mapping->a_ops d107cad8
>  Pid 16648, comm gcc
>  File is /usr/bin/gcc
>  Badness in dumpbadfile at fs/file_table.c:133
>  Call trace:
>   [c00059b8] check_bug_trap+0xa8/0x120
>   [c0005c94] ProgramCheckException+0x264/0x4e0
>   [c00050a8] ret_from_except_full+0x0/0x4c
>   [c0080bb4] dumpbadfile+0x114/0x160
>   [c007f9f0] vfs_read+0xa0/0x1c0
>   [c008ef7c] kernel_read+0x3c/0x60
>   [c0091810] do_execve+0x1e0/0x280
>   [c0008594] sys_execve+0x64/0xd0
>   [c0004980] ret_from_syscall+0x0/0x44

It's hard to imagine a stack overflow on such a short
call chain. The other idea I have is a backlink chain
corruption, but GCC generated code is not very sensitive
to it unless you use alloca()...

In this case, it would be very useful to also have the 
value of the stack pointer (r1) on each line in the call
backtrace. (The PPC ABI makes the call backtrace much more 
reliable than on x86, where the backtrace without frame pointer
is an educated guess at best).

	Regards,
	Gabriel
