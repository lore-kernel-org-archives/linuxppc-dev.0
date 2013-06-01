Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x235.google.com (mail-pb0-x235.google.com
 [IPv6:2607:f8b0:400e:c01::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A7BCF2C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Jun 2013 21:13:43 +1000 (EST)
Received: by mail-pb0-f53.google.com with SMTP id un4so3484852pbc.40
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Jun 2013 04:13:41 -0700 (PDT)
Date: Sat, 1 Jun 2013 19:13:30 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] powerpc/mpc85xx: remove the unneeded pci init
 functions for corenet ds board
Message-ID: <20130601111330.GB1850@pek-khao-d1.corp.ad.wrs.com>
References: <20130531064348.GC16514@pek-khao-d1.corp.ad.wrs.com>
 <1370042841.13614.19@snotra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
In-Reply-To: <1370042841.13614.19@snotra>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2013 at 06:27:21PM -0500, Scott Wood wrote:
> On 05/31/2013 01:43:49 AM, Kevin Hao wrote:
> >On Thu, May 30, 2013 at 01:54:59PM -0500, Scott Wood wrote:
> >> On 05/30/2013 05:20:34 AM, Kevin Hao wrote:
> >> >On Tue, May 28, 2013 at 05:52:09PM -0500, Scott Wood wrote:
> >> >> On 05/21/2013 07:04:58 AM, Kevin Hao wrote:
> >> >> >It also seems that we don't support ISA on all the current
> >> >corenet ds
> >> >> >boards. So picking a primary bus seems useless, remove that
> >> >function
> >> >> >too.
> >> >>
> >> >> IIRC that was due to some bugs in the PPC PCI code in the
> >absence of
> >> >> any primary bus.
> >> >
> >> >Do you know more about these bugs?
> >>
> >> Not off the top of my head -- either search the archives or ask Ben.
> >>
> >> >>  fsl_pci_assign_primary() will arbitrarily pick one
> >> >> to be primary if there's no ISA.  Have the bugs been fixed?
> >> >
> >> >I know there should be some reason that we put the
> >> >fsl_pci_assign_primary()
> >> >here. But frankly I am not sure what bugs this workaround try to
> >> >fix. For these
> >> >corenet boards picking one to be primary has no effect to the
> >> >64bit kernel.
> >> >And for 32bit kernel, the only effect of this is that isa_io_base
> >> >is set to the
> >> >io virtual base of the primary bus. But the isa_io_base only make
> >> >sense when
> >> >we do have a isa bus, so that we can access some well-known io
> >> >ports directly
> >> >by using outx/inx. But if we don't have isa bus on the board, the
> >> >value of
> >> >isa_io_base should make no sense at all. So we really don't need
> >> >to pick a
> >> >fake primary bus. Of course I may miss something, correct me if I
> >> >am wrong. :-)
> >>
> >> outx/inx can also be used for PCI I/O BARs.
> >
> >Yes, I know there is also PIO. But the value of isa_io_base doesn't
> >have any effect for this.
>=20
> See this e-mail for some of the issues I was referring to with
> isa_io_base being zero:
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2012-June/098586.html

Thanks for the reference.

>=20
> Reading it again I'm not so sure that the problem is so much that we
> need a primary, as that somewhat bad things happen on non-primary
> buses, such as the possibility of assigning a zero BAR.  Some
> hardware (including QEMU's PCI emulation) cares about this, though
> most doesn't.  We only have one PCI bus under QEMU, so when we
> started picking an arbitrary bus to be primary, the problem went
> away because there was only one bus and therefore there was no
> non-primary bus.

Sorry, I am not sure what you mean. Do you mean that it will affect
the resources assigned to a bridge when it is marked as a primary bus?
I searched the code and didn't found anything related to this? Could you
give me some hint? :-)

Thanks,
Kevin

>=20
> -Scott

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJRqddaAAoJEJNY7TDerrFxx5UH/07z9vvJDY/BhwkpMwQSWhrN
JQmR0oR1bbLTsCWFoRZwkJT0zi91abhzaiv9nYTXhTfV4Sk42bT5SrHIgpep7sLi
3JwSYE5HUWfSu6Pz517plPrIfI1D2GraDLPNMEYqozIhS3F1pStD9Ck9uzb3ecAq
sYmfJj9KC2Ka1sWkmfWOagSf54pHpmZRcNQ7jqJcat7luI8xpx79w5Q5GOVU1ina
YVJ714b/doSIq8xPY7F4slUbk4zAMsnSnkqe3aeEfIxZOVAUklwjek7QDJ8gAotC
Unjlqs4PEZxszict+mYBMz79xKAkvUNBMKJ+MUW+yuPPs8zuO6z9N1e072J0R/w=
=mvyH
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
