Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0138.outbound.protection.outlook.com [207.46.100.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF3D51A0186
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 22:45:57 +1000 (AEST)
From: Liberman Igal <Igal.Liberman@freescale.com>
To: Liberman Igal <Igal.Liberman@freescale.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Scott Wood
 <scottwood@freescale.com>, Madalin-Cristian Bucur
 <madalin.bucur@freescale.com>, "pebolle@tiscali.nl" <pebolle@tiscali.nl>,
 "joakim.tjernlund@transmode.se" <joakim.tjernlund@transmode.se>,
 "ppc@mindchasers.com" <ppc@mindchasers.com>
Subject: RE: [v3, 5/9] fsl/fman: Add Frame Manager support
Date: Thu, 23 Jul 2015 12:45:50 +0000
Message-ID: <DM2PR03MB383CBFE012027E474F683E3E6820@DM2PR03MB383.namprd03.prod.outlook.com>
References: <1437564138-16592-1-git-send-email-igal.liberman@freescale.com>
In-Reply-To: <1437564138-16592-1-git-send-email-igal.liberman@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Regards,
Igal Liberman.

> +static struct platform_driver fm_driver =3D {
> +	.driver =3D {
> +		   .name =3D "fsl-fman",
> +		   .of_match_table =3D fm_match,
> +		   },
> +	.probe =3D fm_probe,
> +};
> +
> +builtin_platform_driver(fm_driver);
> +
> +static int __init __cold fm_load(void)
> +{
> +	if (platform_driver_register(&fm_driver)) {
> +		pr_crit("platform_driver_register() failed\n");
> +		return -ENODEV;
> +	}
> +
> +	pr_info("Freescale FMan module\n");
> +	return 0;
> +}
> +
> +device_initcall(fm_load);

Please notice, when using builtin_platform_driver, device_initcall(fm_load)=
; becomes redundant.=20
Same issue in 2 other places.
I have patches which fix that which were left out of this submission, I'll =
add them to v4.
