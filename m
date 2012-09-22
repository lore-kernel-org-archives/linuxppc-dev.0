Return-Path: <av1474@comtv.ru>
Received: from akado.ru (fe02x03-cgp.akado.ru [77.232.31.165])
 by ozlabs.org (Postfix) with ESMTP id EEC962C008E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Sep 2012 01:37:17 +1000 (EST)
Date: Sat, 22 Sep 2012 19:37:03 +0400 (MSK)
From: malc <av1474@comtv.ru>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: Probing for native availability of isel from userspace
In-Reply-To: <20120922102151.GA31314@visitor2.iram.es>
Message-ID: <alpine.LNX.2.00.1209221936330.3878@linmac>
References: <alpine.LNX.2.00.1209212355050.8539@linmac>
 <50EE7AAC-3080-4B1B-B741-E3F7F5A57A73@kernel.crashing.org>
 <alpine.LNX.2.00.1209221412010.1468@linmac>
 <20120922102151.GA31314@visitor2.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, hollis@penguinppc.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 22 Sep 2012, Gabriel Paubert wrote:

> On Sat, Sep 22, 2012 at 02:12:42PM +0400, malc wrote:
> > On Sat, 22 Sep 2012, Segher Boessenkool wrote:
> > 
> > > > Is it possible to determine if _native_ isel is available from userspace
> > > > somehow?
> > > 
> > > Just try to execute one and catch the SIGILL?
> > > 
> > 
> > Unfortunately my kernel emulates ISEL for me in this case, so i don't
> > get any SIGILLs.
> 
> Perform a few isels in a loop between a couple of mftb and measure the 
> shortest time it takes. Any emulation will take tens of timebase ticks,
> hardware implementation will return very small values, perhaps even
> 0 depending on the relationship between core and timebase frequencies.
> 
> I don't remember whether it's necessary inserting an isync between the
> two mftb. I believe that even on the most OOO machines, two mftb in
> a row will not be reordered to the point that the second executes before 
> the first.
> 

Thanks for suggestion, but i'd rather not play with heuristics.

-- 
mailto:av1474@comtv.ru
