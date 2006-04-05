Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH] powerpc: Use rtas query-cpu-stopped-state in smp
	spinup
From: Michael Ellerman <michael@ellerman.id.au>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20060404172550.GE25663@localdomain>
References: <20060404112459.C9170679EB@ozlabs.org>
	<20060404172550.GE25663@localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-xov13G4DxjsoAwQUXHLD"
Date: Wed, 05 Apr 2006 13:23:30 +0200
Message-Id: <1144236210.6788.6.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-xov13G4DxjsoAwQUXHLD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-04-04 at 12:25 -0500, Nathan Lynch wrote:
> Michael Ellerman wrote:
> > Currently we use a cpumask called of_spin_map to keep track of which th=
reads
> > have been spun up. We basically guess that OF has spun up all even numb=
ered
> > threads, and so all the odd numbered threads need to be brought up.
> >=20
> > That's a bit of a dicey assumption at best, and is totally incorrect fo=
r
> > kexec.
> >
> > Luckily we have an rtas call which can tell us whether a cpu is up
> > or not, so let's use it?
>=20
> 1. query-cpu-stopped-state isn't available on all RTAS systems (I
>    believe it's required only on systems that support cpu offline).

That should be ok, I'm pretty sure the way I've written it if
query-cpu-stopped-state isn't there we try and start it the old way
anyway.

> 2. I've tried it before.  Hope I'm remembering this correctly, but I
>    think my experience was that query-cpu-stopped-state reported
>    nonsense for cpus that were started by OF.  This was on Power5,
>    btw.

That's not what I see, perhaps I have newer firmware?

> 3. This isn't how query-cpu-stopped-state was intended to be used.
>    It's meant to be used by the OS to determine when a thread has
>    stopped itself using the stop-self method.  Which might partially
>    explain (2).

Perhaps, PAPR says: "The query-cpu-stopped-state primitive is used to
query a different processor thread to determine its status with respect
to the RTAS stopped state". I guess I assumed that a thread that's not
started would be in the "RTAS stopped state", which seems logical if not
correct.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person


--=-xov13G4DxjsoAwQUXHLD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEM6iydSjSd0sB4dIRAjqlAKCgwkZtBJ/99hrJG9kPMs5IwkFxOQCcC1r5
5moOg3B6DHAU18d+XsoTMuA=
=NV1d
-----END PGP SIGNATURE-----

--=-xov13G4DxjsoAwQUXHLD--
