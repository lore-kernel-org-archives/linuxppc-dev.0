Return-Path: <dja@axtens.net>
Received: from mail-pd0-x22c.google.com (mail-pd0-x22c.google.com
 [IPv6:2607:f8b0:400e:c02::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 234ED1A1A2C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 14:57:53 +1000 (AEST)
Received: by pdbnt7 with SMTP id nt7so61290771pdb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 21:57:51 -0700 (PDT)
Message-ID: <1437540961.30906.39.camel@axtens.net>
Subject: Re: [PATCH v5 6/7] powerpc/powernv: generic nest pmu event functions
From: Daniel Axtens <dja@axtens.net>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Stephane
 Eranian <eranian@google.com>, Paul Mackerras <paulus@samba.org>, Anton
 Blanchard <anton@samba.org>,  Sukadev Bhattiprolu
 <sukadev@linux.vnet.ibm.com>, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>
Date: Wed, 22 Jul 2015 14:56:01 +1000
In-Reply-To: <1437045206-7491-7-git-send-email-maddy@linux.vnet.ibm.com>
References: <1437045206-7491-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1437045206-7491-7-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-cl9WOXIxkfKB9Nigg2E2"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-cl9WOXIxkfKB9Nigg2E2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


> +static void p8_nest_read_counter(struct perf_event *event)
> +{
> +	uint64_t *addr;
> +	u64 data =3D 0;
You've got a u64 and a uint64_t, and then...
> +
> +	addr =3D (u64 *)event->hw.event_base;
... you cast to event_base to a u64 pointer, which you assign to a
uint64_t pointer.
> +	data =3D __be64_to_cpu(*addr);
And now you dereference the pointer.
Could you just have:
    data =3D __be64_to_cpu(*event->hw.event_base);

> +	local64_set(&event->hw.prev_count, data);
> +}
> +
> +static void p8_nest_perf_event_update(struct perf_event *event)
> +{
> +	u64 counter_prev, counter_new, final_count;
> +	uint64_t *addr;
> +
> +	addr =3D (uint64_t *)event->hw.event_base;
Here at least the cast type is the same as the type of addr, but again,
why do you need the different types, and why local variable?
> +	counter_prev =3D local64_read(&event->hw.prev_count);
> +	counter_new =3D __be64_to_cpu(*addr);
> +	final_count =3D counter_new - counter_prev;
> +
> +	local64_set(&event->hw.prev_count, counter_new);
> +	local64_add(final_count, &event->count);
> +}
> +
> +static void p8_nest_event_start(struct perf_event *event, int flags)
> +{
> +	event->hw.state =3D 0;
Should this be an enum or a #define rather than a bare 0? (It may not
need to be, I was just wondering because I don't know what 0 means.)
> +	p8_nest_read_counter(event);
> +}
> +
--=20
Regards,
Daniel

--=-cl9WOXIxkfKB9Nigg2E2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVryJhAAoJEPC3R3P2I92F+4kP/jJsT6LMbfBmZDBEtGdcTUvS
qHpg0+tgSQ/PLYvBH0lAp1E7YTqiiGDHuvJWpEiuPdIi+gxbVpZL4gVHAnBKxkTq
f1gsYeIL3eO3ugZJe+wgCjBBNu6a7hKEtbigX3IUUTAY8cF430F09zuMbaAsofUs
OfjezpCfMmUh7FjL3a4KScPyeLdn0TYdh3tVBwTmwJ17p8bBWVLnRBflaa2IBI0A
cDzZ8UGgnZ51mhFUcSY2PMLHXBzVMZ9Q1Et0A0s8eQZ2ewj1q0KcP7wWMzOHHzM6
L76afTzTAVv1moCChSxcMNvQ3VnAbI12kxhMGQ3UBQBNRWScjab9BZfcljbpORi5
L3abVQPBxxtAQslkKWy+0tv3taSTqNvxXa+BWEVJ75029kdTXN3Yk2GuTlOi0d4m
P+McJLWPqNeK67A855ewhfh+JzQvAXL/6Gg/xoRiCXQpjInQs/xtxFyub6rjewOb
Cr1vpYPhEJC+Om58ikQ8hp8vdAxWjJI11Ie7hnXHV8escXoXwMZ1/Tba+idgU0Ia
97MznL9ndNWIfX1mZ1d07W4X2dEWaRdIgiFf+V76hLomW8WC2RBI9RRtws9Az2hG
z2YLz8T3qh6TMXsaH7uBrG2Jhe7wkbuDzCEwRIUu2J0LilOw43yYBg5p+LQaWen0
u42WO0CqJIjXaL1GZKJY
=Vz7x
-----END PGP SIGNATURE-----

--=-cl9WOXIxkfKB9Nigg2E2--
