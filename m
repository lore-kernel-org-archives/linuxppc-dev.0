Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 03623DDE00
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 18:41:02 +1000 (EST)
Subject: Re: [RFC/PATCH 2/2] powerpc: irqtrace support to 64-bit powerpc
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20071015072826.2D541DDE16@ozlabs.org>
References: <20071015072826.2D541DDE16@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-oSrGzu1DIywujjV+EfwS"
Date: Mon, 15 Oct 2007 10:41:21 +0200
Message-Id: <1192437681.3349.12.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-oSrGzu1DIywujjV+EfwS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-10-15 at 17:28 +1000, Benjamin Herrenschmidt wrote:
> This adds the low level irq tracing hooks to the powerpc architecture
> needed to enable full lockdep functionality
>=20
> Some rework from Johannes initial version, removing the asm trampoline th=
at
> isn't needed (thus improving perfs) and fixing a couple of bugs such as
> incorrect initial preempt_count on the softirq alternate stack.

Cool. I always wanted to look into seeing if I could remove that but
never got around to it. Thanks!


> --- linux-work.orig/include/asm-powerpc/irqflags.h	2007-10-15 17:10:12.00=
0000000 +1000
> +++ linux-work/include/asm-powerpc/irqflags.h	2007-10-15 17:11:09.0000000=
00 +1000
=20
>  /*
> - * Do the CPU's IRQ-state tracing from assembly code. We call a
> - * C function, so save all the C-clobbered registers:
> + * Most of the CPU's IRQ-state tracing is done from assembly code; we
> + * have to call a C function so call a wrapper that saves all the
> + * C-clobbered registers.
>   */

That comment is now wrong, it should probably be removed.

johannes

--=-oSrGzu1DIywujjV+EfwS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARxMnsKVg1VMiehFYAQJiuxAAuLqoUFfrZhnbvXn91X8mMbcm/0pvfl06
e9nqjpQvdozgH2jZwF9haZIa2G/G3/lmEWRMhO9jSJOy+6PvWuei21f3ncWNtdFC
9gploSmfRhtdkfpiq2nPtzgMfAlikQPR6WtpUAEWwfnExdfFtXy+dvi2q+9coYKn
rK/aA0fjff4jxvTuHJKNiDVYNbQe8JySJOyQKnCwdWNV7cB/d9Z9pz9T9sRidkYQ
FFuCac/ZOWbLHi9u1EPuOupEYovrD6lSPeJ/lvk2ubqUx3oV0cv/z59mVP3iheO6
y2nSCy1wH7WadjtY/18sWxemIvJ16QFga6iUi5GomUxhVeXfcJ7hJ1+JtLI9zC7J
jWxuOmfvetEvc98w6yYboSDgF0Vvk5ePdwAHngVl+RUeILXvNegGKgrl4KbI1e5p
8tMKF5mNyWrpx58yw+rMPv4eOZ8YfaddTX54jAKPqzvcrrw6lixfQitG4+e+7pn1
ysHxCkaSZOP7luWbr+etbnWz3kU4Vd4OSZwIuWj1AtsDMvZR873jUSamKT88KKUQ
x7YOb0W+u2NNa7SBEzYZEq6NpzJQo8HXvQfhrddY6e+QnqHrkzdga6XgIVyoFYBC
YxZRIyx0aCs9pn56SvrxYgH8NMmuLZH8daJjvOCNeVMB2/VcP79ilvo3Bls3ByQG
EVAXlZHFjwg=
=MOkW
-----END PGP SIGNATURE-----

--=-oSrGzu1DIywujjV+EfwS--
