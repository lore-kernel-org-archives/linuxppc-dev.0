Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 46D32DDEB9
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 00:15:55 +1000 (EST)
Subject: Re: [PATCH v3] powerpc: fix suspend states again
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1177933035.5102.33.camel@johannes.berg>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1177710095.3565.64.camel@johannes.berg>
	<20070427215338.GB17224@lixom.net>
	<1177710883.3565.66.camel@johannes.berg>
	<1177711372.3565.73.camel@johannes.berg>
	<17973.13523.57567.352585@cargo.ozlabs.ibm.com>
	<1177933035.5102.33.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-LdHUEEEdQb7FLd03JhyC"
Date: Tue, 01 May 2007 16:16:30 +0200
Message-Id: <1178028990.4157.9.camel@johannes.berg>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-LdHUEEEdQb7FLd03JhyC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-04-30 at 13:37 +0200, Johannes Berg wrote:
> In commit 0fba3a1f39f8b0a50b56c8b068fa52131cbc84c2 (a very long time ago,
> May 2006), I fixed a bug that caused powermacs to crash when you tried
> entering standby/mem suspend states.
>=20
> As I'm now getting more familiar with the suspend code I notice a few
> more things:
[...]

Regardless of the follow-up pmu pm_ops patch you should really merge
this patch since I changed the generic pm_ops infrastructure to be less
broken, and the current code in .21 may sometimes work due to the
breakage that is now no longer there; pm_ops will now not be invoked for
suspend to disk unless
 (1) the user has 'platform' in /sys/power/disk
 (2) pm_ops.pm_disk_mode is set to PM_DISK_PLATFORM

(1) can be changed by the user so even the old code was just correct in
case the user didn't change anything, and (2) isn't true in the current
tree.

johannes

--=-LdHUEEEdQb7FLd03JhyC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGN0u9/ETPhpq3jKURAli+AKCjKybGTle7htlfY9HJWRWpaVDQcACfTUFt
ci0EMSgIXD1tBxiE3+KEfi8=
=CvSr
-----END PGP SIGNATURE-----

--=-LdHUEEEdQb7FLd03JhyC--
