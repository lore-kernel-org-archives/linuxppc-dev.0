Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 84828B705F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2012 08:02:52 +1000 (EST)
Message-ID: <1339797753.9220.187.camel@pasglop>
Subject: Re: [PATCH 2/2] powerpc/e6500: TLB miss handler with hardware
 tablewalk support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Sat, 16 Jun 2012 08:02:33 +1000
In-Reply-To: <4FDB67BE.9040000@freescale.com>
References: <20120614234101.GB17147@tyr.buserror.net>
 <1339722302.9220.175.camel@pasglop> <4FDB67BE.9040000@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-06-15 at 11:50 -0500, Scott Wood wrote:
> On 06/14/2012 08:05 PM, Benjamin Herrenschmidt wrote:
> >>  - It has threads, but no "tlbsrx." -- so we need a spinlock and
> >>    a normal "tlbsx".  Because we need this lock, hardware tablewalk
> >>    is mandatory on e6500 unless we want to add spinlock+tlbsx to
> >>    the normal bolted TLB miss handler.
> > 
> > Isn't this a violation of the architecture ? (Isn't tlbsrx. mandatory ?
> > in 2.06 MAV2 ?).
> 
> I don't think so -- not only does it have a category name, there's a
> MAV2-specific bit in MMUCSR indicating whether the category is present.
> 
> I still don't understand why Freescale omitted it from a chip that has
> threads, though.

Right, especially since from memory, the idea for it came from FSL (Mike
maybe) during a meeting between the IBM and FSL folks (I was there) :-)

Oh well .... probably a case of HW folks with no clue that didn't
understand why it would be needed. Did you whack a few heads with a
cluebat ?

Cheers,
Ben.
