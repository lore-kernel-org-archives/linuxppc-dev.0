Return-Path: <lasaine@lvk.cs.msu.su>
Received: from mail.lvk.cs.msu.su (gate.lvk.cs.msu.su [158.250.17.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.lvk.cs.msu.su", Issuer "CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 92D85B7101
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Feb 2011 11:19:42 +1100 (EST)
Date: Tue, 8 Feb 2011 03:19:25 +0300
From: Alexander Gordeev <lasaine@lvk.cs.msu.su>
To: Tirumala Marri <tmarri@apm.com>
Subject: Re: [PATCH V8 03/10] USB/ppc4xx: Add Synopsys DWC OTG Core
	Interface Layer
Message-ID: <20110208031925.60bd1118@apollo.gnet>
In-Reply-To: <4d3a1de3bf1ff8a4f69bf2d90da0a1cf@mail.gmail.com>
References: <1295477852-14735-1-git-send-email-tmarri@apm.com>
	<20110126191734.5dff9641@desktopvm.lvknet>
	<4d3a1de3bf1ff8a4f69bf2d90da0a1cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA256;
	boundary="Sig_/3A1N0aSLTF.bj33i_73MB9s";
	protocol="application/pgp-signature"
Cc: Mark Miesfeld <mmiesfeld@apm.com>, greg@kroah.com,
	linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/3A1N0aSLTF.bj33i_73MB9s
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

=D0=92 Mon, 7 Feb 2011 10:53:25 -0800
Tirumala Marri <tmarri@apm.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> dwc_read_reg32 is used nowhere throughout the code. One of dwc_read32 and
> dwc_read_reg32 should be removed IMO. There was once only dwc_read_reg32.=
 In
> version 5 of your patchset I believe. Why did you add another function?
> AFAIK it is not correct to store pointers in u32 because they need 8 bytes
> on 64-bit archs. So it was ok with the old dwc_read_reg32.
> [Marri] If u32 is 8bytes isn't pointer type would be 8bytes as well.

Sorry, I don't understand that. I think u32 is always 32bit =3D 4byte on
all archs. Right?

> I had change the API to avoid type castings to register addresses.

IMO it's now much worse because you pass a u32 value and cast it
internally to a pointer. I think it's unsafe and counter-intuitive. BTW
what is the problem with type casting to register addresses that you
mention? I've checked version 5 of your patchset (which is the last
version where the old API is used) and there are no casts.

--=20
  Alexander

--Sig_/3A1N0aSLTF.bj33i_73MB9s
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBCAAGBQJNUIwNAAoJEElrwznyooJbSZsH/25ARf8MZbuQi528oVv65nN0
pMRvRhMufY8d3mnKPHIP6GRArCqyxq1tNwWX4XGVz0RnKj7tzViDStG5UaQ6Zu24
qt8w+B0ifvph6YTQ1azf0O+jhPOd4GhXlEkb5gQ9oVLnc6lYTWDE/08mRwPjXnvK
u2rOr22j9KhwefnNxaOhXzTQp5z/W2hmPp0HJZ8FtmbqdVUwfw1sczbjOaj/NFwU
5SvFTSYXykUiID2gsAtFLSi6nXly3z88ZwmV8mPUg6J8+/A/tj4bh+0r8Qzxq5WP
hS7xh17h9v8z7A+VS9wHUYDbnN/SoNoXmzTxqVhjc7PZgCXCNCXYWgXTVElDXwQ=
=0syE
-----END PGP SIGNATURE-----

--Sig_/3A1N0aSLTF.bj33i_73MB9s--
