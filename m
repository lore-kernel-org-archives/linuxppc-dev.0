Return-Path: <pavel@ucw.cz>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVqk20jGpzDrLd
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 22:15:54 +1100 (AEDT)
Date: Mon, 6 Nov 2017 12:08:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Miroslav Benes <mbenes@suse.cz>
Cc: jpoimboe@redhat.com, jeyu@kernel.org, jikos@kernel.org,
 pmladek@suse.com, lpechacek@suse.cz, live-patching@vger.kernel.org,
 linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
Subject: Re: [PATCH v3 1/2] livepatch: send a fake signal to all blocking tasks
Message-ID: <20171106110833.GB24863@amd>
References: <20171031114853.841-1-mbenes@suse.cz>
 <20171031114853.841-2-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
In-Reply-To: <20171031114853.841-2-mbenes@suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> --- a/Documentation/ABI/testing/sysfs-kernel-livepatch
> +++ b/Documentation/ABI/testing/sysfs-kernel-livepatch
> @@ -33,6 +33,15 @@ Contact:	live-patching@vger.kernel.org
>  		An attribute which indicates whether the patch is currently in
>  		transition.
> =20
> +What:		/sys/kernel/livepatch/<patch>/signal
> +Date:		Oct 2017
> +KernelVersion:	4.15.0
> +Contact:	live-patching@vger.kernel.org
> +Description:
> +		A writable attribute that allows administrator to affect the
> +		course of an existing transition. Writing 1 sends a signal to
> +		all remaining blocking tasks.

What kind of signal?

>  What:		/sys/kernel/livepatch/<patch>/<object>
>  Date:		Nov 2014
>  KernelVersion:	3.19.0
> diff --git a/Documentation/livepatch/livepatch.txt b/Documentation/livepa=
tch/livepatch.txt
> index ecdb18104ab0..6694530d0894 100644
> --- a/Documentation/livepatch/livepatch.txt
> +++ b/Documentation/livepatch/livepatch.txt
> @@ -178,6 +178,12 @@ transition, it shows -1.  Any tasks which are blocki=
ng the transition
>  can be signaled with SIGSTOP and SIGCONT to force them to change their
>  patched state.
> =20
> +Administrator can also affect a transition through
> +/sys/kernel/livepatch/<patch>/signal attribute. Writing 1 to the attribu=
te sends
> +a signal to all remaining blocking tasks. This is an alternative for
> +SIGSTOP/SIGCONT approach mentioned in the previous paragraph. It should =
also be
> +less harmful to the system.

Well... If SIGSTOP / SIGCONT is considered harmful (it probably is),
it should be mentioned above, and not in note here...
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAloAQrAACgkQMOfwapXb+vK1YQCfZTYld5Xapwyx+UHxqVu7BTsn
AicAoKk+hmbgt/wGPwEq8YgqlJcxAP5p
=Jg0X
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
