Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 83066DDE08
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 00:32:36 +1100 (EST)
Date: Thu, 20 Nov 2008 00:32:24 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: linux-next: spinlock lockup with next-20081118 on powerpc
Message-Id: <20081120003224.8d0f481c.sfr@canb.auug.org.au>
In-Reply-To: <20081119105833.GZ26308@kernel.dk>
References: <20081119093023.48895b84.sfr@canb.auug.org.au>
	<20081119091628.GT26308@kernel.dk>
	<20081119203922.0412c041.sfr@canb.auug.org.au>
	<20081119094300.GW26308@kernel.dk>
	<20081119213304.d2d21042.sfr@canb.auug.org.au>
	<20081119105833.GZ26308@kernel.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__20_Nov_2008_00_32_24_+1100_MeBzhtPhZulmxBmw"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__20_Nov_2008_00_32_24_+1100_MeBzhtPhZulmxBmw
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Wed, 19 Nov 2008 11:58:33 +0100 Jens Axboe <jens.axboe@oracle.com> wrote:
>
> ;-) I'm aware of that, I meant the 'timer' data argument. But you are
> right, it's probably q->queue_lock being NULL here or we would have
> oopsed earlier. There's no code line.
>=20
> > address of the spinlock (though I need to check more to be sure) as it
> > crashed inside _spin_lock_irqsave.
>=20
> Do you know what device this might be? It still makes no sense, if the
> timer was added, we went through the normal IO paths and we would have
> crashed on NULL ->queue_lock much earlier.

I don't know much more, but I may find out tomorrow with Paul's help.
However it bisects down to commit
279430a72bb6e83d335b4219e9af5557e2ff3350 "block: leave the request
timeout timer running even on an empty list" and reverting that commit on
next-20081118 makes the spinlock lockup go away.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__20_Nov_2008_00_32_24_+1100_MeBzhtPhZulmxBmw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkkFWgACgkQjjKRsyhoI8yNKACdGMos5jpMAhzoQmYm0ILOlxQc
vdUAoKjqdD8HGS9BO6FDi8+tztdBeYQZ
=MeIW
-----END PGP SIGNATURE-----

--Signature=_Thu__20_Nov_2008_00_32_24_+1100_MeBzhtPhZulmxBmw--
