Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A2F91A0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 11:40:17 +1000 (AEST)
Date: Tue, 2 Jun 2015 10:24:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v11 28/34] vfio: powerpc/spapr:
 powerpc/powernv/ioda: Define and implement DMA windows API
Message-ID: <20150602002403.GA3186@voom.fritz.box>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-29-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
In-Reply-To: <1432889098-22924-29-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 06:44:52PM +1000, Alexey Kardashevskiy wrote:
> This extends iommu_table_group_ops by a set of callbacks to support
> dynamic DMA windows management.
>=20
> create_table() creates a TCE table with specific parameters.
> it receives iommu_table_group to know nodeid in order to allocate
> TCE table memory closer to the PHB. The exact format of allocated
> multi-level table might be also specific to the PHB model (not
> the case now though).
> This callback calculated the DMA window offset on a PCI bus from @num
> and stores it in a just created table.
>=20
> set_window() sets the window at specified TVT index + @num on PHB.
>=20
> unset_window() unsets the window from specified TVT.
>=20
> This adds a free() callback to iommu_table_ops to free the memory
> (potentially a tree of tables) allocated for the TCE table.
>=20
> create_table() and free() are supposed to be called once per
> VFIO container and set_window()/unset_window() are supposed to be
> called for every group in a container.
>=20
> This adds IOMMU capabilities to iommu_table_group such as default
> 32bit window parameters and others. This makes use of new values in
> vfio_iommu_spapr_tce. IODA1/P5IOC2 do not support DDW so they do not
> advertise pagemasks to the userspace.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Acked-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbPejAAoJEGw4ysog2bOStc4QAJZMf5p0TQVV4f58ymM8lWje
/bdmel4NutnO7KUXhf5l2sikc0lCQN7Qi23tSKlWLwCYmnTk4SPhiOvn3x+M71cs
msEZg92HLyJxXQu3mCOJY5PzMse/2Vfz/iNwJHe3M8+C5ILVaNbtJ5oFiVozTT1U
MV7VxtEGBxoZg5wA+9fQMYbNN6UyXtnZT3R3G9bSOUtEFIB0EV12XFTELdRmqk7O
3QvJBtzjN7ZEeqok8xDiKr5flEkZBgH/pr6/hpEiLZtQGYUo9lqfeSCNdPTCLvly
9/T8VluDpTawcqCAFurtHfNULgEUjSM6bII1OlLcMmDWBDwJeDFzovAVeg9aMdnK
rEh/nRdAo8az+0p6qYbmddyNutXOje5IAkkmlLIlnRnJRlniEav25jk+oWhDR6F/
RaXk28y/BCkfiZcLotkIwvl/2wjXeWdF9w1LNeqGA+PtQ80kA9r6N5mOyZr6W8je
1ZR+dAzyguLsHbAgfUEQqte7/iGVHgeMiG1Ga9YrILv6r0yvl5IrP1atWvP8hm5w
1eMz1RYxLEWWJYO25w81ryxlRnISM0mFpaK+ZEUhQWxwQq7Ao/NJg06lgYsPfxED
kkxG6f+zUTDjvy9aqUq+5O2mcucGP1reJ8UY7dkO4/PYht941ZEtTLTgPsvN3nry
KLNnKk2Fh/iwjHtYkkt1
=OQwy
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
