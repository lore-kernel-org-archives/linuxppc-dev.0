Return-Path: <dgibson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DBCD21A0C1B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 12:32:20 +1100 (AEDT)
Date: Thu, 5 Nov 2015 12:32:43 +1100
From: David Gibson <dgibson@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, thuth@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: on crash, kexec'ed kernel needs all CPUs are
 online
Message-ID: <20151105123243.47dda843@voom.fritz.box>
In-Reply-To: <563A0E2B.4090404@redhat.com>
References: <1444935658-27319-1-git-send-email-lvivier@redhat.com>
 <5639FB4A.7020508@linux.vnet.ibm.com> <563A0E2B.4090404@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=4D6S1VH0bpPJrsE85/Ep4z"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/=4D6S1VH0bpPJrsE85/Ep4z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Nov 2015 14:54:51 +0100
Laurent Vivier <lvivier@redhat.com> wrote:

>=20
>=20
> On 04/11/2015 13:34, Hari Bathini wrote:
> > On 10/16/2015 12:30 AM, Laurent Vivier wrote:
> >> On kexec, all secondary offline CPUs are onlined before
> >> starting the new kernel, this is not done in the case of kdump.
> >>
> >> If kdump is configured and a kernel crash occurs whereas
> >> some secondaries CPUs are offline (SMT=3Doff),
> >> the new kernel is not able to start them and displays some
> >> "Processor X is stuck.".
> >>
> >> Starting with POWER8, subcore logic relies on all threads of
> >> core being booted. So, on startup kernel tries to start all
> >> threads, and asks OPAL (or RTAS) to start all CPUs (including
> >> threads). If a CPU has been offlined by the previous kernel,
> >> it has not been returned to OPAL, and thus OPAL cannot restart
> >> it: this CPU has been lost...
> >>
> >> Signed-off-by: Laurent Vivier<lvivier@redhat.com>
> >=20
> >=20
> > Hi Laurent,
>=20
> Hi Hari,
>=20
> > Sorry for jumping too late into this.
>=20
> better late than never :)
>=20
> > Are you seeing this issue even with the below patches:
> >=20
> > pseries:
> > http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dc1caae3de46a072d0855729aed6e793e536a4a55

Unfortunately, this is unlikely to be relevant - this fixes a failure
while setting up the kexec.  The problem we see occurs once we've
booted the second kernel and it's attempting to bring up secondary CPUs.

> > opal/powernv:
> > https://github.com/open-power/skiboot/commit/9ee56b5
>=20
> Very interesting. Is there a way to have a firmware with the fix ?

=46rom Laurent's analysis of the crash, I don't think this will be
relevant either, but I'm not sure.  It would be very interesting to
know which (if any) released firmwares include this patch so we can
test it.

--=20
David Gibson <dgibson@redhat.com>
Senior Software Engineer, Virtualization, Red Hat

--Sig_/=4D6S1VH0bpPJrsE85/Ep4z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWOrG7AAoJEGw4ysog2bOSs34P/iAUweczZ2c4gjv/FHo3ySwU
+gEQKEYFKHPD3elPxIBVZ+I5kARpnzWyNHk59yBasnfiQFeX8AK0ZCoVcTKNSCWQ
MeG/lDWuzx2/PXfMcWlyLeJbwxEKT6SQE1vgvbG9nmg9BIqKXllCGhUq+6g6T7C8
puOuUFlGNJXNU3gTrLS5TAHjDr0GL0hDP5AEqsG70V+zphU2MH17e15p7Fve/tW+
lyNkZxaAnHyrdXd5aXf+vta68AQAX7D117jlhcJr62WqSvSB+o5GTW/yx1vD9K8w
PyFlWDn3z7JdPr1VOvjEDVm2mbUTnBF7RjoslsncNwV6IoJRkjU/U+ffVF/TcRgR
2fu6Qc9jcBIkI0fwq/t0Z1UJ8f+VAzkkl0MOSzP1qKtyC5krQRAeYYxLcy188BJD
4LM5PANsfAdzSIkfk3oIDNVTXdXJIq272ylMf6D6LxCf2/rrM7CAlddcvO/eGYr1
Whu65LELteHbOjeIWqV4byf8fWzkEh4xPSklhdaSdii6zJy89/OTIf3LkFqpJ6sM
iJ+FM21nYdTshzq0S0gjXd6rwlQHPLxXhJ0W+MladCXfxBDwpB50k5dHE5lAjVlr
liknmLIJ3hiaN0gYiT/4/jcDCFOfXg+yp1Hx0w9Q3+XA6M0FEwEPepTxUWiXiKDB
Lyu4ysPPYgddDMT7ckGK
=qeDS
-----END PGP SIGNATURE-----

--Sig_/=4D6S1VH0bpPJrsE85/Ep4z--
