Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (www.linutronix.de [62.245.132.108])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 95C902C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 18:26:12 +1000 (EST)
Date: Wed, 12 Jun 2013 10:25:56 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] of: Fix locking vs. interrupts
In-Reply-To: <1371015544.8250.182.camel@pasglop>
Message-ID: <alpine.LFD.2.02.1306121023150.22970@ionos>
References: <1371015544.8250.182.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: devicetree-discuss@lists.ozlabs.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 12 Jun 2013, Benjamin Herrenschmidt wrote:

> The OF code uses irqsafe locks everywhere except in a handful of functions
> for no obvious reasons. Since the conversion from the old rwlocks, this
> now triggers lockdep warnings when used at interrupt time. At least one
> driver (ibmvscsi) seems to be doing that from softirq context.
> 
> This converts the few non-irqsafe locks into irqsafe ones, making them
> consistent with the rest of the code.

Fun. https://lkml.org/lkml/2013/2/4/416 seems to have got lost 
 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: <stable@vger.kernel.org> [v3.9+]

Acked-by: Thomas Gleixner <tglx@linutronix.de>

> ---
> 
> Note: It's silly to access the device-tree at interrupt time in most cases,
> and we should probably fix ibmvscsi, but for the time being, let's fix the

Right.

> obvious bug. Thomas, this can probably still go into 3.10... If not, I've
> CCed stable.

Should go through Grant I think.

Thanks,

	tglx
