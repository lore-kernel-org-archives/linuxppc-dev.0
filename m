Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 916982C01CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2012 08:21:19 +1000 (EST)
Message-ID: <1341440465.16808.38.camel@pasglop>
Subject: Re: [Qemu-ppc] [RFC PATCH 09/17] KVM: PPC64: booke: Hard disable
 interrupts when entering guest
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Thu, 05 Jul 2012 08:21:05 +1000
In-Reply-To: <10CBFB35-5A18-4EA8-A129-58CCC4CFBB83@suse.de>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-10-git-send-email-mihai.caraman@freescale.com>
 <10CBFB35-5A18-4EA8-A129-58CCC4CFBB83@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "qemu-ppc@nongnu.org List" <qemu-ppc@nongnu.org>,
 Mihai Caraman <mihai.caraman@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, KVM list <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-07-04 at 16:14 +0200, Alexander Graf wrote:
> > +#ifdef CONFIG_64BIT
> > +#define _hard_irq_disable() hard_irq_disable()
> > +#else
> > +#define _hard_irq_disable() local_irq_disable()
> > +#endif
> 
> So you only swap out the disable bit, but not the enable one? Ben,
> would this work out?

hard_irq_disable() both soft and hard disable. local_irq_enable() will
see that irqs are hard disabled and will hard enable.

However, there's a nastier discrepancy above: local_irq_disable will
properly inform lockdep that we are disabling, while hard_irq_disable
won't.

Arguably we might want to fix that inside hard_irq_disable() itself...

Also you need to be careful. If you are coming with interrupts already
enabled, it's fine, but if you have interrupts soft disabled, then
you hard disable, before you enter the guest you probably want to
check if anything was left "pending" and cancel the entering of the
guest if that is the case.

Cheers,
Ben.
