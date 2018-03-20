Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4056nd1CgmzDrNC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 20:19:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH 3/5] powerpc/zImage: Check compatible at driver init
In-Reply-To: <20180319051403.23275-3-oohall@gmail.com>
References: <20180319051403.23275-1-oohall@gmail.com>
 <20180319051403.23275-3-oohall@gmail.com>
Date: Tue, 20 Mar 2018 20:19:13 +1100
Message-ID: <87o9jjf6jy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Oliver O'Halloran <oohall@gmail.com> writes:
> diff --git a/arch/powerpc/boot/mpc52xx-psc.c b/arch/powerpc/boot/mpc52xx-psc.c
> index c2c08633ee35..75470936e661 100644
> --- a/arch/powerpc/boot/mpc52xx-psc.c
> +++ b/arch/powerpc/boot/mpc52xx-psc.c
> @@ -52,6 +52,9 @@ static unsigned char psc_getc(void)
>  
>  int mpc5200_psc_console_init(void *devp, struct serial_console_data *scdp)
>  {
> +	if (!dt_is_compatible(devp, "fsl,mpc5200-psc-uart"))
> +		return 1;

Returning 1 raises the question of whether this is a bool-style function
that returns 1 on success and 0 on failure - or a UNIX style function
that returns 0 for sucesss and 1 on failure.

Can we return ENODEV, or just -1 instead to make it clearer?

cheers
