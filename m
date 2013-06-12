Return-Path: <benh@kernel.crashing.org>
Message-ID: <1371027387.8250.199.camel@pasglop>
Subject: Re: [PATCH] of: Fix locking vs. interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 12 Jun 2013 18:56:27 +1000
In-Reply-To: <alpine.LFD.2.02.1306121023150.22970@ionos>
References: <1371015544.8250.182.camel@pasglop>
 <alpine.LFD.2.02.1306121023150.22970@ionos>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Wed, 2013-06-12 at 10:25 +0200, Thomas Gleixner wrote:
> On Wed, 12 Jun 2013, Benjamin Herrenschmidt wrote:
> 
> > The OF code uses irqsafe locks everywhere except in a handful of functions
> > for no obvious reasons. Since the conversion from the old rwlocks, this
> > now triggers lockdep warnings when used at interrupt time. At least one
> > driver (ibmvscsi) seems to be doing that from softirq context.
> > 
> > This converts the few non-irqsafe locks into irqsafe ones, making them
> > consistent with the rest of the code.
> 
> Fun. https://lkml.org/lkml/2013/2/4/416 seems to have got lost 
>  
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > CC: <stable@vger.kernel.org> [v3.9+]
> 
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> 
> > ---
> > 
> > Note: It's silly to access the device-tree at interrupt time in most cases,
> > and we should probably fix ibmvscsi, but for the time being, let's fix the
> 
> Right.
> 
> > obvious bug. Thomas, this can probably still go into 3.10... If not, I've
> > CCed stable.
> 
> Should go through Grant I think.

Right, thinko. Sent to you due to the bug being exposed by your
conversion to spinlocks. Anyway, Grant got it now.

Cheers,
Ben.
