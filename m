Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40cpVH44J4zDr4X
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 20:41:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?utf-8?Q?C=C3=A9dr?=
 =?utf-8?Q?ic?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 2/4] powerpc/xive: fix hcall H_INT_RESET to support long
 busy delays
In-Reply-To: <20180403071548.19829-3-clg@kaod.org>
References: <20180403071548.19829-1-clg@kaod.org>
 <20180403071548.19829-3-clg@kaod.org>
Date: Fri, 04 May 2018 20:41:58 +1000
Message-ID: <87efir8zyh.fsf@concordia.ellerman.id.au>
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

> diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/=
spapr.c
> index 091f1d0d0af1..7113f5d87952 100644
> --- a/arch/powerpc/sysdev/xive/spapr.c
> +++ b/arch/powerpc/sysdev/xive/spapr.c
> @@ -108,6 +109,52 @@ static void xive_irq_bitmap_free(int irq)
>  	}
>  }
>=20=20
> +
> +/* Based on the similar routines in RTAS */
> +static unsigned int plpar_busy_delay_time(long rc)
> +{
> +	unsigned int ms =3D 0;
> +
> +	if (H_IS_LONG_BUSY(rc)) {
> +		ms =3D get_longbusy_msecs(rc);
> +	} else if (rc =3D=3D H_BUSY) {
> +		ms =3D 10; /* seems appropriate for XIVE hcalls */
> +	}
> +
> +	return ms;
> +}
> +
> +static unsigned int plpar_busy_delay(int rc)
> +{
> +	unsigned int ms;
> +
> +	might_sleep();
> +	ms =3D plpar_busy_delay_time(rc);
> +	if (ms && need_resched())
> +		msleep(ms);

This is called from kexec shutdown isn't it?

In which case I don't think msleep() is a great idea.

We could be crashing for example.

An mdelay would be safer I think?

cheers
