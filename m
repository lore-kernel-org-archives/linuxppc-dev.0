Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id DF9ACDDECA
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 14:52:26 +1000 (EST)
Date: Fri, 21 Sep 2007 14:52:12 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH v2 2/4] Implement generic time of day clocksource for
	powerpc machines.
Message-Id: <20070921145212.7e8a7b89.sfr@canb.auug.org.au>
In-Reply-To: <20070921032603.07AF232C889@thor>
References: <1190345162.620000.305760830507.qpush@thor>
	<20070921032603.07AF232C889@thor>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__21_Sep_2007_14_52_12_+1000_qfMqGoici3Kn0W4A"
Cc: linuxppc-dev@ozlabs.org, Thomas, Paul Mackerras <paulus@samba.org>,
	Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__21_Sep_2007_14_52_12_+1000_qfMqGoici3Kn0W4A
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Small comments.

On Fri, 21 Sep 2007 13:26:02 +1000 Tony Breeds <tony@bakeyournoodle.com> wr=
ote:
>
> +void update_vsyscall(struct timespec *wall_time, struct clocksource *clo=
ck)
> +{
> +	u64 t2x, stamp_xsec;
> +
> +	if (__USE_RTC() || clock !=3D &clocksource_timebase)
            ^^^^^^^^^^^
I think this is redundant as if __USE_RTC() is true, you register
clocksource_rtc below.

> +#ifdef CONFIG_ISERIES
> +	if (!firmware_has_feature(FW_FEATURE_ISERIES))
> +#endif

The #ifdef is redundant since if CONFIG_ISERIES is not set,
firmware_has_feature(FW_FEATURE_ISERIES) is constant 0.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__21_Sep_2007_14_52_12_+1000_qfMqGoici3Kn0W4A
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG804BTgG2atn1QN8RAlmjAJ95h+DfOTUgLZFmepyyLR1inWcPjQCgjNFS
X/EY2FAKfBiku+mj/LzWsFI=
=ptP+
-----END PGP SIGNATURE-----

--Signature=_Fri__21_Sep_2007_14_52_12_+1000_qfMqGoici3Kn0W4A--
