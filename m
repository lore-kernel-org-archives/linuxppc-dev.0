Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 86D9E1A01DD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 14:41:30 +1000 (EST)
Message-ID: <1408596086.9307.3.camel@concordia>
Subject: Re: [PATCH] powerpc/pseries: Drop unnecessary continue
From: Michael Ellerman <mpe@ellerman.id.au>
To: Himangi Saraogi <himangi774@gmail.com>
Date: Thu, 21 Aug 2014 14:41:26 +1000
In-Reply-To: <20140813091847.GA3078@himangi-Dell>
References: <20140813091847.GA3078@himangi-Dell>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 rcj4747@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-08-13 at 14:48 +0530, Himangi Saraogi wrote:
> Continue is not needed at the bottom of a loop.
 
True.

I wonder though, is the code trying to continue to the outer loop? I stared at
it for a minute but it wasn't obvious.

I wonder if Robert still remembers?

cheers

> diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
> index 2d8bf15..fc44ad0 100644
> --- a/arch/powerpc/platforms/pseries/cmm.c
> +++ b/arch/powerpc/platforms/pseries/cmm.c
> @@ -555,7 +555,6 @@ static int cmm_mem_going_offline(void *arg)
>  				pa_last = pa_last->next;
>  				free_page((unsigned long)cmm_page_list);
>  				cmm_page_list = pa_last;
> -				continue;
>  			}
>  		}
>  		pa_curr = pa_curr->next;
