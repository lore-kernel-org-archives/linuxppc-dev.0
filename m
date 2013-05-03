Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4295A2C00D6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 08:03:43 +1000 (EST)
Message-ID: <1367618610.4389.119.camel@pasglop>
Subject: Re: [PATCH] KVM: PPC: Book3E 64: Fix IRQs warnings and hangs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Sat, 04 May 2013 08:03:30 +1000
In-Reply-To: <981DB739-E50F-488F-B2D8-916FDC2E1749@suse.de>
References: <1367597470-22214-1-git-send-email-mihai.caraman@freescale.com>
 <981DB739-E50F-488F-B2D8-916FDC2E1749@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 "kvm@vger.kernel.org VIRTUAL MA..." <kvm@vger.kernel.org>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-05-03 at 18:24 +0200, Alexander Graf wrote:
> > There is no reason to exit guest with soft_enabled == 1, a local_irq_enable()
> > call will do this for us so get rid of kvmppc_layz_ee() calls. With this fix
> > we eliminate irqs_disabled() warnings and some guest and host hangs revealed
> > under stress tests, but guests still exhibit some unresponsiveness.
> > 
> > The unresponsiveness has to do with the fact that arch_local_irq_restore()
> > does not guarantees to hard enable interrupts. To do so replace exception
> > function calls like timer_interrupt() with irq_happened flags. The
> > local_irq_enable() call takes care of replaying them and lets the interrupts
> > hard enabled.
> > 
> > Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> 
> Ben, could you please review?

That does look like the right thing to do indeed.

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Cheers,
Ben.
