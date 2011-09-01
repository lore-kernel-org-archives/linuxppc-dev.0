Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id CA48DB6F81
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Sep 2011 23:30:37 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH] fsl-rio: Release rapidio port I/O region resource if
	portfailed to initialize
Date: Thu, 1 Sep 2011 06:29:55 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E5520210DF01@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <1314870744-27325-1-git-send-email-Gang.Liu@freescale.com>
References: <1314870744-27325-1-git-send-email-Gang.Liu@freescale.com>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: Liu Gang <Gang.Liu@freescale.com>, <linuxppc-dev@lists.ozlabs.org>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	B11780@freescale.com, r58472@freescale.com, r61911@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday, September 01, 2011 5:52 AM
Liu Gang <Gang.Liu@freescale.com> wrote:

> Subject: [PATCH] fsl-rio: Release rapidio port I/O region resource if
> portfailed to initialize
>=20
...
>=20
> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
> ---
>  arch/powerpc/sysdev/fsl_rio.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/fsl_rio.c
> b/arch/powerpc/sysdev/fsl_rio.c
> index c65f75a..22ffccd 100644
> --- a/arch/powerpc/sysdev/fsl_rio.c
> +++ b/arch/powerpc/sysdev/fsl_rio.c
> @@ -1608,6 +1608,7 @@ int fsl_rio_setup(struct platform_device *dev)
>  	return 0;
>  err:
>  	iounmap(priv->regs_win);
> +	release_resource(&port->iores);
>  err_res:
>  	kfree(priv);
>  err_priv:
> --
> 1.7.3.1

Acked-by: Alexandre Bounine <alexandre.bounine@idt.com>
