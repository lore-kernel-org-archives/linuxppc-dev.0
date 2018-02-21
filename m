Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmT6g2dybzF0sl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 18:06:19 +1100 (AEDT)
Subject: Re: [PATCH 0/6] DISCONTIGMEM support for PPC32
To: =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
 linuxppc-dev@lists.ozlabs.org
Cc: Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20180220161424.5421-1-j.neuschaefer@gmx.net>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <193a407d-e6b8-9e29-af47-3d401b6414a0@c-s.fr>
Date: Wed, 21 Feb 2018 08:06:10 +0100
MIME-Version: 1.0
In-Reply-To: <20180220161424.5421-1-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 20/02/2018 à 17:14, Jonathan Neuschäfer a écrit :
> This patchset adds support for DISCONTIGMEM on 32-bit PowerPC. This is
> required to properly support the Nintendo Wii's memory layout, in which
> there are two blocks of RAM and MMIO in the middle.
> 
> Previously, this memory layout was handled by code that joins the two
> RAM blocks into one, reserves the MMIO hole, and permits allocations of
> reserved memory in ioremap. This hack didn't work with resource-based
> allocation (as used for example in the GPIO driver for Wii[1]), however.
> 
> After this patchset, users of the Wii can either select CONFIG_FLATMEM
> to get the old behaviour, or CONFIG_DISCONTIGMEM to get the new
> behaviour.

My question might me stupid, as I don't know PCC64 in deep, but when 
looking at page_is_ram() in arch/powerpc/mm/mem.c, I have the feeling 
the PPC64 implements ram by blocks. Isn't it what you are trying to 
achieve ? Wouldn't it be feasible to map to what's done in PPC64 for PPC32 ?

Christophe

> 
> Some parts of this patchset are probably not ideal (I'm thinking of my
> implementation of pfn_to_nid here), and will require some discussion/
> changes.
> 
> [1]: https://www.spinics.net/lists/devicetree/msg213956.html
> 
> Jonathan Neuschäfer (6):
>    powerpc/mm/32: Use pfn_valid to check if pointer is in RAM
>    powerpc: numa: Fix overshift on PPC32
>    powerpc: numa: Use the right #ifdef guards around functions
>    powerpc: numa: Restrict fake NUMA enulation to CONFIG_NUMA systems
>    powerpc: Implement DISCONTIGMEM and allow selection on PPC32
>    powerpc: wii: Don't rely on reserved memory hack if DISCONTIGMEM is
>      set
> 
>   arch/powerpc/Kconfig                     |  5 ++++-
>   arch/powerpc/include/asm/mmzone.h        | 21 +++++++++++++++++++++
>   arch/powerpc/mm/numa.c                   | 18 +++++++++++++++---
>   arch/powerpc/mm/pgtable_32.c             |  2 +-
>   arch/powerpc/platforms/embedded6xx/wii.c | 10 +++++++---
>   5 files changed, 48 insertions(+), 8 deletions(-)
> 
