Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 015E3DDE0E
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 07:16:36 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: 440 ebony patch seems to have broken 85xx build on powerpc.git
Date: Thu, 24 May 2007 23:16:29 +0200
References: <4655C7A6.2050606@mvista.com> <200705242221.17790.arnd@arndb.de>
	<1180038295.3360.29.camel@zod.rchland.ibm.com>
In-Reply-To: <1180038295.3360.29.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705242316.29713.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 24 May 2007, Josh Boyer wrote:
>=20
> > I think it should really use -mcpu=3Dpowerpc on all files.
> > The problem that Dave saw was the result of using a compiler
> > that defaults to -mcpu=3D8540, which uses instruction that
> > don't work on 440.
>=20
> You sure? =A0It griped about isel, and isel is implemented on all 440s
> with the exception of 440GP. =A0Yay for consistency.

strange indeed. -m440 does enable PPC_OPCODE_ISEL in the current
gas version, and probably all old ones as well.

> > The common files really need to be built with -mcpu flags that
> > make the code work on any system if you want to be able
> > to use just a single boot wrapper binary for all.
>=20
> Yeah, it's finding those combinations that work for all the existing
> toolchains out there that's the issue. =A0That, or making the wrapper not
> compile all the platform files... =A0I don't know which makes more sense.

I've looked up the gas source and found two ways that allow us to
compile everywhere:

1. Pass -Wa,-many to gcc
This will really allow any possible instruction to be assembled, including
the old POWER architecture, but also includes all the other strange
stuff like -maltivec, -mspe, -me500, ...

2. protect the use of special instructions with .machine directives.
You can write all the inline assemblies like

	.machine push
	.machine 440
	<440 specific instruction>
	.machine pop

This should work in any reasonably recent version of binutils, meaning
that we don't need to pass stuff like -Wa,-m440 any more.

	Arnd <><
