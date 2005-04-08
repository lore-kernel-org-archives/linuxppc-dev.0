Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 7CD9A67A64
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Apr 2005 00:39:15 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 8 Apr 2005 09:39:14 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B859345@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Stefan Nickl" <Stefan.Nickl@kontron.com>,
	"Tom Rini" <trini@kernel.crashing.org>
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

I'm not sure what is going on, but that patch causes me to get "eth0: tx
queue full!." messages as soon as I try to use the ethernet
(Same thing happened if I just tried to remove the fcc_restart from
init_fcc_startup)

> -----Original Message-----
> From: Stefan Nickl [mailto:Stefan.Nickl@kontron.com]=20
> Sent: Friday, April 08, 2005 05:49
> To: Tom Rini
> Cc: Rune Torgersen; linuxppc-embedded
> Subject: Re: FCC Ethernet startup crash
>=20
> On Thu, 2005-04-07 at 09:36 -0700, Tom Rini wrote:
> > > The patch Stefan Nickl gave to me works perfectly, and=20
> all it does is
> > > basically move the fcc_restart.
> > > The kernel was still calling fcc_restart twiche per FCC=20
> at startup (one
> > > time on init_fcc_startup, and then again in fcc_open),=20
> now it just calls
> > > it twice in fcc_open. Seems to work.
> >=20
> > Would someone please post what's needed vs current'ish 2.6=20
> so we can get
> > the proper fix up & in? :)  With the Signed-off-by & all=20
> that.. Thanks.
>=20
> I took a little longer because I was not happy with the simple
> cut'n'paste version. I believe the actual problem is that=20
> fcc_restart()
> mustn't be called before netif_start_queue(). So the original version
> only shortens the race period, it does not actually resolve it.
>=20
> Unfortunately I'm deprived of suitable hardware as the focus=20
> of my work
> has shifted in the last months, so I urge everyone out there=20
> to give it
> a try.
>=20
> Signed-off-by: Stefan Nickl <Stefan.Nickl@kontron.com>
>=20
> --=20
> Stefan Nickl
> Kontron Modular Computers
>=20
>=20
