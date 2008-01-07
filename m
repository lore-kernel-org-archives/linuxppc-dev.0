Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH][POWERPC] Workaround for iommu page alignment
From: Michael Ellerman <michael@ellerman.id.au>
To: benh@kernel.crashing.org
In-Reply-To: <1199742359.6734.14.camel@pasglop>
References: <1199742359.6734.14.camel@pasglop>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ITFpJa84ub5aFfuVMFsS"
Date: Tue, 08 Jan 2008 09:41:24 +1100
Message-Id: <1199745684.7518.25.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ITFpJa84ub5aFfuVMFsS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-01-08 at 08:45 +1100, Benjamin Herrenschmidt wrote:
> Our iommu page size is currently always 4K. That means with our current
> code, drivers may do a dma_map_sg() of a 64K page and obtain a dma_addr_t
> that is only 4K aligned.
>=20
> This works fine in most cases except some infiniband HW it seems, where
> they tell the HW about the page size and it ignores the low bits of the
> DMA address.
>=20
> This works around it by making our IOMMU code enforce a PAGE_SIZE alignme=
nt
> for mappings of objects that are page aligned in the first place and whos=
e
> size is larger or equal to a page.
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I don't see in the code where you implement the "size > PAGE_SIZE"
condition. But I only just got back from holidays .. :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-ITFpJa84ub5aFfuVMFsS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHgqqUdSjSd0sB4dIRAuhvAJ903bMtQUJj3SOO7DKRXS/NFgAibACgv/Ny
C1LFcnkZdXOEK7jpQFj/ox0=
=OZcY
-----END PGP SIGNATURE-----

--=-ITFpJa84ub5aFfuVMFsS--
