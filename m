Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id B831BDDF43
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 23:01:03 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: details, details ...
Date: Wed, 13 Aug 2008 15:00:50 +0200
References: <48A2CD2A.5020107@hypersurf.com>
In-Reply-To: <48A2CD2A.5020107@hypersurf.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808131500.51018.arnd@arndb.de>
Cc: Kevin Diggs <kevdig@hypersurf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 13 August 2008, Kevin Diggs wrote:
> In cpu exit function of a cpufreq driver:
>=20
> =A0 =A0 =A0 =A0 =A0while (test_bit(cf750gxmChangingPllBit, &cf750gxvState=
Bits))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msleep(1);
>=20
> This bit will get cleared by a notifier callback.
>=20
> In module_exit function of a related module:
>=20
> =A0 =A0 =A0 =A0 =A0while (test_bit(PLL_LOCK_BIT, (unsigned long *)&boot_r=
atio)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msleep(1);
> =A0 =A0 =A0 =A0 =A0}
>=20
> This bit will get cleared by a timer. It will also fire the notifiers=20
> needed above.
>=20
> I don't think these are in interrupt context. The sleeps ok here?

Technically ok, but not nice. Besides the coding style issues,
it's still a busy loop that should be replaced by wait_for_completion().

> Also, from checkpatch:
>=20
> ERROR: do not initialise externals to 0 or NULL
> #2483: FILE: arch/powerpc/kernel/cpu/pll_if.c:486:
> +int rval =3D 0;
>=20
> ERROR: do not initialise statics to 0 or NULL
> #2058: FILE: arch/powerpc/kernel/cpu/pll_if.c:61:
> +static unsigned int override_bus_clock =3D 0;
>=20
> Huh? What? Anyone care to teach an old dog a new trick???

Don't bother. Old gcc variants would put these variables into .data
instead of .bss, but with a new (less than 5 years or so) gcc, both
will result in .bss storage that is initialized to zero at boot time.

	Arnd <><
