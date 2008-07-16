Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 41244DDF0A
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 18:51:52 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [git pull] Please pull from powerpc.git merge branch
Date: Wed, 16 Jul 2008 10:51:11 +0200
References: <1216172043.7740.136.camel@pasglop>
	<20080716042042.GA13212@redhat.com>
In-Reply-To: <20080716042042.GA13212@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807161051.12545.arnd@arndb.de>
Cc: Dave Jones <davej@redhat.com>, akpm <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 16 July 2008, Dave Jones wrote:
> arch/powerpc/platforms/built-in.o: In function `ep8248e_mdio_probe':
> /builddir/build/BUILD/kernel-2.6.26/linux-2.6.26.ppc/arch/powerpc/platforms/82xx/ep8248e.c:129: undefined reference to `alloc_mdio_bitbang'
> /builddir/build/BUILD/kernel-2.6.26/linux-2.6.26.ppc/arch/powerpc/platforms/82xx/ep8248e.c:143: undefined reference to `mdiobus_register'

FS_ENET and EP8248E both select MDIO_BITBANG, but not PHYLIB or MII, which
looks broken to me.

Also, I think it would be useful to split out the bitbang
driver from ep8248e.c, so that you can build it as a loadable
module if you want to have PHYLIB loadable.

	Arnd <><
