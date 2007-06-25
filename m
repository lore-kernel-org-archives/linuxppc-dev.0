Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 10FC9DDF01
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2007 11:36:50 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] pcmcia: ppc64 needs 32-bit ioaddr_t
Date: Mon, 25 Jun 2007 03:35:56 +0200
References: <20070625005439.GA31289@lixom.net>
In-Reply-To: <20070625005439.GA31289@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706250335.56739.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, akpm@osdl.org,
	linux-pcmcia@lists.infradead.org, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 25 June 2007, Olof Johansson wrote:
> ppc64 really needs ioaddr_t to be 32-bit, since I/O addresses really are
> MMIO addresses, and remapped at an offset that's well above 16 bits in
> some cases.
> 
> While the type is exported to userspace, there hasn't been any platforms
> with PCMCIA on 64-bit powerpc until now, so changing it won't regress
> any existing users.

I just realized that this argument is bogus, because the user space tools
are probably, or at least potentially, built as 32 bit binaries, which
means that any interface using these _will_ break.

However, I could not find any actual user space interfaces in 2.6.22-rc
that are built around ioaddr_t. What are they, or have the been removed
by now?

	Arnd <><
