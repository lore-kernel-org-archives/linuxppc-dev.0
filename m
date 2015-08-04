Return-Path: <balbi@ti.com>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D5CD81A076F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 03:30:10 +1000 (AEST)
Date: Tue, 4 Aug 2015 12:29:33 -0500
From: Felipe Balbi <balbi@ti.com>
To: Robert Baldyga <r.baldyga@samsung.com>
CC: <balbi@ti.com>, <gregkh@linuxfoundation.org>, <Peter.Chen@freescale.com>,
 <johnyoun@synopsys.com>, <dahlmann.thomas@arcor.de>,
 <nicolas.ferre@atmel.com>, <cernekee@gmail.com>, <leoli@freescale.com>,
 <daniel@zonque.org>, <haojian.zhuang@gmail.com>,
 <robert.jarzmik@free.fr>, <michal.simek@xilinx.com>,
 <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
 <linux-usb@vger.kernel.org>, <linux-omap@vger.kernel.org>,
 <linux-geode@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
 <linuxppc-dev@lists.ozlabs.org>, <andrzej.p@samsung.com>,
 <m.szyprowski@samsung.com>, <stern@rowland.harvard.edu>, <petr.cvek@tul.cz>
Subject: Re: [PATCH v5 00/46] usb: gadget: rework ep matching and claiming
 mechanism
Message-ID: <20150804172933.GB9623@saruman.tx.rr.com>
Reply-To: <balbi@ti.com>
References: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
In-Reply-To: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 31, 2015 at 04:00:12PM +0200, Robert Baldyga wrote:
> Hello,
>=20
> This patch series reworks endpoint matching and claiming mechanism in
> epautoconf. From v2 there are couple of new patches adding 'ep_match'
> to usb_gadget_ops and removing chip-specific quirk handling from generic
> code of autoconfig.
>=20
> I'm not sure if this patch set isn't too long, as it has 46 patches,
> but I decided to send it as single series to avoid problems with patch
> applying order.
>=20
> The aim of whole patchset is to rework epautoconf code to get rid of
> things like name-based endpoint matching and UDC name-based quirks in
> generic code. These needed to do some modifications in framework like
> adding 'endpoint capabilities flags' feature or adding 'match_ep'.
>=20
> Following paragraphs contain brief description of what modifications are
> done by particular parts of this patch set:
>=20
> Patch (1) introduces new safer endpoint claiming method, basing on new
> 'claimed' flag. It was discussed here [1]. I proposed this solution over
> year ago and it was accepted, but I apparently forgot to send the final
> version of my patch.
>=20
> Patches (2-3) add the 'capabilities flags' structure and helper macros.
> This solution is inspired by the 'feature flags' originally proposed
> by Felipe Balbi in 2013 [2], but unfortunately implementation of this
> feature has never been completed.
>=20
> Patches (4-36) add' capabilites flags' support to all UDC drivers present
> in the kernel tree. It's needed to be done before replacing old endpoint
> matching mechanism, otherwise UDC drivers which doesn't set 'capabilities
> flags' won't work with new matching function.
>=20
> Patch (37) finally replaces old endpoint matching method with the new
> one basing on capabilities flags.
>=20
> These changes aims to get rid of code, which guesses endpoint capabilities
> basing on it's name, and introduce new better replacement. In result
> we have better way to describe types and directions supported by each
> endpoint.
>=20
> For example the old name-based method didn't allow to have endpoint
> supporing two types of transfers - there were only ability to support
> one or all of endpoint types. The 'capabilities flags' feature supply
> precise, flexible and extensible mechanism of description of endpoint
> hardware limitations, which is desired for proper endpoint matching.
>=20
> Patch (38) removes chip-specific quirk from ep_matches() function.
>=20
> Patches (39-40) remove code modifying endpoint and descriptor structures
> from ep_matches() function and cleans it up to make it simpler and more
> readable.
>=20
> Patch (41) add 'match_ep' callback to usb_gadget_ops and make use of
> it in epautoconf. This callback allows UDC drivers to supply non-standard
> endpoint matching algorithms.
>=20
> Patches (42-43) move ep_matches() and find_ep() functions outside
> epautoconf and rename them to usb_gadget_ep_match_desc() and
> gadget_find_ep_by_name(). It's because they may be useful in 'match_ep'
> callbacks in UDC drivers to avoid writing repetitive code.
>=20
> Patches (44-46) move chip-specific enpoint matching algorithms from
> generic code of usb_ep_autoconfig_ss() function to UDC controller drivers
> using 'match_ep' callback.
>=20
> In the result we have epautoconf source free of chip-specific code, plus
> two new mechanisms allowing to handle non-standard hardware limitations.
>=20
> [1] https://lkml.org/lkml/2014/6/16/94
> [2] http://www.spinics.net/lists/linux-usb/msg99662.html

adding these to my testing/next after fixing a few build warnings and
the comment I had on dwc3 patch. Let's hope it just works :-)

--=20
balbi

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVwPZ9AAoJEIaOsuA1yqRES1QP/iR7eYzQ5VrcGxAx3J1m7IRd
HKkZnhe2YWdZfukLib1B4hLZp6XJBwT+vcm+5dqFoz0BG8RQOiFjNlXAd5PSZtpc
KfpZQJ0HwqsFnxQh6vMgi2wHOQSZ3lEAxsvoBupKjUm/6Rp4m9Ew+8XI0aOKWj1v
JmIkZYyUmkqk7xAJA1Q8wYnbfP+ilC/K9+9f5MGJJvBTF/kCkjKzGCZKbCATYl2h
O5XGwu9w4TwDFG4MlcgqJ1SzJ7oNQFseqNxRi16EBO5SFiSq9TzQfsm/q4R+3UzA
75B2aFQmBdJqk1Z7Cva2QGP6zk2tmmL/R6+Wk40TYmY3fp+KiZRqzPK39vwR/8i/
Y59t4V7Aze08zTWVsEFZc98pWYNl2FK6k3gEq8geO9Rotwq/grBq+4dcWRpkmHbq
iMAUz+6kBhBn1riXFmrju6hMMgsaX7Zq9/ja+BBtPrDxzptt4Ig8iaU720I5rVu1
3ZG1cLjBVFvH22lB4iyq6Sx4VsCBiYHQo3xcfmeEuRptHMybdeQKThSDHXViS5Cj
0m3//6/wus/DVeN+XbV+SVCd0OXxAbxyw3BDhXmiAqqZtpC40NLxtBXCkvMZuMjG
o/YwjDlbAjNFUhcxKk/aYo2I1qcQsyIj6NgqNAcr7ps8HEh92APKOcYQO7iWedBm
bWRpbm4HnEwvUYWyxjzj
=h26C
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
