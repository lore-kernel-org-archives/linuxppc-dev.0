Return-Path: <ntl@pobox.com>
Received: from gretel.pobox.com (gretel.pobox.com [208.58.1.197])
	by ozlabs.org (Postfix) with ESMTP id 305EE67A3F
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 02:36:46 +1000 (EST)
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by gretel.pobox.com (Postfix) with ESMTP id 5BDF228BFBFB
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 12:01:43 -0400 (EDT)
Date: Wed, 17 May 2006 11:00:53 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Jimi Xenidis <jimix@pobox.com>
Subject: Re: [patch] udb_printf() formatting attribute
Message-ID: <20060517160053.GE10310@localdomain>
References: <4025245D-6BAB-41D3-ADB6-2748741F223E@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4025245D-6BAB-41D3-ADB6-2748741F223E@watson.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jimi Xenidis wrote:
> This patch allows the compiler to catch any printf-like mismatches  
> for udbg_printf().
> After some brute force building I've only found issues with my own  
> code and lparcfg.c
> It could break some developers, but IMHO that would be goodness.
> 
> Signed-off-by: Jimi Xenidis <jimix@watson.ibm.com>
> ---
> diff -r 0163968f7fce arch/powerpc/kernel/lparcfg.c
> --- a/arch/powerpc/kernel/lparcfg.c	Tue May 16 15:55:19 2006 -0400
> +++ b/arch/powerpc/kernel/lparcfg.c	Wed May 17 10:43:55 2006 -0400
> @@ -521,10 +521,10 @@ static ssize_t lparcfg_write(struct file
> 	current_weight = (resource >> 5 * 8) & 0xFF;
> -	pr_debug("%s: current_entitled = %lu, current_weight = %lu\n",
> +	pr_debug("%s: current_entitled = %lu, current_weight = %u\n",
> 		 __FUNCTION__, current_entitled, current_weight);
> -	pr_debug("%s: new_entitled = %lu, new_weight = %lu\n",
> +	pr_debug("%s: new_entitled = %lu, new_weight = %u\n",
> 		 __FUNCTION__, *new_entitled_ptr, *new_weight_ptr);
> 	retval = plpar_hcall_norets(H_SET_PPP, *new_entitled_ptr,

Does this really fix a bug?  What warnings are you able to get gcc to
emit?
