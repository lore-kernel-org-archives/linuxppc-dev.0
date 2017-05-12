Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wPPx04wPdzDqc8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 19:36:04 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id s62so7008136pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 02:36:04 -0700 (PDT)
Date: Fri, 12 May 2017 19:35:44 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling
 <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powernv:idle: Set NAPSTATELOST after recovering paca on
 P9 DD1
Message-ID: <20170512193544.258914c5@roar.ozlabs.ibm.com>
In-Reply-To: <1494580926-17590-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1494580926-17590-1-git-send-email-ego@linux.vnet.ibm.com>
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

On Fri, 12 May 2017 14:52:06 +0530
"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> commit 17ed4c8f81da ("powerpc/powernv: Recover correct PACA on wakeup
> from a stop on P9 DD1") promises to set the NAPSTATELOST bit in paca
> after recovering the correct paca for the thread waking up from stop1
> on DD1, so that the GPRs can be correctly restored on the stop exit
> path. However, it loads the value 1 into r3, but stores the value in
> r0 into NAPSTATELOST(r13).
> 
> Fix this by correctly set the NAPSTATELOST bit in paca after
> recovering the paca on POWER9 DD1.
> 
> Fixes: commit 17ed4c8f81da ("powerpc/powernv: Recover correct PACA on wakeup
> from a stop on P9 DD1")
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

This looks obviously correct to me.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  arch/powerpc/kernel/idle_book3s.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 07d4e0a..4898d67 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -416,7 +416,7 @@ power9_dd1_recover_paca:
>  	 * which needs to be restored from the stack.
>  	 */
>  	li	r3, 1
> -	stb	r0,PACA_NAPSTATELOST(r13)
> +	stb	r3,PACA_NAPSTATELOST(r13)
>  	blr
>  
>  /*
