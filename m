Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7A6BFDDDE9
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Feb 2007 17:46:43 +1100 (EST)
Subject: Re: CPU hotplug vs. cpufreq on ppc64
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1170639556.2620.75.camel@localhost.localdomain>
References: <1170360890.4036.19.camel@johannes.berg>
	<1170639556.2620.75.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-4glY/Rtv7aRNuX68vvqn"
Date: Mon, 05 Feb 2007 07:45:51 +0100
Message-Id: <1170657951.23273.22.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	cpufreq <cpufreq@lists.linux.org.uk>,
	Ashok Raj <ashok.raj@intel.com>, davej@codemonkey.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-4glY/Rtv7aRNuX68vvqn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-02-05 at 12:39 +1100, Benjamin Herrenschmidt wrote:

> So you mean that the policy->cpus mask is lost on unplug/replug ? Hrm...

Yes, but fixing that wouldn't fix the problem.

> I'm not sure what's the best way to restore it. Do we have a cpufreq
> backend callback on hotplug to restore things ?

Not afaict, but you can of course always use register_hotcpu_notifier.

This, however, is what cpufreq.c uses to be notified of a new CPU that
is coming online, and it then calls cpufreq_add_dev which even with a
correct policy->cpus mask wouldn't go back to adding the links back,
this is only done when CPU#0 comes online.

I think this is a more generic problem and code will need to be added to
cpufreq to
 (a) call into the cpufreq_driver asking it to update the mask on
     hotplug
 (b) after that, check the mask and re-link on hotplug.

johannes

--=-4glY/Rtv7aRNuX68vvqn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFxtKf/ETPhpq3jKURAr7uAKCxu52CVwxYZiZRX5q9MIb/q5ccOwCgpVHp
k/UQGfRJ0qYRJFKVkesSNAE=
=OxfZ
-----END PGP SIGNATURE-----

--=-4glY/Rtv7aRNuX68vvqn--
