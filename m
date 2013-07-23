Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2C23B2C0114
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 22:34:03 +1000 (EST)
Message-ID: <51EE77FC.8090809@pengutronix.de>
Date: Tue, 23 Jul 2013 14:33:00 +0200
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
Subject: Re: [PATCH v3 11/31] net: can: mscan: improve clock API use
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1374495298-22019-12-git-send-email-gsi@denx.de>
 <51ED2619.5040107@pengutronix.de>
 <20130723115348.GF19071@book.gsilab.sittig.org>
In-Reply-To: <20130723115348.GF19071@book.gsilab.sittig.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2OFXQGVTIVRKRXFDNKXDT"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2OFXQGVTIVRKRXFDNKXDT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/23/2013 01:53 PM, Gerhard Sittig wrote:
> On Mon, Jul 22, 2013 at 14:31 +0200, Marc Kleine-Budde wrote:
>>
>> On 07/22/2013 02:14 PM, Gerhard Sittig wrote:
>>> the .get_clock() callback is run from probe() and might allocate
>>> resources, introduce a .put_clock() callback that is run from remove(=
)
>>> to undo any allocation activities
>>
>> looks good
>>
>>> use devm_get_clk() upon lookup (for SYS and REF) to have the clocks p=
ut
>>> upon driver unload
>>
>> fine
>>
>>> assume that resources get prepared but not necessarily enabled in the=

>>> setup phase, make the open() and close() callbacks of the CAN network=

>>> device enable and disable a previously acquired and prepared clock
>>
>> I think you should call prepare_enable and disable_unprepare in the
>> open/close functions.
>=20
> After more local research, which totally eliminated the need to
> pre-enable the CAN related clocks, but might need more discussion
> as it touches the common gate support, I've learned something
> more:
>=20
> The CAN clock needs to get enabled during probe() already, since
> registers get accessed between probe() for the driver and open()
> for the network device -- while access to peripheral registers
> crashes the kernel when clocks still are disabled (other hardware
> may just hang or provide fake data, neither of this is OK).

Then call prepare_enable(); before and disable_unprepare(); after
accessing the registers. Have a look at the flexcan driver.

> But I see the point in your suggestion to prepare _and_ enable
> the clock during open() as well -- to have open() cope with
> whatever probe() did, after all the driver is shared among
> platforms, which may differ in what they do during probe().

If you enable a clock to access the registers before open() (and disable
it afterwards), it should not harm any architecture that doesn't need
this clock enabled.

> So I will:
> - make open() of the network device prepare _and_ enable the
>   clock for the peripheral (if acquired during probe())

good

> - adjust open() because ATM it leaves the clock enabled when the
>   network device operation fails (the error path is incomplete in
>   v3)

yes, clock should be disabled if open() fails.

> - make the MPC512x specific probe() time .get_clock() routine not
>   just prepare but enable the clock as well

If needed enable the clock, but disable after probe() has finished.

> - and of course address all the shutdown counter parts of the
>   above setup paths

> This results in:
> - specific chip drivers only need to balance their private get
>   and put clock routines which are called from probe and remove,
>   common paths DTRT for all of them

Yes, but clock should not stay enabled between probe() and open().

[...]

> Removing unnecessary devm_put_clk() calls is orthogonal to that.
> Putting these in isn't totally wrong (they won't harm, and they
> do signal "visual balance" more clearly such that the next person
> won't stop and wonder), but it's true that they are redundant.
> "Trained persons" will wonder as much about their presence as
> untrained persons wonder about their absence. :)  Apparently I'm
> not well trained yet.

The whole point about devm_* is to get rid of auto manually tear down
functions. So please remove all devm_put_clk() calls, as it will be
called automatically if a driver instance is removed.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2OFXQGVTIVRKRXFDNKXDT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlHud/wACgkQjTAFq1RaXHMMSwCeMfHdkAhDHmX3ci798jQtjWuB
GKoAn0c0vxyi6q2zcxcQ9CnmCngrkvxb
=tLOU
-----END PGP SIGNATURE-----

------enig2OFXQGVTIVRKRXFDNKXDT--
