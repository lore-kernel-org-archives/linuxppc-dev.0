Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3thkgT1b1RzDwGp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 13:01:57 +1100 (AEDT)
Date: Mon, 19 Dec 2016 11:03:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Thomas Huth <thuth@redhat.com>
Cc: paulus@samba.org, michael@ellerman.id.au, benh@kernel.crashing.org,
 sjitindarsingh@gmail.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH 03/11] powerpc/kvm: Gather HPT related variables into
 sub-structure
Message-ID: <20161219000304.GI12146@umbus.fritz.box>
References: <20161215055404.29351-1-david@gibson.dropbear.id.au>
 <20161215055404.29351-4-david@gibson.dropbear.id.au>
 <c797b46a-60af-b860-4bfe-3a1c1d75c974@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LYw3s/afESlflPpp"
In-Reply-To: <c797b46a-60af-b860-4bfe-3a1c1d75c974@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--LYw3s/afESlflPpp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 16, 2016 at 10:24:17AM +0100, Thomas Huth wrote:
> On 15.12.2016 06:53, David Gibson wrote:
> > Currently, the powerpc kvm_arch structure contains a number of variables
> > tracking the state of the guest's hashed page table (HPT) in KVM HV.  T=
his
> > patch gathers them all together into a single kvm_hpt_info substructure.
> > This makes life more convenient for the upcoming HPT resizing
> > implementation.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  arch/powerpc/include/asm/kvm_host.h | 16 ++++---
> >  arch/powerpc/kvm/book3s_64_mmu_hv.c | 90 ++++++++++++++++++-----------=
--------
> >  arch/powerpc/kvm/book3s_hv.c        |  2 +-
> >  arch/powerpc/kvm/book3s_hv_rm_mmu.c | 62 ++++++++++++-------------
> >  4 files changed, 87 insertions(+), 83 deletions(-)
> >=20
> > diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include=
/asm/kvm_host.h
> > index e59b172..2673271 100644
> > --- a/arch/powerpc/include/asm/kvm_host.h
> > +++ b/arch/powerpc/include/asm/kvm_host.h
> > @@ -241,12 +241,20 @@ struct kvm_arch_memory_slot {
> >  #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
> >  };
> > =20
> > +struct kvm_hpt_info {
> > +	unsigned long virt;
> > +	struct revmap_entry *rev;
> > +	unsigned long npte;
> > +	unsigned long mask;
> > +	u32 order;
> > +	int cma;
> > +};
>=20
> While you're at it, it would be really great if you could add a comment
> at the end of each line with a short description of what the variables
> are about. E.g. if I just read "virt" and do not have much clue of the
> code yet, I have a hard time to figure out what this means...

Good idea, done.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LYw3s/afESlflPpp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYVyO1AAoJEGw4ysog2bOSK6wP/23rCX8ryh5b3qZzHS8Vrn6p
nZ6O823Q6a7Fa842POa8kAECVq04zUyYwnWj5lYxoOVSawlLfkIXMOKh9dOjIJ0z
ZGtZy/Ops9j8Md++2r8uRbqpS0LCJ2YGfzW6yvVtpxYM4TeGFA7Srnvt/1NtZgvY
Hqc8PctcZAzNC/GnFo5XkW0/Iwy8A2sQflO1LXPFgUM/tNDoUROKTw9dcy+c6w/n
xusDUTXFqao+x7l1kx1dLsb/PcEIrQvMNE8j0DpLzjuWFxuJZroIJ8JgVAuQOG6w
0RR5dqR56osxaZRai75agNWtG2BK7i4MFOQrrersv/dyf6Bdfq7RS9TzmQjeOYT4
GRcFhGMfsU2exDCyjFoa9RrQ4Tf5K23s5/AxC2t+93Qd9Bt+w/lSepmQgasOSzsC
zkb3MATFNOXoSvzXkYuEuyKs+XbcigrVQItLO6cVrNyTMKG2rVQTW11VPRWF0TDB
fcWUFMSa49w3huoW/2NBD/XrCHkPRQGnG2e2vmmR3l9T/ycP3tkksEdQ+IjjU+xh
E3SIg2XvzigZeH76lebuHSVNbM73rAMdKzz0pN4lTSEyo17h48kE170UniY9moEr
MGkAkhbj5mmFcd/xAIqCJ3S6toknMI3WzF60mF1KLDZ/aRSLI9mq9zZE95i5fr9y
FqYXMfWdGR599keFWzll
=hum8
-----END PGP SIGNATURE-----

--LYw3s/afESlflPpp--
