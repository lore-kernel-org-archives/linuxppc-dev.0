Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/8] pseries: phyp dump: Docmentation
From: Michael Ellerman <michael@ellerman.id.au>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20080109184437.GU14201@localdomain>
References: <4782B985.2090508@austin.ibm.com>
	<4782C026.8080302@austin.ibm.com> <20080109042911.GT14201@localdomain>
	<3ae3aa420801090731r2e25e42awcae385b448e20b16@mail.gmail.com>
	<20080109184437.GU14201@localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-KipCUMcU5KFyaBlelLd8"
Date: Thu, 10 Jan 2008 09:59:05 +1100
Message-Id: <1199919545.7880.11.camel@concordia>
Mime-Version: 1.0
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org,
	Linas Vepstas <linasvepstas@gmail.com>, lkessler@us.ibm.com,
	strosake@us.ibm.com
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-KipCUMcU5KFyaBlelLd8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-01-09 at 12:44 -0600, Nathan Lynch wrote:
> Hi Linas,
>=20
> Linas Vepstas wrote:
> >=20
> > On 08/01/2008, Nathan Lynch <ntl@pobox.com> wrote:
> > > Manish Ahuja wrote:
> > > > +
> > > > +The goal of hypervisor-assisted dump is to enable the dump of
> > > > +a crashed system, and to do so from a fully-reset system, and
> > > > +to minimize the total elapsed time until the system is back
> > > > +in production use.
> > >
> > > Is it actually faster than kdump?
> >=20
> > This is a basic presumption;
>=20
> > As a side effect, the system is in
> > production *while* the dump is being taken;

It's in "production" with 256MB of RAM? Err. Sure as the dump progresses
more RAM will be freed, but that's hardly production. I think Nathan's
right, any sysadmin who wants predictability will probably double reboot
anyway.

> > with kdump,
> > you can't go into production until after the dump is finished,
> > and the system has been rebooted a second time.  On
> > systems with terabytes of RAM, the time difference can be
> > hours.

> Since you bring up large systems... a system with terabytes of RAM is
> practically guaranteed to be a NUMA configuration with dozens of cpus.
> When processing a dump on such a system, I wonder how well we fare:
> can we successfully boot with (say) 128 cpus and 256MB of usable
> memory?  Do we have to hot-online nodes as system memory is freed up
> (and does that even work)?  We need to be able to restore the system
> to its optimal topology when the dump is finished; if the best we can
> do is a degraded configuration, the workload will suffer and the
> system admin is likely to just reboot the machine again so the kernel
> will have the right NUMA topology.

Yeah that's a good question. Even if the hot-onlining works, there's
still kernel data structures allocated at boot which want to be
node-local. So the end result will be !=3D a "production" boot.

> > > > +Implementation details:
> > > > +----------------------
> > > > +In order for this scheme to work, memory needs to be reserved
> > > > +quite early in the boot cycle. However, access to the device
> > > > +tree this early in the boot cycle is difficult, and device-tree
> > > > +access is needed to determine if there is a crash data waiting.
> > >
> > > I don't think this bit about early device tree access is correct.  By
> > > the time your code is reserving memory (from early_init_devtree(), I
> > > think), RTAS has been instantiated and you are able to test for the
> > > existence of /rtas/ibm,dump-kernel.
> >=20
> > If I remember right, it was still too early to look up this token direc=
tly,
> > so we wrote some code to crawl the flat device tree to find it.  But
> > not only was that a lot of work, but I somehow decided that doing this
> > to the flat tree was wrong, as otherwise someone would surely have
> > written the access code.  If this can be made to work, that would be
> > great, but we couldn't make it work at the time.
> >=20
> > > > +To work around this problem, all but 256MB of RAM is reserved
> > > > +during early boot. A short while later in boot, a check is made
> > > > +to determine if there is dump data waiting. If there isn't,
> > > > +then the reserved memory is released to general kernel use.
> > >
> > > So I think these gymnastics are unneeded -- unless I'm
> > > misunderstanding something, you should be able to determine very earl=
y
> > > whether to reserve that memory.
> >=20
> > Only if you can get at rtas, but you can't get at rtas at that point.

AFAICT you don't need to get at RTAS, you just need to look at the
device tree to see if the property is present, and that is trivial.

You probably just need to add a check in early_init_dt_scan_rtas() which
sets a flag for the PHYP dump stuff, or add your own scan routine if you
need.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-KipCUMcU5KFyaBlelLd8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHhVG5dSjSd0sB4dIRAkl7AKDN8gQM5TVpsWEX+4c9OVDVHah4JwCePN42
Z46NbyD2B8yMJeJOZhB5QiU=
=LSAD
-----END PGP SIGNATURE-----

--=-KipCUMcU5KFyaBlelLd8--
