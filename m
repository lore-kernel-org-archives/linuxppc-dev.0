Return-Path: <grant.likely@secretlab.ca>
Received: from mail-we0-x22f.google.com (mail-we0-x22f.google.com
 [IPv6:2a00:1450:400c:c03::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BAF772C008A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 19:06:21 +1000 (EST)
Received: by mail-we0-f175.google.com with SMTP id t59so6602688wes.20
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 02:06:17 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] of: Fix locking vs. interrupts
To: Thomas Gleixner <tglx@linutronix.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <alpine.LFD.2.02.1306121023150.22970@ionos>
References: <1371015544.8250.182.camel@pasglop>
 <alpine.LFD.2.02.1306121023150.22970@ionos>
Date: Wed, 12 Jun 2013 10:06:12 +0100
Message-Id: <20130612090612.7E4ED3E0A56@localhost>
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

On Wed, 12 Jun 2013 10:25:56 +0200 (CEST), Thomas Gleixner <tglx@linutronix.de> wrote:
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

Applied, thanks.

g.
