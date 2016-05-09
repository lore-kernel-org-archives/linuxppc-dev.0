Return-Path: <felipe.balbi@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by lists.ozlabs.org (Postfix) with ESMTP id 3r3Jq323PhzDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 May 2016 20:42:06 +1000 (AEST)
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
 benh@au1.ibm.com, linux-mips@linux-mips.org
Cc: Christian Lamparter <chunkeey@googlemail.com>, linux-usb@vger.kernel.org,
 johnyoun@synopsys.com, gregkh@linuxfoundation.org, a.seppala@gmail.com,
 linux-kernel@vger.kernel.org
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since
 4.3.0-rc4
In-Reply-To: <4162108.qmr2GZCaDN@wuerfel>
References: <4231696.iL6nGs74X8@debian64> <1908894.Nkk1LXQkFm@debian64>
 <1462753402.20290.95.camel@au1.ibm.com> <4162108.qmr2GZCaDN@wuerfel>
Date: Mon, 09 May 2016 13:39:50 +0300
Message-ID: <8737prikg9.fsf@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Arnd Bergmann <arnd@arndb.de> writes:
> On Monday 09 May 2016 10:23:22 Benjamin Herrenschmidt wrote:
>> On Sun, 2016-05-08 at 13:44 +0200, Christian Lamparter wrote:
>> > On Sunday, May 08, 2016 08:40:55 PM Benjamin Herrenschmidt wrote:
>> > >=20
>> > > On Sun, 2016-05-08 at 00:54 +0200, Christian Lamparter via Linuxppc-=
dev=20
>> > > wrote:
>> > > >=20
>> > > > I've been looking in getting the MyBook Live Duo's USB OTG port
>> > > > to function. The SoC is a APM82181. Which has a PowerPC 464 core
>> > > > and related to the supported canyonlands architecture in
>> > > > arch/powerpc/.
>> > > >=20
>> > > > Currently in -next the dwc2 module doesn't load:=20
>> > > Smells like the APM implementation is little endian. You might need =
to
>> > > use a flag to indicate what endian to use instead and set it
>> > > appropriately based on some DT properties.
>> > I tried. As per common-properties[0], I added little-endian; but it ha=
s no
>> > effect. I looked in dwc2_driver_probe and found no way of specifying t=
he
>> > endian of the device. It all comes down to the dwc2_readl & dwc2_writel
>> > accessors. These - sadly - have been hardwired to use __raw_readl and
>> > __raw_writel. So, it's always "native-endian". While common-properties
>> > says little-endian should be preferred.
>>=20
>> Right, I meant, you should produce a patch adding a runtime test inside
>> those functions based on a device-tree property, a bit like we do for
>> some of the HCDs like OHCI, EHCI etc...
>>=20
>>=20
>
> The patch that caused the problem had multiple issues:
>
> - it broke big-endian ARM kernels: any machine that was working
>   correctly with a little-endian kernel is no longer using byteswaps
>   on big-endian kernels, which clearly breaks them.
> - On PowerPC the same thing must be true: if it was working before,
>   using big-endian kernels is now broken. Unlike ARM, 32-bit PowerPC
>   usually uses big-endian kernels, so they are likely all broken.
> - The barrier for dwc2_writel is on the wrong side of the __raw_writel(),
>   so the MMIO no longer synchronizes with DMA operations.
> - On architectures that require specific CPU instructions for MMIO
>   access, using the __raw_ variant may turn this into a pointer
>   dereference that does not have the same effect as the readl/writel.
>
> I think we can simply make this set of accessors architecture-dependent
> (MIPS vs. the rest of the world) to revert ARM and PowerPC back to
> the working version.

and patch all drivers similarly? Shouldn't arch/mips itself deal with it
and hide it from drivers ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMGj2AAoJEIaOsuA1yqREuNEQAKyGw6qIapBiHGopZJBsjc4a
LNf8tyPx42KfBfQxqwz+iYOz+++MLKYST+JU9iri9YfmPbrVOVfwxflY7Dicfyr6
un/cHYrPPEitw1hhi/YkQ0nK5V+OYPSP5szo+v+5aKF9gJBq3rlSQdMSTKWfXG3B
M2aqPepBVUDd/ppHmXIuchgbNs0lmQC9Ai08E4gvXukMwatDqoMs1WDjCONhXx58
zXG7Z2gnBeSV/c6aqUXaRgbJ0oJYdDkSlyibEqVc7SFexCxvDufgaqMy556bIHBz
DJXh1KC16nPTRDyPv7DmtXMYVKZTo+NkpbRUYqJbHblZJfjYAEXYAP/1nUv5mCuw
WzLApB+wjszF3jj43o7SdGAwZAJx1kqBCEEvoJWNH4T83UWo3sc4F50WlPXlFk3D
IZal/h9VKEl25ia3RY/+ClJJIO97cdc44YUIkCqDu0G3Pj6bElJKlTTc8slAybWz
t7s5+cbWfeI5gM8RlKeTmwhojtJ3oKZ9HHnCKVwCVGhMtJIWTs9K12BpSpwbNDQa
elwwbyMa77BfTNGMNpHeJtC4DtmQHBAgIaa8owvyKJyFrYjNoC/zgytnb5TSLSEE
xdgzPX3FSJ5brCe0bE5q+FP1cUbMJtyKFUeLQgT1wyTFd+8kAuGbXWX48FTVSEIt
ARx6LqXh0rpOZiTdr73X
=7Uot
-----END PGP SIGNATURE-----
--=-=-=--
