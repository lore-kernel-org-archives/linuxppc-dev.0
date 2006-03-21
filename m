Return-Path: <michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Make BUG_ON & WARN_ON play nice with
	compile-time optimisations
Date: Tue, 21 Mar 2006 14:45:23 +1100
References: <20060207052220.917C668A92@ozlabs.org>
In-Reply-To: <20060207052220.917C668A92@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2345622.nkMyxvdSxf";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200603211445.32454.michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart2345622.nkMyxvdSxf
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tue, 7 Feb 2006 16:22, Michael Ellerman wrote:
> Currently if you do BUG_ON(0) you'll still get a trap instruction in your
> object, although it'll never trigger. That's ok, but a bit ugly, it'd be
> nice if the compiler could completely eliminate any trace of the BUG_ON.
>
> So update the BUG_ON & WARN_ON macros to make this possible. From the
> comment in the patch:
>
>  The if statement in BUG_ON and WARN_ON gives the compiler a chance to do
>  compile-time optimisation and possibly elide the entire block. The check
>  for !__builtin_constant(x) has the oppposite effect, if we must do the
>  test at runtime then we avoid a spurious compare and branch by ensuring
>  the if condition is always true.
>
> I've confirmed it works in both cases, if the condition is false at compi=
le
> time we get no code emitted for the BUG statement. If the condition needs
> to be evaluated at runtime we get the same code we used to, ie. only one
> test in the trap instruction.

Turns out this doesn't always do what we want, depending on what the condit=
ion=20
for the BUG_ON() is. Specifically the __builtin_constant_p() sometimes fail=
s=20
to recognise that the condition will be constant, and so we end up with:

 558:   38 00 00 00     li      r0,0
 55c:   0b 00 00 00     tdnei   r0,0

Which is harmless but not really good enough. When gcc gets fixed=20
(http://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D26724) we can think about th=
is=20
again.

cheers

=2D-=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--nextPart2345622.nkMyxvdSxf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEH3bcdSjSd0sB4dIRAl/+AJ9LyjH6MAvl0az9+bTw5LZ9hl9DeACdHplg
kHTx0n9Feyn510kxuIAAMs4=
=r9Fl
-----END PGP SIGNATURE-----

--nextPart2345622.nkMyxvdSxf--
