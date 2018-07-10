Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41QJXv6Ml4zDqyp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 09:38:07 +1000 (AEST)
Message-ID: <69a6086d25c17b03ecf3ab7ed34fe941fd993410.camel@kernel.crashing.org>
Subject: Re: Several suspected memory leaks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Wed, 11 Jul 2018 09:37:51 +1000
In-Reply-To: <468d3c5b-d71d-c95b-dab4-ea8c2cebe129@molgen.mpg.de>
References: <468d3c5b-d71d-c95b-dab4-ea8c2cebe129@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-07-10 at 17:17 +0200, Paul Menzel wrote:
> Dear Liunx folks,
> 
> 
> On a the IBM S822LC (8335-GTA) with Ubuntu 18.04 I built Linux master
> – 4.18-rc4+, commit 092150a2 (Merge branch 'for-linus'
> of git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid) – with
> kmemleak. Several issues are found.

Some of these are completely uninteresting though and look like
kmemleak bugs to me :-)

>     [<00000000bc285bbf>] __pud_alloc+0x80/0x270
>     [<0000000007135d64>] hash__map_kernel_page+0x30c/0x4d0
>     [<0000000071677858>] __ioremap_at+0x108/0x140
>     [<000000000023e921>] __ioremap_caller+0x130/0x180
>     [<000000009dbc3923>] icp_native_init_one_node+0x5cc/0x760
>     [<0000000015f3168a>] icp_native_init+0x70/0x13c
>     [<00000000655550ed>] xics_init+0x38/0x1ac
>     [<0000000088dbf9d1>] pnv_init_IRQ+0x30/0x5c

This is the interrupt controller mapping its registers, why on earth
would that be considered a leak ? kmemleak needs to learn to ignore
kernel page tables allocations.


>     [<00000000bc285bbf>] __pud_alloc+0x80/0x270
>     [<000000002cdcd2db>] vmap_page_range_noflush+0x670/0x880
>     [<0000000041cc3e80>] map_vm_area+0x58/0xb0
>     [<00000000b92ed8c4>] __vmalloc_node_range+0x1cc/0x3f0
>     [<00000000f6cf150a>] __vmalloc+0x50/0x60
>     [<0000000027a0846e>] alloc_large_system_hash+0x3b8/0x554
>     [<00000000ef0d6278>] vfs_caches_init+0xd4/0x138
>     [<0000000055b60f04>] start_kernel+0x60c/0x684
>     [<00000000f8d483c1>] start_here_common+0x1c/0x520

This looks like some generic VFS stuff which similarly is meant to
remain for the whole duration of the system, what's the point on
reporting on init leaks like that ?

> unreferenced object 0xc000000007bd8000 (size 16384):
>   comm "init", pid 1, jiffies 4294895064 (age 1316.236s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000bc285bbf>] __pud_alloc+0x80/0x270
>     [<000000006ee9b8a3>] move_page_tables+0xd6c/0x13d0
>     [<0000000091930c94>] shift_arg_pages+0xc8/0x220
>     [<000000009cfa5804>] setup_arg_pages+0x26c/0x380
>     [<00000000ee516bf8>] load_elf_binary+0x600/0x29ac
>     [<000000005bbeae4b>] search_binary_handler+0x114/0x330
>     [<00000000c39037ab>] __do_execve_file.isra.8+0x8a4/0x10b0
>     [<0000000044d8a16f>] sys_execve+0x58/0x70
>     [<000000001deb923d>] system_call+0x5c/0x70

This is odd, looks like a page table allocation, I'm pretty sure those
get freed when the corresponding process dies, but this is init (PID1),
it probably never does. Again, a false positive.

> unreferenced object 0xc000000007bc8000 (size 16384):
>   comm "init", pid 1, jiffies 4294895064 (age 1316.236s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000bc285bbf>] __pud_alloc+0x80/0x270
>     [<000000001cb1e8bb>] __handle_mm_fault+0x34c/0x2f20
>     [<0000000028b41470>] handle_mm_fault+0x1f0/0x4e0
>     [<00000000f5d2a8db>] __do_page_fault+0x274/0xf90
>     [<0000000094f967e0>] handle_page_fault+0x18/0x38
>     [<00000000a38200c8>] 0xc000007fce3bbaf0
>     [<00000000c3aa995f>] load_elf_binary+0x99c/0x29ac
>     [<000000005bbeae4b>] search_binary_handler+0x114/0x330
>     [<00000000c39037ab>] __do_execve_file.isra.8+0x8a4/0x10b0
>     [<0000000044d8a16f>] sys_execve+0x58/0x70
>     [<000000001deb923d>] system_call+0x5c/0x70
> unreferenced object 0xc000007fb84d0000 (size 16384):
>   comm "systemd-journal", pid 1796, jiffies 4294895847 (age 1313.168s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000bc285bbf>] __pud_alloc+0x80/0x270
>     [<000000006ee9b8a3>] move_page_tables+0xd6c/0x13d0
>     [<0000000091930c94>] shift_arg_pages+0xc8/0x220
>     [<000000009cfa5804>] setup_arg_pages+0x26c/0x380
>     [<00000000ee516bf8>] load_elf_binary+0x600/0x29ac
>     [<000000005bbeae4b>] search_binary_handler+0x114/0x330
>     [<00000000c39037ab>] __do_execve_file.isra.8+0x8a4/0x10b0
>     [<0000000044d8a16f>] sys_execve+0x58/0x70
>     [<000000001deb923d>] system_call+0x5c/0x70
> unreferenced object 0xc000007fb84b0000 (size 16384):
>   comm "systemd-journal", pid 1796, jiffies 4294895847 (age 1313.168s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000bc285bbf>] __pud_alloc+0x80/0x270
>     [<000000001cb1e8bb>] __handle_mm_fault+0x34c/0x2f20
>     [<0000000028b41470>] handle_mm_fault+0x1f0/0x4e0
>     [<00000000f5d2a8db>] __do_page_fault+0x274/0xf90
>     [<0000000094f967e0>] handle_page_fault+0x18/0x38
>     [<00000000cc288b87>] 0xc000007f95657af0
>     [<00000000c3aa995f>] load_elf_binary+0x99c/0x29ac
>     [<000000005bbeae4b>] search_binary_handler+0x114/0x330
>     [<00000000c39037ab>] __do_execve_file.isra.8+0x8a4/0x10b0
>     [<0000000044d8a16f>] sys_execve+0x58/0x70
>     [<000000001deb923d>] system_call+0x5c/0x70
> unreferenced object 0xc000007f92fe8000 (size 16384):
>   comm "lvmetad", pid 1802, jiffies 4294895860 (age 1313.116s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000bc285bbf>] __pud_alloc+0x80/0x270
>     [<000000006ee9b8a3>] move_page_tables+0xd6c/0x13d0
>     [<0000000091930c94>] shift_arg_pages+0xc8/0x220
>     [<000000009cfa5804>] setup_arg_pages+0x26c/0x380
>     [<00000000ee516bf8>] load_elf_binary+0x600/0x29ac
>     [<000000005bbeae4b>] search_binary_handler+0x114/0x330
>     [<00000000c39037ab>] __do_execve_file.isra.8+0x8a4/0x10b0
>     [<0000000044d8a16f>] sys_execve+0x58/0x70
>     [<000000001deb923d>] system_call+0x5c/0x70
> unreferenced object 0xc000007f92ff0000 (size 16384):
>   comm "lvmetad", pid 1802, jiffies 4294895860 (age 1313.116s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000bc285bbf>] __pud_alloc+0x80/0x270
>     [<000000001cb1e8bb>] __handle_mm_fault+0x34c/0x2f20
>     [<0000000028b41470>] handle_mm_fault+0x1f0/0x4e0
>     [<00000000f5d2a8db>] __do_page_fault+0x274/0xf90
>     [<0000000094f967e0>] handle_page_fault+0x18/0x38
>     [<000000009b19a1a9>] 0xc000007f95633af0
>     [<00000000c3aa995f>] load_elf_binary+0x99c/0x29ac
>     [<000000005bbeae4b>] search_binary_handler+0x114/0x330
>     [<00000000c39037ab>] __do_execve_file.isra.8+0x8a4/0x10b0
>     [<0000000044d8a16f>] sys_execve+0x58/0x70
>     [<000000001deb923d>] system_call+0x5c/0x70
> unreferenced object 0xc0000000052f0000 (size 16384):
>   comm "blkmapd", pid 1808, jiffies 4294895896 (age 1312.976s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000bc285bbf>] __pud_alloc+0x80/0x270
>     [<00000000464ece1a>] copy_page_range+0x97c/0xcf0
>     [<00000000470f82ab>] copy_process.isra.6.part.7+0x1458/0x2cd0
>     [<000000001784ab04>] _do_fork+0xf4/0x7e0
>     [<00000000b8327d67>] ppc_clone+0x8/0xc
> […]
> ```
> 
> Please tell me how to continue. Is this the right subsystem?

Doesn't look like it...

Ben.

> 
> Kind regards,
> 
> Paul
