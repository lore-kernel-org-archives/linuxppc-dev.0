Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 29C0A1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 28 Nov 2009 08:36:27 +1100 (EST)
Subject: Re: [PATCH 2.6.31] windfarm: add detection for second cpu pump
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: bmaass@math.uni-bremen.de
In-Reply-To: <20091127164433.0b5087de.krautilein@gmx.de>
References: <20091127164433.0b5087de.krautilein@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 28 Nov 2009 08:36:21 +1100
Message-ID: <1259357781.2076.8.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-11-27 at 16:44 +0100, Bolko Maass wrote:
> Windfarm SMU control is explicitly missing support for a second CPU pump in G5 PowerMacs. 
> Such machines actually exist  (specifically Quads with a second pump), so this patch adds detection for it.
> 

Thanks.

BTW. The Signed-off-by: line normally goes -before- the patch :-) (And
after the description).

I'll get that upstream asap.

Cheers,
Ben.

> 
> diff -uprN a/drivers/macintosh/windfarm_smu_controls.c b/drivers/macintosh/windfarm_smu_controls.c
> --- a/drivers/macintosh/windfarm_smu_controls.c 2009-11-27 16:24:55.000000000 +0100
> +++ b/drivers/macintosh/windfarm_smu_controls.c 2009-11-16 18:22:33.000000000 +0100
> @@ -202,6 +202,8 @@ static struct smu_fan_control *smu_fan_c
>                 fct->ctrl.name = "cpu-front-fan-1";
>         else if (!strcmp(l, "CPU A PUMP"))
>                 fct->ctrl.name = "cpu-pump-0";
> +       else if (!strcmp(l, "CPU B PUMP"))
> +               fct->ctrl.name = "cpu-pump-1";
>         else if (!strcmp(l, "Slots Fan") || !strcmp(l, "Slots fan") ||
>                  !strcmp(l, "EXPANSION SLOTS INTAKE"))
>                 fct->ctrl.name = "slots-fan";
> 
> 
> 
> Signed-off by: Bolko Maass <bmaass@math.uni-bremen.de>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
