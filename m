Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
From: Michael Ellerman <michael@ellerman.id.au>
To: Darren Hart <dvhltc@us.ibm.com>
In-Reply-To: <4C7CAB72.2050305@us.ibm.com>
References: <4C488CCD.60004@us.ibm.com> <20100819155824.GD2690@in.ibm.com>
	<4C7CAB72.2050305@us.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-uwfii3Rd4vP3Pc4mFkwt"
Date: Wed, 01 Sep 2010 15:54:41 +1000
Message-ID: <1283320481.32679.32.camel@concordia>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Gautham R Shenoy <ego@in.ibm.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Will Schmidt <willschm@us.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Ankita Garg <ankita@in.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-uwfii3Rd4vP3Pc4mFkwt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-08-31 at 00:12 -0700, Darren Hart wrote:
..
>=20
> When running with the function plugin I had to stop the trace
> immediately before entering start_secondary after an online or my traces
> would not include the pseries_mach_cpu_die function, nor the tracing I
> added there (possibly buffer size, I am using 2048). The following trace
> was collected using "trace-cmd record -p function -e irq -e sched" and
> has been filtered to only show CPU [001] (the CPU undergoing the
> offline/online test, and the one seeing preempt_count (pcnt) go to
> ffffffff after cede. The function tracer does not indicate anything
> running on the CPU other than the HCALL - unless the __trace_hcall*
> commands might be to blame.=20

It's not impossible. Though normally they're disabled right, so the only
reason they're running is because you're tracing. So if they are causing
the bug then that doesn't explain why you see it normally.

Still, might be worth disabling just the hcall tracepoints just to be
100% sure.

cheers


--=-uwfii3Rd4vP3Pc4mFkwt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkx96p4ACgkQdSjSd0sB4dLbOgCgjDMLTrQFvWzT7FpTwfng5lnh
osIAniT3idLuu4O9gh0dtThRZGHICjIr
=FKzd
-----END PGP SIGNATURE-----

--=-uwfii3Rd4vP3Pc4mFkwt--
