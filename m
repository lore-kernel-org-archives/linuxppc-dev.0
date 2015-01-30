Return-Path: <paubert@iram.es>
Received: from rudy.puc.rediris.es (rudy.puc.rediris.es
 [IPv6:2001:720:418:ca01::132])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D5CE1A0DCD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 20:09:58 +1100 (AEDT)
Date: Fri, 30 Jan 2015 09:49:45 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Markus Stockhausen <stockhausen@collogia.de>
Subject: Re: AW: SPE & Interrupt context (was how to make use of SPE
 instructions)
Message-ID: <20150130084945.GA27784@visitor2.iram.es>
References: <12EF8D94C6F8734FB2FF37B9FBEDD1735F915B69@EXCHANGE.collogia.de>
 <1422418883.10544.73.camel@freescale.com>
 <12EF8D94C6F8734FB2FF37B9FBEDD1735F9160AA@EXCHANGE.collogia.de>
 <1422578995.10544.138.camel@freescale.com>
 <12EF8D94C6F8734FB2FF37B9FBEDD1735F916CCB@EXCHANGE.collogia.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <12EF8D94C6F8734FB2FF37B9FBEDD1735F916CCB@EXCHANGE.collogia.de>
Cc: Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Herbert Xu <herbert@gondor.apana.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 30, 2015 at 05:37:29AM +0000, Markus Stockhausen wrote:
> > Von: Scott Wood [scottwood@freescale.com]
> > Gesendet: Freitag, 30. Januar 2015 01:49
> > An: Markus Stockhausen
> > Cc: Michael Ellerman; linuxppc-dev@lists.ozlabs.org; Herbert Xu
> > Betreff: Re: AW: SPE & Interrupt context (was how to make use of SPE instructions)
> > 
> > On Wed, 2015-01-28 at 05:00 +0000, Markus Stockhausen wrote:
> > > > > Von: Scott Wood [scottwood@freescale.com]
> > > > > Gesendet: Mittwoch, 28. Januar 2015 05:21
> > > > > An: Markus Stockhausen
> > > > > Cc: Michael Ellerman; linuxppc-dev@lists.ozlabs.org; Herbert Xu
> > > > > Betreff: Re: SPE & Interrupt context (was how to make use of SPE instructions)
> > > > >
> > > > > Hi Scott,
> > > > >
> > > > > thanks for your helpful feedback. As you might have seen I sent a first
> > > > > patch for the sha256 kernel module that takes care about preemption.
> > > > >
> > > > > Herbert Xu noticed that my module won't run in for IPsec as all
> > > > > work will be done from interrupt context. Do you have a tip how I can
> > > > > mitigate the check I implemented:
> > > > >
> > > > > static bool spe_usable(void)
> > > > > {
> > > > >   return !in_interrupt();
> > > > > }
> > > > >
> > > > > Intel guys have something like that
> > > > >
> > > > > bool irq_fpu_usable(void)
> > > > > {
> > > > >   return !in_interrupt() ||
> > > > >     interrupted_user_mode() ||
> > > > >     interrupted_kernel_fpu_idle();
> > > > > }
> > > > >
> > > > > But I have no idea how to transfer it to the PPC/SPE case.
> > > >
> > > > I'm not sure what sort of tip you're looking for, other than
> > > > implementing it myself. :-)
> > >
> > > Hi Scott,
> > >
> > > maybe I did not explain it correctly. interrupted_kernel_fpu_idle()
> > > is x86 specific. The same applies to interrupted_user_mode().
> > > I'm just searching for a similar feature in the PPC/SPE world.
> > 
> > There isn't one.
> > 
> > > I can see that enable_kernel_spe() does something with the
> > > MSR_SPE flag, but I have no idea  how to determine if I'm allowed
> > > to enable SPE although I'm inside an interrupt context.
> > 
> > As with x86, you'd want to check whether the kernel interrupted
> > userspace.  I don't know what x86 is doing with TS, but on PPC you might
> > check whether the interrupted thread had MSR_FP enabled.
> > 
> > > I'm asking because from the previous posts I conclude that
> > > running SPE instructions inside an interrupt might be critical.
> > > Because of registers not being saved?
> > 
> > Yes.  Currently callers of enable_kernel_spe() only need to disable
> > preemption, not interrupts.
> > 
> > > Or can I just save the register contents myself and interrupt
> > > context is no longer a showstopper?
> > 
> > If you only need a small number of registers that might be reasonable,
> > but if you need a bunch then you don't want to save them when you don't
> > have to.
> > 
> > Another option is to change enable_kernel_spe() to require interrupts to
> > be disabled.
> 
> Phew, that is going deeper than I expected. 
> 
> I'm a newbie in the topic of interrupts and FPU/SPE registers. Nevertheless
> enforcing enable_kernel_spe() to only be available outside of interrupt
> context sounds too restrictive for me. Also checking for thread/CPU flags 
> of an interrupted process is nothing I can or want to implement. There
> might be the risk that I'm starting something that will be too complex
> for me.
> 
> BUT! Given the fact that SPE registers are only extended GPRs and my
> algorithm needs just 10 of them I can live with the following design.
> 
> - I must already save several non-volatile registers. Putting the 64 bit values 
> into them would require me to save their contents with evstdd instead of 
> stw. Of course stack alignment to 8 bytes required. So only a few alignment
> instructions needed additionally during initialization.

On most PPC ABI the stack is guaranteed to be aligned to a 16 byte
boundary. In some it may be only 8, but I can't remember any 4 byte
only alignment.

I checked my 32 bit kernel images with:

objdump -d vmlinux |awk '/stwu.*r1,/{print $6,$7}'|sort -u

and the stack seems to always be 16 byte aligned.
For 64 bit, use stdu instead of stwu.

I've also found a few stwux/stdux which are hopefully known
to be harmless.

> 
> - During function cleanup I will restore the registers the same way.
> 
> - In case I interrupted myself, I might have saved sensitive data of another 
> thread on my stack. So I will zero that area after I restored the registers.
> That needs an additional 10 instructions. In contrast to ~2000 instructions
> for one sha256 round that should be neglectable.
> 
> This little overhead will save me lots of trouble at other locations:
> 
> - I can avoid checking for an interrupt context.
> 
> - I don't need a fallback to the generic implementation. 
> 
> Thinking about it more and more I think I performance will stay the same. 
> Can you confirm that this will work? If yes I will send a v2 patch.
> 
> Markus

    Gabriel
