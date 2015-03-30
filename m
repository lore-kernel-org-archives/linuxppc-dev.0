Return-Path: <Shengzhou.Liu@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0139.outbound.protection.outlook.com [207.46.100.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D21F31A06C5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 22:23:03 +1100 (AEDT)
From: "Shengzhou.Liu@freescale.com" <Shengzhou.Liu@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [1/4] powerpc/fsl-booke: Add device tree support for T1024/T1023
 SoC
Date: Mon, 30 Mar 2015 11:08:04 +0000
Message-ID: <DM2PR03MB398E5EB28719411243C1C76F8F50@DM2PR03MB398.namprd03.prod.outlook.com>
References: <1422517947-28722-1-git-send-email-Shengzhou.Liu@freescale.com>
 <20150130011949.GA19864@home.buserror.net>
In-Reply-To: <20150130011949.GA19864@home.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Friday, January 30, 2015 9:20 AM
> To: Liu Shengzhou-B36685
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: Re: [1/4] powerpc/fsl-booke: Add device tree support for
> T1024/T1023 SoC
>=20
> On Thu, Jan 29, 2015 at 03:52:24PM +0800, Shengzhou Liu wrote:
> > +	corenet-cf@18000 {
> > +		compatible =3D "fsl,corenet2-cf";
>=20
> While the damage has already been done by the t1040 device tree, this is
> not 100% compatible with what's on t4240.  I'm not sure if it's worth
> doing anything about it at this point, given that you can tell the
> difference by the version register even though that register is reserved
> on t4240 and simliar chips, which is what I do in
> http://patchwork.ozlabs.org/patch/419911/

Now here "fsl,corenet2-cf" is suitable for t1024 after your t1040 patch was=
 merged.
T1024 and t1040 have the same version of ccf.

>=20
> > +		reg =3D <0x18000 0x1000>;
> > +		interrupts =3D <16 2 1 31>;
> > +		fsl,ccf-num-csdids =3D <32>;
> > +		fsl,ccf-num-snoopids =3D <32>;
>=20
> The t1040/t1024 CCM does not have CSD/Snoop IDs.
Removed.


> > +/include/ "qoriq-i2c-0.dtsi"
> > +/include/ "qoriq-i2c-1.dtsi"
>=20
> t1023 has only three i2c controllers -- where do you disable the fourth?

u-boot will disable the fourth i2c controller.


> > +/include/ "t1023si-post.dtsi"
> > +&soc {
> > +	display:display@180000 {
> > +		compatible =3D "fsl,t1024-diu", "fsl,diu";
> > +		reg =3D <0x180000 1000>;
> > +		interrupts =3D <74 2 0 0>;
> > +	};
> > +};
>=20
> There are other differences between t1023 an t1024.  Where do you
> describe t1024's QE?  Where do you describe the DDR and IFC differences?
> can they be detected at runtime?  t1024 supports deep sleep, but t1023
> doesn't -- yet you label both chips as having t1024 rcpm.
>=20
As QE IP block has not been upstream yet, so have to removed QE info in dts=
 currently(same on t1040),=20
DDR and IFC differences are in u-boot, not in dts.
Both t1023 and t1024 support sleep, so label both chips as having t1024 rcp=
m.
Only t1024 has deep sleep, the difference is identified in *.c not in dts (=
confirmed with deep sleep owner).=20
