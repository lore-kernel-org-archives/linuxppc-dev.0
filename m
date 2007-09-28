Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 3A849DDE1C
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 06:00:32 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 01/18] Virtex: Add uartlite bootwrapper driver
Date: Fri, 28 Sep 2007 21:45:08 +0200
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
	<20070928181551.18608.88418.stgit@trillian.cg.shawcable.net>
In-Reply-To: <20070928181551.18608.88418.stgit@trillian.cg.shawcable.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709282145.09411.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 28 September 2007, Grant Likely wrote:
> +static void uartlite_putc(unsigned char c)
> +{
> +=A0=A0=A0=A0=A0=A0=A0while ((in_be32(reg_base + 0x8) & 0x08) !=3D 0); /*=
 spin */
> +=A0=A0=A0=A0=A0=A0=A0out_be32(reg_base + 0x4, c);
> +}

When coding a spin-loop, it's better to do a cpu_relax() between
each attempt.

	Arnd <><
