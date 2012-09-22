Return-Path: <paubert@iram.es>
Received: from villa.puc.rediris.es (unknown [IPv6:2001:720:418:ca00::7])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CD55F2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Sep 2012 21:28:40 +1000 (EST)
Date: Sat, 22 Sep 2012 12:21:51 +0200
From: Gabriel Paubert <paubert@iram.es>
To: malc <av1474@comtv.ru>
Subject: Re: Probing for native availability of isel from userspace
Message-ID: <20120922102151.GA31314@visitor2.iram.es>
References: <alpine.LNX.2.00.1209212355050.8539@linmac>
 <50EE7AAC-3080-4B1B-B741-E3F7F5A57A73@kernel.crashing.org>
 <alpine.LNX.2.00.1209221412010.1468@linmac>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.00.1209221412010.1468@linmac>
Cc: linuxppc-dev@lists.ozlabs.org, hollis@penguinppc.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Sep 22, 2012 at 02:12:42PM +0400, malc wrote:
> On Sat, 22 Sep 2012, Segher Boessenkool wrote:
> 
> > > Is it possible to determine if _native_ isel is available from userspace
> > > somehow?
> > 
> > Just try to execute one and catch the SIGILL?
> > 
> 
> Unfortunately my kernel emulates ISEL for me in this case, so i don't
> get any SIGILLs.

Perform a few isels in a loop between a couple of mftb and measure the 
shortest time it takes. Any emulation will take tens of timebase ticks,
hardware implementation will return very small values, perhaps even
0 depending on the relationship between core and timebase frequencies.

I don't remember whether it's necessary inserting an isync between the
two mftb. I believe that even on the most OOO machines, two mftb in
a row will not be reordered to the point that the second executes before 
the first.

	Gabriel
