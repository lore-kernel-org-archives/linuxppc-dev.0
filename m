Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 37AE2DDED4
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 09:48:13 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2] powerpc: Show current speed in /proc/cpuinfo
Date: Wed, 2 May 2007 01:48:07 +0200
References: <20070427084118.GA8842@lixom.net>
	<20070430035339.GA15771@lixom.net>
In-Reply-To: <20070430035339.GA15771@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705020148.07954.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 30 April 2007, Olof Johansson wrote:
> On other architectures, the frequency in /proc/cpuinfo moves with cpufreq
> changes. It makes sense to do the same on powerpc to keep users from
> getting confused.
>=20
> Change the format to three decimals, having full Hz granularity is silly
> these days. Also specify in output if it's cpufreq or firmware-reported:
>=20
> clock =A0 =A0 =A0 =A0 =A0 : 1250.000MHz (from firmware)
> or:
> clock =A0 =A0 =A0 =A0 =A0 : 2500.000MHz (actual speed)


Good idea, but I'd be _very_ careful with changing any field in
/proc/cpuinfo. Having the extra text in there can easily confuse
parsers in poorly written user applications, maybe even in good ones ;-)

How about rather adding a new line in there for one of the fields, either

clock             : 1250.000MHz
max-clock         : 2500.000MHz

or

clock             : 2500.000MHz
current-clock     : 1250.000MHz

	Arnd <><
