Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ymn6S2HNxzDrbb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 15:06:56 +1100 (AEDT)
Date: Wed, 29 Nov 2017 15:06:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: a3b2cb30 broken panic reporting for qemu guests
Message-ID: <20171129040652.GF3023@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="B0nZA57HJSoPbsHY"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--B0nZA57HJSoPbsHY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

a3b2cb30 "powerpc: Do not call ppc_md.panic in fadump panic notifier"
purports to fix a problem when the kernel panics with fadump not
registered, but it breaks something else instead.  I _think_ it was
working on the incorrect assumption that ppc_md.panic was (or should
be) only used with fadump, but I'm not really sure.

Panic works with kdump enabled, and (I think) with fadump enabled).
However, with neither of these enabled, we always go to the generic
panic logic.

That's incorrect for PAPR guests - they should call ibm,os-term via
RTAS.  Under qemu this leads to a "GUEST_PANICKED" event notification
which higher-level management pays attention to.  Since a3b2cb30 we
now reboot instead of reporting that.

I believe it will also break panic for PS3 machines, but since that
platform basically no longer exists, we probably don't care.

I'm not entirely sure how to fix this.  I _think_ what we want is to
call ppc_md.panic from a late panic notifier, the way this patch does
for fadump_panic_event() if fadump is registered.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--B0nZA57HJSoPbsHY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloeMlwACgkQbDjKyiDZ
s5LtpBAAoED64ll1UqluDExj7X52d2OQJlKqJpRgRm9+3U9xyNYDlfTNEw69EYQN
r5WzW5s1heCtEmlRCXcrcfvfh6zli5JADHmQwpVIn3P3MiVVp8eZIR/cxHAd9kRS
69l30XZIojmd1tm++PX621PdPzdNbQpAe9DSiJNjXn1GysnVHJhRvH1+aS8dwK5t
m/bKzdXVOs0cU6Vh5kUYxnTEBP54oRqB7HOTBQi6G+DBkSsFEUOaCdEIIDMovdeL
Pko6R5AVqu2GxvTH+5uhLeRqwGRIRiv79MSGuucft4G1lomVAgEVllliwzh69mpM
UbuMes4qMKjt94bZbTZgJVr3Uu0D7CnHTFaXsr2sk95jzpnvvyfVtVBYhNM8g1xQ
mlOzKWu61rjk/1egF2h97LbSCnHu2u7/2LydxhvlX9StRFGue1B96bPU3I2PUuvT
2VVvBniOieLzc5e7Gr5uW7KPIcSaqSUznQ/RS2wGG2javeHXpSHknfIH1MYJgpMS
juFdEo68lmKb1OpneAQKHh8hOYDudQR38JTsj0wNSqwrqWOzSFsBFzyDJC7OLuNR
GTfsYmT4PPBw6iBwVCkNAG1VU6Rv90WvNoDQcu49owCFmW22V/nJZiopuBkOGHuT
MR5dEMti574+8ZDnnn99dsNhE1YtHgeOGlJCpCCRGipXqGhDKP4=
=GhFX
-----END PGP SIGNATURE-----

--B0nZA57HJSoPbsHY--
