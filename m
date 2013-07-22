Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CD9322C009E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 03:41:03 +1000 (EST)
Date: Mon, 22 Jul 2013 12:40:47 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] mmc: esdhc: get voltage from dts file
To: Haijun Zhang <Haijun.Zhang@freescale.com>
References: <1374479636-9254-1-git-send-email-Haijun.Zhang@freescale.com>
 <1374479636-9254-2-git-send-email-Haijun.Zhang@freescale.com>
In-Reply-To: <1374479636-9254-2-git-send-email-Haijun.Zhang@freescale.com>
 (from Haijun.Zhang@freescale.com on Mon Jul 22 02:53:56 2013)
Message-ID: <1374514847.15592.7@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linux-mmc@vger.kernel.org, AFLEMING@freescale.com, cbouatmailru@gmail.com,
 cjb@laptop.org, linuxppc-dev@lists.ozlabs.org,
 Haijun Zhang <haijun.zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/22/2013 02:53:56 AM, Haijun Zhang wrote:
> Add voltage-range support in esdhc of T4, So we can choose
> to read voltages from dts file as one optional.
> If we can get a valid voltage-range from device node, we use
> this voltage as the final voltage support. Else we still read
> from capacity or from other provider.
>=20
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 31 =20
> +++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c          |  3 +++
>  include/linux/mmc/sdhci.h         |  1 +
>  3 files changed, 35 insertions(+)
>=20
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c =20
> b/drivers/mmc/host/sdhci-of-esdhc.c
> index 15039e2..8b4b27a 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -262,6 +262,35 @@ static int esdhc_pltfm_bus_width(struct =20
> sdhci_host *host, int width)
>  	return 0;
>  }
>=20
> +static void esdhc_get_voltage(struct sdhci_host *host,
> +			struct platform_device *pdev)
> +{
> +	const u32 *voltage_ranges;
> +	int num_ranges, i;
> +	struct device_node *np;
> +	np =3D pdev->dev.of_node;
> +
> +	voltage_ranges =3D of_get_property(np, "voltage-ranges", =20
> &num_ranges);
> +	num_ranges =3D num_ranges / sizeof(*voltage_ranges) / 2;
> +	if (!voltage_ranges || !num_ranges) {
> +		dev_info(&pdev->dev, "OF: voltage-ranges =20
> unspecified\n");
> +		return;
> +	}
> +
> +	for (i =3D 0; i < num_ranges; i++) {
> +		const int j =3D i * 2;
> +		u32 mask;
> +		mask =3D =20
> mmc_vddrange_to_ocrmask(be32_to_cpu(voltage_ranges[j]),
> +				be32_to_cpu(voltage_ranges[j + 1]));
> +		if (!mask) {
> +			dev_info(&pdev->dev,
> +				"OF: false voltage-ranges specified\n");
> +			return;
> +		}
> +		host->ocr_mask |=3D mask;
> +	}
> +}

Don't duplicate this code.  Move it somewhere common and share it.

Why did you remove the range index from the error string, and why did =20
you change it from dev_err to dev_info?

-Scott=
