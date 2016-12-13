Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3td7jb6BNBzDt3H
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 16:36:19 +1100 (AEDT)
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3td7jb1Hgjz9t2p
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2016 16:36:19 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id 3so3319207pgd.0
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Dec 2016 21:36:19 -0800 (PST)
Message-ID: <1481607371.11971.1.camel@gmail.com>
Subject: Re: [powerpc/nmi: RFC 2/2] Keep interrupts enabled even on soft
 disable
From: Balbir Singh <bsingharora@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Date: Tue, 13 Dec 2016 16:36:11 +1100
In-Reply-To: <20161212233111.1712ba79@roar.ozlabs.ibm.com>
References: <20161212095003.1885-1-bsingharora@gmail.com>
 <20161212095003.1885-3-bsingharora@gmail.com>
 <20161212233111.1712ba79@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-12-12 at 23:31 +1000, Nicholas Piggin wrote:
> On Mon, 12 Dec 2016 20:50:03 +1100
> Balbir Singh <bsingharora@gmail.com> wrote:
> 
> > This patch removes the disabling of interrupts
> > in soft-disable mode, when interrupts are received
> > (in lazy mode). The new scheme keeps the interrupts
> > enabled when we receive an interrupt and does the
> > following
> > 
> > a. On decrementer interrupt, instead of setting
> > dec to maximum and returning, we do the following
> >   i. Call a function handle_nmi_dec, which in
> >      turn calls handle_soft_nmi
> >   ii. handle_soft_nmi sets the decrementer value
> >       to 1 second and checks if more than 30
> >       seconds have passed since starting it. If
> >       so it calls BUG_ON(1), we can do an NMI
> >       panic as well.
> > b. When an external interrupt is received, we
> >    store the interrupt in local_paca via
> >    ppc_md.get_irq(). Later when interrupts are
> >    enabled and replayed, we reuse the stored
> >    interrupt and process it via generic_handle_irq
> 
> This seems pretty good. My NMI handler should plug in just
> the same to the masked decrementer, so that wouldn't be a
> problem.

Thats good to know, I believe so as well.

<snip>

> > while soft-disable */
> > +	u32 irq;			/* IRQ pending */
> >  	u8 nap_state_lost;		/* NV GPR values lost in
> > power7_idle */
> >  	u64 sprg_vdso;			/* Saved user-
> > visible sprg */
> 
> Can you avoid some padding if you move it to below irq_happened?
>

Will do
 
> > +EXC_COMMON(handle_nmi_dec, 0x900, handle_soft_nmi)
> > +EXC_COMMON(elevate_save_irq, 0x500, handle_elevated_irq)
> 
> I wonder if the name should match the type of interrupt rather than
> implementation detail (elevated?), and match the existing handlers
> e.g, hardware_interrupt_masked common handler could call
> do_IRQ_masked.
>

Sure, will rename them
 
> As for the NMI, I would prefer just to keep it out of the timer path
> completely and schedule a Linux timer for it as I had.
> 
> Otherwise, this looks nice if it does the right thing with the
> interrupt
> controller. It hasn't taken a lot of lines to implement which is very
> cool.
> 

Yep, although the code works for PPC_XICS only which is good for now.
When we do XIVE, we can add more bits

Balbir
