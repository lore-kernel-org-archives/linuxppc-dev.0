Return-Path: <paubert@iram.es>
Received: from rudy.puc.rediris.es (rudy.puc.rediris.es [130.206.18.132])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F0E571A02DE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 22:05:42 +1100 (AEDT)
Date: Thu, 10 Mar 2016 12:04:14 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Scott Wood <oss@buserror.net>
Cc: Alessio Igor Bogani <alessio.bogani@elettra.eu>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [1/1] powerpc/embedded6xx: Make reboot works on MVME5100
Message-ID: <20160310110414.GB14842@visitor2.iram.es>
References: <1457423952-13014-1-git-send-email-alessio.bogani@elettra.eu>
 <20160309063818.GA10069@home.buserror.net>
 <20160309102855.GA12303@visitor2.iram.es>
 <1457558781.5360.149.camel@buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457558781.5360.149.camel@buserror.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 09, 2016 at 03:26:21PM -0600, Scott Wood wrote:
> On Wed, 2016-03-09 at 11:28 +0100, Gabriel Paubert wrote:
> > On Wed, Mar 09, 2016 at 12:38:18AM -0600, Scott Wood wrote:
> > > On Tue, Mar 08, 2016 at 08:59:12AM +0100, Alessio Igor Bogani wrote:
> > > > The mtmsr() function hangs during restart. Make reboot works on
> > > > MVME5100 removing that function call.
> > > > ---
> > > >  arch/powerpc/platforms/embedded6xx/mvme5100.c | 2 --
> > > >  1 file changed, 2 deletions(-)
> > > 
> > > Missing signoff
> > > 
> > > Do you know why MSR_IP was there to begin with? 
> > 
> > Huh? The patch sets MSR_IP for reset but it is cleared while running Linux.
> > I don't have any MVME5100, however I do have MVME2400/2700 with the same
> > bridge (Hawk), so I can say that the address space layout is quite standard:
> > memory at 0, ROM at the high end of the 32-bit address space. However the
> > reset method is quite different (no external register set on the Hawk).
> 
> I meant why the line of code was there, not why the bit was ever set.  It
> seems odd to me that the pre-reset value of MSR would matter at all --
> shouldn't it get reset along with the rest of the CPU, as you later suggest? 

I don't know, it may create a soft reset. I have the board documentation
and it is not clear (at least not 100% clear to me) whether this reset 
drives the HRESET of SRESET pin, although HRESET is more likely.

>  And if it does matter, then why are Alessio and whoever wrote the code
> (assuming it wasn't an untested copy-and-paste from somewhere else) seeing
> different results regarding whether IP needs to be set or unset?

The different results are perfectly explained by taking a DSI exception
on accessing *restart (the only access to this address in the whole
code, so the hash table has to be filled at this time). With MSR_IP set, 
DSI exception goes to 0xfff00300, and then probably hangs.

> 
> > > Does this board have a switch that determines whether boot vectors 
> > > are high or low (I remember some 83xx boards that did), in which 
> > > case is this fixing one config by breaking another?
> > 
> > For the switch, no AFAICT. And the code is MVME5100 specific so I
> > suspect that it is very unlikely to break other boards.
> >
> > Very likely the source of the problem is that the restart address is
> > remapped 
> > (ioremap) but never accessed while the kernel is running (the only access to
> > *restart is in the reboot routine) so we take a DSI exception to fill the
> > hash 
> > table when attempting to reboot. 
> >
> > It would be enough to move the setting of MSR_IP until after triggering the 
> > restart, but this performs a hard reset of the CPU, which will set MSR_IP 
> > anyway (granted that the CPU will probably set MSR_IP way before the reset 
> > signal comes in).
> 
> How can you perform anything after the reset is triggered?  There might be
> some lag before it takes effect, but depending on that seems hackish and
> unreliable, and why would it make a difference?

It would make a difference if this reset is connected to SRESET, which
does not affect MSR_IP.

> 
> > One way to check this hypothesis would be to introduce a write of 0 to
> > the restart address before setting MSR_IP.
> 
> I'm not familiar with the register interface for this board logic, but what
> would that demonstrate?

Writing a 0 would not trigger the reset, but ensure that the hash table
is filled, then you can change MSR_IP and perform the real reset, and be
sure that you'll end up executing the reset in FLASH, not in RAM.

The alternative solution it to put code at 0x100 that
sets MSR_IP and branches to 0xfff00100.

> 
> > This said restart is declared as u_char *, so the cast in the out_8 
> > register access is useless and ugly.
> 
> Yes, and restart should be __iomem.

Indeed.

    Gabriel
