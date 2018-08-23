Return-Path: <srs0=iwkb=lg=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wwMR2JJ8zF2Dd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 17:02:11 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41wwMR0qTZz8tQV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 17:02:11 +1000 (AEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41wwMQ3vs3z9s3Z
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2018 17:02:10 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id k19-v6so2228392pfi.1
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2018 00:02:10 -0700 (PDT)
Date: Thu, 23 Aug 2018 17:02:02 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael Ellerman
 <mpe@ellerman.id.au>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [RESEND PATCH v2] powerpc/mce: Fix SLB rebolting during MCE
 recovery path.
Message-ID: <20180823170202.775e8bb0@roar.ozlabs.ibm.com>
In-Reply-To: <153500619258.20614.8965724795728734200.stgit@jupiter.in.ibm.com>
References: <153500619258.20614.8965724795728734200.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 23 Aug 2018 12:06:53 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> With the powerpc next commit e7e81847478 (powerpc/mce: Fix SLB rebolting
> during MCE recovery path.), the SLB error recovery is broken. The new
> change now does not add index value to RB[52-63] that selects the SLB
> entry while rebolting, instead it assumes that the shadow save area
> already have index embeded correctly in esid field. While all valid bolted
> save areas do contain index value set correctly, there is a case where
> 3rd (KSTACK_INDEX) entry for kernel stack does not embed index for NULL
> esid entry. This patch fixes that.
> 
> Without this patch the SLB rebolt code overwrites the 1st entry of kernel
> linear mapping and causes SLB recovery to fail.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Changelog just needs a little more work, maybe this?


The commit e7e81847478 ("powerpc/64s: move machine check SLB flushing
to mm/slb.c") introduced a bug in reloading bolted SLB entries. Unused
bolted entries are stored with .esid=0 in the slb_shadow area, and
that value is now used directly as the RB input to slbmte, which means
the RB[52:63] index field is set to 0, which causes SLB entry 0 to be
cleared.

Fix this by storing the index bits in the unused bolted entries, which
directs the slbmte to the right place.

The SLB shadow area is also used by the hypervisor, but PAPR is okay
with that, from LoPAPR v1.1, 14.11.1.3 SLB Shadow Buffer:

  Note: SLB is filled sequentially starting at index 0
  from the shadow buffer ignoring the contents of
  RB field bits 52-63

Fixes: e7e81847478 ("powerpc/64s: move machine check SLB flushing to
mm/slb.c")

Thanks,
Nick

> ---
>  arch/powerpc/mm/slb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> index 0b095fa54049..9f574e59d178 100644
> --- a/arch/powerpc/mm/slb.c
> +++ b/arch/powerpc/mm/slb.c
> @@ -70,7 +70,7 @@ static inline void slb_shadow_update(unsigned long ea, int ssize,
>  
>  static inline void slb_shadow_clear(enum slb_index index)
>  {
> -	WRITE_ONCE(get_slb_shadow()->save_area[index].esid, 0);
> +	WRITE_ONCE(get_slb_shadow()->save_area[index].esid, cpu_to_be64(index));
>  }
>  
>  static inline void create_shadowed_slbe(unsigned long ea, int ssize,
> 
