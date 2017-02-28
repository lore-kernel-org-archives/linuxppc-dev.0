Return-Path: <ego.lkml@gmail.com>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXhsL6jQ0zDqHJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 02:12:54 +1100 (AEDT)
Received: by mail-it0-x243.google.com with SMTP id w185so1765827ita.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 07:12:54 -0800 (PST)
MIME-Version: 1.0
Reply-To: ego@linux.vnet.ibm.com
In-Reply-To: <20170216183901.28611-4-npiggin@gmail.com>
References: <20170216183901.28611-1-npiggin@gmail.com>
 <20170216183901.28611-4-npiggin@gmail.com>
From: Gautham R Shenoy <ego.lkml@gmail.com>
Date: Tue, 28 Feb 2017 20:42:52 +0530
Message-ID: <CAHZ_5WzdE_e+-XCgX5hmLx0P7G9cOvtGLSRK-8mPWpkEtzTPnA@mail.gmail.com>
Subject: Re: [PATCH 3/5] powerpc/64s: use alternative feature patching
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, ego@linux.vnet.ibm.com,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nick,

On Fri, Feb 17, 2017 at 12:08 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
> This reduces the number of nops for POWER8
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

This change looks ok to me.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

> ---
>  arch/powerpc/kernel/idle_book3s.S | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 1271344e5523..ab15dee371c9 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -417,13 +417,8 @@ BEGIN_FTR_SECTION
>         rldicl  r5,r5,4,60
>         cmpd    cr4,r5,r4
>         bge     cr4,pnv_wakeup_tb_loss
> -       /*
> -        * Waking up without hypervisor state loss. Return to
> -        * reset vector
> -        */
> -       blr
>
> -END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
> +FTR_SECTION_ELSE
>
>         /*
>          * POWER ISA 2.07 or less.
> @@ -440,9 +435,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
>          * indicates we are waking with hypervisor state loss from nap.
>          */
>         bgt     cr3,.
> +ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
>
> -       blr     /* Return back to System Reset vector from where
> -                  pnv_restore_hyp_resource was invoked */
> +       /*
> +        * Waking up without hypervisor state loss. Return to
> +        * reset vector
> +        */
> +       blr
>
>  /*
>   * Called if waking up from idle state which can cause either partial or
> --
> 2.11.0
>



-- 
Thanks and Regards
gautham.
