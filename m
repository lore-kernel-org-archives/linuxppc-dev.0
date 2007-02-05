Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 98F54DDEEC
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 04:37:06 +1100 (EST)
Subject: Re: CPU hotplug vs. cpufreq on ppc64
From: Johannes Berg <johannes@sipsolutions.net>
To: Jacob Shin <jacob.shin@amd.com>
In-Reply-To: <45C765C3.3090004@amd.com>
References: <1170360890.4036.19.camel@johannes.berg> <45C765C3.3090004@amd.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-eg5xO6QXgBm90qXJ7+GM"
Date: Mon, 05 Feb 2007 18:33:30 +0100
Message-Id: <1170696810.3572.28.camel@johannes.berg>
Mime-Version: 1.0
Cc: davej@codemonkey.org.uk, Ashok Raj <ashok.raj@intel.com>,
	cpufreq <cpufreq@lists.linux.org.uk>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, mark.langsdorf@amd.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-eg5xO6QXgBm90qXJ7+GM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

> CPU0 comes online first, and no other CPUs are online yet.  CPU0 cannot=20
> advertise to cpufreq what his affected CPUs are because CPU1, CPU2, and=20
> CPU3 do not exist!

Actually, the current powermac cpufreq code does (and can because it
knows that there are only 4 CPUs that you can't actually hotplug
physically.)

> At this point in time, the kernel is only aware of=20
> CPU0, which is the only CPU that cpufreq manages for the moment.

Right, the current cpufreq code still sets policy->cpus =3D 1|2|4|8
though.

> Now, say CPU1 comes online.  CPU1 now knows that itself and CPU0 are=20
> tied together in freq scaling.

Aha, so the knowledge should be the other way around.

> However, CPU0 is still left in the dark,=20
> and thinks that he only manages himself.  So CPU1 will register itself,=20
> and tell cpufreq that its affected cpus are itself and CPU0.  The=20
> cpufreq driver will see that CPU0 is already managed, update CPU0's=20
> affected cpus data structure, symlink CPU1 to CPU0, and finally call=20
> exit on CPU1 to clean up.

Ok.

> Same story for CPU2 and CPU3.

Yeah, I understand now. Thanks for the explanation. I think the fix is
actually trivial too.

johannes

--=-eg5xO6QXgBm90qXJ7+GM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFx2pq/ETPhpq3jKURAtf3AJ4swXveQP1dTkHwGdeRJLsz6fmmHQCeM3MC
c1L+LlVdsh0MGPd0LWrW/+M=
=ynya
-----END PGP SIGNATURE-----

--=-eg5xO6QXgBm90qXJ7+GM--
