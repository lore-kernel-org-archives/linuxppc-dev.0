Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1C057B7B72
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 11:40:43 +1000 (EST)
Subject: Re: [PATCH] powerpc/mm: Fix 40x and 8xx vs. _PAGE_SPECIAL
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rex Feany <RFeany@mrv.com>
In-Reply-To: <20090924005300.GB11737@compile2.chatsunix.int.mrv.com>
References: <1253679146.7103.270.camel@pasglop>
	<20090924005300.GB11737@compile2.chatsunix.int.mrv.com>
Content-Type: text/plain
Date: Thu, 24 Sep 2009 11:40:34 +1000
Message-Id: <1253756434.7103.377.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, "Weirich,
	Bernhard" <Bernhard.Weirich@riedel.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-09-23 at 17:53 -0700, Rex Feany wrote:
> Thus spake Benjamin Herrenschmidt (benh@kernel.crashing.org):
> 
> > Bernhard, Rex, please let me know if that works for you.
> 
> it doesn't work for me, it crashes differently then before though!

Hrm. This is really strange...

> trunk+benh complicated patch:
> 
> crashes earlier:
> 
> BUG: Bad page map in process swapper  pte:001f88e9 pmd:020d8001

It's complaining because for some reason a PTE ends up with
_PAGE_SPECIAL set which indeed shouldn't be the case for a stack
page which is what is being accessed in our case. However, I have
no idea how that bit ended up being set. The generic code shouldn't
be setting it, and I looked several times at the TLB miss handling
on 8xx and can't find how in hell it would inadvertently set that
bit in the PTE...

Scott, I don't have any 8xx HW, any chance you can have a look at
what's going on here ?

The other bits in there look fine. So something must be whacking
_PAGE_SPECIAL in somewhere or at least whacking 0x8 in there.

Also, _PAGE_HWWRITE isn't set, but the DataTLBError code will
set it when setting dirty, so the page must have been created
pre-dirtied or something... all very weird I must say.

> addr:7ffffff6 vm_flags:00100177 anon_vma:c20d95e0 mapping:(null) index:7ffff
> Call Trace:
> [c341fd20] [c00067d0] show_stack+0x44/0x14c (unreliable)
> [c341fd60] [c0056860] print_bad_pte+0x1b4/0x1d0
> [c341fd90] [c00568c8] vm_normal_page+0x4c/0x78
> [c341fda0] [c0056988] follow_page+0x94/0x1b8
> [c341fdc0] [c005854c] __get_user_pages+0x324/0x3c4
> [c341fe20] [c006c12c] get_arg_page+0x40/0xac
> [c341fe40] [c006c374] copy_strings+0xec/0x1d4
> [c341fe80] [c006c47c] copy_strings_kernel+0x20/0x38
> [c341fea0] [c006d3cc] do_execve+0x110/0x240
> [c341fee0] [c00070c4] sys_execve+0x50/0x7c
> [c341ff00] [c000d0dc] ret_from_syscall+0x0/0x38
> [c341ffc0] [c00023ac] init_post+0x5c/0x168
> [c341ffe0] [c01df22c] kernel_init+0x10c/0x124
> [c341fff0] [c000cf3c] kernel_thread+0x4c/0x68
> 
> this is running on a MPC 875, and I'm happy to test any patches or
> add any debugging code if it helps.
> 
> thanks!
> /rex
