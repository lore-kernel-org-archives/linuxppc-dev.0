Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: disable MSI using new interface if possible
From: Michael Ellerman <michael@ellerman.id.au>
To: Nishanth Aravamudan <nacc@us.ibm.com>
In-Reply-To: <1299202862-10682-1-git-send-email-nacc@us.ibm.com>
References: <1299200729.3630.52.camel@concordia>
	<1299202862-10682-1-git-send-email-nacc@us.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-bdZ15BohIXn1/oAixbK1"
Date: Fri, 04 Mar 2011 14:01:24 +1100
Message-ID: <1299207684.3630.76.camel@concordia>
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, miltonm@bga.com
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-bdZ15BohIXn1/oAixbK1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-03-03 at 17:41 -0800, Nishanth Aravamudan wrote:
> On 04.03.2011 [12:05:29 +1100], Michael Ellerman wrote:
> > On Thu, 2011-03-03 at 11:39 -0800, Nishanth Aravamudan wrote:
> > > On upcoming hardware, we have a PCI adapter with two functions, one o=
f
> > > which uses MSI and the other uses MSI-X. This adapter, when MSI is
> > > disabled using the "old" firmware interface (RTAS_CHANGE_FN), still
> > > signals an MSI-X interrupt and triggers an EEH. We are working with t=
he
> > > vendor to ensure that the hardware is not at fault, but if we use the
> > > "new" interface (RTAS_CHANGE_MSI_FN) to disable MSI, we also
> > > automatically disable MSI-X and the adapter does not appear to signal
> > > any stray MSI-X interrupt.
> >=20
> > It seems this could also be a firmware bug, have we heard anything from
> > them? PAPR explicitly says that RTAS_CHANGE_FN (function=3D1) should
> > disable MSI _and_ MSI-X (R1???7.3.10.5.1???1).
>=20
> We're tracking that down too. I think the fact that the interrupt is
> coming in is a hardware bug in this particular adapter.
>=20
> I'm looking at PAPR again and I see what might be a contradiction:
>=20
> 7.3.10.5.1: "To removing all MSIs, set the Requested Number of
> Interrupts to zero."
>=20
> Table 71: "Function ... 1: Request to set to a new number of MSI or
> MSI-X (platform choice) interrupts (including set to 0)"
>=20
> It seems like the Table claims that using RTAS_CHANGE_FN with 0, could
> change only MSI or MSI-X and still be not a bug?

Yeah I guess you could read it that way, though I think that would be a
bug.

The idea is that it chooses for you whether it uses MSI or MSI-X. So the
only sane semantic is that when deconfiguring it deconfigures either,
ie. both, kinds.

Looking closer at your patch, now I don't understand :)

+       /*
+        * disabling MSI with the explicit interface also disables MSI-X
+        */
+       if (rtas_change_msi(pdn, RTAS_CHANGE_MSI_FN, 0) !=3D 0) {


So we first disable using function 3, which should:

        3: Request to set to a new number of MSI interrupts (including set =
to 0)

Which does not mention MSI-X at all, implying it has no effect on them.
Which contradicts what you see, and the comment in the code?

So I think I'm not sure what's going on here :)

cheers

--=-bdZ15BohIXn1/oAixbK1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk1wVgQACgkQdSjSd0sB4dI29ACeOKzLlqjlZC23kcy4WI+rE+AE
ZvoAn2OU1Cgm2GSYPV4mwC7DFwgk3UVO
=W5Bt
-----END PGP SIGNATURE-----

--=-bdZ15BohIXn1/oAixbK1--
