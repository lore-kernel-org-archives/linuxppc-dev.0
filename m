Return-Path: <oohall@gmail.com>
Received: from mail-qk0-x233.google.com (mail-qk0-x233.google.com
 [IPv6:2607:f8b0:400d:c09::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpXGB5189zDqnb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 14:33:54 +1100 (AEDT)
Received: by mail-qk0-x233.google.com with SMTP id p22so30539173qka.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 20:33:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <871stylr1n.fsf@concordia.ellerman.id.au>
References: <20170302004920.21948-1-oohall@gmail.com>
 <20170302004920.21948-4-oohall@gmail.com>
 <871stylr1n.fsf@concordia.ellerman.id.au>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Thu, 23 Mar 2017 14:33:51 +1100
Message-ID: <CAOSf1CF6BHr+T8r+0kV8sk0-NzfzLf=dwxpJkK0gCofMa_TPAg@mail.gmail.com>
Subject: Re: [PATCH 4/5] powerpc/smp: add cpu_cache_mask
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 15, 2017 at 10:26 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Oliver O'Halloran <oohall@gmail.com> writes:
>
>> Traditionally we have only ever tracked which CPUs are in the same core
>> (cpu_sibling_mask) and on the same die (cpu_core_mask). For Power9 we
>> need to be aware of which CPUs share cache with each other so this patch
>> adds cpu_cache_mask and the underlying cpu_cache_map variable to track
>> this.
>
> But which cache?

I'm not sure it matters. All the scheduler really wants to know is
that that migrating between cpus with a shared cache is cheaper than
migrating elsewhere.

> Some CPUs on Power8 share L3, or L4.

Eh... it's not really the same. The "L4" is part of the memory buffers
and it's function is conceptually different to the processor caches.
The L3 on P8 is only shared when the core that owns is offline (or
sleeping) so the scheduler doesn't really need to be aware of it. Even
if the scheduler was aware I don't think it can take advantage of it
without some terrible hacks.

>
> I think just call it cpu_l2cache_map to make it explicit.

I was being deliberately vague. I know it's only a shared currently,
but it's possible we might have a (real) shared L3 in the future. The
latest high-end x86 chips have some of l3 sharing across the entire
chip so you never know. I'm not particularly attached to the name
though, so i'll rename it if you really want.

Oliver
