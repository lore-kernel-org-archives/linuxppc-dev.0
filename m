Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 5411BDDDFC
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 06:21:28 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: 440 ebony patch seems to have broken 85xx build on powerpc.git
Date: Thu, 24 May 2007 22:21:17 +0200
References: <4655C7A6.2050606@mvista.com>
	<2ded9f19fbaf49a89ed6e32de87f5828@kernel.crashing.org>
	<1180035543.3360.25.camel@zod.rchland.ibm.com>
In-Reply-To: <1180035543.3360.25.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705242221.17790.arnd@arndb.de>
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
> > Nothing is telling GCC what CPU to compile for, so it
> > will just use the compiler's default, which very likely
> > is not what you want. =A0For files that will only ever
> > be used on 440, the correct flags are -mcpu=3D440 -Wa,-m440 .
>=20
> We could add that to the per-file flags already, right?

I think it should really use -mcpu=3Dpowerpc on all files.
The problem that Dave saw was the result of using a compiler
that defaults to -mcpu=3D8540, which uses instruction that
don't work on 440.

The common files really need to be built with -mcpu flags that
make the code work on any system if you want to be able
to use just a single boot wrapper binary for all.

	Arnd <><
