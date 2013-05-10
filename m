Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x22c.google.com (mail-pb0-x22c.google.com
 [IPv6:2607:f8b0:400e:c01::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 362C02C00C2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 May 2013 00:12:26 +1000 (EST)
Received: by mail-pb0-f44.google.com with SMTP id wz17so2824708pbc.17
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2013 07:12:23 -0700 (PDT)
Date: Fri, 10 May 2013 22:12:13 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable interrupts
Message-ID: <20130510141213.GA31597@pek-khao-d1.corp.ad.wrs.com>
References: <1368134856.654.11@snotra>
 <1368137220.3715.14.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
In-Reply-To: <1368137220.3715.14.camel@pasglop>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Caraman Mihai Claudiu-B02008 <B02008@freescale.com>,
 "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "tiejun.chen" <tiejun.chen@windriver.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2013 at 08:07:00AM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2013-05-09 at 16:27 -0500, Scott Wood wrote:
> > On 05/09/2013 07:37:42 AM, Benjamin Herrenschmidt wrote:
> > > On Thu, 2013-05-09 at 17:44 +0800, tiejun.chen wrote:
> > > >
> > > > Actually in the case GS=3D1 even if EE=3D0, EXT/DEC/DBELL still occ=
ur =20
> > > as I
> > > > recall.
> > >=20
> > > Only if directed to the hypervisor.
> >=20
> > This is always the case with KVM, right?  At least on booke...
>=20
> Hrm, on A2 we could choose iirc. Well not DEC but EXT at least, I don't
> remember about DBELL.
>=20
> > > > > Case 1)
> > > > >   -> Local_irq_disable()  will set soft_enabled =3D 0
> > > > >   -> Now Externel interrupt happens, there we set PACA_IRQ_EE in
> > > > irq_happened, Also clears EE in SRR1 and rfi. So interrupts are hard
> > > > disabled. No more other interrupt gated by MSR.EE can happen. Looks
> > > > like the idea here is to not let a device keep on inserting =20
> > > interrupt
> > > > till the interrupt condition on device is cleared, right?
> > >=20
> > > The external interrupt line is level sensitive normally, so we have to
> > > mask MSR:EE in that case or the interrupt would keep re-occurring =20
> > > (note
> > > that FSL has this concept of auto-acked interrupts via the on die MPIC
> > > for which you can potentially use PACA_IRQ_EE_EDGE instead and avoid
> > > having to mask MSR:EE).
> >=20
> > Note that if we do this, we can no longer leave the interrupt vector in=
 =20
> > EPR, and would have to track (potentially multiple different) pending =
=20
> > external interrupts in software.
>=20
> Right, you can have a little queue in the PACA and leave EE disabled if
> it's full. You can probably get away with a queue of 1 though :-)

So I would assume you will not pick up these two patches, right?
http://patchwork.ozlabs.org/patch/235530/
http://patchwork.ozlabs.org/patch/235532/

Anyway it is more easier to enable the external proxy by using this method.
But if you insist, I can respin a patch to use the method you suggested
since it will definitely reduce the window where the irq is hard disabled.

Thanks,
Kevin

>=20
> Cheers,
> Ben.
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJRjQA9AAoJEJNY7TDerrFxrTIIAJAUeWKGH5JWYhKFUrzpVD6n
FvwbXP12C83ZxhCn/dqElgNna2F4b4Qvbkzo6Fn6/nj5aqOz89wGCTTRLfXaPALR
Q703n1IzIfkB9Jlc/1UtTd3X87q0IuIUFxgc+c/o238eA5S/pEbviE0FBQtTx+LY
XoRtBxeYMjeoP5rpNUannoMBrEWMGUVaapMyBS8cJTew+xhX4AX3rGp5xg74KvGw
6Evjncx4HoDEmgng/vgP+1AICDyE33RbQCxvUa82fRmF5yuomAoBtqUXc6DJSt0r
ELOluj5Vic33WEN+oawfNYV9jJQnChT9bRtQp8nhrbeovSM01m1Xv26cYMIlP4M=
=JnmG
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
