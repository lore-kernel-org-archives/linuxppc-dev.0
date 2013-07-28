Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x22e.google.com (mail-pb0-x22e.google.com
 [IPv6:2607:f8b0:400e:c01::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B6A762C0118
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Jul 2013 10:32:33 +1000 (EST)
Received: by mail-pb0-f46.google.com with SMTP id rq8so3346173pbb.19
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jul 2013 17:32:30 -0700 (PDT)
Date: Sun, 28 Jul 2013 08:32:21 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] powerpc/mpc85xx: remove the unneeded pci init
 functions for corenet ds board
Message-ID: <20130728003221.GA7396@pek-khao-d1.corp.ad.wrs.com>
References: <20130607020020.GA4678@pek-khao-d1.corp.ad.wrs.com>
 <1374618676.15592.40@snotra>
 <20130725125453.GK5084@pek-khao-d1.corp.ad.wrs.com>
 <1374878624.30721.33@snotra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
In-Reply-To: <1374878624.30721.33@snotra>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2013 at 05:43:44PM -0500, Scott Wood wrote:
> On 07/25/2013 07:54:53 AM, Kevin Hao wrote:
> >The reason is that the ppc kernel assume that the BARs starting
> >at 0 is unset and will reassign it later. There is a bug in the
> >previous
> >kernel, so the kernel maybe not work well for qemu in this case. But I
> >think this has been fixed by the commit c5df457f (powerpc/pci:
> >Check the
> >bus address instead of resource address in pcibios_fixup_resources).
>=20
> What ensures that the reassignment will not assign zero?

In function pcibios_resource_survey() we will reserve the low IO area
before reassignment. Please see the following comments and codes in this
function.

        /* Before we start assigning unassigned resource, we try to reserve
         * the low IO area and the VGA memory area if they intersect the
         * bus available resources to avoid allocating things on top of them
         */
        if (!pci_has_flag(PCI_PROBE_ONLY)) {
                list_for_each_entry(b, &pci_root_buses, node)
                        pcibios_reserve_legacy_regions(b);
        }   =20


Thanks,
Kevin

>=20
> I'm not doubting the result that it does, but I'm having a hard time
> seeing it in the code.
>=20
> Or are you saying that the resource assignment code will run twice,
> rather than just saying that we won't trust the firmware when we
> find zero?
>=20
> -Scott

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJR9GaVAAoJEJNY7TDerrFxy1IH/3Ny/9GqzkQJwCO2f3ismXcm
X2cZO8igD2CQPXAw/fdbccnzA78hP3HWkRKM5xV9LNlSDFO6j7td1Ui8osFni5BZ
NmY3HVwWvYF0pOzcbTNqcVuaMilUfHJqCXtZ6GHNRDJaYrw0dn+pz8zPUwaigtqt
kAOBOJdenj5vnHIiH4glFS/wXU0M88GTuH3CbDXhUyvi5Tr9tE8Zb9Qpjfj/ytPy
pPteilNJcPt2LyBdoAKD7yrJZNYG6pspDxSp5FTCLCvjqN2fEVCBGbtBspBYlu0M
kW02UwDu1Bh4EntngMRaYy8RVOLAj9HUowgKtedtApHZX4KOxtQyiXXLtplM2Tc=
=Qhy6
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
