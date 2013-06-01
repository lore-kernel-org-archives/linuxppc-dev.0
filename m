Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x22a.google.com (mail-pb0-x22a.google.com
 [IPv6:2607:f8b0:400e:c01::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A8A472C009D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Jun 2013 20:59:53 +1000 (EST)
Received: by mail-pb0-f42.google.com with SMTP id uo1so3499356pbc.29
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Jun 2013 03:59:46 -0700 (PDT)
Date: Sat, 1 Jun 2013 18:59:36 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] powerpc/mpc85xx: remove the unneeded pci init
 functions for corenet ds board
Message-ID: <20130601105936.GA1850@pek-khao-d1.corp.ad.wrs.com>
References: <1369137900-5748-1-git-send-email-haokexin@gmail.com>
 <1369137900-5748-2-git-send-email-haokexin@gmail.com>
 <1369781529.18630.25@snotra>
 <20130530102034.GB18702@pek-khao-d1.corp.ad.wrs.com>
 <1369940099.14679.14@snotra>
 <20130531064102.GB16514@pek-khao-d1.corp.ad.wrs.com>
 <1369995080.3928.140.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
In-Reply-To: <1369995080.3928.140.camel@pasglop>
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2013 at 08:11:20PM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2013-05-31 at 14:41 +0800, Kevin Hao wrote:
> > Hi Ben,
> >=20
> > Could you shed some light on this issue? Do we really has the restricti=
on
> > that we have to pick one bus controller as primary even there is no
> > ISA bus on the board? I did check the current code and found no code
> > has a requirement for this. I also searched the archives and but found
> > nothing useful. :-(
>=20
> You can just pick the first one as primary... The reason we somewhat need
> a primary is related to how we handle IO space.
>=20
> We ioremap the IO space of all busses and assign the base of the primary
> one to a global "_IO_BASE". Then any "port" access is an offset from that
> which means that non-primary can end up having negative offsets. We fix
> up all resources, which works fine ... unless drivers do stupid casts
> and the wrap-around fails.
>=20
> The main reason we did that originally is because we still had a slew of
> x86 originated HW that would access hard wired IO ports, especially on th=
ings
> like CHRP machines, looking for things like 8259 PIC, legacy kbd controll=
ers,
> UARTs, etc... at fixed IO port numbers.
>=20
> We still support some of these boxes (though I do wonder how long since
> somebody last booted a Pegasos) so I'm not quite yet keen on getting rid
> of that stuff...

Thanks for the detailed explanation. But I don't mean to drop the support
of the primary bus. As you said, this is definitely needed now in order to
make some legacy device drivers work. What I want to do is not to pick a
primary bus if there is no such ISA devices at all. For example, on a fsl
p4080ds board, we would do the following in the current kernel:

	/* pick up a random host bridge as primary bus */
	for_each_matching_node(np, pci_ids) {
		...
	}

	/* for host bridge 0 */
	fsl_add_bridge(pdev, primary =3D 1) {=20
		...
		pci_process_bridge_OF_ranges(hose, dev, is_primary =3D 1);
	}

	/* for host bridge 1*/
	fsl_add_bridge(pdev, primary =3D 0) {
		...
		pci_process_bridge_OF_ranges(hose, dev, is_primary =3D 0);
	}

But there is no ISA bus on this board and we also don't need to support any
fixed IO port numbers. So it seems redundant to iterate the device list to
pick a host bridge as primary bus. So we can simply change the above to:

	/* for host bridge 0 */
	fsl_add_bridge(pdev, primary =3D 0) {
		...
		pci_process_bridge_OF_ranges(hose, dev, is_primary =3D 0);
	}

	/* for host bridge 1*/
	fsl_add_bridge(pdev, primary =3D 0) {
		...
		pci_process_bridge_OF_ranges(hose, dev, is_primary =3D 0);
	}


The effect of this change is that the isa_io_base will be 0 and the IO
resource are equal to the virtual address of the IO space. But the IO
functions such as outx/inx should work as well. This is why I ask the
above question. What do you think about this? Are there any subtle bugs
that will be triggered by this?

Thanks,
Kevin

>=20
> Cheers,
> Ben.
>=20
>=20

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJRqdQYAAoJEJNY7TDerrFxgRIH/0j6EFrUXQbmTBUPn8AHTQ9Q
B7zLeva68j2CF/savsvEQuBG2ms4uyxj/77o4ci+Wy7V2kql3S1x/5ovNOjmImh6
l2xyQxUR3u7atNxRGyM4kn0ziTur3Nhk8UsEAaxxvQPfn0TiP7xkLVeI+PqDXk1M
cqhDX0yyiusLk5ojkjyVaEoPqXBpylJi6/Zfks9V6PvQHKmmLtUPLO4En+Phh9CJ
of1HST4uBrlGyq9y1cDFuBZyifFpcxrf9XQrg5TlMF9x4i0odCudfMioOHnpdh0/
KUR9dOAeWKC/0sUhL/nhxHaff18gKX620nQUWBKx/Lne0OQgQCfkzO2TeSRyST8=
=JKck
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
