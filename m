Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0132.outbound.protection.outlook.com [207.46.100.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1FC581A02E2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 13:57:12 +1100 (AEDT)
Message-ID: <1420599417.4961.48.camel@freescale.com>
Subject: Re: [RFC] PPC: MPIC: necessary readback after EOI?
From: Scott Wood <scottwood@freescale.com>
To: Andreas Mohr <andi@lisas.de>
Date: Tue, 6 Jan 2015 20:56:57 -0600
In-Reply-To: <20150105184322.GA30255@rhlx01.hs-esslingen.de>
References: <20150105174616.GA3159@rhlx01.hs-esslingen.de>
 <1420481454.4961.16.camel@freescale.com>
 <20150105184322.GA30255@rhlx01.hs-esslingen.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Purcareata Bogdan <b43198@freescale.com>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-01-05 at 19:43 +0100, Andreas Mohr wrote:
> [CC related ppl]
> 
> On Mon, Jan 05, 2015 at 12:10:54PM -0600, Scott Wood wrote:
> > On Mon, 2015-01-05 at 18:46 +0100, Andreas Mohr wrote:
> > > Hi,
> > > 
> > > > I was curious why the mpic_cpu_read(MPIC_INFO(CPU_WHOAMI)) was there in
> > > > the first place and if it's still needed. If it's still required, I
> > > > guess a better approach is to eliminate the call only if the kernel is
> > > > running on the KVM guest side, where the MPIC is emulated and no longer
> > > > requires a readback.
> > > 
> > > "Why not?"
> > > 
> > > A mechanism being "emulated"/"virtual" or not
> > > may not necessarily be much of a distinction (if at all!).
> > > The readback might be required
> > > to properly fulfill all requirements
> > > of a full state change protocol specification,
> > > which might easily be the case for both RS(*) and virtual hardware.
> > > And especially for virtual hardware
> > > such a "readback" event
> > > might be an extremely important "end of transaction" marker
> > > which may often be needed for freeing of temporary resources etc.
> > 
> > I'm not convinced that it's required in real silicon (though there are
> > many MPIC implementations which have their own quirks...), and I'm 100%
> > sure that it's not required in the QEMU/KVM implementation of MPIC.
> > 
> > It would have been nice if a code comment explained why it was doing the
> > readback...  I don't see any particular need to wait for EOI completion
> > here (unlike when masking).
> 
> Hmm, yeah.
> 
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/history/history.git
> git checkout v2.6.11
> git blame ./ppc64/kernel/mpic.c
> git show 378193eb
>     [PATCH] ppc64: Rewrite the openpic driver
> 
> +/* Send an EOI */
> +static inline void mpic_eoi(struct mpic *mpic)
> +{
> +       mpic_cpu_write(MPIC_CPU_EOI, 0);
> +       (void)mpic_cpu_read(MPIC_CPU_WHOAMI);
> +}
> 
> 
> -static void openpic_eoi(void)
> -{
> -       DECL_THIS_CPU;
> -
> -       CHECK_THIS_CPU;
> -       openpic_write(&OpenPIC->THIS_CPU.EOI, 0);
> -       /* Handle PCI write posting */
> -       (void)openpic_read(&OpenPIC->THIS_CPU.EOI);
> -}
> 
> 
> So, this does seem to be about PCI posted writes after all.
> Which begs the question whether all PIC hardware is connected via PCI bus,
> which... is not the case for emulated hardware at least, I'd think.
> 
> And it's somewhat unfortunate
> that the comment in fact was removed in that commit
> (perhaps reinstate this comment in all of the various mpic.c life forms?).

But even for PCI, why do we need to wait for this write to complete?
Back in the arch/ppc days ppc_md.get_irq() was called in a loop, so it
would make sense that we'd need the next IRQ to be ready by the time
it's called again, but now that there's no get_irq() loop we shouldn't
need to wait.

-Scott
