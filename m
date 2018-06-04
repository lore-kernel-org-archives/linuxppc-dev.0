Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zq3S2v6ZzF10j
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2018 19:13:08 +1000 (AEST)
Date: Mon, 4 Jun 2018 18:57:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
 elfring@users.sourceforge.net, jasowang@redhat.com,
 mpe@ellerman.id.au, hch@infradead.org
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
Message-ID: <20180604085742.GQ4251@umbus>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <f77638ddef3af52dd71341083707c9e3745dd505.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QVgWX4+QEldMe/r9"
In-Reply-To: <f77638ddef3af52dd71341083707c9e3745dd505.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--QVgWX4+QEldMe/r9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 24, 2018 at 08:27:04AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2018-05-23 at 21:50 +0300, Michael S. Tsirkin wrote:
>=20
> > I re-read that discussion and I'm still unclear on the
> > original question, since I got several apparently
> > conflicting answers.
> >=20
> > I asked:
> >=20
> > 	Why isn't setting VIRTIO_F_IOMMU_PLATFORM on the
> > 	hypervisor side sufficient?
>=20
> I thought I had replied to this...
>=20
> There are a couple of reasons:
>=20
> - First qemu doesn't know that the guest will switch to "secure mode"
> in advance. There is no difference between a normal and a secure
> partition until the partition does the magic UV call to "enter secure
> mode" and qemu doesn't see any of it. So who can set the flag here ?

This seems weird to me.  As a rule HV calls should go through qemu -
or be allowed to go directly to KVM *by* qemu.  We generally reserve
the latter for hot path things.  Since this isn't a hot path, having
the call handled directly by the kernel seems wrong.

Unless a "UV call" is something different I don't know about.

> - Second, when using VIRTIO_F_IOMMU_PLATFORM, we also make qemu (or
> vhost) go through the emulated MMIO for every access to the guest,
> which adds additional overhead.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QVgWX4+QEldMe/r9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsU/wQACgkQbDjKyiDZ
s5KTZBAA2JRvAwRshKqCoS6sEhIMO2dPsjGf3qAlcnFwyw24Lt3UoLHqz5UQNTNk
ki41d+YG7H1hYA2S1DdBvieX87/e/jCI+tXrAl2kM1BFfctUhYBFwvc/WYUPniOD
TIlnSL07++YeIpkTvluzT2J2/nTLcrxwRKaD5D0QQlL1MyjNENZlkKqHdH/sG9vk
nTXiTmxBKOzU+1mJQo8LjMJcEhXCZxoAMw2yTZtOQkMfsxk4VOnr7clR4qe3v/4c
USnb8wCxHhXxQw0NjHM5FiwD5dt1yNGQsAhwFccHOYKvViatHcu93d563g6RID0B
hXzE5iKBvwz+XoFEredm4Sz+twRxGN6CA2jqRRZ8jSSSKfBenu5sB7o0MHJEAwY4
qeUcH5GO/71x8CnHCB98nE7LBDLHdueyHE8qtqhzkMQ6Bg5nF9ipPviMnfr7f1TZ
Kfuv4p9lRY70dq+dJkeBLpTsO03h55zonZq3LhDKPB+HKX7tmFAyAnEPqCZYTxSW
ujWGp6ThNs5RcKQJSLLr1zBVksW/UekrkCWbAOuj8xV1XFFOciPVFKEFmggo09G+
36DINiPFQMfjIVkYtX8SGuHwEsdR+ae4QDlZAtgdgpeXjTKvRMYVID1Ee+5nXL5j
wxAjS2/owJThiSvPpmMQq0dcbTfliEX/J/L5vBnRqg3dnRXJW/c=
=z0UZ
-----END PGP SIGNATURE-----

--QVgWX4+QEldMe/r9--
