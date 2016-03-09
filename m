Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 04A761A0033
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 08:26:32 +1100 (AEDT)
Message-ID: <1457558781.5360.149.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Gabriel Paubert <paubert@iram.es>
Cc: Alessio Igor Bogani <alessio.bogani@elettra.eu>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Wed, 09 Mar 2016 15:26:21 -0600
In-Reply-To: <20160309102855.GA12303@visitor2.iram.es>
References: <1457423952-13014-1-git-send-email-alessio.bogani@elettra.eu>
 <20160309063818.GA10069@home.buserror.net>
 <20160309102855.GA12303@visitor2.iram.es>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [1/1] powerpc/embedded6xx: Make reboot works on MVME5100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-03-09 at 11:28 +0100, Gabriel Paubert wrote:
> On Wed, Mar 09, 2016 at 12:38:18AM -0600, Scott Wood wrote:
> > On Tue, Mar 08, 2016 at 08:59:12AM +0100, Alessio Igor Bogani wrote:
> > > The mtmsr() function hangs during restart. Make reboot works on
> > > MVME5100 removing that function call.
> > > ---
> > >  arch/powerpc/platforms/embedded6xx/mvme5100.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > 
> > Missing signoff
> > 
> > Do you know why MSR_IP was there to begin with? 
> 
> Huh? The patch sets MSR_IP for reset but it is cleared while running Linux.
> I don't have any MVME5100, however I do have MVME2400/2700 with the same
> bridge (Hawk), so I can say that the address space layout is quite standard:
> memory at 0, ROM at the high end of the 32-bit address space. However the
> reset method is quite different (no external register set on the Hawk).

I meant why the line of code was there, not why the bit was ever set.  It
seems odd to me that the pre-reset value of MSR would matter at all --
shouldn't it get reset along with the rest of the CPU, as you later suggest? 
 And if it does matter, then why are Alessio and whoever wrote the code
(assuming it wasn't an untested copy-and-paste from somewhere else) seeing
different results regarding whether IP needs to be set or unset?

> > Does this board have a switch that determines whether boot vectors 
> > are high or low (I remember some 83xx boards that did), in which 
> > case is this fixing one config by breaking another?
> 
> For the switch, no AFAICT. And the code is MVME5100 specific so I
> suspect that it is very unlikely to break other boards.
>
> Very likely the source of the problem is that the restart address is
> remapped 
> (ioremap) but never accessed while the kernel is running (the only access to
> *restart is in the reboot routine) so we take a DSI exception to fill the
> hash 
> table when attempting to reboot. 
>
> It would be enough to move the setting of MSR_IP until after triggering the 
> restart, but this performs a hard reset of the CPU, which will set MSR_IP 
> anyway (granted that the CPU will probably set MSR_IP way before the reset 
> signal comes in).

How can you perform anything after the reset is triggered?  There might be
some lag before it takes effect, but depending on that seems hackish and
unreliable, and why would it make a difference?

> One way to check this hypothesis would be to introduce a write of 0 to
> the restart address before setting MSR_IP.

I'm not familiar with the register interface for this board logic, but what
would that demonstrate?

> This said restart is declared as u_char *, so the cast in the out_8 
> register access is useless and ugly.

Yes, and restart should be __iomem.

-Scott
