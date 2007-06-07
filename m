Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 8BAA3DDECF
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 00:03:39 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: MPC8349ea Random Number Generator driver
Date: Thu, 7 Jun 2007 16:03:14 +0200
References: <BAY122-F20901751968A5E85E76FBB85260@phx.gbl>
In-Reply-To: <BAY122-F20901751968A5E85E76FBB85260@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706071603.15837.arnd@arndb.de>
Cc: sl@powerlinux.fr, Philippe Lachenal <philippe.lachenal@hotmail.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 07 June 2007, Philippe Lachenal wrote:
> +-
> +-=A0=A0=A0=A0=A0=A0return ioremap(res.start, 1 + res.end - res.start);
> +-}
>=20
>=20
> why is there a =A01+ res.end-res.start ? Am I wrong in not adding one in =
my=20
> code ?
>=20

Yes. The res.start is the first byte in the area, res.end is the last one.
=46or example, in a two byte range, start could be 100, and end 101.
res.end - res.start would therefore be one, not two as ioremap expects.

	Arnd <><
