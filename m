Return-Path: <B42677@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9A0D02C008C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 12:38:53 +1000 (EST)
From: Zhang Haijun-B42677 <B42677@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 2/2] mmc: esdhc: get voltage from dts file
Date: Tue, 23 Jul 2013 02:38:33 +0000
Message-ID: <99E897753B6F7048BD8CCDB4661D02E13E49EC@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1374479636-9254-1-git-send-email-Haijun.Zhang@freescale.com>
 <1374479636-9254-2-git-send-email-Haijun.Zhang@freescale.com>
 <1374514847.15592.7@snotra>
In-Reply-To: <1374514847.15592.7@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "cjb@laptop.org" <cjb@laptop.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Thanks.

Regards
Haijun.


> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Tuesday, July 23, 2013 1:41 AM
> To: Zhang Haijun-B42677
> Cc: linux-mmc@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> cbouatmailru@gmail.com; cjb@laptop.org; Fleming Andy-AFLEMING; Zhang
> Haijun-B42677; Zhang Haijun-B42677
> Subject: Re: [PATCH 2/2] mmc: esdhc: get voltage from dts file
>=20
> On 07/22/2013 02:53:56 AM, Haijun Zhang wrote:
> > Add voltage-range support in esdhc of T4, So we can choose to read
> > voltages from dts file as one optional.
> > If we can get a valid voltage-range from device node, we use this
> > voltage as the final voltage support. Else we still read from capacity
> > or from other provider.
> >
> > Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> > Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
> > ---
> >  drivers/mmc/host/sdhci-of-esdhc.c | 31
> > +++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci.c          |  3 +++
> >  include/linux/mmc/sdhci.h         |  1 +
> >  3 files changed, 35 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-esdhc.c
> > b/drivers/mmc/host/sdhci-of-esdhc.c
> > index 15039e2..8b4b27a 100644
> > --- a/drivers/mmc/host/sdhci-of-esdhc.c
> > +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> > @@ -262,6 +262,35 @@ static int esdhc_pltfm_bus_width(struct
> > sdhci_host *host, int width)
> >  	return 0;
> >  }
> >
> > +static void esdhc_get_voltage(struct sdhci_host *host,
> > +			struct platform_device *pdev)
> > +{
> > +	const u32 *voltage_ranges;
> > +	int num_ranges, i;
> > +	struct device_node *np;
> > +	np =3D pdev->dev.of_node;
> > +
> > +	voltage_ranges =3D of_get_property(np, "voltage-ranges",
> > &num_ranges);
> > +	num_ranges =3D num_ranges / sizeof(*voltage_ranges) / 2;
> > +	if (!voltage_ranges || !num_ranges) {
> > +		dev_info(&pdev->dev, "OF: voltage-ranges
> > unspecified\n");
> > +		return;
> > +	}
> > +
> > +	for (i =3D 0; i < num_ranges; i++) {
> > +		const int j =3D i * 2;
> > +		u32 mask;
> > +		mask =3D
> > mmc_vddrange_to_ocrmask(be32_to_cpu(voltage_ranges[j]),
> > +				be32_to_cpu(voltage_ranges[j + 1]));
> > +		if (!mask) {
> > +			dev_info(&pdev->dev,
> > +				"OF: false voltage-ranges specified\n");
> > +			return;
> > +		}
> > +		host->ocr_mask |=3D mask;
> > +	}
> > +}
>=20
> Don't duplicate this code.  Move it somewhere common and share it.
[Haijun Wrote:] So, move it drivers/mmc/host/sdhci-pltfm.c and share it as
Sdhc_get_voltage()....?
>=20
> Why did you remove the range index from the error string, and why did you
> change it from dev_err to dev_info?
[Haijun Wrote:] I'll correct this. In case voltage-range specified if there=
 is still err.
It should be err.
>=20
> -Scott
