Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41f2ls229MzF12X
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 11:58:16 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6U1sNbF073221
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jul 2018 21:58:14 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kh5krtprp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jul 2018 21:58:14 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Mon, 30 Jul 2018 02:58:11 +0100
Date: Mon, 30 Jul 2018 11:58:05 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, bryantly@linux.vnet.ibm.com
Subject: Re: [PATCH v2 1/1] powerpc/pseries: fix EEH recovery of some IOV
 devices
References: <7598ffeb48c16c88a34937ad93b18f806222b8df.1527208281.git.sbobroff@linux.ibm.com>
 <87in5ymp03.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
In-Reply-To: <87in5ymp03.fsf@concordia.ellerman.id.au>
Message-Id: <20180730015804.GA10188@tungsten.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 10:59:24AM +1000, Michael Ellerman wrote:
> Sam Bobroff <sbobroff@linux.ibm.com> writes:
>=20
> > EEH recovery currently fails on pSeries for some IOV capable PCI
> > devices, if CONFIG_PCI_IOV is on and the hypervisor doesn't provide
> > certain device tree properties for the device. (Found on an IOV
> > capable device using the ipr driver.)
> >
> > Recovery fails in pci_enable_resources() at the check on r->parent,
> > because r->flags is set and r->parent is not.  This state is due to
> > sriov_init() setting the start, end and flags members of the IOV BARs
> > but the parent not being set later in
> > pseries_pci_fixup_iov_resources(), because the
> > "ibm,open-sriov-vf-bar-info" property is missing.
> >
> > Correct this by zeroing the resource flags for IOV BARs when they
> > can't be configured.
> >
> > Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> > ---
> > Hi,
> >
> > This is a fix to allow EEH recovery to succeed in a specific situation,
> > which I've tried to explain in the commit message.
> >
> > As with the RFC version, the IOV BARs are disabled by setting the resou=
rce
> > flags to 0 but the other fields are now left as-is because that is what=
 is done
> > elsewhere (see sriov_init() and __pci_read_base()).
> >
> > I've also examined the concern raised by Bjorn Helgaas, that VFs could =
be
> > enabled later after the BARs are disabled, and it already seems safe: e=
nabling
> > VFs (on pseries) depends on another device tree property,
> > "ibm,number-of-configurable-vfs" as well as support for the RTAS functi=
on
> > "ibm_map_pes". Since these are all part of the hypervisor's support for=
 IOV it
> > seems unlikely that we would ever see some of them but not all. (None a=
re
> > currently provided by QEMU/KVM.) (Additionally, the ipr driver on which=
 the EEH
> > recovery failure was discovered doesn't even seem to have SR-IOV suppor=
t so it
> > certainly can't enable VFs.)
>=20
> Can you fold/reword the above into the change log, it seems like useful
> detail.
>=20
> cheers

Sure, sounds good.


--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAltecKUACgkQMX8w6AQl
/iIuEAgAldcMH4SfqHL3E1/Vi5kTRRzLaFgr29LFeG8oPOQNWkTq2CvbcmzUTZgx
xvHjxxZCBfus+s4SFCnvQsScFq5bve37XZj+NZr7X01DzkdBxG4VelCTUWAwHqJw
hJtbM5iVSsYHCVOwcqF7RBn/Bxbah9PgHoXla67RZMq06vn1jZl8qeM29MephsqG
+nQF26sxZ4Uh4Y6f39jWqUO0VntlNZtkbA7mRz0fc9Yc2lzAvDirMZEdtB+UEmdB
iCGYTNR1+kkHiyML4XZYi6nIZ/WMTmDTl1cw3UzseRAUS4WczhDhsowzTBn6FCTs
/1Ib5HTsw57/MbrT/tTcyQVhfi6GZw==
=qHtA
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
