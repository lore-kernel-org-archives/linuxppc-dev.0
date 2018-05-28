Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40vd450HMVzDrp5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 May 2018 23:29:08 +1000 (AEST)
Message-ID: <7e6878a1b6c16ea0e18ce0bd9cc7ae5d2de17359.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/64s: Clear PCR on boot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guenter Roeck <linux@roeck-us.net>, Michael Ellerman
 <michael@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Mon, 28 May 2018 23:28:34 +1000
In-Reply-To: <20180527034503.GA31985@roeck-us.net>
References: <20180525133308.GA17443@roeck-us.net>
 <31148B04-5AA9-4F4F-BD34-CD9665F7F6D6@ellerman.id.au>
 <20180527034503.GA31985@roeck-us.net>
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

On Sat, 2018-05-26 at 20:45 -0700, Guenter Roeck wrote:
> 
> I already have a patch, or at least one that does the trick for me.
> Getting qemu patched was not the problem. I just want to be sure that
> the problem is indeed a qemu problem.

Hey Guenter !

It's not quite the right patch though. The PCR is a hypervisor
priviledged register, your patch makes it supervisor accessible.

I don't have all my stuff at hand to provide a "proper" or tested patch
but it should look like

    spr_register_hv(env, SPR_PCR, "PCR",
                    SPR_NOACCESS, SPR_NOACCESS,
                    SPR_NOACCESS, SPR_NOACCESS,
                    &spr_read_generic, &spr_write_generic, 0);

Additionally the TCG ppc instruction decoder should be made to check
the PCR for varous instructions (that or use a specific write callback
that affects the CPU flags) but that's less urgent.

Cheers,
Ben.

> Thanks,
> Guenter
> 
> ---
> > From 1617bac264b4c49d817b6947611affa9b73318f6 Mon Sep 17 00:00:00 2001
> 
> From: Guenter Roeck <linux@roeck-us.net>
> Date: Fri, 25 May 2018 06:38:40 -0700
> Subject: [PATCH] PowerPC: Permit privileged access to SPR_PCR for POWER7+
> 
> Without this access, Linux mainline bails out.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  target/ppc/translate_init.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 391b94b..3b09c49 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -7953,11 +7953,12 @@ static void gen_spr_power6_common(CPUPPCState *env)
>  #endif
>      /*
>       * Register PCR to report POWERPC_EXCP_PRIV_REG instead of
> -     * POWERPC_EXCP_INVAL_SPR.
> +     * POWERPC_EXCP_INVAL_SPR in userspace. Permit privileged
> +     * access.
>       */
>      spr_register(env, SPR_PCR, "PCR",
>                   SPR_NOACCESS, SPR_NOACCESS,
> -                 SPR_NOACCESS, SPR_NOACCESS,
> +                 &spr_read_generic, &spr_write_generic,
>                   0x00000000);
>  }
>  
