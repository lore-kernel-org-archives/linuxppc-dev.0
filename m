Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id F2E26DDEC5
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 07:53:18 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] pasemi: Kconfig for mdio_gpio
Date: Tue, 24 Apr 2007 23:53:06 +0200
References: <20070424175834.GA7985@lixom.net>
In-Reply-To: <20070424175834.GA7985@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704242353.07286.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 24 April 2007, Olof Johansson wrote:
> +config PPC_PASEMI_MDIO
> +=A0=A0=A0=A0=A0=A0=A0depends on PPC_PASEMI
> +=A0=A0=A0=A0=A0=A0=A0bool "MDIO support via GPIO"
> +=A0=A0=A0=A0=A0=A0=A0default y
> +=A0=A0=A0=A0=A0=A0=A0select PHYLIB
> +=A0=A0=A0=A0=A0=A0=A0help
> +=A0=A0=A0=A0=A0=A0=A0 =A0Driver for MDIO via GPIO on PWRficient platforms
> +

Looks still wrong. I stumbled over the original bug because in fedora,
CONFIG_PHYLIB=3Dm. When you make PPC_PASEMI_MDIO a bool, it will
force PHYLIB=3Dy, which is potentially undesired.

Can you make this a modular driver (tristate)?

Instead of making it select PHYLIB directly, it might be more
straightforward to make PPC_PASEMI_MDIO depend on PHYLIB
and have the actual network driver select both PPC_PASEMI_MDIO
and PHYLIB.

	Arnd <><
