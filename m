Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 3BB80DDDF9
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Sep 2007 00:53:28 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 01/10] cpm2: Infrastructure code cleanup.
Date: Sat, 8 Sep 2007 16:48:53 +0200
References: <20070905192841.GA32441@ld0162-tx32.am.freescale.net>
In-Reply-To: <20070905192841.GA32441@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709081648.54960.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 05 September 2007, Scott Wood wrote:
>=20
> =A0void *cpm_dpram_addr(unsigned long offset)
> =A0{
> -=A0=A0=A0=A0=A0=A0=A0return (void *)(im_dprambase + offset);
> +=A0=A0=A0=A0=A0=A0=A0return (void __force *)(im_dprambase + offset);
> =A0}
> =A0EXPORT_SYMBOL(cpm_dpram_addr);

This does not look like a legitimate use of __force. I think it's better
to leave the warning in place for cases like this, so that someone else
can clean up the remaining users of this.

In this particular case, it seems that the function should either
be removed or changed to return an __iomem pointer so you get the
warning in the mac-fcc driver using it.

The rest of your patch looks great.

	Arnd <><
