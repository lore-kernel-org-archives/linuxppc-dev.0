Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 56332DDE3E
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 14:00:26 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l5J40KCN005733
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2007 21:00:20 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l5J40GLr018552
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2007 23:00:17 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-7"
Subject: RE: [PATCH] rheap: eliminates internal fragments caused by alignment
Date: Tue, 19 Jun 2007 12:02:09 +0800
Message-ID: <989B956029373F45A0B8AF0297081890D82CAB@zch01exm26.fsl.freescale.net>
In-Reply-To: <DA299F48-E5A6-495C-8169-A211D4C83864@gmail.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Pantelis Antoniou" <pantelis.antoniou@gmail.com>,
	<joakim.tjernlund@transmode.se>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>, Paul <paulus@samba.org>,
	Vitaly Bordug <vbordug@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Pantelis Antoniou [mailto:pantelis.antoniou@gmail.com]
> Sent: Monday, June 18, 2007 8:31 PM
> To: joakim.tjernlund@transmode.se
> Cc: Li Yang-r58472; Paul; Vitaly Bordug; linuxppc-dev Development
> Subject: Re: [PATCH] rheap: eliminates internal fragments caused by =
alignment
>=20
>=20
> On 18 =C9=EF=F5=ED 2007, at 3:25 =CC=CC, Joakim Tjernlund wrote:
>=20
> > On Mon, 2007-06-18 at 15:14 +0300, Pantelis Antoniou wrote:
> >> Hi Li,
> >>
> >> The patch appears fine at first glance.
> >>
> >> I'm really curious what kind of alignment do you use in order to
> >> have so
> >> much wasted space that re-inserting the leftovers makes so much of =
a
> >> difference.
>=20
> Jocke,
>=20
> Ugh, 256?
>=20
> That's not nice at all.
Pantelis,

For QE, most of the MURAM allocation requires relative large alignment.  =
SDMA buffer even needs a 4k alignment.

> I'm not sure that even then you're going to have any guarantees that
> the allocations will be successful.
>=20
> I'm afraid that in those case it would be better for the board
> platform setup to have the space preallocated according to the BSP
> requirements.

Dynamic allocation surely can't match the efficiency of manual =
allocation.  But with this patch applied, the utilization efficiency =
will be good enough for most systems to work correctly, and without the =
great trouble to partition the space yourself.  Moreover, given the fact =
that in QE drivers some MURAM usage can be tunable, it will be more =
suitable to use the dynamic allocation.

A general policy will be helpful, that allocations with huge alignment =
(like 4k) should always be done as early as possible.

- Leo
