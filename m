Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 9C938DDE0E
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 19:52:41 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [4/5] replace CONFIG_POWER4_ONLY by new tuning mechanism
Date: Mon, 21 Jul 2008 11:52:35 +0200
References: <200807210845.30434.marvin24@gmx.de>
	<200807210857.03775.marvin24@gmx.de>
In-Reply-To: <200807210857.03775.marvin24@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807211152.36226.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 21 July 2008, Marvin wrote:
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -115,13 +115,30 @@ config OPT_EXCLUSIVE
> =A0=A0=A0=A0=A0=A0=A0=A0 =A0
> =A0=A0=A0=A0=A0=A0=A0=A0 =A0If you are unsure, select no.
> =A0
> -config BATS64
> +config PPC64_GEN
> =A0=A0=A0=A0=A0=A0=A0=A0depends on PPC64
> -=A0=A0=A0=A0=A0=A0=A0def_bool y if !POWER4_ONLY
> +=A0=A0=A0=A0=A0=A0=A0int
> +=A0=A0=A0=A0=A0=A0=A0default "1" if !OPT_EXCLUSIVE
> +=A0=A0=A0=A0=A0=A0=A0default "2" if TUNE_RS64
> +=A0=A0=A0=A0=A0=A0=A0default "3" if TUNE_POWER3
> +=A0=A0=A0=A0=A0=A0=A0default "4" if TUNE_POWER4 || TUNE_CELL || TUNE_970
> +=A0=A0=A0=A0=A0=A0=A0default "5" if TUNE_POWER5
> +=A0=A0=A0=A0=A0=A0=A0default "6" if TUNE_POWER6

Unfortunately, the world is not this easy, e.g. POWER5 doesn't have
all the features that Cell and 970 have (or vice versa), and PA6T
doesn't fit in here either.

If you want to model this correctly, you need to have each CPU
as a separate option, and then deduce the feature set from that,
like:

menuconfig "CPU selection"

config MIN_POWER3
	bool "Power 3 support"

config MIN_POWER4
	bool "Power 4 support"

config MIN_CELL
	bool "Cell Broadband Engine support"


and so on. All this has nothing to do with the tuning option,
except that you may want to make sure a CPU is enabled if you
want to be able to tune for it.

> @@ -185,7 +202,7 @@ config PHYS_64BIT
> =A0
> =A0config ALTIVEC
> =A0=A0=A0=A0=A0=A0=A0=A0bool "AltiVec Support"
> -=A0=A0=A0=A0=A0=A0=A0depends on CLASSIC32 || POWER4
> +=A0=A0=A0=A0=A0=A0=A0depends on CLASSIC32 || PPC64
> =A0=A0=A0=A0=A0=A0=A0=A0---help---
> =A0=A0=A0=A0=A0=A0=A0=A0 =A0This option enables kernel support for the Al=
tivec extensions to the
> =A0=A0=A0=A0=A0=A0=A0=A0 =A0PowerPC processor. The kernel currently suppo=
rts saving and restoring

If you know exactly what CPUs are supported, you can do this
automatically: Altivec works only on G4 (mpc74xx and mpc86xx),
G5 (970), Cell, Power6 and PA6T.

> @@ -201,7 +218,7 @@ config ALTIVEC
> =A0
> =A0config VSX
> =A0=A0=A0=A0=A0=A0=A0=A0bool "VSX Support"
> -=A0=A0=A0=A0=A0=A0=A0depends on POWER4 && ALTIVEC && PPC_FPU
> +=A0=A0=A0=A0=A0=A0=A0depends on PPC64 && ALTIVEC && PPC_FPU
> =A0=A0=A0=A0=A0=A0=A0=A0---help---
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0 =A0This option enables kernel support for the Ve=
ctor Scaler extensions

Similarly, VSX is available only on Power6.

	Arnd <><
