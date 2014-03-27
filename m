Return-Path: <Jason.Jin@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0205.outbound.protection.outlook.com [207.46.163.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E2A3214008C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 14:42:40 +1100 (EST)
From: "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>
To: Timur Tabi <timur@tabi.org>
Subject: RE: [PATCH 2/2] video/fsl: Fix the sleep function for FSL DIU module
Date: Thu, 27 Mar 2014 03:42:31 +0000
Message-ID: <e3e45edb388c482eb53474e18575f227@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1395855704-19908-1-git-send-email-Jason.Jin@freescale.com>
 <1395855704-19908-2-git-send-email-Jason.Jin@freescale.com>
 <53332168.5050805@tabi.org>
In-Reply-To: <53332168.5050805@tabi.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>=20
> On 03/26/2014 12:41 PM, Jason Jin wrote:
> > +	if (!diu_ops.set_pixel_clock) {
> > +		data->saved_pixel_clock =3D 0;
> > +		if (of_address_to_resource(ofdev->dev.of_node, 1, &res))
> > +			pr_err(KERN_ERR "No pixel clock set func and no pixel
> node!\n");
> > +		else {
> > +			data->pixelclk_ptr =3D
> > +				devm_ioremap(&ofdev->dev, res.start,
> resource_size(&res));
> > +			if (!data->pixelclk_ptr) {
> > +				pr_err(KERN_ERR "fslfb: could not map pixelclk
> register!\n");
> > +				ret =3D -ENOMEM;
> > +			} else
> > +				data->saved_pixel_clock =3D in_be32(data-
> >pixelclk_ptr);
> > +		}
> > +	}
>=20
> This seems very hackish.  What node does ofdev point to?  I wonder if
> this code should be in the platform file instead.
>=20
[Jason Jin-R64188] It's not hackish, we can provide the pixel clock registe=
r in the DIU node, I did not provide the dts update as this is only tested =
on T1040 platform. For other platforms such as p1022 and 8610, we still can=
 use the pixel clock setting function in the platform.=20

The dts node update for T1040 is:
display:display@180000 {
        compatible =3D "fsl,t1040-diu", "fsl,diu";
-       reg =3D <0x180000 1000>;
+       reg =3D <0x180000 1000 0xfc028 4>;
        interrupts =3D <74 2 0 0>;
};

If saving the pixel clock register likes a hackish. We can provide more inf=
ormation in the node to move the pixel clock settings to the driver. It see=
ms that we only need to provide another parameter(the ratio) for pixel cloc=
k setting.

> Also, use dev_info() instead of pr_err, and never use exclamation marks
> in driver messages.
Ok, Thanks.
