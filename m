Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40cpVR5FykzDrLk
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 20:42:07 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?utf-8?Q?C=C3=A9dr?=
 =?utf-8?Q?ic?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 3/4] powerpc/xive: shutdown XIVE when kexec or kdump is
 performed
In-Reply-To: <20180403071548.19829-4-clg@kaod.org>
References: <20180403071548.19829-1-clg@kaod.org>
 <20180403071548.19829-4-clg@kaod.org>
Date: Fri, 04 May 2018 20:42:06 +1000
Message-ID: <87bmdv8zy9.fsf@concordia.ellerman.id.au>
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

> The hcall H_INT_RESET should be called to make sure XIVE is fully
> reseted.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  arch/powerpc/platforms/pseries/kexec.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/kexec.c b/arch/powerpc/platfo=
rms/pseries/kexec.c
> index eeb13429d685..1d9bbf8e7357 100644
> --- a/arch/powerpc/platforms/pseries/kexec.c
> +++ b/arch/powerpc/platforms/pseries/kexec.c
> @@ -52,8 +52,11 @@ void pseries_kexec_cpu_down(int crash_shutdown, int se=
condary)
>  		}
>  	}
>=20=20
> -	if (xive_enabled())
> +	if (xive_enabled()) {
>  		xive_kexec_teardown_cpu(secondary);
> -	else
> +
> +		if (!secondary)
> +			xive_shutdown();

Couldn't that logic go in xive_kexec_teardown_cpu()?

Why do we not want to do it on powernv?

Actually we *do* do it on powernv, but elsewhere.

cheers

> +	} else
>  		xics_kexec_teardown_cpu(secondary);
>  }
> --=20
> 2.13.6
