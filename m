Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDCsH3pTXzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 20:30:59 +1000 (AEST)
In-Reply-To: <1493257052-828-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: matthew.brown.dev@gmail.com
Subject: Re: powerpc/powernv: Fix missing attr initialisation in
 opal_export_attrs()
Message-Id: <3wDCsG6vVCz9sNM@ozlabs.org>
Date: Thu, 27 Apr 2017 20:30:58 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-04-27 at 01:37:32 UTC, Michael Ellerman wrote:
> In opal_export_attrs() we dynamically allocate some bin_attributes. They're
> allocated with kmalloc() and although we initialise most of the fields, we don't
> initialise write() or mmap(), and in particular we don't initialise the lockdep
> related fields in the embedded struct attribute.
> 
> This leads to a lockdep warning at boot:
> 
>   BUG: key c0000000f11906d8 not in .data!
>   WARNING: CPU: 0 PID: 1 at ../kernel/locking/lockdep.c:3136 lockdep_init_map+0x28c/0x2a0
>   ...
>   Call Trace:
>     lockdep_init_map+0x288/0x2a0 (unreliable)
>     __kernfs_create_file+0x8c/0x170
>     sysfs_add_file_mode_ns+0xc8/0x240
>     __machine_initcall_powernv_opal_init+0x60c/0x684
>     do_one_initcall+0x60/0x1c0
>     kernel_init_freeable+0x2f4/0x3d4
>     kernel_init+0x24/0x160
>     ret_from_kernel_thread+0x5c/0xb0
> 
> Fix it by kzalloc'ing the attr, which fixes the uninitialised write() and
> mmap(), and calling sysfs_bin_attr_init() on it to initialise the lockdep
> fields.
> 
> Fixes: 11fe909d2362 ("powerpc/powernv: Add OPAL exports attributes to sysfs")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/83c4919058459c32138a1ebe35f72b

cheers
