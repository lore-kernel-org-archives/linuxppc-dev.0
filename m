Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xj5fY24mSzDqMY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 23:18:13 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, andrew.donnellan@au1.ibm.com,
 clombard@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com
Cc: alistair@popple.id.au
Subject: Re: [PATCH v2 1/3] powerpc/mm: Export flush_all_mm()
In-Reply-To: <20170830101550.16821-1-fbarrat@linux.vnet.ibm.com>
References: <20170830101550.16821-1-fbarrat@linux.vnet.ibm.com>
Date: Wed, 30 Aug 2017 23:17:50 +1000
Message-ID: <87inh519fl.fsf@concordia.ellerman.id.au>
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

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:

> With the optimizations introduced by commit a46cc7a90fd8
> ("powerpc/mm/radix: Improve TLB/PWC flushes"), flush_tlb_mm() no
> longer flushes the page walk cache with radix. This patch introduces
> flush_all_mm(), which flushes everything, tlb and pwc, for a given mm.
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> ---
> Changelog:
> v2: this patch is new
>
>  arch/powerpc/include/asm/book3s/64/tlbflush-hash.h  |  8 ++++++++
>  arch/powerpc/include/asm/book3s/64/tlbflush-radix.h |  3 +++
>  arch/powerpc/include/asm/book3s/64/tlbflush.h       | 15 +++++++++++++++
>  arch/powerpc/mm/tlb-radix.c                         |  6 ++++--
>  4 files changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
> index 2f6373144e2c..c5d89d271a96 100644
> --- a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
> @@ -65,6 +65,14 @@ static inline void hash__flush_tlb_mm(struct mm_struct *mm)
>  {
>  }
>  
> +static inline void hash__local_flush_all_mm(struct mm_struct *mm)
> +{
> +}
> +
> +static inline void hash__flush_all_mm(struct mm_struct *mm)
> +{
> +}

It's not clear why it makes sense for these to be empty. Either for the
general idea of the "flush_all_mm()" API, or for your intended use by
CXL.

cheers
