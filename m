Return-Path: <michael@ellerman.id.au>
Subject: Re: Config Items appearing twice in same Kconfig file?
From: Michael Ellerman <michael@ellerman.id.au>
To: Christoph Egger <siccegge@cs.fau.de>
In-Reply-To: <20100512144017.GA722@faui48a.informatik.uni-erlangen.de>
References: <20100512143445.GA32559@faui48a.informatik.uni-erlangen.de>
	<20100512144017.GA722@faui48a.informatik.uni-erlangen.de>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-h/kN6/EO2DvGfQAWWQqy"
Date: Thu, 13 May 2010 11:08:49 +1000
Message-ID: <1273712929.25436.5.camel@concordia>
Mime-Version: 1.0
Cc: linux-ia64@vger.kernel.org, vamos@i4.informatik.uni-erlangen.de,
	Jesse Barnes <jbarnes@virtuousgeek.org>, Timo Teras <timo.teras@iki.fi>,
	Chen Liqin <liqin.chen@sunplusct.com>, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Lennox Wu <lennox.wu@gmail.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	"Pekka Savola \(ipv6\)" <pekkas@netcore.fi>, x86@kernel.org,
	James Morris <jmorris@namei.org>, Ingo Molnar <mingo@redhat.com>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Matt Turner <mattst88@gmail.com>,
	Fenghua Yu <fenghua.yu@intel.com>, Mike Frysinger <vapier@gentoo.org>,
	Arnd Bergmann <arnd@arndb.de>, Graf Yang <graf.yang@analog.com>,
	Mikael Starvik <starvik@axis.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Richard Henderson <rth@twiddle.net>, Karsten Keil <isdn@linux-pingi.de>,
	Tony Luck <tony.luck@intel.com>, linux-cris-kernel@axis.com,
	linuxppc-dev@ozlabs.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Patrick McHardy <kaber@trash.net>,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	linux-alpha@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-h/kN6/EO2DvGfQAWWQqy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-05-12 at 16:40 +0200, Christoph Egger wrote:
> Just noticed it might have been worth adding the output so everyone
> out there doesn't ned to grep through his tree for reference:
>=20
> % grep  ^config **/Kconfig* | sort | uniq -dc                            =
  =20

That didn't actually work for me?

>       2 arch/powerpc/Kconfig:config KERNEL_START
>       2 arch/powerpc/Kconfig:config PAGE_OFFSET
>       2 arch/powerpc/Kconfig:config PHYSICAL_START
>       2 arch/powerpc/Kconfig:config RELOCATABLE

The duplication of these is caused by the second definitions being
inside an "if PPC64" block.

For PAGE_OFFSET and KERNEL_START we want the 2nd definitions, the
default value is different between 32 & 64 bit.

For RELOCATABLE it's a little weird, but we want the 2nd definition
because the depends condition is different between 32 & 64bit - though
they could probably be merged.

I don't really see why we need two versions of PHYSICAL_START.

cheers

--=-h/kN6/EO2DvGfQAWWQqy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkvrUR0ACgkQdSjSd0sB4dJ7HwCgmCXXhb0zeKo4q5rwizaQsc1u
qnUAoKwiE9Qk0disa6OQAd42Mv7OowT2
=UXV0
-----END PGP SIGNATURE-----

--=-h/kN6/EO2DvGfQAWWQqy--
