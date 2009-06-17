Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 274C8B71BE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 06:56:10 +1000 (EST)
MIME-Version: 1.0
In-Reply-To: <20090617201408.GA17909@oksana.dev.rtsoft.ru>
References: <20090611201545.GA15942@oksana.dev.rtsoft.ru>
	<20090617201408.GA17909@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 17 Jun 2009 14:55:46 -0600
Message-ID: <fa686aa40906171355x5a917b60ne372796133c9e336@mail.gmail.com>
Subject: Re: [PATCH v2] sdhci: Add support for hosts that are only capable of
	1-bit transfers
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Pierre Ossman <pierre@ossman.eu>,
	devicetree-discuss@ozlabs.org, sdhci-devel@lists.ossman.eu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 17, 2009 at 2:14 PM, Anton
Vorontsov<avorontsov@ru.mvista.com> wrote:
> Some hosts (hardware configurations, or particular SD/MMC slots) may
> not support 4-bit bus. For example, on MPC8569E-MDS boards we can
> switch between serial (1-bit only) and nibble (4-bit) modes, thought
> we have to disable more peripherals to work in 4-bit mode.
>
> Along with some small core changes, this patch modifies sdhci-of
> driver, so that now it looks for "sdhci,1-bit-only" property in the
> device-tree, and if specified we enable a proper quirk.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Looks good to me.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

g.

> ---
>
> Pierre,
>
> As promised, here is a version with a quirk.
> Also incorporated suggestions by Grant Likely.
>
>
> Thanks,
>
> =A0Documentation/powerpc/dts-bindings/fsl/esdhc.txt | =A0 =A02 ++
> =A0drivers/mmc/host/sdhci-of.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A03 +++
> =A0drivers/mmc/host/sdhci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 =A05 ++++-
> =A0drivers/mmc/host/sdhci.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 =A02 ++
> =A04 files changed, 11 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/powerpc/dts-bindings/fsl/esdhc.txt b/Documenta=
tion/powerpc/dts-bindings/fsl/esdhc.txt
> index 5093ddf..3ed3797 100644
> --- a/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
> +++ b/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
> @@ -10,6 +10,8 @@ Required properties:
> =A0 - interrupts : should contain eSDHC interrupt.
> =A0 - interrupt-parent : interrupt source phandle.
> =A0 - clock-frequency : specifies eSDHC base clock frequency.
> + =A0- sdhci,1-bit-only : (optional) specifies that a controller can
> + =A0 =A0only handle 1-bit data transfers.
>
> =A0Example:
>
> diff --git a/drivers/mmc/host/sdhci-of.c b/drivers/mmc/host/sdhci-of.c
> index 09cc597..dd65f84 100644
> --- a/drivers/mmc/host/sdhci-of.c
> +++ b/drivers/mmc/host/sdhci-of.c
> @@ -244,6 +244,9 @@ static int __devinit sdhci_of_probe(struct of_device =
*ofdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->ops =3D &sdhci_of_data->ops;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (of_get_property(np, "sdhci,1-bit-only", NULL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->quirks |=3D SDHCI_QUIRK_FORCE_1_BIT_D=
ATA;
> +
> =A0 =A0 =A0 =A0clk =3D of_get_property(np, "clock-frequency", &size);
> =A0 =A0 =A0 =A0if (clk && size =3D=3D sizeof(*clk) && *clk)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_host->clock =3D *clk;
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 9234be2..f28f94a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1721,7 +1721,10 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0mmc->ops =3D &sdhci_ops;
> =A0 =A0 =A0 =A0mmc->f_min =3D host->max_clk / 256;
> =A0 =A0 =A0 =A0mmc->f_max =3D host->max_clk;
> - =A0 =A0 =A0 mmc->caps =3D MMC_CAP_4_BIT_DATA | MMC_CAP_SDIO_IRQ;
> + =A0 =A0 =A0 mmc->caps =3D MMC_CAP_SDIO_IRQ;
> +
> + =A0 =A0 =A0 if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_4_BIT_DATA;
>
> =A0 =A0 =A0 =A0if (caps & SDHCI_CAN_DO_HISPD)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_SD_HIGHSPEED;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 65c6f99..834f877 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -226,6 +226,8 @@ struct sdhci_host {
> =A0#define SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET =A0 =A0 =A0 =A0 =A0 (1<<1=
9)
> =A0/* Controller has to be forced to use block size of 2048 bytes */
> =A0#define SDHCI_QUIRK_FORCE_BLK_SZ_2048 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(1<<20)
> +/* Controller can only handle 1-bit data transfers */
> +#define SDHCI_QUIRK_FORCE_1_BIT_DATA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (1<<21)
>
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq; =A0 =A0 =
=A0 =A0 =A0 =A0/* Device IRQ */
> =A0 =A0 =A0 =A0void __iomem * =A0 =A0 =A0 =A0 =A0ioaddr; =A0 =A0 =A0 =A0 =
/* Mapped address */
> --
> 1.6.3.1
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
