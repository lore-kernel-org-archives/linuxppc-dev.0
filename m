Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.189])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7MMv1TyfzDqTq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 01:51:22 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Arnd Bergmann' <arnd@arndb.de>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
CC: 'Arvind Yadav' <arvind.yadav.cs@gmail.com>, "zajec5@gmail.com"
 <zajec5@gmail.com>, "leoli@freescale.com" <leoli@freescale.com>,
 "qiang.zhao@freescale.com" <qiang.zhao@freescale.com>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "scottwood@freescale.com"
 <scottwood@freescale.com>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, "linux@roeck-us.net" <linux@roeck-us.net>
Subject: RE: [5.3] ucc_geth: Fix to avoid IS_ERR_VALUE abuses and dead code
 on 64bit systems.
Date: Mon, 8 Aug 2016 15:49:22 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D5F50C532@AcuExch.aculab.com>
References: <1470386442-7208-1-git-send-email-arvind.yadav.cs@gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6D5F50C493@AcuExch.aculab.com>
 <2862487.guU7g5Qkfj@wuerfel>
In-Reply-To: <2862487.guU7g5Qkfj@wuerfel>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Arnd Bergmann
> Sent: 08 August 2016 16:13
>=20
> On Monday, August 8, 2016 2:49:11 PM CEST David Laight wrote:
> >
> > > If qe_muram_alloc will return any error, Then IS_ERR_VALUE will alway=
s
> > > return 0. it'll not call ucc_fast_free for any failure. Inside 'if co=
de'
> > > will be a dead code on 64bit. Even qe_muram_addr will return wrong
> > > virtual address. Which can cause an error.
> > >
> > >  kfree((void *)ugeth->tx_bd_ring_offset[i]);
> >
> > Erm, kfree() isn't the right function for things allocated by qe_muram_=
alloc().
> >
> > I still thing you need to stop this code using IS_ERR_VALUE() at all.
>=20
> Those are two separate issues:
>=20
> a) The ucc_geth driver mixing kmalloc() memory with muram, and assigning
>    the result to "u32" and "void __iomem *" variables, both of which
>    are wrong at least half of the time.
>=20
> b) calling conventions of qe_muram_alloc() being defined in a way that
>    requires the use of IS_ERR_VALUE(), because '0' is a valid address
>    here.

Yep, it is all a big bag of worms...
'0' being valid is going to make tidying up after failure 'problematic'.

> The first one can be solved by updating the network driver, ideally
> by getting rid of the casts and using proper types and accessors,
> while the second would require updating all users of that interface.

It might be worth (at least as a compilation option) of embedding the
'muram offset' in a structure (passed and returned by value).

The compiler can then check that the driver code is never be looking
directly at the value.

For 'b' zero can be made invalid by changing the places where the
offset is added/subtracted.
It could even be used to offset the saved physical and virtual
addresses of the area - so not needing any extra code when the values
are converted to physical/virtual addresses.

	David
