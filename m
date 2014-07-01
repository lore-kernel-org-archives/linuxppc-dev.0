Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2905B1A0044
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jul 2014 10:52:08 +1000 (EST)
Message-ID: <1404175926.30002.1.camel@concordia>
Subject: Re: [PATCH] powerpc/powernv: Check for IRQHAPPENED before sleeping
From: Michael Ellerman <mpe@ellerman.id.au>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Tue, 01 Jul 2014 10:52:06 +1000
In-Reply-To: <20140630062404.29315.23382.stgit@preeti.in.ibm.com>
References: <20140630062404.29315.23382.stgit@preeti.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: mikey@neuling.org, linux-kernel@vger.kernel.org, shreyas@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-06-30 at 11:54 +0530, Preeti U Murthy wrote:
> Commit 8d6f7c5a: "powerpc/powernv: Make it possible to skip the IRQHAPPENED
> check in power7_nap()" added code that prevents even cores which enter sleep
> on idle, from checking for pending interrupts. Fix this.

To be clear, it is a bug in the original commit. Mikey and I pair programmed
that code, and he was *definitely* typing at that point ;)

Can you please include in the changelog what the symptom of the bug is, and
have you seen it in practice?

The bad commit went into 3.16-rc1, so we don't need to backport this to any
stable release.

cheers

> diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
> index 2480256..5cf3d36 100644
> --- a/arch/powerpc/kernel/idle_power7.S
> +++ b/arch/powerpc/kernel/idle_power7.S
> @@ -131,7 +131,7 @@ _GLOBAL(power7_nap)
>  
>  _GLOBAL(power7_sleep)
>  	li	r3,1
> -	li	r4,0
> +	li	r4,1
>  	b	power7_powersave_common
>  	/* No return */
>  
> 
