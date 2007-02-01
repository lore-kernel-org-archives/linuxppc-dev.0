Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 93F13DDDFE
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Feb 2007 23:13:40 +1100 (EST)
Subject: powerbook/radeon PM problem
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/MjuKt6eOmq/NtHqjUWp"
Date: Thu, 01 Feb 2007 20:11:23 +0100
Message-Id: <1170357083.4036.5.camel@johannes.berg>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-/MjuKt6eOmq/NtHqjUWp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Whenever I resume my powerbook I get:

[  336.307861] BUG: sleeping function called from invalid context at kernel=
/rwsem.c:20
[  336.307871] in_atomic():0, irqs_disabled():1
[  336.307875] Call Trace:
[  336.307879] [EC257D30] [C000901C] show_stack+0x3c/0x194 (unreliable)
[  336.307900] [EC257D60] [C00268B8] __might_sleep+0xd4/0xe8
[  336.307918] [EC257D70] [C004555C] down_read+0x24/0x5c
[  336.307930] [EC257D90] [C003A574] blocking_notifier_call_chain+0x20/0x54
[  336.307940] [EC257DB0] [C017FB60] fb_notifier_call_chain+0x24/0x34
[  336.307949] [EC257DC0] [C0180178] fb_set_suspend+0x58/0x6c
[  336.307956] [EC257DE0] [C01A79F0] radeonfb_pci_resume+0x1fc/0x3e0
[  336.307964] [EC257E00] [C01A7BF8] radeonfb_early_resume+0x24/0x40
[  336.307970] [EC257E20] [C001A5C0] pmac_call_early_video_resume+0x2c/0x3c
[  336.307985] [EC257E30] [C01E1148] pmu_ioctl+0x6f8/0xb64
[  336.307994] [EC257ED0] [C0091C84] do_ioctl+0x80/0x84
[  336.308003] [EC257EE0] [C0091D0C] vfs_ioctl+0x84/0x43c
[  336.308009] [EC257F10] [C0092104] sys_ioctl+0x40/0x74
[  336.308014] [EC257F40] [C00114B4] ret_from_syscall+0x0/0x38


Hence, there must be a bug somewhere... The documentation to
fb_set_suspend notes:
"It must be called with the console semaphore held"

So that's one of the bugs, how can that be satisfied when we're just
resuming and haven't taken that semaphore? (if we did take it, then we'd
get the warning earlier..)

Then again, is the resume code really supposed to be called with
interrupts disabled?

I'm totally unsure what the correct fix for this is.

johannes

--=-/MjuKt6eOmq/NtHqjUWp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFwjtb/ETPhpq3jKURArx/AJ4ooxeuId0n/uyG0WQTC2eohvfOoQCfd0Te
AcKCTukO552Q9NKXJw4JN2c=
=9hgx
-----END PGP SIGNATURE-----

--=-/MjuKt6eOmq/NtHqjUWp--
