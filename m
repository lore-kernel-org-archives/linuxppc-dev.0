Return-Path: <liyiadam@gmail.com>
Received: from mail-wr0-x244.google.com (mail-wr0-x244.google.com
 [IPv6:2a00:1450:400c:c0c::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401Q4N1d1ZzDqnb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 19:34:08 +1100 (AEDT)
Received: by mail-wr0-x244.google.com with SMTP id h2so3762874wre.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 01:34:08 -0700 (PDT)
MIME-Version: 1.0
From: "Li Yi (Adam)" <liyiadam@gmail.com>
Date: Wed, 14 Mar 2018 16:34:04 +0800
Message-ID: <CAN7W-Tbai=VjA6HBVM-2tQwdgk1ebiSZ_d-D2o42Yhz=bJOo-Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc/64s: Fix NULL AT_BASE_PLATFORM when using DT CPU
 features
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Date: Wed, 14 Mar 2018 10:14:11 +1100
> From: Michael Ellerman <mpe@ellerman.id.au>
> To: linuxppc-dev@ozlabs.org
> Cc: sukadev@linux.vnet.ibm.com, npiggin@gmail.com
> Subject: [PATCH] powerpc/64s: Fix NULL AT_BASE_PLATFORM when using DT
>         CPU features
> Message-ID: <20180313231411.9537-1-mpe@ellerman.id.au>
>
> When running virtualised the powerpc kernel is able to run the system
> in "compat mode" - which means the kernel and hardware are pretending
> to userspace that the CPU is an older version than it actually is.
>
> AT_BASE_PLATFORM is an AUXV entry that we export to userspace for use
> when we're running in that mode, which tells userspace the "platform"
> string for the real CPU version, as opposed to the faked version.
>
> Although we don't support compat mode when using DT CPU features, and
> arguably don't need to set AT_BASE_PLATFORM, the existing cputable
> based code always sets it even when we're running bare metal. That
> means the lack of AT_BASE_PLATFORM is a user-visible artifact of the
> fact that the kernel is using DT CPU features, which we don't want.
>
> So set it in the DT CPU features code also.
>
> This results in eg:
>   $ LD_SHOW_AUXV=1 /bin/true | grep "AT_.*PLATFORM"
>   AT_PLATFORM:     power9
>   AT_BASE_PLATFORM:power9
>

Is this issue related with DD2.2 CPU?
I tested on a Boston system with DD2.1 CPU, with kernel 4.14.23,
AT_BASE_PLATFORM value is correct:

[root@boston-sh-04 ~]# LD_SHOW_AUXV=1 /bin/true | grep "AT_.*PLATFORM"
AT_PLATFORM:     power9
AT_BASE_PLATFORM:power9
[root@boston-sh-04 ~]# uname -a
Linux boston-sh-04 4.14.23 #1 SMP Sat Mar 3 12:14:56 CST 2018 ppc64le
ppc64le ppc64le GNU/Linux

Thanks,
-Yi

> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kernel/dt_cpu_ftrs.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
> index 945e2c29ad2d..0bcfb0f256e1 100644
> --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
> +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
> @@ -720,6 +720,9 @@ static void __init cpufeatures_setup_finished(void)
>                 cur_cpu_spec->cpu_features |= CPU_FTR_HVMODE;
>         }
>
> +       /* Make sure powerpc_base_platform is non-NULL */
> +       powerpc_base_platform = cur_cpu_spec->platform;
> +
>         system_registers.lpcr = mfspr(SPRN_LPCR);
>         system_registers.hfscr = mfspr(SPRN_HFSCR);
>         system_registers.fscr = mfspr(SPRN_FSCR);
> --
> 2.14.1
