Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 78D36679E7
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Oct 2006 18:36:52 +1000 (EST)
Date: Mon, 9 Oct 2006 18:36:52 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Cell timebase bug workaround
Message-Id: <20061009183652.3d4897bc.sfr@canb.auug.org.au>
In-Reply-To: <1160377517.14601.48.camel@localhost.localdomain>
References: <1160370623.14601.42.camel@localhost.localdomain>
	<20061009165629.4fa5813a.sfr@canb.auug.org.au>
	<1160377517.14601.48.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__9_Oct_2006_18_36_52_+1000_qdZwpHVa/dncvie0"
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__9_Oct_2006_18_36_52_+1000_qdZwpHVa/dncvie0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 09 Oct 2006 17:05:17 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> > Why not branch back to the mftb if the lower word is zero (this would
> > also take care of the very unlikely "hitting the bug more than once" case
> > and the "normal" case would then not have to branch at all.  (And it uses
> > one less instruction.)
>
> Because that would cause us to spinloop for the whole duration of a tb
> tick in that case, which is pretty bad when the timebase is slow (the
> slower I've seen so far is 14Mhz).

Right!  /me hits himself in the forehead :-)

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__9_Oct_2006_18_36_52_+1000_qdZwpHVa/dncvie0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFKgokFdBgD/zoJvwRAswvAJ9GCLEKbcC1XG/x6g7Q5tu17+a3UQCgisSY
7uLzGNrBUv9/GK63ptDq7LQ=
=dNv1
-----END PGP SIGNATURE-----

--Signature=_Mon__9_Oct_2006_18_36_52_+1000_qdZwpHVa/dncvie0--
