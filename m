Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0206.outbound.protection.outlook.com [207.46.163.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CC0042C008F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jan 2014 08:19:54 +1100 (EST)
Message-ID: <1389129582.11795.190.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/mpic: supply a .disable callback
From: Scott Wood <scottwood@freescale.com>
To: Wang Dongsheng-B40534 <Dongsheng.Wang@freescale.com>
Date: Tue, 7 Jan 2014 15:19:42 -0600
In-Reply-To: <a889eb6414b44d418a34bc5e61fc538a@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1389073086-6763-1-git-send-email-dongsheng.wang@freescale.com>
 <1389073776.4672.5.camel@pasglop>
 <a889eb6414b44d418a34bc5e61fc538a@BN1PR03MB188.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-01-07 at 04:18 -0600, Wang Dongsheng-B40534 wrote:
> 
> > -----Original Message-----
> > From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
> > Sent: Tuesday, January 07, 2014 1:50 PM
> > To: Wang Dongsheng-B40534
> > Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH] powerpc/mpic: supply a .disable callback
> > 
> > On Tue, 2014-01-07 at 13:38 +0800, Dongsheng Wang wrote:
> > > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> > >
> > > Currently MPIC provides .mask, but not .disable.  This means that
> > > effectively disable_irq() soft-disables the interrupt, and you get
> > > a .mask call if an interrupt actually occurs.
> > >
> > > I'm not sure if this was intended as a performance benefit (it seems common
> > > to omit .disable on powerpc interrupt controllers, but nowhere else), but it
> > > interacts badly with threaded/workqueue interrupts (including KVM
> > > reflection).  In such cases, where the real interrupt handler does a
> > > disable_irq_nosync(), schedules defered handling, and returns, we get two
> > > interrupts for every real interrupt.  The second interrupt does nothing
> > > but see that IRQ_DISABLED is set, and decide that it would be a good
> > > idea to actually call .mask.
> > 
> > We probably don't want to do that for edge, only level interrupts.
> > 
> Sorry Ben, I am not understand your comments.
> 
> This issue is the kernel api irq_disable() only use chip->irq_disable(), but mpic
> not have this interface so we don't real disable the interrupt.

I think he means that the "two interrupts for every real interrupt"
effect will only happen with level triggered interrupts, and he'd like
to keep the potential performance benefit of lazy disabling for edge
interrupts.

To implement this for "ordinary" edge interrupts (not IPI, timer, etc)
we'd need to add a new .irq_disable() function that checks whether it's
level/edge and only calls .irq_mask() if level -- or, introduce a
separate struct irq_chip for edge versus level.

-Scott
