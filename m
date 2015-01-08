Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0982C1A0F6C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jan 2015 06:18:04 +1100 (AEDT)
Message-ID: <1420744670.5830.44.camel@kernel.crashing.org>
Subject: Re: [RFC] PPC: MPIC: necessary readback after EOI?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Thu, 08 Jan 2015 20:17:50 +0100
In-Reply-To: <1420650283.4961.52.camel@freescale.com>
References: <20150105174616.GA3159@rhlx01.hs-esslingen.de>
 <1420481454.4961.16.camel@freescale.com>
 <1420641876.5830.32.camel@kernel.crashing.org>
 <1420650283.4961.52.camel@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Purcareata Bogdan <b43198@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Andreas Mohr <andi@lisas.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-01-07 at 11:04 -0600, Scott Wood wrote:
> On Wed, 2015-01-07 at 15:44 +0100, Benjamin Herrenschmidt wrote:
> > On Mon, 2015-01-05 at 12:10 -0600, Scott Wood wrote:
> > > It would have been nice if a code comment explained why it was doing the
> > > readback...  I don't see any particular need to wait for EOI completion
> > > here (unlike when masking).
> > 
> > The EOI is what causes the MPIC to drop it's EE output to the CPU, if the
> > EOI is processed too slowly & asynchronously (posted write + 33Mhz MPIC)
> > we observe cases of spurrious interrupts. We had some macs basically getting
> > a spurrious irq for every MPIC interrupts...
> 
> Shouldn't reading INTACK be what causes the MPIC to drop its EE output?

Hrm, looks like I had too much wine or something, you are correct yes,
it's the intack, so my explanation is bogus.

So we are down to possibly delaying the raising back of the CPU priority
which is not a big deal indeed, we could probably get rid of the read
back.

Ben.
