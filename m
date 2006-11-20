Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Reorganise and then fixup the pseries cpu hotplug code
From: Michael Ellerman <michael@ellerman.id.au>
To: jschopp <jschopp@austin.ibm.com>
In-Reply-To: <45612D68.8080404@austin.ibm.com>
References: <20061116154051.GB2008@localdomain>
	<20061117033638.0E24B67BCE@ozlabs.org>
	<20061117180456.GG23600@austin.ibm.com>
	<1163984914.7832.16.camel@localhost.localdomain>
	<45612D68.8080404@austin.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-WKoeIF9knjOLdn8+5KJx"
Date: Mon, 20 Nov 2006 16:59:15 +1100
Message-Id: <1164002356.13318.4.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: srinivasa@in.ibm.com, ego@in.ibm.com, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Anton Blanchard <anton@samba.org>, ntl@pobox.com
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-WKoeIF9knjOLdn8+5KJx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-11-19 at 22:22 -0600, jschopp wrote:
> >>> +	/* Isolation and deallocation are definatly done by
> >>                                         ^^^^^^^^^
> >> typo
>=20
> That word definitely gives me trouble.  I'd imagine the typo originated w=
ith me.

Yeah it's definitely a tricky one ;)

> >>
> >>> +	 * drslot_chrp_cpu.  If they were not they would be
> >>> +	 * done here.  Change isolate state to Isolate and
> >>> +	 * change allocation-state to Unusable.
> >>> +	 */
> >>> +	paca[cpu].cpu_start =3D 0;
> >> I can't figure out what the comment means with respect=20
> >> to this code ...=20
> >=20
> > Me either. It's unchanged from the original merge of cpu hotplug:
> > http://kernel.org/git/?p=3Dlinux/kernel/git/torvalds/old-2.6-bkcvs.git;=
a=3Dcommit;h=3D24c13f21f0a6abe07020a959990da2b134e6734f
> > http://kernel.org/git/?p=3Dlinux/kernel/git/torvalds/old-2.6-bkcvs.git;=
a=3Dblobdiff;h=3D72144b6122f9336e7fa242e50b65b099df0cd72b;hp=3Df671515c0676=
e61064ae414273fa4546d0c04938;hb=3D24c13f21f0a6abe07020a959990da2b134e6734f;=
f=3Darch/ppc64/kernel/smp.c
> >=20
> > Which carries the name of one Joel Schopp :)
> >=20
> > Grepping the tree at that point finds no other mention of
> > drslot_chrp_cpu, so I think it's a stale comment - we should probably
> > just rip it out - Joel?
>=20
> It might be clearer by saying "the userspace program drslot_chrp_cpu" or =
"isolation and=20
> deallocation occur in userspace, so just stop the cpu.  If isolation and =
deallocation ever=20
> move from userpace to kernel space they would go here".  On pseries dynam=
ic partitioning=20
> or cpu guard (the things that initiate a cpu hotplug) all call a userspac=
e program drmgr,=20
> which calls drslot_chrp_cpu, which then talks to the firmware to isolate =
and unallocate=20
> (on remove, the opposite on add) after it has hotplug removed the cpu via=
 the /sys=20
> interface.  This allows the cpu to be reassigned to another partition.
>=20
> At least that's what I remember from back then when we did it.  Though I =
don't think it's=20
> changed any.  Feel free to make the comment more intelligible.

OK, it didn't occur to me that it was referring to userspace. I'll
change it to:

/*
 * Isolation and deallocation occur in userspace, so just stop the cpu.
 * If isolation and deallocation ever move from userpace to kernel space
 * we would do them here.
 */

Sound OK?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-WKoeIF9knjOLdn8+5KJx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFYUQydSjSd0sB4dIRArovAJ9yNzBo6FNbdNsxfBh6SxFL260nBgCcCtad
SexREwSBVXLJhgADL6M9hpA=
=KyhT
-----END PGP SIGNATURE-----

--=-WKoeIF9knjOLdn8+5KJx--
