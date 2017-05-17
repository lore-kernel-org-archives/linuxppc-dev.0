Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wSTg03GQ8zDqZQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 19:34:36 +1000 (AEST)
In-Reply-To: <1494399469-17833-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: rusty@rustcorp.com.au, jeyu@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: powerpc/modules: If mprofile-kernel is enabled add it to vermagic
Message-Id: <3wSTg02Y1Rz9s85@ozlabs.org>
Date: Wed, 17 May 2017 19:34:36 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-05-10 at 06:57:49 UTC, Michael Ellerman wrote:
> On powerpc we can build the kernel with two different ABIs for mcount(), which
> is used by ftrace. Kernels built with one ABI do not know how to load modules
> built with the other ABI. The new style ABI is called "mprofile-kernel", for
> want of a better name.
> 
> Currently if we build a module using the old style ABI, and the kernel with
> mprofile-kernel, when we load the module we'll oops something like:
> 
>   # insmod autofs4-no-mprofile-kernel.ko
>   ftrace-powerpc: Unexpected instruction f8810028 around bl _mcount
>   ------------[ cut here ]------------
>   WARNING: CPU: 6 PID: 3759 at ../kernel/trace/ftrace.c:2024 ftrace_bug+0x2b8/0x3c0
>   CPU: 6 PID: 3759 Comm: insmod Not tainted 4.11.0-rc3-gcc-5.4.1-00017-g5a61ef74f269 #11
>   ...
>   NIP [c0000000001eaa48] ftrace_bug+0x2b8/0x3c0
>   LR [c0000000001eaff8] ftrace_process_locs+0x4a8/0x590
>   Call Trace:
>     alloc_pages_current+0xc4/0x1d0 (unreliable)
>     ftrace_process_locs+0x4a8/0x590
>     load_module+0x1c8c/0x28f0
>     SyS_finit_module+0x110/0x140
>     system_call+0x38/0xfc
>   ...
>   ftrace failed to modify
>   [<d000000002a31024>] 0xd000000002a31024
>    actual:   35:65:00:48
> 
> We can avoid this by including in the vermagic whether the kernel/module was
> built with mprofile-kernel. Which results in:
> 
>   # insmod autofs4-pg.ko
>   autofs4: version magic
>   '4.11.0-rc3-gcc-5.4.1-00017-g5a61ef74f269 SMP mod_unload modversions '
>   should be
>   '4.11.0-rc3-gcc-5.4.1-00017-g5a61ef74f269-dirty SMP mod_unload modversions mprofile-kernel'
>   insmod: ERROR: could not insert module autofs4-pg.ko: Invalid module format
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Balbir Singh <bsingharora@gmail.com>
> Acked-by: Jessica Yu <jeyu@redhat.com>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/43e24e82f35291d4c1ca78877ce1b2

cheers
