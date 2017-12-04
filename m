Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yqv8K4qY8zDrnp
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Dec 2017 16:49:21 +1100 (AEDT)
Date: Mon, 4 Dec 2017 16:45:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: a3b2cb30 broken panic reporting for qemu guests
Message-ID: <20171204054543.GN2130@umbus.fritz.box>
References: <20171129040652.GF3023@umbus.fritz.box>
 <20171129142343.1e371cbb@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WU3I8Do+sziGY3UL"
In-Reply-To: <20171129142343.1e371cbb@roar.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--WU3I8Do+sziGY3UL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 02:23:43PM +1000, Nicholas Piggin wrote:
> On Wed, 29 Nov 2017 15:06:52 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > a3b2cb30 "powerpc: Do not call ppc_md.panic in fadump panic notifier"
> > purports to fix a problem when the kernel panics with fadump not
> > registered, but it breaks something else instead.  I _think_ it was
> > working on the incorrect assumption that ppc_md.panic was (or should
> > be) only used with fadump, but I'm not really sure.
> >=20
> > Panic works with kdump enabled, and (I think) with fadump enabled).
> > However, with neither of these enabled, we always go to the generic
> > panic logic.
>=20
> Yeah thanks, I can't remember what assumption I was working on tbh.
> =20
> > That's incorrect for PAPR guests - they should call ibm,os-term via
> > RTAS.  Under qemu this leads to a "GUEST_PANICKED" event notification
> > which higher-level management pays attention to.  Since a3b2cb30 we
> > now reboot instead of reporting that.
> >=20
> > I believe it will also break panic for PS3 machines, but since that
> > platform basically no longer exists, we probably don't care.
>=20
> I (hope) it should just go down to the normal panic path and not do
> much worse than it already does -- although it won't print out that
> message.

Sounds plausible.

> > I'm not entirely sure how to fix this.  I _think_ what we want is to
> > call ppc_md.panic from a late panic notifier, the way this patch does
> > for fadump_panic_event() if fadump is registered.
>=20
> The problem I had there is that some of the printk and console stuff
> wasn't getting flushed out, so I was getting a blank screen. This was
> probably in conjunction with panicing from NMI context that we're now
> starting to introduce.

Ok.  What was the exact bit of panic() that wasn't getting invoked
that needed to be?

AFAICT ppc_md.panic was already being called at the end of the panic
notifiers, by using INT_MIN priority.  Note that this is the same way
that the pvpanic device (used on x86 for similar panic notification
functionality) does it.  Well, pvpanic uses priority 1, which seems
less thorough than INT_MIN.

> So it's a bit annoying. There's other ugliness we have for being unable
> to control panic code well enough from arch code
> (arch/powerpc/platforms/powernv/opal.c)
>=20
> I guess a really minimal fix is to put an #ifdef powerpc down the bottom
> there (/me *cries*).

That would work for the PAPR os-term thing, but wouldn't if we ever
had a specific device that worked like pvpanic.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WU3I8Do+sziGY3UL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlok4QUACgkQbDjKyiDZ
s5I4Mg/9GBn0TWl1xfSMEFGJnLbS74Xj0oRmPzQMkJkJHINw8y/il9GeB0jIiy0y
ogjPQqaMYAVnfQP2n8ppx980/um0TZGHA8Ka7bIyWsWXOFBsOA5bnmKOOHIFHDOC
v/15gTPJ7x9qNn0mAs2GFGODyIa67vjh3QP0XXZPEVxXWAAagah+d/l5pezX7kmN
Eoo3XKgtvnh5SgxlsMdt6AUaHrfmGAmJQIVqNdlmxbIjD8osK7K3Vp0wbUETCptN
8eQKeC+X3Iz8GCM+ktVk+km2r/BH4naTNZDWajgVM8ee01L0n1OiCRfDd8zzLtKU
TJib1kI1LsqF/t4QRbpGZhBlKuXaEyIXF7URfUqLOYtGUf00yvNYY5gtNgUxrMvk
KQW113cjCjbvw6hmtEhLPQO8bN28j1x79HaAWo7JIJvsb/NU4C/t49IDJMCpRL3k
FRwQnvCmz5T6sYuSDV7tqSObu2QF5Q3PAWBXA4OvfhNzgtgZUOml6mNJ6D2BPDuk
SnUx4JXwUEAzoQN+UyAt7hHpfd/BILYkFgEF3H+clXvGy5gR+1uc9gLL40ZkmvKt
iB1pLMjdnHZ9eXpjAGtc+JTuv/oD8Kk5MjQHIy9VuNsIciioUUwuM7FQXFTRCRei
zBOJlefIVqjRYwEqoq9z/idu6n3DY5mRxADwn3nWRq9Qws0WGAk=
=TqZT
-----END PGP SIGNATURE-----

--WU3I8Do+sziGY3UL--
