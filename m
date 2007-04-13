Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [RFC, PATCH] selection of CPU optimization
Date: Fri, 13 Apr 2007 02:10:47 +0200
References: <20070410111508.GA2969@localhost.localdomain>
	<200704121926.03723.arnd@arndb.de>
	<e5b10849669a764f002d1926838edc76@kernel.crashing.org>
In-Reply-To: <e5b10849669a764f002d1926838edc76@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704130210.48508.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 12 April 2007, Segher Boessenkool wrote:
> > What would be the right options to pass on e200 and on
> > pa6t?
>=20
> The best thing would be to add GCC -mcpu=3D options. =A0For
> now, you're probably best of with -mcpu=3Dpowerpc and
> -mcpu=3Dpowerpc64 resp., i.e. the "blended models". =A0This
> is a good option for multiplatform kernels too; add -mtune=3D
> to optimise for a specific core, but it will *work* on
> the whole family.

We already have makefile magic to test if gcc supports a flag
and fall back to some other one if not.

After looking at rs6000.c, I found that we can probably
reduce the number of different -mcpu=3D options to 16 and only
have separate -mtune=3D options for each specific cpu.

My understanding at this point is that we can always fall back
to -mcpu=3Dpowerpc or -mcpu=3Dpowerpc64, and also

(401, 505, power, power2, rsc) -> not supported

403 -> -mcpu=3D403
(405, 440) -> -mcpu=3D405
(e500, 85xx) -> -mcpu=3D8540
601 -> -mcpu=3D601
(6xx, g3, g4, e300, e600) -> -mcpu=3D603
(ec603e, e200, 82xx) -> -mcpu=3Dec603e
(8xx) -> -mcpu=3D860

(power3, rs64) -> -mcpu=3Dpower3
power4 -> -mcpu=3Dpower4 >> -mcpu=3Dpower3
970 -> -mcpu=3D970 >> -mcpu=3Dpower4
cell -> -mcpu=3Dcell >> -mcpu=3D970
power5 -> -mcpu=3Dpower5 >> -mcpu=3Dpower4
power5+ -> -mcpu=3Dpower5+ >> -mcpu=3Dpower5
power6 -> -mcpu=3Dpower6 >> -mcpu=3Dpower5+
power6x -> -mcpu=3Dpower6x >> -mcpu=3Dpower6
pa6t -> -mcpu=3Dpa6t >> (???)

So if we select e.g. power6 and cell, it needs to fall back to power4,
which is the common subset. Selecting both 403 and 405 would result
in falling back to -mcpu=3Dpowerpc, because they don't have any larger
subset.

I'm not sure what the right fallback fo pa6t should be. I would guess
that it's a superset of power6x and 970 when considering the kernel,
but it's not entirely clear what the fallback should be.

	Arnd <><
