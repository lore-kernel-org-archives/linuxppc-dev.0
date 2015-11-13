Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B5AF1A08F6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2015 15:04:09 +1100 (AEDT)
Date: Fri, 13 Nov 2015 12:50:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: Daniel Axtens <dja@axtens.net>, kvm@vger.kernel.org,
 michaele@au1.ibm.com, mahesh@linux.vnet.ibm.com, agraf@suse.de,
 kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] KVM: PPC: Exit guest upon fatal machine check exception
Message-ID: <20151113015015.GI4886@voom.redhat.com>
References: <20151111165845.3721.98296.stgit@aravindap>
 <876118ymy4.fsf@gamma.ozlabs.ibm.com>
 <20151112033816.GJ5852@voom.redhat.com>
 <5644164A.40706@linux.vnet.ibm.com>
 <20151112044316.GA4886@voom.redhat.com>
 <5644D1DD.1020201@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="VaKJWhUROU/xPxjb"
In-Reply-To: <5644D1DD.1020201@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--VaKJWhUROU/xPxjb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2015 at 11:22:29PM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Thursday 12 November 2015 10:13 AM, David Gibson wrote:
> > On Thu, Nov 12, 2015 at 10:02:10AM +0530, Aravinda Prasad wrote:
> >>
> >>
> >> On Thursday 12 November 2015 09:08 AM, David Gibson wrote:
> >>> On Thu, Nov 12, 2015 at 01:24:19PM +1100, Daniel Axtens wrote:
> >>>> Aravinda Prasad <aravinda@linux.vnet.ibm.com> writes:
> >>>>
> >>>>> This patch modifies KVM to cause a guest exit with
> >>>>> KVM_EXIT_NMI instead of immediately delivering a 0x200
> >>>>> interrupt to guest upon machine check exception in
> >>>>> guest address. Exiting the guest enables QEMU to build
> >>>>> error log and deliver machine check exception to guest
> >>>>> OS (either via guest OS registered machine check
> >>>>> handler or via 0x200 guest OS interrupt vector).
> >>>>>
> >>>>> This approach simplifies the delivering of machine
> >>>>> check exception to guest OS compared to the earlier approach
> >>>>> of KVM directly invoking 0x200 guest interrupt vector.
> >>>>> In the earlier approach QEMU patched the 0x200 interrupt
> >>>>> vector during boot. The patched code at 0x200 issued a
> >>>>> private hcall to pass the control to QEMU to build the
> >>>>> error log.
> >>>>>
> >>>>> This design/approach is based on the feedback for the
> >>>>> QEMU patches to handle machine check exception. Details
> >>>>> of earlier approach of handling machine check exception
> >>>>> in QEMU and related discussions can be found at:
> >>>>>
> >>>>> https://lists.nongnu.org/archive/html/qemu-devel/2014-11/msg00813.h=
tml
> >>>>
> >>>> I've poked at the MCE code, but not the KVM MCE code, so I may be
> >>>> mistaken here, but I'm not clear on how this handles errors that the
> >>>> guest can recover without terminating.
> >>>>
> >>>> For example, a Linux guest can handle a UE in guest userspace by kil=
ling
> >>>> the guest process. A hypthetical non-linux guest with a microkernel
> >>>> could even survive UEs in drivers.
> >>>>
> >>>> It sounds from your patch like you're changing this behaviour. Is th=
is
> >>>> right?
> >>>
> >>> So, IIUC.  Once the qemu pieces are in place as well it shouldn't
> >>> change this behaviour: KVM will exit to qemu, qemu will log the error
> >>> information (new), then reinject the MC to the guest which can still
> >>> handle it as you describe above.
> >>
> >> Yes. With KVM and QEMU both in place this will not change the behavior.
> >> QEMU will inject the UE to guest and the guest handles the UE based on
> >> where it occurred. For example if an UE happens in a guest process
> >> address space, that process will be killed.
> >>
> >>>
> >>> But, there could be a problem if you have a new kernel with an old
> >>> qemu, in that case qemu might not understand the new exit type and
> >>> treat it as a fatal error, even though the guest could actually cope
> >>> with it.
> >>
> >> In case of new kernel and old QEMU, the guest terminates as old QEMU
> >> does not understand the NMI exit reason. However, this is the case with
> >> old kernel and old QEMU as they do not handle UE belonging to guest. T=
he
> >> difference is that the guest kernel terminates with different error
> >> code.
> >=20
> > Ok.. assuming the guest has code to handle the UE in 0x200, why would
> > the guest terminate with old kernel and old qemu?  I haven't quite
> > followed the logic.
>=20
> I overlooked it. I think I need to take into consideration whether guest
> issued "ibm, nmi-register". If the guest has issued "ibm, nmi-register"
> then we should not jump to 0x200 upon UE. With the old kernel and old
> QEMU this is broken as we always jump to 0x200.
>=20
> However, if the guest has not issued "ibm, nmi-register" then upon UE we
> should jump to 0x200. If new kernel is used with old QEMU this
> functionality breaks as it causes guest to terminate with unhandled NMI
> exit.
>=20
> So thinking whether qemu should explicitly enable the new NMI
> behavior.

So, I think the reasoning above tends towards having qemu control the
MC behaviour.  If qemu does nothing, MCs are delivered direct to
0x200, if it enables the new handling, they cause a KVM exit and qemu
will deliver the MC.

Then I'd expect qemu to switch on the new-style handling from
ibm,nmi-register.

>=20
> Regards,
> Aravinda
>=20
> >=20
> >>
> >> old kernel and old QEMU -> guest panics [1] irrespective of where UE
> >>                            happened in guest address space.
> >> old kernel and new QEMU -> guest panics. same as above.
> >> new kernel and old QEMU -> guest terminates with unhanded NMI error
> >>                            irrespective of where UE happened in guest
> >> new kernel and new QEMU -> guest handles UEs in process address space
> >>                            by killing the process. guest terminates
> >>                            for UEs in guest kernel address space.
> >>
> >> [1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-June/118329.h=
tml
> >>
> >>>
> >>> Aravinda, do we need to change this so that qemu has to explicitly
> >>> enable the new NMI behaviour?  Or have I missed something that will
> >>> make that case work already.
> >>
> >> I think we don't need to explicitly enable the new behavior. With new
> >> kernel and new QEMU this should just work. As mentioned above this is
> >> already broken for old kernel/QEMU. Any thoughts?
> >>
> >> Regards,
> >> Aravinda
> >>
> >>>
> >>>
> >>>
> >>> _______________________________________________
> >>> Linuxppc-dev mailing list
> >>> Linuxppc-dev@lists.ozlabs.org
> >>> https://lists.ozlabs.org/listinfo/linuxppc-dev
> >>>
> >>
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VaKJWhUROU/xPxjb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWRUHWAAoJEGw4ysog2bOSasgQAOMmKw++8UZZsCBT3NA912Qv
HbM1qez6fcyG+6DUtuucSG+pMUOddtXkQdSoKXLIuw8008ewoL1J+5vomaDwffTG
Ua+ZemrQfGEECi7uzsRxSPOL+CtgqpogAMij+x4qmW0jDvZkA0zV88H1CmYN5nmI
JjY4RsblHacAD4yaKswC4v43AE7xRuUjpgOaQtlibB57GQVfrX7AwxQ6gVABfFwO
NirE2z9ymt8Vh4h6B5IyYZPPcJguqD1fO4jY1Vz/h3IRKMq9vAWFZLY/1p2tFFUP
ZXUC5JJchXjnCT5oxj3Tx4KcPEJYQGZmh3vi+mxgezMI0ML3B65t74YUgPtAy7hs
mS0n7CkRGkVqdKbeTkqoaIH49zL8otr0Le69qtEcI3KhyMPqijH9aX2oEtomnJJC
TTnyJBnnH7ZIv2did+33E+9uVIXq/sJquU+sSDsr1ggpd4fk2i6K9iLS1hAMlXOy
HU9nkU1qjZX+JK5g/Mv6vp5B7cic+ViKgyB1BUIrZxfqu1KK3BzimgEkmGfmMtuT
hoc8v2hAB5jwb70LUrhVpsSh5xhWSLx3eZNXRFdHFMHTaxqKowVNF6uFkf/OJ1Xs
XEM/OPh9X/qYSlJ0hAWVLMbgqsfOkS9sYXqc/ZB6SWWyWZhy2yAE0qvPjNVTSEUl
+cCUPvVrvSXU/qiY4NVN
=bSM/
-----END PGP SIGNATURE-----

--VaKJWhUROU/xPxjb--
