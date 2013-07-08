Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1118D2C02C6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jul 2013 03:09:10 +1000 (EST)
Date: Mon, 8 Jul 2013 12:08:58 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: =?UTF-8?b?562U5aSNOg==?= [PATCH 2/2] powerpc/85xx: add the
 P1020RDB-PD DTS support
To: Zhang Haijun-B42677 <B42677@freescale.com>
In-Reply-To: <99E897753B6F7048BD8CCDB4661D02E1362C90@039-SN2MPN1-023.039d.mgd.msft.net>
 (from B42677@freescale.com on Wed Jul  3 21:04:40 2013)
Message-ID: <1373303338.8183.161@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Huang Changming-R66093 <r66093@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Xie Xiaobo-R63061 <r63061@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/03/2013 09:04:40 PM, Zhang Haijun-B42677 wrote:
>=20
>=20
> Regards & Thanks
>=20
> Haijun.
>=20
> ________________________________________
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Wood Scott-B07421
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2013=E5=B9=B47=E6=9C=883=E6=97=A5 1=
9:09
> =E6=94=B6=E4=BB=B6=E4=BA=BA: Zhang Haijun-B42677
> Cc: galak@kernel.crashing.org; linuxppc-dev@lists.ozlabs.org; Zhang =20
> Haijun-B42677; Huang Changming-R66093
> =E4=B8=BB=E9=A2=98: Re: [PATCH 2/2] powerpc/85xx: add the P1020RDB-PD DTS=
 support
>=20
> On 06/30/2013 11:12:23 PM, Haijun Zhang wrote:
> > From: "Haijun.Zhang" <Haijun.Zhang@freescale.com>
> >
> > Overview of P1020RDB-PD device:
> > - DDR3 2GB
> > - NOR flash 64MB
> > - NAND flash 128MB
> > - SPI flash 16MB
> > - I2C EEPROM 256Kb
> > - eTSEC1 (RGMII PHY) connected to VSC7385 L2 switch
> > - eTSEC2 (SGMII PHY)
> > - eTSEC3 (RGMII PHY)
> > - SDHC
> > - 2 USB ports
> > - 4 TDM ports
> > - PCIe
> >
> > Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > CC: Scott Wood <scottwood@freescale.com>
> > ---
> >  arch/powerpc/boot/dts/p1020rdb-pd.dtsi    | 257
> > ++++++++++++++++++++++++++++++
> >  arch/powerpc/boot/dts/p1020rdb-pd_32b.dts |  90 +++++++++++
> >  2 files changed, 347 insertions(+)
> >  create mode 100644 arch/powerpc/boot/dts/p1020rdb-pd.dtsi
> >  create mode 100644 arch/powerpc/boot/dts/p1020rdb-pd_32b.dts
>=20
> What about 36b?
>=20
> Haijun: 2G DDR was fix on P1020RDB-PD board. No need 36bit support. =20
> Also no 36bit uboot support.

So then why not just have one "p1020rdb-pd.dts"?

Or, can you have a common p1020rdb.dtsi that all the variants use, with =20
the .dts file only handling the differences?

> > +     cpld@2,0 {
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <1>;
> > +             compatible =3D "cpld";
> > +             reg =3D <0x2 0x0 0x20000>;
> > +             read-only;
> > +     };
>=20
> Where does "cpld" as a compatible come from (it's way too vague)?  =20
> What
> is read-only supposed to mean here?
>=20
> Haijun: In fact almost all board has its special CPLD. This node just =20
> copy from p1020rdb-pc board.
>=20
> So, change it to :
>=20
> cpld@2,0 {
>           compatible =3D "fsl, p1020rdb-cpld";
>           reg =3D <0x2 0x0 0x20000>;
>           read-only;
> };

Again, what is read-only supposed to mean here?  I don't care that it's =20
copied from the PC version.  It doesn't make sense, and is not =20
documented in a binding.

Is the -pd CPLD 100% identical to the -pc CPLD?  If not, shouldn't the =20
compatible note the difference between the two?

-Scott=
