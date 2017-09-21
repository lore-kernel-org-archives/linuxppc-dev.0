Return-Path: <peter.ujfalusi@ti.com>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyZ0v2RgBzDqT0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 21:20:46 +1000 (AEST)
Subject: Re: [PATCH 1/3] ASoC: davinci-mcasp: Handle return value of
 devm_kasprintf
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
 <timur@tabi.org>, <nicoleotsuka@gmail.com>, <Xiubo.Lee@gmail.com>,
 <fabio.estevam@nxp.com>, <alsa-devel@alsa-project.org>,
 <linux-kernel@vger.kernel.org>
References: <1505901971-12004-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1505901971-12004-2-git-send-email-arvind.yadav.cs@gmail.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-omap@vger.kernel.org>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <2fcb7f93-0449-118a-aa8d-4de51ee39895@ti.com>
Date: Thu, 21 Sep 2017 14:11:54 +0300
MIME-Version: 1.0
In-Reply-To: <1505901971-12004-2-git-send-email-arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=EF=BB=BF
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki

On 2017-09-20 13:06, Arvind Yadav wrote:
> devm_kasprintf() can fail here and we must check its return value.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  sound/soc/davinci/davinci-mcasp.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinc=
i-mcasp.c
> index f395bbc..d1a4aa2 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -1867,6 +1867,10 @@ static int davinci_mcasp_probe(struct platform_dev=
ice *pdev)
>  	if (irq >=3D 0) {
>  		irq_name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_common",
>  					  dev_name(&pdev->dev));
> +		if (!irq_name) {
> +			ret =3D -ENOMEM;
> +			goto err;
> +		}
>  		ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
>  						davinci_mcasp_common_irq_handler,
>  						IRQF_ONESHOT | IRQF_SHARED,
> @@ -1884,6 +1888,10 @@ static int davinci_mcasp_probe(struct platform_dev=
ice *pdev)
>  	if (irq >=3D 0) {
>  		irq_name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_rx",
>  					  dev_name(&pdev->dev));
> +		if (!irq_name) {
> +			ret =3D -ENOMEM;
> +			goto err;
> +		}
>  		ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
>  						davinci_mcasp_rx_irq_handler,
>  						IRQF_ONESHOT, irq_name, mcasp);
> @@ -1899,6 +1907,10 @@ static int davinci_mcasp_probe(struct platform_dev=
ice *pdev)
>  	if (irq >=3D 0) {
>  		irq_name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_tx",
>  					  dev_name(&pdev->dev));
> +		if (!irq_name) {
> +			ret =3D -ENOMEM;
> +			goto err;
> +		}
>  		ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
>  						davinci_mcasp_tx_irq_handler,
>  						IRQF_ONESHOT, irq_name, mcasp);
>=20

- P=C3=A9ter
