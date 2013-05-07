Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E09672C0129
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 17:25:28 +1000 (EST)
Message-ID: <1367911520.5769.12.camel@pasglop>
Subject: Re: [PATCH] powerpc: Make hard_irq_disable() do the right thing vs.
 irq tracing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "tiejun.chen" <tiejun.chen@windriver.com>
Date: Tue, 07 May 2013 17:25:20 +1000
In-Reply-To: <5188AA2D.1040802@windriver.com>
References: <1367910242.5769.11.camel@pasglop> <5188AA2D.1040802@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-05-07 at 15:15 +0800, tiejun.chen wrote:
> Could we simplify this as follows:
> 
> +#define hard_irq_disable()     do {                    \
> +       __hard_irq_disable();                           \
> +       if (get_paca()->soft_enabled) {                 \
> +               trace_hardirqs_off();                   \
> +               get_paca()->soft_enabled = 0;           \
> +       }                                               \
> +       get_paca()->irq_happened |= PACA_IRQ_HARD_DIS;  \
> +} while(0)

I'd rather not. When lockdep is not enabled trace_hardirqs_off() is a
nop and thus we have no conditional at all which is arguably better...

Cheers,
Ben.
