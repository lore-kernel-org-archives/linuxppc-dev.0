Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id F3DD1DDF34
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 09:39:31 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 13/14] powerpc: add ps3 platform system bus support
Date: Wed, 2 May 2007 01:39:22 +0200
References: <4563D02F.9010307@am.sony.com> <20070430155823.GA30344@aepfle.de>
	<1178001851.3085.137.camel@pmac.infradead.org>
In-Reply-To: <1178001851.3085.137.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705020139.23402.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>, Olaf Hering <olaf@aepfle.de>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 01 May 2007, David Woodhouse wrote:
> I have no particular objection to this, but would observe that it's more
> normal to have the number->name mapping done in userspace by modprobe,
> rather than inside the kernel.

I have one ;-)

> For now I'd just added explicit aliases like 'MODULE_ALIAS("ps3:3");' to
> the modules in question, because I hadn't yet worked out how to do all
> the mod_devicetable stuff to pick it out of the match_id in the driver
> structure.

I think the simple numbering is far more straightforward, because this
way the bus doesn't need to know about what devices can be connected
to it. The way that Olaf's patch does it, every new device type that
may get added in the future needs both a device driver and a change to
the bus code, while the other way, we can simply add a new driver.

	Arnd <><
