Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsXlC2pKYzDqY7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 12:05:59 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4/5] powerpc/smp: add cpu_cache_mask
In-Reply-To: <CAOSf1CF6BHr+T8r+0kV8sk0-NzfzLf=dwxpJkK0gCofMa_TPAg@mail.gmail.com>
References: <20170302004920.21948-1-oohall@gmail.com>
 <20170302004920.21948-4-oohall@gmail.com>
 <871stylr1n.fsf@concordia.ellerman.id.au>
 <CAOSf1CF6BHr+T8r+0kV8sk0-NzfzLf=dwxpJkK0gCofMa_TPAg@mail.gmail.com>
Date: Tue, 28 Mar 2017 12:05:58 +1100
Message-ID: <87k27ab47d.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Oliver O'Halloran <oohall@gmail.com> writes:

> On Wed, Mar 15, 2017 at 10:26 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Oliver O'Halloran <oohall@gmail.com> writes:
>>
>>> Traditionally we have only ever tracked which CPUs are in the same core
>>> (cpu_sibling_mask) and on the same die (cpu_core_mask). For Power9 we
>>> need to be aware of which CPUs share cache with each other so this patch
>>> adds cpu_cache_mask and the underlying cpu_cache_map variable to track
>>> this.
>
>> Some CPUs on Power8 share L3, or L4.
>
> Eh... it's not really the same. The "L4" is part of the memory buffers
> and it's function is conceptually different to the processor caches.
> The L3 on P8 is only shared when the core that owns is offline (or
> sleeping) so the scheduler doesn't really need to be aware of it.

But that's exactly my point, this mask only tracks whether CPUs share an
L2, so it should be named as such.

>> I think just call it cpu_l2cache_map to make it explicit.
>
> I was being deliberately vague. I know it's only a shared currently,
> but it's possible we might have a (real) shared L3 in the future. The
> latest high-end x86 chips have some of l3 sharing across the entire
> chip so you never know.

Sure, but in that case we'd probably want a new mask to track which CPUs
share L3, because we'd probably also have CPUs sharing L2, and those
masks might not be equal.

But if I'm wrong we can just rename it *then*.

>I'm not particularly attached to the name though, so i'll rename it
>if you really want.

Yes please.

cheers
