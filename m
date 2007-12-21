Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id ACD99DDE41
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 06:36:42 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH -mm 18/43] powerpc compat_binfmt_elf
Date: Fri, 21 Dec 2007 20:36:27 +0100
References: <20071220115200.C767E26F98A@magilla.localdomain>
	<20071221085609.4D53B26F98A@magilla.localdomain>
	<20071221175106.GB17656@fattire.cabal.ca>
In-Reply-To: <20071221175106.GB17656@fattire.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712212036.29098.arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 21 December 2007, Kyle McMartin wrote:
> Just taking a stab that hch means,
>=20
> config BINFMT_COMPAT_ELF
> =A0=A0=A0=A0=A0=A0=A0=A0def_bool n
> =A0=A0=A0=A0=A0=A0=A0=A0depends on 64BIT
>=20

I'd call it COMPAT_BINFMT_ELF, for consistency with the file name.
Also, the definition and the depends are redundant if you expect the
option to be autoselected. You can do either of

config COMPAT_BINFMT_ELF
	bool

or=20

config COMPAT_BINFMT_ELF
	def_bool y
	depends on COMPAT

The second option makes sense at the point where all architectures with
compat code are using the same compat_binfmt_elf code.

	Arnd <><
