Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id E37C82BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 01:41:40 +1100 (EST)
In-Reply-To: <20050112083637.GA13794@gate.ebshome.net>
References: <20050112083637.GA13794@gate.ebshome.net>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <0A7D665B-64A8-11D9-AAE5-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 12 Jan 2005 08:41:27 -0600
To: "Eugene Surovegin" <ebs@ebshome.net>
Cc: Kumar Gala <galak@somerset.sps.mot.com>, linuxppc-embedded@ozlabs.org
Subject: Re: RFC: [PATCH] platform device driver model support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jan 12, 2005, at 2:36 AM, Eugene Surovegin wrote:

> On Wed, Jan 12, 2005 at 01:43:09AM -0600, Kumar Gala wrote:
>  >
> > Please take a look at the following patch.=A0 It adds driver model=20=

> support
> > via platform devices to 85xx.=A0 This is originally based on patches=20=

> from
> > Jason M.
> >
> > The idea behind the code is that for a give family: 4xx, 8xx, 82xx,=20=

> 83xx,
> > 85xx, 86xx we will have structure defns for the following:
>  >
> > enum ppc_soc_devices
>  > in asm-ppc/<family.h>:
> >=A0=A0 list of all unique devices in the family
>  >
> > struct platform_device soc_platform_devices[]
> > in arch/ppc/platforms/<family>/<family>_devices.c:
> >=A0=A0 describes all platform devices that exist in the family
>  >
> > struct soc_spec soc_specs[]
>  > in arch/ppc/platforms/<family>/<family>_soc.c:
> >=A0=A0 describes each unique chip in the family and what devices it =
has
>
> Well, there is a problem right here at least for 4xx.
> Current OCP implementation is much more flexible IMHO.
>
> For 4xx is not uncommon when you have the same "logical" device at the
> different places with different "properties" (e.h. different channel,
> etc).
>
> Your case (85xx) looks simpler - all you need is a list of devices
> which particular SoC supports, without significant differences in
> "properties". This will not work that easy for 4xx.
>
> In fact, I don't see any gain (at least for 4xx) in all these changes.
> It makes 4xx much more tangled IMHO, because we'll still need all
> those ibm405gp.c, ibm405ep.c, ibm440gp.c etc.
>
> Please note, using platform_device is orthogonal to the way we
> describe each SoC (this is what I don't quite like in your patch), and
> I don't have any strong objections to using platform_device instead of
> OCP or feature_call or whatever for communication with device drivers.

I need to understand a bit more about how 4xx does things.  When I=20
started the SOC stuff, it was freescale specific.  I agree that its=20
orthogonal to the use of platform device.  Does this some like a bad=20
idea for the fsl case?

> > Plus the following functions:
>  >
> > identify_soc_by_id() -- determine soc by an int id
> > identify_soc_by_name() -- determin soc by name (useful in some 82xx=20=

> cases)
>  > ppc_soc_get_pdata() -- get platform_data pointer so board code can=20=

> modify
>  > ppc_soc_update_paddr() -- update iomem resources with a given paddr
>
> IMHO, ppc_soc_update_paddr - is a very confusing name, in fact, from
> first read I though it _changes_ paddr to the new value, not _adds_ it
> :)
>
> Probably this function should be made 85xx specific as I cannot come
> up with any use for it in 4xx (we don't have anything similar to
> CCSRBAR ;).

Not an issue, any suggestions on renaming to make it clear what it=20
does?  Also, I can make this fsl_increment_paddr() since its useful to=20=

more than on family of fsl processors.

> [snip]
>
> > +
>  > +struct platform_device soc_platform_devices[] =3D {
>  > +=A0=A0=A0=A0 [MPC85xx_TSEC1] =3D {
>  > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .name =3D "fsl-gianfar",
>  > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .id=A0=A0=A0=A0 =3D 1,
>  > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .dev.platform_data =3D =
&mpc85xx_tsec1_pdata,
> > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .num_resources=A0=A0 =3D 4,
>  > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 .resource =3D (struct =
resource[]) {
>  > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 .start=A0 =3D MPC85xx_ENET1_OFFSET,
> > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 .end=A0=A0=A0 =3D MPC85xx_ENET1_OFFSET +
>  > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 MPC85xx_ENET1_SIZE =
-=20
> 1,
>  > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 .flags=A0 =3D IORESOURCE_MEM,
> > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 .name=A0=A0 =3D "tx",
>  > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 .start=A0 =3D MPC85xx_IRQ_TSEC1_TX,
> > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 .end=A0=A0=A0 =3D MPC85xx_IRQ_TSEC1_TX,
> > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 .flags=A0 =3D IORESOURCE_IRQ,
> > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 .name=A0=A0 =3D "rx",
>  > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 .start=A0 =3D MPC85xx_IRQ_TSEC1_RX,
> > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 .end=A0=A0=A0 =3D MPC85xx_IRQ_TSEC1_RX,
> > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 .flags=A0 =3D IORESOURCE_IRQ,
> > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 {
>  > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 .name=A0=A0 =3D "error",
>  > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 .start=A0 =3D MPC85xx_IRQ_TSEC1_ERROR,
> > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 .end=A0=A0=A0 =3D MPC85xx_IRQ_TSEC1_ERROR,
> > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 .flags=A0 =3D IORESOURCE_IRQ,
> > +=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 },
>  [snip]
>
>
>
> I already wrote about this but repeat again :(.
>
>  Why put all these defines (e.g. for memory regions) into header when
> the only user is this particular file. It doesn't help readability and
>  only obfuscates sources (and 4xx is a very good example of such mess
> :)

Understood, I forgot about this.  I've got now issue with changing it,=20=

just trying to minimize changes.

thanks

- kumar
