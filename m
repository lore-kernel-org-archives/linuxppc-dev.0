Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 599C1DDDD5
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 08:56:45 +1000 (EST)
Date: Mon, 14 May 2007 17:59:46 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] pcmcia: ppc64 needs 64-bit ioaddr_t
Message-ID: <20070514225946.GB4191@lixom.net>
References: <20070512143105.GA12890@lixom.net>
	<20070514150802.b9120e9f.akpm@linux-foundation.org>
	<1179182824.32247.131.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1179182824.32247.131.camel@localhost.localdomain>
From: olof@lixom.net (Olof Johansson)
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 15, 2007 at 08:47:04AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2007-05-14 at 15:08 -0700, Andrew Morton wrote:
> > 
> > Well that's some pretty sad code you've found there.  The kernel
> > surely has
> > some appropriate type to use here without us having to invent a new
> > one. 
> > But I suspect if we were to rationalise things in there it will get
> > messy.
> 
> There is more sad stuff involved with drivers assuming IO ports fit in
> int. A proper fix for 2.6.23 will be the rework of PIO allocation I'm
> doing. A temporary fix for 2.6.22 would be for Olof to use
> reserve_phb_iospace() to make sure his PIO gets in the low 31 bits. We
> need to add a spinlock to it though.

Yes, we should do fine with just a 32-bit type and my CF driver being
fixed. I've been travelling and catching up with other things today,
I should have something to post tomorrow.

Andrew, you can drop this patch for now. Sorry for the churn.


-Olof
