Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D155D1A000B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 13:13:58 +1100 (AEDT)
Date: Tue, 16 Feb 2016 13:14:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel v3 7/7] KVM: PPC: Add support for multiple-TCE
 hcalls
Message-ID: <20160216021459.GC2269@voom.redhat.com>
References: <1455501309-47200-1-git-send-email-aik@ozlabs.ru>
 <1455501309-47200-8-git-send-email-aik@ozlabs.ru>
 <20160216004058.GB2269@voom.redhat.com>
 <20160216010555.GA23111@oak.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
In-Reply-To: <20160216010555.GA23111@oak.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 16, 2016 at 12:05:56PM +1100, Paul Mackerras wrote:
> On Tue, Feb 16, 2016 at 11:40:58AM +1100, David Gibson wrote:
> > On Mon, Feb 15, 2016 at 12:55:09PM +1100, Alexey Kardashevskiy wrote:
> > > This adds real and virtual mode handlers for the H_PUT_TCE_INDIRECT a=
nd
> > > H_STUFF_TCE hypercalls for user space emulated devices such as IBMVIO
> > > devices or emulated PCI. These calls allow adding multiple entries
> > > (up to 512) into the TCE table in one call which saves time on
> > > transition between kernel and user space.
> > >=20
> > > The current implementation of kvmppc_h_stuff_tce() allows it to be
> > > executed in both real and virtual modes so there is one helper.
> > > The kvmppc_rm_h_put_tce_indirect() needs to translate the guest addre=
ss
> > > to the host address and since the translation is different, there are
> > > 2 helpers - one for each mode.
> > >=20
> > > This implements the KVM_CAP_PPC_MULTITCE capability. When present,
> > > the kernel will try handling H_PUT_TCE_INDIRECT and H_STUFF_TCE if th=
ese
> > > are enabled by the userspace via KVM_CAP_PPC_ENABLE_HCALL.
> > > If they can not be handled by the kernel, they are passed on to
> > > the user space. The user space still has to have an implementation
> > > for these.
> > >=20
> > > Both HV and PR-syle KVM are supported.
> > >=20
> > > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>=20
> [snip]
>=20
> > > +	idx =3D srcu_read_lock(&vcpu->kvm->srcu);
> > > +	if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, NULL)) {
> > > +		ret =3D H_TOO_HARD;
> > > +		goto unlock_exit;
> > > +	}
> > > +	tces =3D (u64 __user *) ua;
> > > +
> > > +	for (i =3D 0; i < npages; ++i) {
> > > +		if (get_user(tce, tces + i)) {
> > > +			ret =3D H_PARAMETER;
> >=20
> > I'm trying to work out if H_PARAMETER is really the right thing here.
> >=20
> > If the guest has actually supplied a bad address, I'd expect
> > kvmppc_gpa_to_ua() to have picked that up.  So I see two cases here:
> > 1) this shouldn't ever happen, in which case a WARN_ON() and
> > H_HARDWARE would be better or 2) this can happen because of something
> > concurrently unmapping / swapping out the userspace memory, in whih
> > case it's not the guest's fault and should probably be H_TOO_HARD.
> >=20
> > Or am I missing something?
>=20
> The only situations I can see that would cause this to fail here are
> an out-of-memory condition or userspace concurrently unmapping the
> memory.  If it's just a swapout then the get_user should bring it back
> in.

Ok.  They don't sound like the guest's fault, so I think it should be
H_TOO_HARD.

> [snip]
>=20
> > > +	rmap =3D (void *) vmalloc_to_phys(rmap);
> > > +
> > > +	/*
> > > +	 * Synchronize with the MMU notifier callbacks in
> > > +	 * book3s_64_mmu_hv.c (kvm_unmap_hva_hv etc.).
> > > +	 * While we have the rmap lock, code running on other CPUs
> > > +	 * cannot finish unmapping the host real page that backs
> > > +	 * this guest real page, so we are OK to access the host
> > > +	 * real page.
> > > +	 */
> > > +	lock_rmap(rmap);
> >=20
> > You don't appear to actually use rmap between the lock and unlock..
>=20
> No, he doesn't need to.  The effect of taking the lock is to stop the
> page getting unmapped, by stopping other code from running.  That's
> what we are trying to explain with the comment just above the
> lock_rmap call.  Is the comment not clear enough?  How would you word
> it?

The comment is fine, I just didn't read it.  Sorry.

Ok, with the H_TOO_HARD change above:

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWwoYjAAoJEGw4ysog2bOS2N8P/1j3VmkXE2Rj0ZW/z4Z92ap4
4KXQKJiFCFx0HMQMmH3KHDddMCwq7a3bOXzwWUD4Nfb4Npy2vYvhFOacDZRDxpp8
pVAg80FaTdOuzghslctxM0SlrGkKAKnaO0km3D9EAANHSEqud2t0Xgc9+vFj3i1V
JdSDbcTZNprR77lG4sZ43wxzO6hRKAG2gHKtg3X48rwwVqjPGa4Ge/W3UBpIr9k2
sYhLLGQ00nmloicNlhIXXgawZeWC7lQIBeiulM3zkVtV8llOJ8lC4srdBXVA1Ks4
/coHnlOQI/bj9J8Gy2wWLsfI2aYuQYQ+Y6Veeg2sG4fr0JAMm2IVXolBENYrskfa
mF1ei7oGD6YtioW7hDDHvhf9F2XB7b9/81bOWyzmGdqyMhoPtFM+bhM2xMNlux7k
uRnOq3/ESNnKeTTQOcxwdNKMYiWNED7wktijqhNCfXpzKfj4MtFFhI4M2IOjODMu
klFycPqXkxMKK90mhZ4csmcYuH+SilTAUtg6GCkzgLndlh3UOKTrO23RSfpYz1P7
FcZ9XUIp5ld1BKLJBHsozWpWti++Afgee96HSL1Sq8x8vshBTy/IdSEUeieU5VS0
+RuU5EiIhKKZIAhdkv/do0OjRn87739KmjcPKCrEYUfKQpQlEpEl2HTi0cRBf+X9
Z4e3Z7So3IPRhOnVAI+0
=Yv9L
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--
