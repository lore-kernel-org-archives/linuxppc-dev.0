Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id 2A73FB7D01
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Mar 2010 08:32:15 +1100 (EST)
Message-ID: <4B956CD9.9090401@harris.com>
Date: Mon, 08 Mar 2010 16:32:09 -0500
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: BUG: Bad page map in process mm2
References: <4B956156.8010807@harris.com>
In-Reply-To: <4B956156.8010807@harris.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Steven A. Falco wrote:

Apologies - previous crash dump was mangled by the
interspersed program output.  Here is one showing
just the crash dump.

Interestingly, the program does produce correct output,
as verified by dd'ing from /dev/mem to a file, then
doing "od" on the result.  So in some sense, the error
is spurious.

	Steve

# ./mm2 > foo 2>&1
BUG: Bad page map in process mm2  pte:00000452 pmd:0f6c8400
page:c0396000 flags:00000404 count:1 mapcount:-1 mapping:(null) index:0
addr:4801f000 vm_flags:400844fb anon_vma:(null) mapping:cea78430 index:0
vma->vm_ops->fault: 0x0
vma->vm_file->f_op->mmap: mmap_mem+0x0/0xa4
Call Trace:
[cf4c5d90] [c0006cf4] show_stack+0x44/0x16c (unreliable)
[cf4c5dd0] [c0067800] print_bad_pte+0x140/0x1cc
[cf4c5e00] [c0068640] unmap_vmas+0x41c/0x594
[cf4c5e80] [c006c8f0] exit_mmap+0xb8/0x150
[cf4c5ea0] [c0020948] mmput+0x50/0xe0
[cf4c5eb0] [c0024504] exit_mm+0xec/0x10c
[cf4c5ee0] [c0025bd0] do_exit+0xc4/0x5d4
[cf4c5f20] [c0026124] do_group_exit+0x44/0xa4
[cf4c5f30] [c0026198] sys_exit_group+0x14/0x28
[cf4c5f40] [c000edcc] ret_from_syscall+0x0/0x3c
Disabling lock debugging due to kernel taint
BUG: Bad page state in process mm2  pfn:00000
page:c0396000 flags:00000404 count:0 mapcount:-1 mapping:(null) index:0
Call Trace:
[cf4c5d80] [c0006cf4] show_stack+0x44/0x16c (unreliable)
[cf4c5dc0] [c00585bc] bad_page+0x94/0x12c
[cf4c5de0] [c005d234] put_page+0x4c/0x170
[cf4c5df0] [c0073e54] free_page_and_swap_cache+0x34/0x8c
[cf4c5e00] [c0068490] unmap_vmas+0x26c/0x594
[cf4c5e80] [c006c8f0] exit_mmap+0xb8/0x150
[cf4c5ea0] [c0020948] mmput+0x50/0xe0
[cf4c5eb0] [c0024504] exit_mm+0xec/0x10c
[cf4c5ee0] [c0025bd0] do_exit+0xc4/0x5d4
[cf4c5f20] [c0026124] do_group_exit+0x44/0xa4
[cf4c5f30] [c0026198] sys_exit_group+0x14/0x28
[cf4c5f40] [c000edcc] ret_from_syscall+0x0/0x3c
# cat foo
00000000: 7c7f1b78 7c9e2378 7cbd2b78 7cdc3378
00000010: 7cfb3b78 480022ad 3c000002 60001032
00000020: 7c1b03a6 3c00c000 60002210 7c1a03a6
00000030: 4c000064 48000000 00000000 00000000
# dd count=1 if=/dev/mem of=goo
# od -X goo
0000000         7c7f1b78        7c9e2378        7cbd2b78        7cdc3378
0000020         7cfb3b78        480022ad        3c000002        60001032
0000040         7c1b03a6        3c00c000        60002210        7c1a03a6
0000060         4c000064        48000000        00000000        00000000
0000100
