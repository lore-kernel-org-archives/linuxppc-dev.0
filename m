Return-Path: <gerhard_pircher@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rf64T2qMGzDqmW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 23:25:25 +1000 (AEST)
MIME-Version: 1.0
Message-ID: <trinity-87866221-2d33-4447-ae4a-25ca8152f64a-1467120318263@3capp-gmx-bs60>
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 29/38] powerpc: Move 32-bit probe() machine to later in
 the boot process
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jun 2016 15:25:18 +0200
In-Reply-To: <1467115279.20278.127.camel@kernel.crashing.org>
References: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
 <1467026976-7974-30-git-send-email-benh@kernel.crashing.org>
 <32078f2a-4e8d-3ac4-f4f6-30563bf7e601@gmx.net> ,
 <1467063605.20278.93.camel@kernel.crashing.org>
 <trinity-c46b0444-1060-47bf-a8a6-4ddc08cab4d1-1467114142663@3capp-gmx-bs17>,
 <1467115279.20278.127.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-06-28 at 14:01 +0200, Benjamin Herrenschmidt wrote:
> On Tue, 2016-06-28 at 13:42 +0200, Gerhard Pircher wrote:
> > The question is, if a compile time option that simply clear ?s
> > CPU_FTR_NEED_COHERENT after identify_cpu() would be acceptable. And
> > then I still wonder why KVM needs its own similar fix to work on the
> > AmigaOne. I specifically had to remove/clear the PTE_M bit
> > inarch/powerpc/kvm/book3s_32_mmu_host.c for th
> 
> No we could just add something to early_init_devtree that does clear
> that bit if it sees the relevant piece of broken HW, it's not the AmigaOne per-se, it's the northbridge right ?
Does that work for CPU_FTR_NEED_COHERENT, given that the feature fixups
are done right after identify_cpu() and instructions within BEGIN_FTR_SECTION
and END_FTR_SECTION* are patched out (if I understand this mechanism
correctly) !?
But yes, the specific northbridge is the problem here.

> We could also make non-coherent cache a runtime option if we really
> wanted, it's just more churn ...
Yeah, I remember a discussion or two about this topic and I always wondered
how driver code would differentiate then between non-coherent and coherent
DMA, given that they sometimes require different handling of the DMA addresses
(e.g. if I look at /sound/core/pcm_native.c or the DRM code).

> > > Do we know where the lockups come from btw ? A problem with the
> > > northbridge ?
> > Yes, it's a problem with the northbridge...as usual. :-(
> 
> Marvell ?
No, the one with the dreaded "A" name: MAI Logic's "Articia S" :-)

BR,
Gerhard
