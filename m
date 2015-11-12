Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6EF331A0228
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2015 14:38:56 +1100 (AEDT)
Date: Thu, 12 Nov 2015 14:38:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Axtens <dja@axtens.net>
Cc: Aravinda Prasad <aravinda@linux.vnet.ibm.com>, paulus@ozlabs.org,
 linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org,
 mahesh@linux.vnet.ibm.com, agraf@suse.de, michaele@au1.ibm.com,
 kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Exit guest upon fatal machine check exception
Message-ID: <20151112033816.GJ5852@voom.redhat.com>
References: <20151111165845.3721.98296.stgit@aravindap>
 <876118ymy4.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="NgG1H2o5aFKkgPy/"
In-Reply-To: <876118ymy4.fsf@gamma.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--NgG1H2o5aFKkgPy/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2015 at 01:24:19PM +1100, Daniel Axtens wrote:
> Aravinda Prasad <aravinda@linux.vnet.ibm.com> writes:
>=20
> > This patch modifies KVM to cause a guest exit with
> > KVM_EXIT_NMI instead of immediately delivering a 0x200
> > interrupt to guest upon machine check exception in
> > guest address. Exiting the guest enables QEMU to build
> > error log and deliver machine check exception to guest
> > OS (either via guest OS registered machine check
> > handler or via 0x200 guest OS interrupt vector).
> >
> > This approach simplifies the delivering of machine
> > check exception to guest OS compared to the earlier approach
> > of KVM directly invoking 0x200 guest interrupt vector.
> > In the earlier approach QEMU patched the 0x200 interrupt
> > vector during boot. The patched code at 0x200 issued a
> > private hcall to pass the control to QEMU to build the
> > error log.
> >
> > This design/approach is based on the feedback for the
> > QEMU patches to handle machine check exception. Details
> > of earlier approach of handling machine check exception
> > in QEMU and related discussions can be found at:
> >
> > https://lists.nongnu.org/archive/html/qemu-devel/2014-11/msg00813.html
>=20
> I've poked at the MCE code, but not the KVM MCE code, so I may be
> mistaken here, but I'm not clear on how this handles errors that the
> guest can recover without terminating.
>=20
> For example, a Linux guest can handle a UE in guest userspace by killing
> the guest process. A hypthetical non-linux guest with a microkernel
> could even survive UEs in drivers.
>=20
> It sounds from your patch like you're changing this behaviour. Is this
> right?

So, IIUC.  Once the qemu pieces are in place as well it shouldn't
change this behaviour: KVM will exit to qemu, qemu will log the error
information (new), then reinject the MC to the guest which can still
handle it as you describe above.

But, there could be a problem if you have a new kernel with an old
qemu, in that case qemu might not understand the new exit type and
treat it as a fatal error, even though the guest could actually cope
with it.

Aravinda, do we need to change this so that qemu has to explicitly
enable the new NMI behaviour?  Or have I missed something that will
make that case work already.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NgG1H2o5aFKkgPy/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWRAmoAAoJEGw4ysog2bOSh5MP/1KX/mFZ3R0r4OiP/A9IU7rJ
AAyge4kOd1Ec/Tg5nfCi7DhaWuPWucwpvSIrFKAKO5gwE3mryfs5syXGrwSXI61o
kiD0RMu/roXE5sp5yXVyGvJDCW7riof1VpgTsYOLnexD+J9hdq35QeY63Ux06OFI
uDHjfHJfODvHSP0dD3/Rbo2cQqRUO0zppwBKRax6Vwr/Tg1s2Ns+NiTFwio3AHgO
o4lsgUhEczHxwAmrDldVMj1dj6cBOZEYd6jwpybNQ4CexetIRMTRlUGT/vDv8/4E
hfM/R1p5zu+3MFGC/9V9aluB/Do2WsK9UELBBfjDrtFoWSx61hjiJi7Z7qaNxeAo
e74NR8+A9DDL9atFu7rVsPaiKtf6qQ5w2my4Ct9kZ1QX7vF7UCuvuP2N5CJrBxj7
OrGjlqXDJhpGaXvSIWFCUnBab54zg2J8IxpJUXfBLwF0FRLrs1FZumz6xbmbsoHC
+pfSZ5wK2Zdrn1WZ9I4Wnn6hma0xR2IQQCC8JyxUAE6yR4TOeXx/NA2w1dAkLnzX
Q6d1L3gZpEDtqy43Y+lLj1ZQI8c1fdhoifX5pIdB6Oa5P/cXfcBsagWG3wcYQMuU
OlZLt6dEMruRL4Is8O6omHGTqpv3qG442VzffVR5ETa9sof7Bifod497ioDwxewo
GXvNyELGAu1f82JJ8XbT
=nEB/
-----END PGP SIGNATURE-----

--NgG1H2o5aFKkgPy/--
