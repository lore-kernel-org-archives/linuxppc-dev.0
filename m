Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH]: PowerPC: make sure the rtas stop-self token is defined.
From: Michael Ellerman <michael@ellerman.id.au>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20061113180500.GB4307@austin.ibm.com>
References: <20061110182253.GV30625@austin.ibm.com>
	<20061110200152.GC23089@localdomain>
	<20061111010108.GX30625@austin.ibm.com>
	<1163377944.7410.12.camel@localhost.localdomain>
	<45580ED0.7000704@austin.ibm.com>
	<20061113180500.GB4307@austin.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-QEsnfq2umNAtqpyp/vmH"
Date: Tue, 14 Nov 2006 12:17:44 +1100
Message-Id: <1163467065.8048.37.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-QEsnfq2umNAtqpyp/vmH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-11-13 at 12:05 -0600, Linas Vepstas wrote:
> On Mon, Nov 13, 2006 at 12:21:04AM -0600, jschopp wrote:
> > >I can only find one caller? Is it called via a #define or something?
>=20
> Right. I was looking at pSeries_mach_cpu_die(), which is called
> as md.cpu_die from many places.
>=20
> > >Wouldn't it be preferable to just change rtas.h like so:
> > >
> > >#ifdef CONFIG_HOTPLUG_CPU
> > >extern void rtas_stop_self(void);
> > >#else
> > >static inline void rtas_stop_self(void) { }
> > >#endif
>=20
> Well, the problem is that this would just pass the BUG() to=20
> the next level, in pSeries_mach_cpu_die():
>=20
> static void pSeries_mach_cpu_die(void)
> {
>    local_irq_disable();
>    idle_task_exit();
>    xics_teardown_cpu(0);
>    rtas_stop_self();
>    /* Should never get here... */
>    BUG();
>    for(;;);
> }
>=20
> so does that mean that CONFIG_HOTPLUG_CPU should also be used to=20
> stop the complation of pSeries_mach_cpu_die() ?=20

Yes. And its connection to ppc_md.cpu_die.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-QEsnfq2umNAtqpyp/vmH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFWRk4dSjSd0sB4dIRAlF3AKC36RC0lj2yEz5xhj5PvkG3DZlXXQCgp6BG
oK4x+e31PlP3zgRbLA1XXxA=
=MiWz
-----END PGP SIGNATURE-----

--=-QEsnfq2umNAtqpyp/vmH--
