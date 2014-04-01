Return-Path: <Li.Xiubo@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0239.outbound.protection.outlook.com [207.46.163.239])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3B467140090
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 13:58:05 +1100 (EST)
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>, Scott Wood
 <scottwood@freescale.com>, "timur@tabi.org" <timur@tabi.org>
Subject: RE: [PATCH 2/2] Make the diu driver work without board level
 initilization
Date: Tue, 1 Apr 2014 02:57:58 +0000
Message-ID: <1305603ae9b846d9bc4c78f21a8c0494@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1395920287-5204-1-git-send-email-Jason.Jin@freescale.com>
In-Reply-To: <1395920287-5204-1-git-send-email-Jason.Jin@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> @@ -1752,6 +1793,22 @@ static int fsl_diu_probe(struct platform_device *p=
dev)
>  		goto error;
>  	}
>=20
> +	if (!diu_ops.set_pixel_clock) {
> +		data->pixelclk_reg =3D of_iomap(np, 1);
> +		if (!data->pixelclk_reg) {
> +			dev_err(&pdev->dev, "Cannot map pixelclk registers, please \
> +				provide the diu_ops for pixclk setting instead.\n");

The error message should be in one line if possible, or it will hard to gre=
p.
If cannot, should split it into two or more lines, like:
 +			dev_err(&pdev->dev, "Cannot map pixelclk registers,\n"
 +				"please provide the diu_ops for pixclk setting instead.\n");

Thanks,

BRs
Xiubo
