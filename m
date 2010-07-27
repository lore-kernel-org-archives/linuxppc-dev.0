Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 6541BB6EEF
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jul 2010 20:36:55 +1000 (EST)
Date: Tue, 27 Jul 2010 12:36:47 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 2/2] powerpc/mpc5121: add initial support for
	PDM360NG  board
Message-ID: <20100727123647.0a3b8832@wker>
In-Reply-To: <AANLkTi=Ee6HR+Ux0g4V1+81DXUmsO=UDhi6jWsDgGchv@mail.gmail.com>
References: <1272882222-12253-1-git-send-email-agust@denx.de>
	<1279892973-24110-1-git-send-email-agust@denx.de>
	<AANLkTi=Ee6HR+Ux0g4V1+81DXUmsO=UDhi6jWsDgGchv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Detlev Zundel <dzu@denx.de>, Markus Fischer <markus.fischer.ec@ifm.com>,
	devicetree-discuss@lists.ozlabs.org,
	Michael Weiss <michael.weiss@ifm.com>, linuxppc-dev@ozlabs.org,
	Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant,

On Sun, 25 Jul 2010 01:42:23 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:
...
> Hi Anatolij,
>=20
> Finally got some time tonight to properly dig into this patch.  Comments =
below.

Thanks for review and comments! My reply below.

...
> > + =A0 =A0 =A0 nfc@40000000 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121-nfc";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x40000000 0x100000>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <0x6 0x8>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic>;
>=20
> This device tree can be less verbose if you remove the
> interrupt-parent property from all the nodes, and have a single
> interrupt-parent =3D <&ipic>; in the root node.  Nodes inherit the
> interrupt-parent from their (grand-)parents.

Fixed in next patch version to use interrupt-parent in root node only.

...
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdio@2800 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc51=
21-fec-mdio";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x2800 0x200>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy: ethernet-phy@0 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <=
0x1f>;
>=20
> For completeness, phy should have a compatible property.

Added in next patch version.

...
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi@11900 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc51=
21-psc-spi", "fsl,mpc5121-psc";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <9>;
>=20
> Try to drop the cell-index properties.  They are almost always misused.

Removing cell-index would require changing the spi driver's probe.
Currently cell-index is used to set spi bus number. What could be used
for bus enumeration instead? Is it okay to use part of the spi node
address? e.g. obtaining the offset 0x11900, masking out the unrelated
bits and shifting by 8 would deliver unique index 9 for PSC9 in SPI
mode. This would work for all 12 PSC SPI controllers of mpc5121.

...
> > +static int pdm360ng_get_pendown_state(void)
> > +{
> > + =A0 =A0 =A0 u32 reg;
> > +
> > + =A0 =A0 =A0 reg =3D in_be32((u32 *)(pdm360ng_gpio_base + 0xc));
> > + =A0 =A0 =A0 if (reg & 0x40)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 setbits32((u32 *)(pdm360ng_gpio_base + 0x=
c), 0x40);
> > +
> > + =A0 =A0 =A0 reg =3D in_be32((u32 *)(pdm360ng_gpio_base + 0x8));
>=20
> (u32*) casts are unnecessary and can be removed.

Fixed.

> > +
> > + =A0 =A0 =A0 /* return 1 if pen is down */
> > + =A0 =A0 =A0 return reg & 0x40 ? 0 : 1;
>=20
> return reg & 0x40 =3D=3D 0;

Fixed.

...
> > +static int __init pdm360ng_penirq_init(void)
> > +{
> > + =A0 =A0 =A0 struct device_node *np;
> > + =A0 =A0 =A0 struct resource r;
> > +
> > + =A0 =A0 =A0 np =3D of_find_compatible_node(NULL, NULL, "fsl,mpc5121-g=
pio");
> > + =A0 =A0 =A0 if (!np) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Can't find 'mpc5121-gpio' nod=
e\n", __func__);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> > + =A0 =A0 =A0 }
>=20
> return -ENODEV;

Ok, fixed also.

...
> > + =A0 =A0 =A0 pdm360ng_gpio_base =3D ioremap(r.start, resource_size(&r)=
);
>=20
> Or you could have simply used of_iomap() to eliminate some code.

of_iomap() is used in next patch version.

...
> > +static int __init pdm360ng_touchscreen_init(void)
> > +{
> > + =A0 =A0 =A0 struct device_node *np;
> > + =A0 =A0 =A0 struct of_device *of_dev;
> > + =A0 =A0 =A0 struct spi_board_info info;
> > + =A0 =A0 =A0 const u32 *prop;
> > + =A0 =A0 =A0 int bus_num =3D -1;
> > + =A0 =A0 =A0 int len;
> > +
> > + =A0 =A0 =A0 np =3D of_find_compatible_node(NULL, NULL, "ti,ads7845");
> > + =A0 =A0 =A0 if (!np)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> > +
> > + =A0 =A0 =A0 memset(&info, 0, sizeof(info));
> > + =A0 =A0 =A0 info.irq =3D irq_of_parse_and_map(np, 0);
> > + =A0 =A0 =A0 if (info.irq =3D=3D NO_IRQ)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> > +
> > + =A0 =A0 =A0 info.platform_data =3D &pdm360ng_ads7846_pdata;
> > + =A0 =A0 =A0 if (strlcpy(info.modalias, "ads7846",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SPI_NAME_SIZE) >=3D SPI_NAME_SIZE)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> > +
> > + =A0 =A0 =A0 np =3D of_get_next_parent(np);
> > + =A0 =A0 =A0 if (!np)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> > +
> > + =A0 =A0 =A0 prop =3D of_get_property(np, "cell-index", &len);
> > + =A0 =A0 =A0 if (prop && len =3D=3D 4)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus_num =3D *prop;
>=20
> Blech.  Don't use cell-index for bus enumeration.  In fact, none of
> this should be necessary at all (see below).

I dropped this code entirely in the next patch version.

> > +
> > + =A0 =A0 =A0 if (bus_num < 0 || bus_num > 11)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> > +
> > + =A0 =A0 =A0 info.bus_num =3D bus_num;
> > +
> > + =A0 =A0 =A0 of_dev =3D of_find_device_by_node(np);
> > + =A0 =A0 =A0 of_node_put(np);
> > + =A0 =A0 =A0 if (of_dev) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct fsl_spi_platform_data *pdata;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D kzalloc(sizeof(*pdata), GFP_KER=
NEL);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->bus_num =3D bus_nu=
m;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->max_chipselect =3D=
 1;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_dev->dev.platform_data=
 =3D pdata;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 if (pdm360ng_penirq_init())
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> > +
> > + =A0 =A0 =A0 return spi_register_board_info(&info, 1);
>=20
> This ends up being a lot of code simply to attach a pdata structure to
> an spi device.  I've been thinking about this problem, and I think
> there is a better way.  Instead, use a bus notifier attached to the
> SPI bus to wait for the spi_device to get registered, but before it
> gets bound to a driver.  Then you can attach the pdata structure very
> simply.  Something like this I think (completely untested, or even
> compiled.  Details are left as an exercise to the developer):
>=20
> static int pdm360ng_touchscreen_notifier_call(struct notifier_block *nb,
> 					unsigned long event, void *__dev)
> {
> 	struct device *dev =3D __dev;
>=20
> 	if ((event =3D=3D BUS_NOTIFIY_ADD_DEVICE) && (dev->of_node =3D=3D [FOO]))
> 		dev->platform_data =3D [BAR];
> }
>=20
> static struct notifier_block pdm360ng_touchscreen_nb =3D {
> 	notifier_call =3D pdm360ng_touchscreen_notifier_call;
> };
>=20
> static int __init pdm360ng_touchscreen_init(void)
> {
> 	bus_register_notifier(&spi_bus_type, pdm360ng_touchscreen_nb);
> }

Thanks! Bus notifier is now used for setting platform data in v4.
This requires fixing the mpc5121 psc spi driver to create spi child
nodes of the spi master node. I have already send the appropriate
patch to spi-devel list, but it is not the right approach to call
of_register_spi_devices() in each driver. Do you plan to fix it in
core spi code in v2.6.36?

...
> > +}
> > +machine_device_initcall(pdm360ng, pdm360ng_touchscreen_init);
>=20
> This code is *in the same file* as the board setup file.  Don't use an
> initcall.  Call it from the init callback instead.

OK, initcall dropped.

Thanks,
Anatolij
