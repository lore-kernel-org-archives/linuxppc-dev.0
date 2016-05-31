Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJdY84ql1zDqYc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 13:01:14 +1000 (AEST)
Message-ID: <1464663620.3078.222.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/5] powerpc/pseries: Drop support for MPIC in pseries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rashmica <rashmicy@gmail.com>, mpe@ellerman.id.au, paulus@samba.org,
 nfont@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 31 May 2016 13:00:20 +1000
In-Reply-To: <574CEA20.5070809@gmail.com>
References: <1464589095-442-1-git-send-email-rashmicy@gmail.com>
 <1464593541.3078.192.camel@kernel.crashing.org>
 <574CEA20.5070809@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-05-31 at 11:34 +1000, Rashmica wrote:
> 
> On 30/05/16 17:32, Benjamin Herrenschmidt wrote:
> > 
> > On Mon, 2016-05-30 at 16:18 +1000, Rashmica Gupta wrote:
> > > 
> > > MPIC was only used by Power3 which is now unsupported, so drop support
> > > for MPIC. XICS is now the only supported interrupt controller for
> > > pSeries so make the XICS functions generic.
> > The second half I'm not sure ... XIVE is around the corner...
> > 
> > Cheers,
> > Ben.
> > 
> I thought XIVE was replacing XICS? And so then we can just simply 
> replace all the specific XICS code such as xics_init() and 
> xics_smp_probe() with the relevant XIVE functions?

We still need to boot on P8 that doesn't have XIVE, so we need to
support both. IE, the same way we had to chose at runtime between MPIC
and XICS, we'll now have to chose between XICS and XIVE.

> By "make the XICS functions generic" I meant that if there is only one 
> interrupt controller for pseries then we don't need to have both static 
> void __init pseries_xics_init_IRQ(void) and static void __init 
> pSeries_init_IRQ(void), etc.

There will be two.

Cheers,
Ben.
