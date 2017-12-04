Return-Path: <spopovyc@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yr70R1zCFzDqkJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Dec 2017 01:43:19 +1100 (AEDT)
Subject: Re: [PATCH 0/4] Fix use after free in HPT resizing code and related
 minor improvements
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linux-kernel@vger.kernel.org, michael@ellerman.id.au, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
References: <1511973506-65683-1-git-send-email-spopovyc@redhat.com>
 <20171204061025.GQ2130@umbus.fritz.box>
From: Serhii Popovych <spopovyc@redhat.com>
Message-ID: <dececaf0-3a41-9342-f244-4c1305f70e61@redhat.com>
Date: Mon, 4 Dec 2017 16:43:01 +0200
MIME-Version: 1.0
In-Reply-To: <20171204061025.GQ2130@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="IBQBKV9ECxlM94Ux51vFdtmdAxbNlxIGd"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IBQBKV9ECxlM94Ux51vFdtmdAxbNlxIGd
Content-Type: multipart/mixed; boundary="NNuEQoKljIAcsQ3ofCpciqBOmoTuLd35a";
 protected-headers="v1"
From: Serhii Popovych <spopovyc@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linux-kernel@vger.kernel.org, michael@ellerman.id.au, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Message-ID: <dececaf0-3a41-9342-f244-4c1305f70e61@redhat.com>
Subject: Re: [PATCH 0/4] Fix use after free in HPT resizing code and related
 minor improvements
References: <1511973506-65683-1-git-send-email-spopovyc@redhat.com>
 <20171204061025.GQ2130@umbus.fritz.box>
In-Reply-To: <20171204061025.GQ2130@umbus.fritz.box>

--NNuEQoKljIAcsQ3ofCpciqBOmoTuLd35a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

David Gibson wrote:
> On Wed, Nov 29, 2017 at 11:38:22AM -0500, Serhii Popovych wrote:
>> It is possible to trigger use after free during HPT resize
>> causing host kernel to crash. More details and analysis of
>> the problem can be found in change with corresponding subject
>> (KVM: PPC: Book3S HV: Fix use after free in case of multiple
>> resize requests).
>>
>> We need some changes to prepare for the fix, especially
>> make ->error in HPT resize instance single point for
>> tracking allocation state, improve kvmppc_allocate_hpt()
>> and kvmppc_free_hpt() so they can be used more safely.
>>
>> See individual commit description message to get more
>> information on changes presented.
>=20
> I spoke with Paul Mackerras about these patches on IRC today.  We want
> this as a fix, ASAP, in 4.15.  However, he's uncomfortable with
> pushing some of extra cleanups which aren't necessary for the bug fix
> this late for 4.15, and was having trouble following what was the core
> of the fix.  He was also nervous about the addition of more BUG_ON()s.

Good, no problem, cleanups will be pushed additionally.

>=20
> To avoid the round trip to Ukraine time and back, I've made revised
> versions of patches 1 & 3 which should apply standalone, replaced the
> BUG_ON()s with WARN_ON()s and revised the commit messages to better
> explain the crucial part of the fix.
>=20
> However, I've run out of time to test them.

I did the same test as for this v1 series and found no problem with v2
you sent to me: it seems patch improving kvmppc_allocate_hpt() and
kvmppc_free_hpt() isn't actually necessary as I was thinking when
submitting v1.

>=20
> Serhii,  I'll send you my revised patches shortly.  Can you please
> test them and repost.  Then you can rebase patches 2 & 4 from this
> series on top of the revised patches and post those separately (as a
> cleanup with less urgency than the actual fix).

Tested with same test case as with v1: no problem so far.

>=20
> A couple of people have also suggested CCing kvm@vger.kernel.org on
> the next round in addition to the lists already included.
>=20

Done.

--=20
Thanks,
Serhii


--NNuEQoKljIAcsQ3ofCpciqBOmoTuLd35a--

--IBQBKV9ECxlM94Ux51vFdtmdAxbNlxIGd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJaJV8AAAoJEBTawMmQ61bBa2EH/ioiJXKYSoxZozSBnZJKPKFh
WU+cPgD0RgdDrrxMrxY0YarcqsKh6q7nPVKWf0w88gWxFQDTksSjlzVfcMV2TAT4
6y1aUxshO6rjmGaBWJmlF34G0lGPnpbCZRiWjpnKZNj1H2xgAS9+6c1I+7HhgPaV
ZhIqRDKAQctOwp0wWA4BjBzcVmP4F5ggAN7pIMSGao+o1uZGFq9Q1d+KjUJSC+uC
erXSsN+Fs2pIKuN65Tbl6l4p9Sp6jYyEYrirSA6ArB+4T0wnARoQpLKsxPa07fWS
Nc0Iv76aL35eIbdvQOuRm1apIZ/Zm2qOAb9oqYNqwCLwJZPLH6oZhLkp9CgtdOY=
=q5Bs
-----END PGP SIGNATURE-----

--IBQBKV9ECxlM94Ux51vFdtmdAxbNlxIGd--
