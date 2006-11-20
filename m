Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Reorganise and then fixup the pseries cpu hotplug code
From: Michael Ellerman <michael@ellerman.id.au>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20061117180456.GG23600@austin.ibm.com>
References: <20061116154051.GB2008@localdomain>
	<20061117033638.0E24B67BCE@ozlabs.org>
	<20061117180456.GG23600@austin.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Mrx1lE//08W3exJM6AzD"
Date: Mon, 20 Nov 2006 12:08:34 +1100
Message-Id: <1163984914.7832.16.camel@localhost.localdomain>
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


--=-Mrx1lE//08W3exJM6AzD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-11-17 at 12:04 -0600, Linas Vepstas wrote:
> On Fri, Nov 17, 2006 at 02:36:35PM +1100, Michael Ellerman wrote:
> > The pseries cpu hotplug code is currently spread between ./kernel/rtas.=
c,
> > ./platforms/pseries/smp.c and ./platforms/pseries/setup.c. Some of it i=
s
> > not #ifdef CONFIG_HOTPLUG_CPU, but it should be.
> >=20
> > So move all the cpu hotplug code into platforms/pseries/hotplug-cpu.c
>=20
> Yes, much cleaner this way.

I agree :)

> > +	/* Isolation and deallocation are definatly done by
>                                         ^^^^^^^^^
> typo
>=20
> > +	 * drslot_chrp_cpu.  If they were not they would be
> > +	 * done here.  Change isolate state to Isolate and
> > +	 * change allocation-state to Unusable.
> > +	 */
> > +	paca[cpu].cpu_start =3D 0;
>=20
> I can't figure out what the comment means with respect=20
> to this code ...=20

Me either. It's unchanged from the original merge of cpu hotplug:
http://kernel.org/git/?p=3Dlinux/kernel/git/torvalds/old-2.6-bkcvs.git;a=3D=
commit;h=3D24c13f21f0a6abe07020a959990da2b134e6734f
http://kernel.org/git/?p=3Dlinux/kernel/git/torvalds/old-2.6-bkcvs.git;a=3D=
blobdiff;h=3D72144b6122f9336e7fa242e50b65b099df0cd72b;hp=3Df671515c0676e610=
64ae414273fa4546d0c04938;hb=3D24c13f21f0a6abe07020a959990da2b134e6734f;f=3D=
arch/ppc64/kernel/smp.c

Which carries the name of one Joel Schopp :)

Grepping the tree at that point finds no other mention of
drslot_chrp_cpu, so I think it's a stale comment - we should probably
just rip it out - Joel?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Mrx1lE//08W3exJM6AzD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFYQASdSjSd0sB4dIRAs2uAKCR1QENxOm1rZbbFWpIbs+n7FG/JQCfTQcU
9y/WWcNvzKJqfxFnrSSpDlU=
=SeT1
-----END PGP SIGNATURE-----

--=-Mrx1lE//08W3exJM6AzD--
