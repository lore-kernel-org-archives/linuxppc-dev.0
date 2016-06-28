Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rf4Cg0qjxzDqmk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 22:01:34 +1000 (AEST)
Message-ID: <1467115279.20278.127.camel@kernel.crashing.org>
Subject: Re: [PATCH 29/38] powerpc: Move 32-bit probe() machine to later in
 the boot process
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 28 Jun 2016 22:01:19 +1000
In-Reply-To: <trinity-c46b0444-1060-47bf-a8a6-4ddc08cab4d1-1467114142663@3capp-gmx-bs17>
References: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
 <1467026976-7974-30-git-send-email-benh@kernel.crashing.org>
 <32078f2a-4e8d-3ac4-f4f6-30563bf7e601@gmx.net>
 , <1467063605.20278.93.camel@kernel.crashing.org>
 <trinity-c46b0444-1060-47bf-a8a6-4ddc08cab4d1-1467114142663@3capp-gmx-bs17>
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

On Tue, 2016-06-28 at 13:42 +0200, Gerhard Pircher wrote:
> The question is, if a compile time option that simply clear ?s
> CPU_FTR_NEED_COHERENT after identify_cpu() would be acceptable. And
> then I still wonder why KVM needs its own similar fix to work on the
> AmigaOne. I specifically had to remove/clear the PTE_M bit
> inarch/powerpc/kvm/book3s_32_mmu_host.c for th

No we could just add something to early_init_devtree that does clear
that bit if it sees the relevant piece of broken HW, it's not the AmigaOne per-se, it's the northbridge right ?

We could also make non-coherent cache a runtime option if we really
wanted, it's just more churn ...

> 206         pteg0 = ((eaddr & 0x0fffffff) >> 22) | (vsid << 7) |
> PTE_V |
> 207                 (primary ? 0 : PTE_SEC);
> 208         pteg1 = hpaddr | PTE_M | PTE_R | PTE_C;
>                              ^^^^^
> 
> > Do we know where the lockups come from btw ? A problem with the
> > northbridge ?
> Yes, it's a problem with the northbridge...as usual. :-(

Marvell ?

Cheers,
Ben.
