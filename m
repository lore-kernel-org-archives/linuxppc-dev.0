Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 3288867A6D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Apr 2005 02:27:05 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 5 Apr 2005 11:27:04 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B859337@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Stefan Nickl" <Stefan.Nickl@kontron.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: RE: FCC Ethernet startup crash
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ahhh....
I see what happened....
Basically only the last part of that patch has been applied to the 2.6
kernels..

fcc_restart gets called both in init_fcc_startup *and* fcc_open.
=20
I'll try to remove the fcc_restart in init_fcc_startup, and see what
happens.


> -----Original Message-----
> From: Stefan Nickl [mailto:Stefan.Nickl@kontron.com]=20
> Sent: Tuesday, April 05, 2005 10:57
> To: Rune Torgersen
> Cc: linuxppc-embedded
> Subject: Re: FCC Ethernet startup crash
>=20
> On Tue, 2005-04-05 at 10:37 -0500, Rune Torgersen wrote:
> > I've been running into the old problem of the kernel ip=20
> stack crasheing
> > the kernel, because of early packets again.
> >=20
> > This has been mentioned on this list several times before, but the
> > worarounds that used to work doesn't seem to work anymore.
> > (like changing the order of things in ip_init())
> >=20
> > As far as I can tell, it is because the FCC enet drivers starts to
> > receive packets way before the ip stack is initialized.
> >=20
> > Does anybody have any good ideas on how to fix this?
>=20
> Maybe you want to try my version:
>=20
> http://ozlabs.org/ppc32-patches/patch.pl?id=3D14
>=20
> Or is it equal to your (no longer working) solution?
>=20
> --=20
> Stefan Nickl
> Kontron Modular Computers
>=20
>=20
>=20
>=20
