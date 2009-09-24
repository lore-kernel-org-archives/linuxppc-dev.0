Return-Path: <RFeany@mrv.com>
Received: from bos-spam.mrv.com (mx5.mrv.com [140.179.254.12])
	by ozlabs.org (Postfix) with ESMTP id 15F75B7B7A
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 10:53:04 +1000 (EST)
Date: Wed, 23 Sep 2009 17:53:00 -0700
From: Rex Feany <RFeany@mrv.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm: Fix 40x and 8xx vs. _PAGE_SPECIAL
Message-ID: <20090924005300.GB11737@compile2.chatsunix.int.mrv.com>
References: <1253679146.7103.270.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1253679146.7103.270.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, "Weirich,
	Bernhard" <Bernhard.Weirich@riedel.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thus spake Benjamin Herrenschmidt (benh@kernel.crashing.org):

> Bernhard, Rex, please let me know if that works for you.

it doesn't work for me, it crashes differently then before though!

This patch worked for me:
> 
> Signed-off-by: Bernhard Weirich <bernhard.weirich@riedel.net>
> --- linux/arch/powerpc/include/asm/pte-common.h 2009-09-16 11:23:44.000000000 +0200
> +++ linux/arch/powerpc/include/asm/pte-common.h 2009-09-22 11:13:08.000000000 +0200
> @@ -176,7 +176,7 @@
>  #define HAVE_PAGE_AGP
>  
>  /* Advertise support for _PAGE_SPECIAL */
> -#ifdef _PAGE_SPECIAL
> +#if _PAGE_SPECIAL != 0
>  #define __HAVE_ARCH_PTE_SPECIAL
>  #endif
> 

without either patch:

boots into userspace, starts running my code
which uses mmap to access an fpga:

BUG: Bad page map in process loadfpga  pte:ff1008d3 pmd:02103001
addr:30028000 vm_flags:400844fb anon_vma:(null) mapping:c30000e8 index:ff100
vma->vm_ops->fault: 0x0
vma->vm_file->f_op->mmap: mmap_mem+0x0/0xa8
Call Trace:
[c2107db0] [c00067d0] show_stack+0x44/0x14c (unreliable)
[c2107df0] [c0056854] print_bad_pte+0x1b4/0x1d0
[c2107e20] [c0056898] vm_normal_page+0x28/0x50
[c2107e30] [c0056c30] unmap_vmas+0x1b8/0x510
[c2107eb0] [c005b17c] unmap_region+0x94/0x124
[c2107ef0] [c005c110] do_munmap+0x264/0x2dc
[c2107f20] [c005c1c0] sys_munmap+0x38/0x5c
[c2107f40] [c000d0dc] ret_from_syscall+0x0/0x38

trunk+benh complicated patch:

crashes earlier:

BUG: Bad page map in process swapper  pte:001f88e9 pmd:020d8001
addr:7ffffff6 vm_flags:00100177 anon_vma:c20d95e0 mapping:(null) index:7ffff
Call Trace:
[c341fd20] [c00067d0] show_stack+0x44/0x14c (unreliable)
[c341fd60] [c0056860] print_bad_pte+0x1b4/0x1d0
[c341fd90] [c00568c8] vm_normal_page+0x4c/0x78
[c341fda0] [c0056988] follow_page+0x94/0x1b8
[c341fdc0] [c005854c] __get_user_pages+0x324/0x3c4
[c341fe20] [c006c12c] get_arg_page+0x40/0xac
[c341fe40] [c006c374] copy_strings+0xec/0x1d4
[c341fe80] [c006c47c] copy_strings_kernel+0x20/0x38
[c341fea0] [c006d3cc] do_execve+0x110/0x240
[c341fee0] [c00070c4] sys_execve+0x50/0x7c
[c341ff00] [c000d0dc] ret_from_syscall+0x0/0x38
[c341ffc0] [c00023ac] init_post+0x5c/0x168
[c341ffe0] [c01df22c] kernel_init+0x10c/0x124
[c341fff0] [c000cf3c] kernel_thread+0x4c/0x68

this is running on a MPC 875, and I'm happy to test any patches or
add any debugging code if it helps.

thanks!
/rex
