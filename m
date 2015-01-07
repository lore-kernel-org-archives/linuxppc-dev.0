Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0117.outbound.protection.outlook.com [65.55.169.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C7CD51A0EF4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jan 2015 04:04:59 +1100 (AEDT)
Message-ID: <1420650283.4961.52.camel@freescale.com>
Subject: Re: [RFC] PPC: MPIC: necessary readback after EOI?
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 7 Jan 2015 11:04:43 -0600
In-Reply-To: <1420641876.5830.32.camel@kernel.crashing.org>
References: <20150105174616.GA3159@rhlx01.hs-esslingen.de>
 <1420481454.4961.16.camel@freescale.com>
 <1420641876.5830.32.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
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

On Wed, 2015-01-07 at 15:44 +0100, Benjamin Herrenschmidt wrote:
> On Mon, 2015-01-05 at 12:10 -0600, Scott Wood wrote:
> > It would have been nice if a code comment explained why it was doing the
> > readback...  I don't see any particular need to wait for EOI completion
> > here (unlike when masking).
> 
> The EOI is what causes the MPIC to drop it's EE output to the CPU, if the
> EOI is processed too slowly & asynchronously (posted write + 33Mhz MPIC)
> we observe cases of spurrious interrupts. We had some macs basically getting
> a spurrious irq for every MPIC interrupts...

Shouldn't reading INTACK be what causes the MPIC to drop its EE output?

-Scott
