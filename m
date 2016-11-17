Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKbcy3ZJMzDvvd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 09:38:26 +1100 (AEDT)
Message-ID: <1479422306.6542.32.camel@neuling.org>
Subject: Re: [PATCH] powerpc/64: Fix setting of AIL in hypervisor mode
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Anton Blanchard <anton@au1.ibm.com>
Date: Fri, 18 Nov 2016 09:38:26 +1100
In-Reply-To: <1479184113.2608.45.camel@kernel.crashing.org>
References: <1479184113.2608.45.camel@kernel.crashing.org>
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

On Tue, 2016-11-15 at 15:28 +1100, Benjamin Herrenschmidt wrote:
> Commit d3cbff1b5 "powerpc: Put exception configuration in a common place"
> broke the setting of the AIL bit (which enables taking exceptions with
> the MMU still on) on all processors, moving it incorrectly to a function
> called only on the boot CPU. This was correct for the guest case but
> not when running in hypervisor mode.
>=20
> This fixes it by partially reverting that commit, putting the setting
> back in cpu_ready_for_interrupts()
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Fixes: d3cbff1b5 ("powerpc: Put exception configuration in a common place=
")
> CC: stable@vger.kernel.org # v4.8+

Acked-By: Michael Neuling <mikey@neuling.org>

> ---
> =C2=A0arch/powerpc/kernel/setup_64.c | 20 ++++++++++++++------
> =C2=A01 file changed, 14 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_6=
4.c
> index 7ac8e6e..ac75224 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -226,17 +226,25 @@ static void __init configure_exceptions(void)
> =C2=A0		if (firmware_has_feature(FW_FEATURE_OPAL))
> =C2=A0			opal_configure_cores();
> =C2=A0
> -		/* Enable AIL if supported, and we are in hypervisor mode */
> -		if (early_cpu_has_feature(CPU_FTR_HVMODE) &&
> -		=C2=A0=C2=A0=C2=A0=C2=A0early_cpu_has_feature(CPU_FTR_ARCH_207S)) {
> -			unsigned long lpcr =3D mfspr(SPRN_LPCR);
> -			mtspr(SPRN_LPCR, lpcr | LPCR_AIL_3);
> -		}
> +		/* AIL on native is done in cpu_ready_for_interrupts */
> =C2=A0	}
> =C2=A0}
> =C2=A0
> =C2=A0static void cpu_ready_for_interrupts(void)
> =C2=A0{
> +	/*
> +	=C2=A0* Enable AIL if supported, and we are in hypervisor mode. This
> +	=C2=A0* is called once for every processor.
> +	=C2=A0*
> +	=C2=A0* If we are not in hypervisor mode the job is done once for
> +	=C2=A0* the whole partition in configure_exceptions().
> +	=C2=A0*/
> +	if (early_cpu_has_feature(CPU_FTR_HVMODE) &&
> +	=C2=A0=C2=A0=C2=A0=C2=A0early_cpu_has_feature(CPU_FTR_ARCH_207S)) {
> +		unsigned long lpcr =3D mfspr(SPRN_LPCR);
> +		mtspr(SPRN_LPCR, lpcr | LPCR_AIL_3);
> +	}
> +
> =C2=A0	/* Set IR and DR in PACA MSR */
> =C2=A0	get_paca()->kernel_msr =3D MSR_KERNEL;
> =C2=A0}
>=20
