Return-Path: <balbi@ti.com>
Received: from na3sys009aog120.obsmtp.com (na3sys009aog120.obsmtp.com
 [74.125.149.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8C0031007D7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 20:38:43 +1100 (EST)
Received: by mail-gy0-f172.google.com with SMTP id r14so2333728ghr.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 01:38:38 -0800 (PST)
Date: Thu, 24 Nov 2011 11:32:09 +0200
From: Felipe Balbi <balbi@ti.com>
To: Li Yang-R58472 <r58472@freescale.com>
Subject: Re: [PATCH] usb/fsl_udc: fix dequeuing a request in progress
Message-ID: <20111124093208.GI3352@legolas.emea.dhcp.ti.com>
References: <1321015093-13715-1-git-send-email-leoli@freescale.com>
 <20111122093437.GA18543@nchen-desktop>
 <3F607A5180246847A760FD34122A1E052D94DB@039-SN1MPN1-003.039d.mgd.msft.net>
 <CAL411-qEgc8T+sdn4VzUXeCd76mQ1wkc9V6oV+CovVV8QrRxYg@mail.gmail.com>
 <CAL411-rXmawefELJCdCgiXT7Ma5Mi7z1zbR_eLZCncTChiR4Mg@mail.gmail.com>
 <3F607A5180246847A760FD34122A1E052DB395@039-SN1MPN1-003.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="WHz+neNWvhIGAO8A"
In-Reply-To: <3F607A5180246847A760FD34122A1E052DB395@039-SN1MPN1-003.039d.mgd.msft.net>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 Chen Peter-B29397 <B29397@freescale.com>, "gregkh@suse.de" <gregkh@suse.de>,
 "balbi@ti.com" <balbi@ti.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Peter Chen <hzpeterchen@gmail.com>
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--WHz+neNWvhIGAO8A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 23, 2011 at 08:20:54AM +0000, Li Yang-R58472 wrote:
> >Leo, I have debugged this issue at my board just now, the reason of
> >failure is we only have one ep struct for ep0, so when talking about ep0,
> >it always pointers to udc->ep[0]. So even we initialize the current qh
> >address for ep0in at probe, it still can't get the ep0in's qh address
> >through ep structure, as ep0 is always udc->ep[0].
>=20
> Oops.  I forgot the fact that we used a single ep structure to handle
> both IN and OUT ep0 because the gadget layer only knows about one ep0
> structure.

the gadget framework knows about USB endpoints which are bidirectional
logical entities. One USB endpoint is composed of two unidirectional HW
endpoints.

> I guess currently we have no other way out unless the gadget layer do
> honor ep0 with direction.  IMHO, it is a limitation to current gadget
> APIs that each udc driver need to take too much care of the protocol
> related stuff on ep0.

indeed, if you can come up with a sensible patch we're here to review
;-)

--=20
balbi

--WHz+neNWvhIGAO8A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOzg8YAAoJEIaOsuA1yqREUd0P/RoSUPEw7IG7BFsMNDoUFTHb
pkZ+wU5vkgXlCOKJEbZOwDKItBXjsj7nkNPOfR49f0IGBa7sJ/JU3O/sA01XWCQN
anq7jROZVevDNCHLSV2Sp/YxJb2enjvGhPkMFnrwYu8Dq4ItGOZS7aoyC1nNQujh
cwub/yq3AWUvr8x7xagmEbi+U9NWFAkwSnJfMYqo+byjN5lQQBysjZTjC9BnshVX
T8NT8zvZ5t9CkEVLsserF1jTJPpPadVPD1/9ZYjIjtojcuJCu/VxCJAf096NXu+m
CXGl5BS0L3TGuHHaYpKhoze+zN/1fni9pl8wDiIKBcMH6ynXLRTxi6P8aRGIWHh6
fya+fwCYN0VdBxSrmZdQc5NyR7VGErVJ8of9In5Q/DhflzAaTfNUCBEEaYMgldiC
sXQOjJY5gB8Hu6YhUJTFquf/ESc+Ylf2pFEMiMxTLQzS2Wj4Ch1CwYJhAZPWXcaK
ip/SQqC1jfPi+bJXB4RBT75q/dXswP6KbyvfynPjXcN80oCWnCp7cwtvHK4XVIA3
25XyIx9ame1NR5AEwYolUcwi1B2a3JzXugoAAiJE3svCmZAnhkvjjMUSfSbErJxt
I/j296P3rh6WOVY3OXp2VzZu1G1vtZgwVa/3FF/KKEt/YBrQ4QcheaRI8nBw4yhb
Wz2PFhjNanLp7kj7209j
=xFpZ
-----END PGP SIGNATURE-----

--WHz+neNWvhIGAO8A--
