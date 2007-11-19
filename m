Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 89CACDDDF4
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 23:36:16 +1100 (EST)
Subject: NULL dereference in clockevents_program_event
From: Johannes Berg <johannes@sipsolutions.net>
To: Thomas Gleixner <tglx@linutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-TMxDqhAVH2yKIVXj0ubm"
Date: Mon, 19 Nov 2007 21:06:44 +0100
Message-Id: <1195502804.19479.6.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-TMxDqhAVH2yKIVXj0ubm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

During a hibernate cycle on my G5, while machine was powering down after
saving the image, I just had a NULL dereference  in
clockevents_program_event when accessing dev->mode, dev was NULL.

Unfortunately the machine rebooted before I was able to write down more
than the fact that it was called from tick_program_event(); the problem
doesn't seem to be easily reproducible.

=46rom what I can see when doing the same thing, the shutdown attempts to
offline all CPUs. Because the snapshot was actually saved to disk and
the machine was shutting down I guess that the it happened at that time,
but I have no idea what else to do to debug this.

I have

| CONFIG_HIGH_RES_TIMERS=3Dy
| CONFIG_NO_HZ=3Dy

in this config.

johannes

--=-TMxDqhAVH2yKIVXj0ubm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR0Hs06Vg1VMiehFYAQJUuw//dwXy5lFVNZzjnOJdIszRKUkpqCFwGK2N
vKba7eUvmWyLTXeWarC4lxrG0Hu0dH9Ep48q2ciBAKWjdjkD8OQbXyIt56f3/VLS
VxkHOmFFshSAa9y0sMiuEOqYjmj5bVN7VTGKgMgqznjDEt4xbe3PUqPA7i7dwX29
lc6+TfDCin1NZkUM4kXGSIYZaupe0/qGdD+GY11uYgPyhfpHU9XIZPJpOhqmPta5
Kb/AGilz0LgcPGRXKs3YRWatKhLl6lYsRFPhyUIRZtaiBNoxxBbGcxD4H4NBdWtS
Kv9mPc0m21rd7OGmMEAa3CmsnERqXUPclJwksJFqq+wVHZp8RPB4M7Bd/k8121zM
j3BKL9Hsy9y+YsibCeuw/4hz+sk7ZDP/iHa4A5vppqbTVGswjycRO6gaLWO3ydbY
sI8oVnsoRYNHtckyOCjn76Ar6FVUjn0ukrz35NpQoVVnzmnkQk9L3H8QTx+G0LYA
smOqZYc6H95YFswF7sAudRqG/oab4feGXVgV+zX2jKQOrOvNa2xHpfpQXcRIVNl/
xV88cxDbp7TEQd1oZ1QFE4h1kr7v/h5w6mWhq8BXz6OdQKd09IjdHs49SX6DgetM
2TsCqefz9Krom/NgBcShEIQNg6nYZzc1uAsSf5mfJ0XC+ooJXA54G+428hDBCIVm
92rAdQhnYJ4=
=SHwy
-----END PGP SIGNATURE-----

--=-TMxDqhAVH2yKIVXj0ubm--
