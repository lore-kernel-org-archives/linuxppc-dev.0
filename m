Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH] force -mno-string option on cell
Date: Fri, 23 Mar 2007 21:46:20 +0100
References: <1174544624.10836.24.camel@localhost.localdomain>
	<20070323120619.GA7472@localhost.localdomain>
	<d7a191672b71056daf28a7c93c4e969c@kernel.crashing.org>
In-Reply-To: <d7a191672b71056daf28a7c93c4e969c@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703232146.21224.arnd@arndb.de>
Cc: Akinobu Mita <mita@fixstars.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 23 March 2007, Segher Boessenkool wrote:

> =A0=A0=A0=A0=A0=A0=A0=A0CFLAGS_whatever.o :=3D -msome-flags
>=20
> It would be even better to not lie to the compiler by
> telling it it can use the LS area as normal memory, since
> evidently it cannot :-)

Yes, this is the important point. I actually think the first
patch that just replaces memcpy with memcpy_fromio is the
right solution for the specific problem.

Avoiding certain instructions in the kernel may be a good
thing to do as well, but this is not at all a cell specific
thing.

Maybe we should have a more detailed CPU selection Kconfig
option like

CPU Family
   * 64 bit common (power3/4/5/6, ppc970, cell, *star)
   * 32 bit common (6xx, 82xx, 83xx, 86xx)
   * 40x/44x
   * ...

Minimum supported CPU (gcc -march=3D, depending on above selection)
   * 603
   * 604
   * 750
   * power3
   * power4
   * 970

Optimize for CPU (gcc -mtune)
   (subset of the -march list as before)

	Arnd <><
