Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id C8BE2B7D24
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Apr 2010 17:43:46 +1000 (EST)
Date: Fri, 30 Apr 2010 09:43:43 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Timur Tabi <timur.tabi@gmail.com>
Subject: Re: [PATCH 5/5] fsl-diu-fb: Support setting display mode using EDID
Message-ID: <20100430094343.2a504b2a@wker>
In-Reply-To: <n2oed82fe3e1004291844habbdfe76lc369d66cf9a9d9fd@mail.gmail.com>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
	<1272584978-19063-6-git-send-email-agust@denx.de>
	<n2oed82fe3e1004291844habbdfe76lc369d66cf9a9d9fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
	yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 29 Apr 2010 20:44:12 -0500
Timur Tabi <timur.tabi@gmail.com> wrote:

> On Thu, Apr 29, 2010 at 6:49 PM, Anatolij Gustschin <agust@denx.de> wrote:
>=20
> > +Optional properties:
> > +- EDID : verbatim EDID data block describing attached display.
> > + =C2=A0Data from the detailed timing descriptor will be used to
> > + =C2=A0program the display controller.
>=20
> The property name should be lower-case.

Will change to lower-case.

> > =C2=A0/*
> > =C2=A0* These parameters give default parameters
> > @@ -217,6 +218,7 @@ struct mfb_info {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0int x_aoi_d; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* aoi display x offset to physical screen */
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0int y_aoi_d; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* aoi display y offset to physical screen */
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct fsl_diu_data *parent;
> > + =C2=A0 =C2=A0 =C2=A0 char *edid_data;
>=20
> edid_data should be "u8 *".  "char *" is should be used only for
> strings or arrays of characters.

Will fix it, too.

> > + =C2=A0 =C2=A0 =C2=A0 /* Still not found, use preferred mode from data=
base if any */
> > + =C2=A0 =C2=A0 =C2=A0 if (!has_default_mode && info->monspecs.modedb !=
=3D NULL) {
>=20
> No need for the "!=3D NULL"

Ok, I will simplify this.

Thanks,
Anatolij
