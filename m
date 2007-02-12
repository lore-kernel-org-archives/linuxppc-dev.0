Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id B0DAEDDE04
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2007 23:44:25 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [POWERPC] Wire up sys_getcpu
Date: Mon, 12 Feb 2007 13:43:38 +0100
References: <20070212220918.496afa83.sfr@canb.auug.org.au>
In-Reply-To: <20070212220918.496afa83.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702121343.39137.arnd@arndb.de>
Cc: Jeremy Kerr <jeremyke@au1.ibm.com>, ppc-dev <linuxppc-dev@ozlabs.org>,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 12 February 2007 12:09, Stephen Rothwell wrote:
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
> =A0include/asm-powerpc/systbl.h | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>=20
> Arnd, should this be _SPU?

Good question. There is nothing wrong with having the SPU call this,
i.e. it won't break stuff. The question is more if it should return
an SPU number instead of a CPU number. I've had people ask for
a feature like that in the past.

The node information returned from the call usually is the same for
the CPU and the SPU, but we don't guarantee that, unless the user
has specified node affinity.

I don't see a 'right' answer for your question, but I'd say let's
not forbid the user to call it and make it _SPU, even if it is
pointless.

	Arnd <><
