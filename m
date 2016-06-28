Return-Path: <gerhard_pircher@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rf3vf5Fm7zDqnM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 21:47:41 +1000 (AEST)
MIME-Version: 1.0
Message-ID: <trinity-c46b0444-1060-47bf-a8a6-4ddc08cab4d1-1467114142663@3capp-gmx-bs17>
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 29/38] powerpc: Move 32-bit probe() machine to later in
 the boot process
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jun 2016 13:42:22 +0200
In-Reply-To: <1467063605.20278.93.camel@kernel.crashing.org>
References: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
 <1467026976-7974-30-git-send-email-benh@kernel.crashing.org>
 <32078f2a-4e8d-3ac4-f4f6-30563bf7e601@gmx.net>,
 <1467063605.20278.93.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-06-27 at 23:40 +0200, Benjamin Herrenschmidt wrote:
> On Mon, 2016-06-27 at 22:42 +0200, Gerhard Pircher wrote:
> > This patch series reminds me of a long-standing issue with the
> > AmigaOne platform code, which would have to clear the coherence
> > (M) flag for every memory mapping to avoid lockups (especially
> > on G4 CPUs) - as you can read in the comment below your patch
> > above.
> > 
> > Now the follow-up code in amigaone/setup.c to clear the
> > corresponding CPU feature flag is essentially dead code (it used
> > to work with a second call of do_feature_fixups() before the
> > handling of the CPU_FTR_NEED_COHERENT flag was changed/inverted
> > somewhere around v2.6.30). Also it doesn't seem to fix all
> > deadlocks, as e.g. KVM virtual machines can still inject memory
> > mappings with the M flag set AFAICT.
> > 
> > Now I wonder, if there is a reasonably clean way to clear the M
> > flag in all hardware page table and BAT entries without defacing
> > generic kernel code too much. Any ideas?
> 
> Other than a compile time option ?
Well, I guess a runtime option would always be preferable, but I don't
see how this could be implemented without moving probe_machine() in
front of identify_cpu() (which doesn't look easy either). On the other
side the AmigaOne also requires CONFIG_NOT_COHERENT_CACHE set and this
one is still a compile time option, too.
The question is, if a compile time option that simply clears
CPU_FTR_NEED_COHERENT after identify_cpu() would be acceptable. And
then I still wonder why KVM needs its own similar fix to work on the
AmigaOne. I specifically had to remove/clear the PTE_M bit in
arch/powerpc/kvm/book3s_32_mmu_host.c for this:

206         pteg0 = ((eaddr & 0x0fffffff) >> 22) | (vsid << 7) | PTE_V |
207                 (primary ? 0 : PTE_SEC);
208         pteg1 = hpaddr | PTE_M | PTE_R | PTE_C;
                             ^^^^^

> Do we know where the lockups come from btw ? A problem with the
> northbridge ?
Yes, it's a problem with the northbridge...as usual. :-(

> Cheers,
> Ben.

Thanks!

BR,
Gerhard
