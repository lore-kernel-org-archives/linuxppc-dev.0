Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfLCF37HZzDqrZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 08:32:09 +1000 (AEST)
Message-ID: <1467151536.20278.177.camel@kernel.crashing.org>
Subject: Re: [PATCH 29/38] powerpc: Move 32-bit probe() machine to later in
 the boot process
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Wed, 29 Jun 2016 08:05:36 +1000
In-Reply-To: <trinity-87866221-2d33-4447-ae4a-25ca8152f64a-1467120318263@3capp-gmx-bs60>
References: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
 <1467026976-7974-30-git-send-email-benh@kernel.crashing.org>
 <32078f2a-4e8d-3ac4-f4f6-30563bf7e601@gmx.net>
 , <1467063605.20278.93.camel@kernel.crashing.org>
 <trinity-c46b0444-1060-47bf-a8a6-4ddc08cab4d1-1467114142663@3capp-gmx-bs17>
 , <1467115279.20278.127.camel@kernel.crashing.org>
 <trinity-87866221-2d33-4447-ae4a-25ca8152f64a-1467120318263@3capp-gmx-bs60>
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

On Tue, 2016-06-28 at 15:25 +0200, Gerhard Pircher wrote:
> > No we could just add something to early_init_devtree that does clear
> > that bit if it sees the relevant piece of broken HW, it's not the AmigaOne per-se, it's the northbridge right ?
> Does that work for CPU_FTR_NEED_COHERENT, given that the feature fixups
> are done right after identify_cpu() and instructions within BEGIN_FTR_SECTION
> and END_FTR_SECTION* are patched out (if I understand this mechanism
> correctly) !?

Right that's a problem. We do the fixup before early_init_devtree() on
ppc32 (we don't on ppc64) ... ugh. I'll have to think about it. We can
try to make them match by moving the fixup but that means making
sure that the transition to the "initial" MMU mapping use for
machine_init() can be done without the fixups being applied.

I can have a quick sweep of the init code later today or tomorrow to
see how bad that would be.

Otherwise, compile option...

> But yes, the specific northbridge is the problem here.
> 
> > We could also make non-coherent cache a runtime option if we really
> > wanted, it's just more churn ...
> Yeah, I remember a discussion or two about this topic and I always wondered
> how driver code would differentiate then between non-coherent and coherent
> DMA, given that they sometimes require different handling of the DMA addresses
> (e.g. if I look at /sound/core/pcm_native.c or the DRM code).
> 
> > > > Do we know where the lockups come from btw ? A problem with the
> > > > northbridge ?
> > > Yes, it's a problem with the northbridge...as usual. :-(
> > 
> > Marvell ?
> No, the one with the dreaded "A" name: MAI Logic's "Articia S" :-)

Heh ok.

Cheers,
Ben.
