Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ynNzV1ZzvzDr8n
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 15:03:02 +1100 (AEDT)
Date: Thu, 30 Nov 2017 14:54:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Serhii Popovych <spopovyc@redhat.com>
Cc: linux-kernel@vger.kernel.org, michael@ellerman.id.au, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix use after free in HPT resizing code and related
 minor improvements
Message-ID: <20171130035446.GS3023@umbus.fritz.box>
References: <1511973506-65683-1-git-send-email-spopovyc@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="z4IKABJTiQIqPwmW"
In-Reply-To: <1511973506-65683-1-git-send-email-spopovyc@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--z4IKABJTiQIqPwmW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 11:38:22AM -0500, Serhii Popovych wrote:
> It is possible to trigger use after free during HPT resize
> causing host kernel to crash. More details and analysis of
> the problem can be found in change with corresponding subject
> (KVM: PPC: Book3S HV: Fix use after free in case of multiple
> resize requests).
>=20
> We need some changes to prepare for the fix, especially
> make ->error in HPT resize instance single point for
> tracking allocation state, improve kvmppc_allocate_hpt()
> and kvmppc_free_hpt() so they can be used more safely.
>=20
> See individual commit description message to get more
> information on changes presented.
>=20
> Serhii Popovych (4):
>   KVM: PPC: Book3S HV: Drop prepare_done from struct kvm_resize_hpt and
>     cleanups
>   KVM: PPC: Book3S HV: Improve kvmppc_allocate_hpt()/kvmppc_free_hpt()
>   KVM: PPC: Book3S HV: Fix use after free in case of multiple resize
>     requests
>   KVM: PPC: Book3S HV: Remove redundant parameter from
>     resize_hpt_release()
>=20
>  arch/powerpc/kvm/book3s_64_mmu_hv.c | 139 +++++++++++++++++++++---------=
------
>  1 file changed, 82 insertions(+), 57 deletions(-)

Paul, these (at least 1-3) fix (another :() host crash bug which can
be triggered by guest and/or userspace actions.  Please merge ASAP.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--z4IKABJTiQIqPwmW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlofgQYACgkQbDjKyiDZ
s5JM9A/+MgJQALlYbgxZOkf5cgI34EpyZjerm1fKBUfx6ldByDXcPcpph8Z9Xeaz
p/B+gq7jF5Tt4C0TK+JP8kurg8Pd5I7a7NUCXqARwNxfWlaqQlPRWa+9GKrYpQPE
TEI61Xba3htQJFA27ZcMp++gXdmHO5C8quE+rz2PCZf/tvf3WFlb+H21ClpSnANG
ZqHYgM/PrsT5QgM/hlBxwTvAV4HUffn4myUFDndpQQpfNRDEWBdUPVdSc011ASfz
WaDG1cGTT6OXwdYHRM8h0v38uBKf6PFrVk/ACQlpCeLdsOrG/b4BIzsSvZfLEWW7
m13Zj0WQCgtOH4CD4uzZV4oRDprADOp0xa9vq4NjFpzXzBcP0BvQfa2zySawcV5Z
7l9HpMDTp8zxZ0JFWh+Nx31lMpqxRGs5irrWZ/iPZP7SMVpNbEbGJuMfmfqjExtN
cEoE3uiSBylwrPeOF9jxb/MKrRfk6f5QE4KuwD1YTCelis49XE/xMC7Lj7tRKa05
JcNhL6OwJ7ZMYBjnlQlt+58CbUVlVzmY/LiptHIPyYWLhkpx+oEWl+0779QTBKDT
qrqNNllgAN+kj7olVlUfxhRB7DAreEQ+tCV3faQUV4fJqeqSGlggbQdlX5nneVVF
KAbxwQBnd64JN3inxctRBUUBjH6Bx/SOGWu22YpGmfkdShklqwE=
=0aV8
-----END PGP SIGNATURE-----

--z4IKABJTiQIqPwmW--
