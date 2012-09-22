Return-Path: <dgibson@ozlabs.org>
Date: Sun, 23 Sep 2012 02:13:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: malc <av1474@comtv.ru>
Subject: Re: Probing for native availability of isel from userspace
Message-ID: <20120922161331.GA9800@truffula.fritz.box>
References: <alpine.LNX.2.00.1209212355050.8539@linmac>
 <50EE7AAC-3080-4B1B-B741-E3F7F5A57A73@kernel.crashing.org>
 <alpine.LNX.2.00.1209221412010.1468@linmac>
 <20120922102151.GA31314@visitor2.iram.es>
 <alpine.LNX.2.00.1209221936330.3878@linmac>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.00.1209221936330.3878@linmac>
Cc: linuxppc-dev@lists.ozlabs.org, hollis@penguinppc.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Sep 22, 2012 at 07:37:03PM +0400, malc wrote:
> On Sat, 22 Sep 2012, Gabriel Paubert wrote:
> 
> > On Sat, Sep 22, 2012 at 02:12:42PM +0400, malc wrote:
> > > On Sat, 22 Sep 2012, Segher Boessenkool wrote:
> > > 
> > > > > Is it possible to determine if _native_ isel is available from userspace
> > > > > somehow?
> > > > 
> > > > Just try to execute one and catch the SIGILL?
> > > > 
> > > 
> > > Unfortunately my kernel emulates ISEL for me in this case, so i don't
> > > get any SIGILLs.
> > 
> > Perform a few isels in a loop between a couple of mftb and measure the 
> > shortest time it takes. Any emulation will take tens of timebase ticks,
> > hardware implementation will return very small values, perhaps even
> > 0 depending on the relationship between core and timebase frequencies.
> > 
> > I don't remember whether it's necessary inserting an isync between the
> > two mftb. I believe that even on the most OOO machines, two mftb in
> > a row will not be reordered to the point that the second executes before 
> > the first.
> 
> Thanks for suggestion, but i'd rather not play with heuristics.

It sounds like the sort of thing that ought to be in the ELF aux
vector, but I don't know if it actually is.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
