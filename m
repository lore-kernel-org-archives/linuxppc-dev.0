Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BDABD1A0337
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2015 15:42:44 +1100 (AEDT)
Date: Thu, 12 Nov 2015 15:43:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: Daniel Axtens <dja@axtens.net>, kvm@vger.kernel.org,
 michaele@au1.ibm.com, mahesh@linux.vnet.ibm.com, agraf@suse.de,
 kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] KVM: PPC: Exit guest upon fatal machine check exception
Message-ID: <20151112044316.GA4886@voom.redhat.com>
References: <20151111165845.3721.98296.stgit@aravindap>
 <876118ymy4.fsf@gamma.ozlabs.ibm.com>
 <20151112033816.GJ5852@voom.redhat.com>
 <5644164A.40706@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
In-Reply-To: <5644164A.40706@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2015 at 10:02:10AM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Thursday 12 November 2015 09:08 AM, David Gibson wrote:
> > On Thu, Nov 12, 2015 at 01:24:19PM +1100, Daniel Axtens wrote:
> >> Aravinda Prasad <aravinda@linux.vnet.ibm.com> writes:
> >>
> >>> This patch modifies KVM to cause a guest exit with
> >>> KVM_EXIT_NMI instead of immediately delivering a 0x200
> >>> interrupt to guest upon machine check exception in
> >>> guest address. Exiting the guest enables QEMU to build
> >>> error log and deliver machine check exception to guest
> >>> OS (either via guest OS registered machine check
> >>> handler or via 0x200 guest OS interrupt vector).
> >>>
> >>> This approach simplifies the delivering of machine
> >>> check exception to guest OS compared to the earlier approach
> >>> of KVM directly invoking 0x200 guest interrupt vector.
> >>> In the earlier approach QEMU patched the 0x200 interrupt
> >>> vector during boot. The patched code at 0x200 issued a
> >>> private hcall to pass the control to QEMU to build the
> >>> error log.
> >>>
> >>> This design/approach is based on the feedback for the
> >>> QEMU patches to handle machine check exception. Details
> >>> of earlier approach of handling machine check exception
> >>> in QEMU and related discussions can be found at:
> >>>
> >>> https://lists.nongnu.org/archive/html/qemu-devel/2014-11/msg00813.html
> >>
> >> I've poked at the MCE code, but not the KVM MCE code, so I may be
> >> mistaken here, but I'm not clear on how this handles errors that the
> >> guest can recover without terminating.
> >>
> >> For example, a Linux guest can handle a UE in guest userspace by killi=
ng
> >> the guest process. A hypthetical non-linux guest with a microkernel
> >> could even survive UEs in drivers.
> >>
> >> It sounds from your patch like you're changing this behaviour. Is this
> >> right?
> >=20
> > So, IIUC.  Once the qemu pieces are in place as well it shouldn't
> > change this behaviour: KVM will exit to qemu, qemu will log the error
> > information (new), then reinject the MC to the guest which can still
> > handle it as you describe above.
>=20
> Yes. With KVM and QEMU both in place this will not change the behavior.
> QEMU will inject the UE to guest and the guest handles the UE based on
> where it occurred. For example if an UE happens in a guest process
> address space, that process will be killed.
>=20
> >=20
> > But, there could be a problem if you have a new kernel with an old
> > qemu, in that case qemu might not understand the new exit type and
> > treat it as a fatal error, even though the guest could actually cope
> > with it.
>=20
> In case of new kernel and old QEMU, the guest terminates as old QEMU
> does not understand the NMI exit reason. However, this is the case with
> old kernel and old QEMU as they do not handle UE belonging to guest. The
> difference is that the guest kernel terminates with different error
> code.

Ok.. assuming the guest has code to handle the UE in 0x200, why would
the guest terminate with old kernel and old qemu?  I haven't quite
followed the logic.

>=20
> old kernel and old QEMU -> guest panics [1] irrespective of where UE
>                            happened in guest address space.
> old kernel and new QEMU -> guest panics. same as above.
> new kernel and old QEMU -> guest terminates with unhanded NMI error
>                            irrespective of where UE happened in guest
> new kernel and new QEMU -> guest handles UEs in process address space
>                            by killing the process. guest terminates
>                            for UEs in guest kernel address space.
>=20
> [1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-June/118329.html
>=20
> >=20
> > Aravinda, do we need to change this so that qemu has to explicitly
> > enable the new NMI behaviour?  Or have I missed something that will
> > make that case work already.
>=20
> I think we don't need to explicitly enable the new behavior. With new
> kernel and new QEMU this should just work. As mentioned above this is
> already broken for old kernel/QEMU. Any thoughts?
>=20
> Regards,
> Aravinda
>=20
> >=20
> >=20
> >=20
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWRBjkAAoJEGw4ysog2bOSbNAP/A5ls49fZBzLfoht/2iMRT6c
LR0k205oMgtDDAHYmSI/hQuoxJ0Fzo6xmCerp9IJzrxZYTxE5H142igEO5zH0LXU
vFnAcgNEBFN12pjSowOu8KVq+aBn93Ejsk+z/1LPmibxh/ppVsWvStsuhRX41pUZ
M78VL+JijoGCmF9Vm5iMl8LumwYoBk3okUtz2IRFWbbiV0736NM0WzMs1ddt0F4b
Ck8H3txxFI7LWee7FUvy0hQhQeZq1kHFwc0SAWcVyQ7KPAeeWOkFUApaGEAVClkU
S/5uHnmfkQQX1uuhN/qsMNyYvyHEi4q9hSTeOGJ2VNAsGdROY/Jhfe9qXR9bVqhT
nNbiyHP3fW+vht8ZbXC0Saa0J9BGGmrPII1al9jFmaNCm3WBp7vNn6gtSsVNdHIO
fBAQg4GDHL3nrV3Gbjbk7szyZSpIkdL1VA90tSgvLhndLSlaYTOke+Q1bKGfXgCM
33K0c4poSI+s9DplnkuM3Yad4ajXPgLv2nveegtirhjsioaLQQucrhPNl0h2/2Bq
BJe7qXIogsIQ9xkCKng/TBIvpy7dFbyWjiPixNFo5aWlpPh4sljQQnzu+7z9eDJ7
nUfgwNInGG7px1VGjMQWc9zphGcgwe7WIo1mrvlSjvPajMtN6RbCox2gu8pU3f7r
NCUg83M9YDmLon05f3IK
=FsoF
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
