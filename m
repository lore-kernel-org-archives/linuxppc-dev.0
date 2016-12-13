Return-Path: <npiggin@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3td8Nv6bb5zDt0J
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 17:06:55 +1100 (AEDT)
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3td8Nv1G7tz9t14
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2016 17:06:55 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id c4so5476118pfb.3
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Dec 2016 22:06:55 -0800 (PST)
Date: Tue, 13 Dec 2016 16:06:41 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [powerpc/nmi: RFC 2/2] Keep interrupts enabled even on soft
 disable
Message-ID: <20161213160641.47a6332d@roar.ozlabs.ibm.com>
In-Reply-To: <1481607371.11971.1.camel@gmail.com>
References: <20161212095003.1885-1-bsingharora@gmail.com>
 <20161212095003.1885-3-bsingharora@gmail.com>
 <20161212233111.1712ba79@roar.ozlabs.ibm.com>
 <1481607371.11971.1.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 13 Dec 2016 16:36:11 +1100
Balbir Singh <bsingharora@gmail.com> wrote:

> On Mon, 2016-12-12 at 23:31 +1000, Nicholas Piggin wrote:
> > On Mon, 12 Dec 2016 20:50:03 +1100
> > Balbir Singh <bsingharora@gmail.com> wrote:
> >   
> > > This patch removes the disabling of interrupts
> > > in soft-disable mode, when interrupts are received
> > > (in lazy mode). The new scheme keeps the interrupts
> > > enabled when we receive an interrupt and does the
> > > following
> > > 
> > > a. On decrementer interrupt, instead of setting
> > > dec to maximum and returning, we do the following
> > >   i. Call a function handle_nmi_dec, which in
> > >      turn calls handle_soft_nmi
> > >   ii. handle_soft_nmi sets the decrementer value
> > >       to 1 second and checks if more than 30
> > >       seconds have passed since starting it. If
> > >       so it calls BUG_ON(1), we can do an NMI
> > >       panic as well.
> > > b. When an external interrupt is received, we
> > >    store the interrupt in local_paca via
> > >    ppc_md.get_irq(). Later when interrupts are
> > >    enabled and replayed, we reuse the stored
> > >    interrupt and process it via generic_handle_irq  
> > 
> > This seems pretty good. My NMI handler should plug in just
> > the same to the masked decrementer, so that wouldn't be a
> > problem.  
> 
> Thats good to know, I believe so as well.
> 
> <snip>
> 
> > > while soft-disable */
> > > +	u32 irq;			/* IRQ pending */
> > >  	u8 nap_state_lost;		/* NV GPR values lost in
> > > power7_idle */
> > >  	u64 sprg_vdso;			/* Saved user-
> > > visible sprg */  
> > 
> > Can you avoid some padding if you move it to below irq_happened?
> >  
> 
> Will do
>  
> > > +EXC_COMMON(handle_nmi_dec, 0x900, handle_soft_nmi)
> > > +EXC_COMMON(elevate_save_irq, 0x500, handle_elevated_irq)  
> > 
> > I wonder if the name should match the type of interrupt rather than
> > implementation detail (elevated?), and match the existing handlers
> > e.g, hardware_interrupt_masked common handler could call
> > do_IRQ_masked.
> >  
> 
> Sure, will rename them
>  
> > As for the NMI, I would prefer just to keep it out of the timer path
> > completely and schedule a Linux timer for it as I had.
> > 
> > Otherwise, this looks nice if it does the right thing with the
> > interrupt
> > controller. It hasn't taken a lot of lines to implement which is very
> > cool.
> >   
> 
> Yep, although the code works for PPC_XICS only which is good for now.
> When we do XIVE, we can add more bits

Other thing is, I would do the masked external interrupt as its own
patch. NMI is basically independent as far as I can see.

Thanks,
Nick
