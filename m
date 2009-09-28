Return-Path: <michael@ellerman.id.au>
Subject: Re: 64bit kernel is huge
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1254125220.8421.21.camel@pasglop>
References: <20090928074503.GB16073@kryten> <1254125220.8421.21.camel@pasglop>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-5oBbbYaePvaaHvxXoDyW"
Date: Mon, 28 Sep 2009 19:13:28 +1000
Message-Id: <1254129208.5959.7.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-5oBbbYaePvaaHvxXoDyW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-09-28 at 18:07 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2009-09-28 at 17:45 +1000, Anton Blanchard wrote:
> > Hi,
> >=20
> > I've found at least one machine that wont boot 2.6.31-rc* with a=20
> > pseries_defconfig. If I move real-base from 0xc00000 to 0xd00000 it
> > boots fine.
> >=20
> > # size vmlinux
> >    text	   data	    bss	    dec	    hex	filename
> > 9812942	1982496	1105228	12900666	 c4d93a	vmlinux
> >=20
> > Looks like we blow right through the 12MB mark. It desperately needs to=
 eat
> > less and lose weight.

> > 262144  kstat_irqs_all
> > 131072  irq_desc
> > 16384   irq_stat
> >=20
> > Could we dynamically allocate our irq structures?
>=20
> We still want one big array, unless we go to sparse IRQ numbering like
> x86 but we'd have to also adapt the remapping stuff. Definitely to put
> on a list somewhere for people who want to pick up something to do :-)

Actually I've already been looking at it. The easy step is to enable
SPARSE_IRQ, the harder step is to get rid of our irq_map. But that's not
that big.

I'll try and get them polished for the next merge window.

> It's hard to properly dynamically size it. I'd rather have a "capacity"
> of _lots_ and sparsely populate the array (a tree ?) because we never
> know with MSIs etc... how many we'll really need.
>=20
> At the -very-least- we could make NR_IRQS a CONFIG option.

Yeah I have a patch for that too, I'll post it. It's no good for distros
but for custom kernels it could be quite handy, small partitions with
virtual most things don't really need many interrupts.

cheers

--=-5oBbbYaePvaaHvxXoDyW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkrAfjQACgkQdSjSd0sB4dLZbQCgp5lNdjfBuAjaqjxWZ2v7B4bo
exIAoJSmjJnz9ixXWDh50SgvJ+MS4URd
=RSQ+
-----END PGP SIGNATURE-----

--=-5oBbbYaePvaaHvxXoDyW--
