Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CD5CC1007D1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2011 06:44:20 +1100 (EST)
Message-ID: <1323373449.12793.40.camel@pasglop>
Subject: Re: [PATCH 01/16 v3] pmac_zilog: fix unexpected irq
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Finn Thain <fthain@telegraphics.com.au>
Date: Fri, 09 Dec 2011 06:44:09 +1100
In-Reply-To: <alpine.LNX.2.00.1112082128330.2357@nippy.intranet>
References: <20111023141108.856998818@telegraphics.com.au>
 <20111023141115.208699274@telegraphics.com.au>
 <alpine.LNX.2.00.1112070203310.14968@nippy.intranet>
 <alpine.LNX.2.00.1112071427280.28552@nippy.intranet>
 <1323318004.12793.21.camel@pasglop> <1323318638.12793.23.camel@pasglop>
 <alpine.LNX.2.00.1112082128330.2357@nippy.intranet>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Thu, 2011-12-08 at 22:26 +1100, Finn Thain wrote:
> 
> Maybe the modem wants a transition on DTR or similar, but it hasn't had 
> time to initialise when that happens during SCC resumption.
> 
> If so, calling pmz_shutdown() then pmz_startup() from the tail of 
> pmz_resume() without delay should probably fail to revive it... 

Well, we power the modem down and back up... but it's possible that we
fail to re-enable something, I'll check. That used to work (at least
with macserial, maybe I never tried this specific torture with pmz...).
I'll figure it out eventually.

Cheers,
Ben.
