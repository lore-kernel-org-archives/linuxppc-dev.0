Return-Path: <ryabinin.a.a@gmail.com>
Received: from mail-lb0-x22d.google.com (mail-lb0-x22d.google.com
 [IPv6:2a00:1450:4010:c04::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8571E1A0372
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 22:13:31 +1000 (AEST)
Received: by lbbsx3 with SMTP id sx3so80643251lbb.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 05:13:27 -0700 (PDT)
Subject: Re: [RFC PATCH V1 7/8] powerpc/mm: kasan: Add kasan support for ppc64
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1439793400-18147-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1439793400-18147-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Message-ID: <55D1CFE7.2070801@gmail.com>
Date: Mon, 17 Aug 2015 15:13:27 +0300
MIME-Version: 1.0
In-Reply-To: <1439793400-18147-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/17/2015 09:36 AM, Aneesh Kumar K.V wrote:
> We use the region with region ID 0xe as the kasan shadow region. Since
> we use hash page table, we can't have the early zero page based shadow
> region support. Hence we disable kasan in the early code and runtime
> enable this. We could imporve the condition using static keys. (but
> that is for a later patch). We also can't support inline instrumentation
> because our kernel mapping doesn't give us a large enough free window
> to map the entire range. For VMALLOC and VMEMMAP region we just
> return a zero page instead of having a translation bolted into the
> htab. This simplifies handling VMALLOC and VMEMAP area. Kasan is not
> tracking both the region as of now
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/kasan.h         | 74 ++++++++++++++++++++++++++++++++
>  arch/powerpc/include/asm/pgtable-ppc64.h |  1 +
>  arch/powerpc/include/asm/ppc_asm.h       | 10 +++++
>  arch/powerpc/include/asm/string.h        | 13 ++++++
>  arch/powerpc/kernel/Makefile             |  1 +
>  arch/powerpc/kernel/prom_init_check.sh   |  2 +-
>  arch/powerpc/kernel/setup_64.c           |  3 ++
>  arch/powerpc/lib/mem_64.S                |  6 ++-
>  arch/powerpc/lib/memcpy_64.S             |  3 +-
>  arch/powerpc/lib/ppc_ksyms.c             | 10 +++++
>  arch/powerpc/mm/Makefile                 |  3 ++
>  arch/powerpc/mm/kasan_init.c             | 44 +++++++++++++++++++
>  arch/powerpc/mm/slb_low.S                |  4 ++
>  arch/powerpc/platforms/Kconfig.cputype   |  1 +
>  14 files changed, 171 insertions(+), 4 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/kasan.h
>  create mode 100644 arch/powerpc/mm/kasan_init.c
> 

Did you disable stack instrumentation (in scripts/Makefile.kasa),
or you version of gcc doesn't support it (e.g. like 4.9.x on x86) ?

Because this can't work with stack instrumentation as you don't have shadow for stack in early code.

But this should be doable, as I think. All you need is to setup shadow for init task's
stack before executing any instrumented function. 
