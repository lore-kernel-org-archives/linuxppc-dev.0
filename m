Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F362EDDF37
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Apr 2007 22:42:08 +1000 (EST)
Subject: Re: [PATCH] powermac: proper sleep management
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17973.32577.253554.707441@cargo.ozlabs.ibm.com>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1177746562.3448.10.camel@johannes.berg>
	<17971.14223.435220.418649@cargo.ozlabs.ibm.com>
	<1177767996.5102.9.camel@johannes.berg>
	<17973.32577.253554.707441@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-+ME8j+zzzE3IB23o18x5"
Date: Mon, 30 Apr 2007 14:08:07 +0200
Message-Id: <1177934887.5102.65.camel@johannes.berg>
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


--=-+ME8j+zzzE3IB23o18x5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-04-30 at 15:31 +1000, Paul Mackerras wrote:

> At a quick look, the generic code is calling
> freeze_processes and shrink_all_memory, and I don't see where it's
> doing a sync.

The sync is done after userspace has been frozen, in freeze_processes. I
agree that shrink_all_memory is bogus, I'll talk to Rafael about it;
we're working on splitting out the hibernate and suspend code paths
anyway so it should be possible to remove this cleanly. It should also
be easy to invoke it only for suspend to disk for now.

> Also, you're now calling pbook_alloc_pci_save after interrupts are
> disabled, and it does a kmalloc(..., GFP_KERNEL).  Oops.

Oops, yes, thanks for pointing that out, it needs to go into the prepare
callback. I just sent an updated patch that moves it there and verified
that no other code was misplaced.

> Part of the problem is exactly what Linus pointed out: that the
> generic code tries to use the same code paths for suspend to RAM and
> suspend to disk, but they are two totally different things.

Actually, the stuff Linus pointed out in the recent thread was about
device drivers and the current PMU code uses the same driver/device
suspend routines that the generic code uses. No difference there.

> I have no objection to adding code to enable the generic code to do
> the (mostly) right thing when you write "mem" into /sys/power/state.
> I have no objection to code being refactored to eliminate
> duplication.  All I ask is that the PMU ioctls continue to do
> essentially the same things in the same order.

I disagree with that, it'll get us no closer to keeping the generic code
working for us. It does in fact work now, I've been using it for a long
time and a few other people have also tried on older powerbooks. It's
also very hard to convince anybody that we need changes in the generic
code if at the same time we do our own stuff because "the generic code
(you wrote) is not good enough for us anyway."

Considering the options from userspace, there are currently 3 programs
(that I know of) that actually use the ioctl:
 * hal via some helper or via pm-utils (almost all gnome/kde programs
   use it)
 * pbbuttonsd
 * pmud (?)

I know that the hal/pm-utils folks would love to get rid of the pmu
specific stuff and I think this and the battery (?) are the last things.
I don't even pretend to know what pbbuttonsd/pmud will do. Regardless of
that, however, the vast majority of users of modern desktop distros will
be using hal and hence the new code simply because that is integrated
into their desktop. If we fragment the user base into these two sets
we're making life more difficult because suddenly "sleep" or "suspend to
RAM" no longer identifies uniquely what the user did. Also, if one of
them breaks people will switch to the other one instead of helping
identify and fix the problem.

johannes

--=-+ME8j+zzzE3IB23o18x5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGNdwn/ETPhpq3jKURAlrvAJ9jioNLHAoCPn+cFmd2rWSI3FtIHwCdHGKs
m9p9YsfluGSHIGbJNdghloA=
=B3ES
-----END PGP SIGNATURE-----

--=-+ME8j+zzzE3IB23o18x5--
