Return-Path: <srs0=pnv8=i7=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415TjP1Nh1zDrbK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 00:32:09 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 415TjM6vclz8wMC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 00:32:07 +1000 (AEST)
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 415TjL3QDhz9s3C
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2018 00:32:06 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id z9-v6so1645225plk.11
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2018 07:32:06 -0700 (PDT)
Date: Thu, 14 Jun 2018 00:31:58 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: Re: [PATCH] powerpc/64s: Fix DT CPU features Power9 DD2.1 logic
Message-ID: <20180614003158.47156ea2@roar.ozlabs.ibm.com>
In-Reply-To: <20180613132356.29246-1-mpe@ellerman.id.au>
References: <20180613132356.29246-1-mpe@ellerman.id.au>
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

On Wed, 13 Jun 2018 23:23:56 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> In the device tree CPU features quirk code we want to set
> CPU_FTR_POWER9_DD2_1 on all Power9s that aren't DD2.0 or earlier. But
> we got the logic wrong and instead set it on all CPUs that aren't
> Power9 DD2.0 or earlier, ie. including Power8.
> 
> Fix it by making sure we're on a Power9. This isn't a bug in practice
> because the only code that checks the feature is Power9 only to begin
> with. But we'll backport it anyway to avoid confusion.
> 
> Fixes: 9e9626ed3a4a ("powerpc/64s: Fix POWER9 DD2.2 and above in DT CPU features")
> Cc: stable@vger.kernel.org # v4.17+
> Reported-by: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  arch/powerpc/kernel/dt_cpu_ftrs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
> index 4be1c0de9406..96dd3d871986 100644
> --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
> +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
> @@ -711,7 +711,8 @@ static __init void cpufeatures_cpu_quirks(void)
>  		cur_cpu_spec->cpu_features |= CPU_FTR_P9_TM_HV_ASSIST;
>  		cur_cpu_spec->cpu_features |= CPU_FTR_P9_TM_XER_SO_BUG;
>  		cur_cpu_spec->cpu_features |= CPU_FTR_POWER9_DD2_1;
> -	} else /* DD2.1 and up have DD2_1 */
> +	} else if ((version & 0xffff0000) == 0x004e0000)
> +		/* DD2.1 and up have DD2_1 */
>  		cur_cpu_spec->cpu_features |= CPU_FTR_POWER9_DD2_1;
>  
>  	if ((version & 0xffff0000) == 0x004e0000) {
