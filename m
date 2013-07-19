Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4BD3F2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jul 2013 20:46:59 +1000 (EST)
Message-ID: <51E918ED.80002@pengutronix.de>
Date: Fri, 19 Jul 2013 12:46:05 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org,
 devicetree-discuss@lists.ozlabs.org, Wolfram Sang <wsa@the-dreams.de>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Pantelis Antoniou <pantelis.antoniou@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <rob.herring@calxeda.com>, Detlev Zundel <dzu@denx.de>
Subject: Re: [PATCH v2 16/24] net: can: mscan: make mpc512x code use common
 clock
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374178858-8683-2-git-send-email-gsi@denx.de>
 <51E8EC17.9060703@pengutronix.de>
 <20130719094143.GQ7080@book.gsilab.sittig.org>
In-Reply-To: <20130719094143.GQ7080@book.gsilab.sittig.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2MFHMOWXWVOUNSMEVKKAA"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2MFHMOWXWVOUNSMEVKKAA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/19/2013 11:41 AM, Gerhard Sittig wrote:
> On Fri, Jul 19, 2013 at 09:34 +0200, Marc Kleine-Budde wrote:
>>
>> On 07/18/2013 10:20 PM, Gerhard Sittig wrote:
>>> extend the mscan(4) driver with alternative support for the COMMON_CL=
K
>>> approach which is an option in the MPC512x platform, keep the existin=
g
>>> clock support implementation in place since the driver is shared with=

>>> other MPC5xxx SoCs which don't have common clock support
>>>
>>> one byproduct of this change is that the CAN driver no longer needs t=
o
>>> access the SoC's clock control registers, which shall be the domain o=
f
>>> the platform's clock driver
>>>
>>> Signed-off-by: Gerhard Sittig <gsi@denx.de>
>>> ---
>>>  drivers/net/can/mscan/mpc5xxx_can.c |  139 +++++++++++++++++++++++++=
++++++++++
>>>  1 file changed, 139 insertions(+)
>>>
>>> diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/ms=
can/mpc5xxx_can.c
>>> index bc422ba..dd26ab6 100644
>>> --- a/drivers/net/can/mscan/mpc5xxx_can.c
>>> +++ b/drivers/net/can/mscan/mpc5xxx_can.c
>>> @@ -108,6 +108,143 @@ static u32 mpc52xx_can_get_clock(struct platfor=
m_device *ofdev,
>>>  #endif /* CONFIG_PPC_MPC52xx */
>>> =20
>>>  #ifdef CONFIG_PPC_MPC512x
>>> +
>>> +#if IS_ENABLED(CONFIG_COMMON_CLK)
>>> +
>>> +static u32 mpc512x_can_get_clock(struct platform_device *ofdev,
>>> +				 const char *clock_source, int *mscan_clksrc)
>>> +{
>>> +	struct device_node *np;
>>> +	u32 clockdiv;
>>> +	enum {
>>> +		CLK_FROM_AUTO,
>>> +		CLK_FROM_IPS,
>>> +		CLK_FROM_SYS,
>>> +		CLK_FROM_REF,
>>> +	} clk_from;
>>> +	struct clk *clk_in, *clk_can;
>>> +	unsigned long freq_calc;
>>> +
>>> +	/* the caller passed in the clock source spec that was read from
>>> +	 * the device tree, get the optional clock divider as well
>>> +	 */
>>> +	np =3D ofdev->dev.of_node;
>>> +	clockdiv =3D 1;
>>> +	of_property_read_u32(np, "fsl,mscan-clock-divider", &clockdiv);
>>> +	dev_dbg(&ofdev->dev, "device tree specs: clk src[%s] div[%d]\n",
>>> +		clock_source ? clock_source : "<NULL>", clockdiv);
>>> +
>>> +	/* when clock-source is 'ip', the CANCTL1[CLKSRC] bit needs to
>>> +	 * get set, and the 'ips' clock is the input to the MSCAN
>>> +	 * component
>>> +	 *
>>> +	 * for clock-source values of 'ref' or 'sys' the CANCTL1[CLKSRC]
>>> +	 * bit needs to get cleared, an optional clock-divider may have
>>> +	 * been specified (the default value is 1), the appropriate
>>> +	 * MSCAN related MCLK is the input to the MSCAN component
>>> +	 *
>>> +	 * in the absence of a clock-source spec, first an optimal clock
>>> +	 * gets determined based on the 'sys' clock, if that fails the
>>> +	 * 'ref' clock is used
>>> +	 */
>>> +	clk_from =3D CLK_FROM_AUTO;
>>> +	if (clock_source) {
>>> +		/* interpret the device tree's spec for the clock source */
>>> +		if (!strcmp(clock_source, "ip"))
>>> +			clk_from =3D CLK_FROM_IPS;
>>> +		else if (!strcmp(clock_source, "sys"))
>>> +			clk_from =3D CLK_FROM_SYS;
>>> +		else if (!strcmp(clock_source, "ref"))
>>> +			clk_from =3D CLK_FROM_REF;
>>> +		else
>>> +			goto err_invalid;
>>> +		dev_dbg(&ofdev->dev, "got a clk source spec[%d]\n", clk_from);
>>> +	}
>>> +	if (clk_from =3D=3D CLK_FROM_AUTO) {
>>> +		/* no spec so far, try the 'sys' clock; round to the
>>> +		 * next MHz and see if we can get a multiple of 16MHz
>>> +		 */
>>> +		dev_dbg(&ofdev->dev, "no clk source spec, trying SYS\n");
>>> +		clk_in =3D clk_get(&ofdev->dev, "sys");
>>> +		if (IS_ERR(clk_in))
>>> +			goto err_notavail;
>>> +		freq_calc =3D clk_get_rate(clk_in);
>>> +		freq_calc +=3D  499999;
>>> +		freq_calc /=3D 1000000;
>>> +		freq_calc *=3D 1000000;
>>> +		if ((freq_calc % 16000000) =3D=3D 0) {
>>> +			clk_from =3D CLK_FROM_SYS;
>>> +			clockdiv =3D freq_calc / 16000000;
>>> +			dev_dbg(&ofdev->dev,
>>> +				"clk fit, sys[%lu] div[%d] freq[%lu]\n",
>>> +				freq_calc, clockdiv, freq_calc / clockdiv);
>>> +		}
>>> +	}
>>> +	if (clk_from =3D=3D CLK_FROM_AUTO) {
>>> +		/* no spec so far, use the 'ref' clock */
>>> +		dev_dbg(&ofdev->dev, "no clk source spec, trying REF\n");
>>> +		clk_in =3D clk_get(&ofdev->dev, "ref");
>>> +		if (IS_ERR(clk_in))
>>> +			goto err_notavail;
>>> +		clk_from =3D CLK_FROM_REF;
>>> +		freq_calc =3D clk_get_rate(clk_in);
>>> +		dev_dbg(&ofdev->dev,
>>> +			"clk fit, ref[%lu] (no div) freq[%lu]\n",
>>> +			freq_calc, freq_calc);
>>> +	}
>>> +
>>> +	/* select IPS or MCLK as the MSCAN input (returned to the caller),
>>> +	 * setup the MCLK mux source and rate if applicable, apply the
>>> +	 * optionally specified or derived above divider, and determine
>>> +	 * the actual resulting clock rate to return to the caller
>>> +	 */
>>> +	switch (clk_from) {
>>> +	case CLK_FROM_IPS:
>>> +		clk_can =3D clk_get(&ofdev->dev, "ips");
>>> +		if (IS_ERR(clk_can))
>>> +			goto err_notavail;
>>> +		clk_prepare_enable(clk_can);
>>
>> Where is the corresponding clk_disable_unprepare()?a
>=20
> It's missing, as I could not find the counterpart of the
> .get_clock() callback where the get and prepare/enable was added
> to.  And it appears that neither are enable errors checked for.
> This patch clearly needs an update as well, but already should be
> the last part of the series in a currently inacceptable state.
>=20
> This .get_clock() routine is supposed to determine the clock
> source, setup the desired rate and return the actual rate.  The
> callback's API is rather limited in that it does communicate
> clock rate values, but cannot access a location to store handles
> to.

I think the API is sufficient, the ofdev links via drv data to the
netdev
(http://lxr.free-electrons.com/source/drivers/net/can/mscan/mpc5xxx_can.c=
#L305)
and you get from the netdev to the mscan_priv
(http://lxr.free-electrons.com/source/drivers/net/can/mscan/mpc5xxx_can.c=
#L281).

BTW: You should prepare_enable the clock in the ndo_open() callback,
i.e. mscan_open() and disable_unprepare in mscan_close(). Doing this you
maximize the power saving effect by not powering the mscan IP core if
the CAN device is not up.

> Are the introduction of a .put_clock() callback and passing the
> 'priv' handle to both get and put routines acceptable?  As this
> would hook up clock handling to probe() and remove() just as
> memory mapping gets approached.

I think an additional priv parameter is not needed. get_ and put_clock()
in probe() and remove() is good, but put the
prepare_enable()/disable_unprepare() in open()/close().

> Below is a patch on top of the CAN related patch in v2 of the
> series.  If this approach is acceptable (maybe modulo how the
> "unused" warnings get silenced), I'll fold it into the
> introduction of common clock support in the mscan(4) driver.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2MFHMOWXWVOUNSMEVKKAA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlHpGO0ACgkQjTAFq1RaXHP2zwCglcDFzmxlHJr/0vPHSj4Kfk58
WYsAnRMHd/NUwmccIuGX+27S3j8U6dPJ
=THt+
-----END PGP SIGNATURE-----

------enig2MFHMOWXWVOUNSMEVKKAA--
