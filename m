Return-Path: <srs0=wo3a=4q=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wN7sC2JcVzDqKs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 May 2017 17:58:23 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wN7sB6NLLz8t08
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 May 2017 17:58:22 +1000 (AEST)
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com
 [IPv6:2a00:1450:4010:c07::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wN7s92p22z9s7C
 for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2017 17:58:21 +1000 (AEST)
Received: by mail-lf0-x242.google.com with SMTP id h4so1988800lfj.3
 for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2017 00:58:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1494399469-17833-1-git-send-email-mpe@ellerman.id.au>
References: <1494399469-17833-1-git-send-email-mpe@ellerman.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 10 May 2017 17:58:17 +1000
Message-ID: <CAKTCnz=aRYzF5BMuWp0ddMG2CO+uuQ_PvfNs3Hk_f3soxWxd3Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc/modules: If mprofile-kernel is enabled add it to
 vermagic
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Rusty Russell <rusty@rustcorp.com.au>, Jessica Yu <jeyu@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 10, 2017 at 4:57 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
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
> ---
>  arch/powerpc/include/asm/module.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/module.h b/arch/powerpc/include/asm/module.h
> index 53885512b8d3..6c0132c7212f 100644
> --- a/arch/powerpc/include/asm/module.h
> +++ b/arch/powerpc/include/asm/module.h
> @@ -14,6 +14,10 @@
>  #include <asm-generic/module.h>
>
>
> +#ifdef CC_USING_MPROFILE_KERNEL
> +#define MODULE_ARCH_VERMAGIC   "mprofile-kernel"
> +#endif
> +
>  #ifndef __powerpc64__
>  /*
>   * Thanks to Paul M for explaining this.
> --

Makes sense

Acked-by: Balbir Singh <bsingharora@gmail.com>
