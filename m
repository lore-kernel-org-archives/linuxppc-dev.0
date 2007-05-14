Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 14AC3DDE45
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 08:48:41 +1000 (EST)
Subject: Re: [PATCH] pcmcia: ppc64 needs 64-bit ioaddr_t
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20070514150802.b9120e9f.akpm@linux-foundation.org>
References: <20070512143105.GA12890@lixom.net>
	<20070514150802.b9120e9f.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Tue, 15 May 2007 08:47:04 +1000
Message-Id: <1179182824.32247.131.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linuxppc-dev@ozlabs.org, paulus@samba.org, Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-05-14 at 15:08 -0700, Andrew Morton wrote:
> 
> Well that's some pretty sad code you've found there.  The kernel
> surely has
> some appropriate type to use here without us having to invent a new
> one. 
> But I suspect if we were to rationalise things in there it will get
> messy.

There is more sad stuff involved with drivers assuming IO ports fit in
int. A proper fix for 2.6.23 will be the rework of PIO allocation I'm
doing. A temporary fix for 2.6.22 would be for Olof to use
reserve_phb_iospace() to make sure his PIO gets in the low 31 bits. We
need to add a spinlock to it though.

Ben.
