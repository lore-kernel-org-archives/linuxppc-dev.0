Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0143.outbound.protection.outlook.com [157.56.110.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 225B71A0259
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 15:53:28 +1000 (AEST)
From: Wang Dongsheng <Dongsheng.Wang@freescale.com>
To: Timur Tabi <timur@tabi.org>
CC: Scott Wood <scottwood@freescale.com>, Jin Jason <Jason.Jin@freescale.com>,
 Li Leo <LeoLi@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-fbdev@vger.kernel.org"
 <linux-fbdev@vger.kernel.org>
Subject: RE: [PATCH] video/fsl: Fix the sleep function for FSL DIU module
Date: Fri, 14 Aug 2015 05:53:17 +0000
Message-ID: <SN1PR0301MB1616D0881B41899B8047267A9D7C0@SN1PR0301MB1616.namprd03.prod.outlook.com>
References: <1395734180-45012-1-git-send-email-dongsheng.wang@freescale.com>
 <5331A6BA.9030507@tabi.org>
In-Reply-To: <5331A6BA.9030507@tabi.org>
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

Hi Tabi,

> -----Original Message-----
> From: Timur Tabi [mailto:timur@tabi.org]
> Sent: Tuesday, March 25, 2014 11:55 PM
> To: Wang Dongsheng-B40534
> Cc: Wood Scott-B07421; Jin Zhengxiong-R64188; Li Yang-Leo-R58472; linuxpp=
c-
> dev@lists.ozlabs.org; linux-fbdev@vger.kernel.org
> Subject: Re: [PATCH] video/fsl: Fix the sleep function for FSL DIU module
>=20
> On 03/25/2014 02:56 AM, Dongsheng Wang wrote:
> > From: Jason Jin <Jason.Jin@freescale.com>
> >
> > For deep sleep, the diu module will power off, when wake up from the
> > deep sleep, the registers need to be reinitialized.
> >
> > Signed-off-by: Jason Jin <Jason.Jin@freescale.com>
> > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> >
> > diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> > index e8758b9..7ec780c 100644
> > --- a/drivers/video/fsl-diu-fb.c
> > +++ b/drivers/video/fsl-diu-fb.c
> > @@ -1628,9 +1628,18 @@ static int fsl_diu_suspend(struct platform_devic=
e
> *ofdev, pm_message_t state)
> >   static int fsl_diu_resume(struct platform_device *ofdev)
> >   {
> >   	struct fsl_diu_data *data;
> > +	struct mfb_info *mfbi;
>=20
> You don't need this, if ...
>=20
> > +	int i;
> >
> >   	data =3D dev_get_drvdata(&ofdev->dev);
> > -	enable_lcdc(data->fsl_diu_info);
> > +	fsl_diu_enable_interrupts(data);
> > +	update_lcdc(data->fsl_diu_info);
> > +
> > +	for (i =3D 0; i < NUM_AOIS; i++) {
> > +		mfbi =3D &data->mfb[i];
> > +		if (mfbi->count)
>=20
> ... you do this:
>=20
> 		if (data->mfb[i].count)
>=20
> Also, 'i' should be an 'unsigned int'.
>=20
> > +			fsl_diu_enable_panel(&data->fsl_diu_info[i]);
> > +	}
> >
> >   	return 0;
> >   }
> >
>=20
> Other than that, this seems okay.
>=20

Thanks, send v2 to update this patch.

Regards,
-Dongsheng
