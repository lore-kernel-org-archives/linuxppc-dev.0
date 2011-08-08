Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 10B90B6F72
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  8 Aug 2011 19:33:12 +1000 (EST)
Message-ID: <4E3FAD41.1030404@pengutronix.de>
Date: Mon, 08 Aug 2011 11:32:49 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC 4/4] [powerpc] Implement a p1010rdb clock source.
References: <1312603504-30282-1-git-send-email-holt@sgi.com>
	<1312603504-30282-5-git-send-email-holt@sgi.com>
	<4E3D4875.30707@pengutronix.de>
	<39414D86-7822-4B92-B005-351890A2A167@kernel.crashing.org>
	<20110806205010.GQ4926@sgi.com>
	<3C4B6145-5C75-4A3C-B504-DA32E0D2EC8A@kernel.crashing.org>
	<4E3FA301.4050005@grandegger.com>
In-Reply-To: <4E3FA301.4050005@grandegger.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1D62CFCFD655DC236D061506"
Cc: Netdev <netdev@vger.kernel.org>, U Bhaskar-B22300 <B22300@freescale.com>,
	socketcan-core@lists.berlios.de, Robin Holt <holt@sgi.com>,
	"linuxppc-dev@lists.ozlabs.org Development" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1D62CFCFD655DC236D061506
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/08/2011 10:49 AM, Wolfgang Grandegger wrote:
> On 08/06/2011 10:59 PM, Kumar Gala wrote:
>>
>> On Aug 6, 2011, at 3:50 PM, Robin Holt wrote:
>>
>>> On Sat, Aug 06, 2011 at 11:52:45AM -0500, Kumar Gala wrote:
>>>>
>>>> On Aug 6, 2011, at 8:58 AM, Marc Kleine-Budde wrote:
>>>>
>>>>> On 08/06/2011 06:05 AM, Robin Holt wrote:
>>>>>> flexcan driver needs the clk_get, clk_get_rate, etc functions
>>>>>> to work.  This patch provides the minimum functionality.
>>>>>
>>>>> This patch has to go via the powerpc git tree. Added
>>>>> linuxppc-dev@lists.ozlabs.org on CC.
>>>>>
>>>>>> Signed-off-by: Robin Holt <holt@sgi.com>
>>>>>> To: Marc Kleine-Budde <mkl@pengutronix.de>
>>>>>> To: Wolfgang Grandegger <wg@grandegger.com>
>>>>>> To: U Bhaskar-B22300 <B22300@freescale.com>
>>>>>> Cc: socketcan-core@lists.berlios.de
>>>>>> Cc: netdev@vger.kernel.org
>>>>>> ---
>>>>>> arch/powerpc/platforms/85xx/p1010rdb.c |   78 ++++++++++++++++++++=
++++++++++++
>>>>>> 1 files changed, 78 insertions(+), 0 deletions(-)
>>>>
>>>> NAK.
>>>>
>>>> This doesn't look right at all.  We should be doing something based =
on the device tree node that isn't board specific.
>>>>
>>>> I believe Bhaskar has a version of flexcan support that he's been wo=
rking on cleanup up for upstream.
>>>
>>> That version may be similar to what is in the freescale BSP which put=
s
>>> the clock functions inside flexcan.c
>>>
>>> The powerpc arch already provides a means for individual boards to pr=
ovide
>>> the clock functions.  I am not posting this patch here for acceptance=

>>> for powerpc and I am sure I will get feedback there when I post to
>>> their mailing list.  I am posting it here only to show that the flexc=
an
>>> developers earlier assertion that this can and should be done in the =
arch
>>> tree is correct and will work for the p1010 assuming we can get chang=
es
>>> into the arch/powerpc directory to implement these clk_* functions.
>>
>> My point is that I don't think they should live in the arch code.  The=
 clk_* functions you want to implement are tied more the FlexCAN IP than =
anything arch specific.  As such I believe they should be in the driver.
>>
>> For example when FSL has a P9999 with FlexCAN on it, we should NOT hav=
e to add any arch code to support it.
>=20
> The Flexcan is found on ARM and now also on PowerPC SOCs. My current
> understanding is that the ability to set the clock source and divider i=
s
> only available on PowerPC SOCs and therefore it's clearly arch specific=

> and should go to arch/powerpc/sysdev/fsl_soc.c if it's common for all
> PowerPC platforms. What do you think?

There is a bit in the CAN-Controller that selects the clock (at least on
arm). The current driver just supports the bus clock. Support for the
other, the oscillator clock, has not been implemented so far.

IIRC the oscillator clock has a frequency that results in worse standard
timing than the bus clock.

cheers, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig1D62CFCFD655DC236D061506
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk4/rUQACgkQjTAFq1RaXHPmsACfYBw3LrMEt377WElOQC1ZKkZO
b20An0Vbo87boZNDuvE1r5+zow2zBPGl
=UmJn
-----END PGP SIGNATURE-----

--------------enig1D62CFCFD655DC236D061506--
