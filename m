Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Silence timebase sync code
From: Michael Ellerman <michael@ellerman.id.au>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <Pine.LNX.4.64.0811171421090.11673@t2.domain.actdsltmp>
References: <1226959111-11221-1-git-send-email-tpiepho@freescale.com>
	<49889E01-9433-41BE-A6F1-66127856D482@kernel.crashing.org>
	<Pine.LNX.4.64.0811171421090.11673@t2.domain.actdsltmp>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-wLIBcTf49bjRzraCBDu3"
Date: Tue, 18 Nov 2008 10:28:21 +1100
Message-Id: <1226964501.8537.3.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-wLIBcTf49bjRzraCBDu3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-11-17 at 14:22 -0800, Trent Piepho wrote:
> On Mon, 17 Nov 2008, Kumar Gala wrote:
> > On Nov 17, 2008, at 3:58 PM, Trent Piepho wrote:
> >
> >> It's over a dozen lines of output and doesn't appear to provide any us=
eful
> >> information.  Even after looking at the code, I'm in the dark about wh=
at
> >> "score 299, offset 250" means.
> >>=20
> >> Signed-off-by: Trent Piepho <tpiepho@freescale.com>
> >> ---
> >> arch/powerpc/kernel/smp-tbsync.c |   12 ++++--------
> >> 1 files changed, 4 insertions(+), 8 deletions(-)
> >>=20
> >> diff --git a/arch/powerpc/kernel/smp-tbsync.c=20
> >> b/arch/powerpc/kernel/smp-tbsync.c
> >> index bc892e6..b590135 100644
> >> --- a/arch/powerpc/kernel/smp-tbsync.c
> >> +++ b/arch/powerpc/kernel/smp-tbsync.c
> >> @@ -113,7 +113,7 @@ void __devinit smp_generic_give_timebase(void)
> >> {
> >>  int i, score, score2, old, min=3D0, max=3D5000, offset=3D1000;
> >>=20
> >> -	printk("Synchronizing timebase\n");
> >> +	pr_info("Synchronizing timebase\n");
> >
> > I think its useful to leave this as a printk.
>=20
> #define pr_info(fmt, arg...) \
>          printk(KERN_INFO fmt, ##arg)
>=20
> Isn't printk with no level tag the same as KERN_INFO?

Stuff like this should IMHO be printk(KERN_DEBUG ..)

That way it will show up in the log as long as you boot with 'debug' on
your command line, it doesn't require a kernel recompile to turn on. And
at the same time it doesn't spam the boot log for a normal boot.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-wLIBcTf49bjRzraCBDu3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkh/hUACgkQdSjSd0sB4dLRxgCffr9tFyH1+FwOr5JE8hFqoa+s
TgoAn059UtTgrm9WsskYOzfLal/1hLPN
=AB3V
-----END PGP SIGNATURE-----

--=-wLIBcTf49bjRzraCBDu3--
