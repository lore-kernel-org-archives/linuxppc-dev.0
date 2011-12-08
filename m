Return-Path: <fthain@telegraphics.com.au>
Received: from vps4.telegraphics.com.au (vm4.telegraphics.com.au
 [98.124.60.149]) by ozlabs.org (Postfix) with ESMTP id 03DEC1007D7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2011 22:27:00 +1100 (EST)
Date: Thu, 8 Dec 2011 22:26:46 +1100 (EST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 01/16 v3] pmac_zilog: fix unexpected irq
In-Reply-To: <1323318638.12793.23.camel@pasglop>
Message-ID: <alpine.LNX.2.00.1112082128330.2357@nippy.intranet>
References: <20111023141108.856998818@telegraphics.com.au>
 <20111023141115.208699274@telegraphics.com.au>
 <alpine.LNX.2.00.1112070203310.14968@nippy.intranet>
 <alpine.LNX.2.00.1112071427280.28552@nippy.intranet>
 <1323318004.12793.21.camel@pasglop>
 <1323318638.12793.23.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, linux-m68k@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Thu, 8 Dec 2011, Benjamin Herrenschmidt wrote:

> On Thu, 2011-12-08 at 15:20 +1100, Benjamin Herrenschmidt wrote:
> 
> > So basic operations seem to work, I've applied the patch to 
> > powerpc-next.

Then I guess Geert should not push this for 3.3 -- or does it make no 
difference?

> > However, the internal modem on my Pismo powerbook doesn't appear to 
> > survive suspend/resume. I'll dig into that and merge a fixup patch 
> > asap.
> 
> BTW. I applied anyway because suspend/resume was already broken (you 
> spotted that we don't clear the suspended flag for example).
> 
> Fixing the flag alone helps a bit. We can't use the modem if we 
> suspend/resume with the open port,

If the SCC IRQ counters change across suspend/resume, perhaps the modem 
itself is not powering up...

> but closing and re-opening works.

Maybe the modem wants a transition on DTR or similar, but it hasn't had 
time to initialise when that happens during SCC resumption.

If so, calling pmz_shutdown() then pmz_startup() from the tail of 
pmz_resume() without delay should probably fail to revive it...

> 
> Lockdep also picked-up a A->B B->A between the port mutex and the pmz 
> irq mutex on suspend.
> 
> I'll try to fix all these, and will let you know (I may not have time 
> today).

Thanks.

Finn

> 
> Cheers,
> Ben.
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
