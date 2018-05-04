Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40cpTz32j6zDqhm
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 20:41:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?utf-8?Q?C=C3=A9dr?=
 =?utf-8?Q?ic?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 1/4] powerpc/64/kexec: fix race in kexec when XIVE is
 shutdowned
In-Reply-To: <20180403071548.19829-2-clg@kaod.org>
References: <20180403071548.19829-1-clg@kaod.org>
 <20180403071548.19829-2-clg@kaod.org>
Date: Fri, 04 May 2018 20:41:39 +1000
Message-ID: <87fu378zz0.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> The kexec_state KEXEC_STATE_IRQS_OFF barrier is reached by all
> secondary CPUs before the kexec_cpu_down() operation is called on
> secondaries. This can raise conflicts and provoque errors in the XIVE
> hcalls when XIVE is shutdowned with H_INT_RESET on the primary CPU.
>
> To synchronize the kexec_cpu_down() operations and make sure the
> secondaries have completed their task before the primary starts doing
> the same, let's move the primary kexec_cpu_down() after the
> KEXEC_STATE_REAL_MODE barrier.

This sounds reasonable, I'm sure you've tested it. I'm just a bit
worried that it could potentially break on other platforms because it
changes the sequence of operations.

Looking we only have kexec_cpu_down() implemented for pseries, powernv,
ps3 and 85xx.

We can easily test the first two. ps3 doesn't do much so hopefully
that's safe.

mpc85xx_smp_kexec_cpu_down() does very little on 32-bit, and on 64-bit
it seems to already wait for at least one other CPU to get into
KEXEC_STATE_REAL_MODE, so that's probably safe too.

So I guess I'm OK to merge this, and we'll fix any fallout. It would be
good for the change log to call out the change though, and that we think
it's a sensible change for all platforms.

cheers

> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  arch/powerpc/kernel/machine_kexec_64.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel=
/machine_kexec_64.c
> index 49d34d7271e7..212ecb8e829c 100644
> --- a/arch/powerpc/kernel/machine_kexec_64.c
> +++ b/arch/powerpc/kernel/machine_kexec_64.c
> @@ -230,16 +230,16 @@ static void kexec_prepare_cpus(void)
>  	/* we are sure every CPU has IRQs off at this point */
>  	kexec_all_irq_disabled =3D 1;
>=20=20
> -	/* after we tell the others to go down */
> -	if (ppc_md.kexec_cpu_down)
> -		ppc_md.kexec_cpu_down(0, 0);
> -
>  	/*
>  	 * Before removing MMU mappings make sure all CPUs have entered real
>  	 * mode:
>  	 */
>  	kexec_prepare_cpus_wait(KEXEC_STATE_REAL_MODE);
>=20=20
> +	/* after we tell the others to go down */
> +	if (ppc_md.kexec_cpu_down)
> +		ppc_md.kexec_cpu_down(0, 0);
> +
>  	put_cpu();
>  }
>=20=20
> --=20
> 2.13.6
