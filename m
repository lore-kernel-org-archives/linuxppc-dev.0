Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0E942DDDF7
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2007 04:17:26 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l55IIRSJ032707
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Jun 2007 14:18:27 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l55IHN3q532286
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Jun 2007 14:17:23 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l55IHMgB026391
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Jun 2007 14:17:22 -0400
Subject: Re: [PATCH 2/3] [PATCH powerpc] during VM oom condition, kill all
	threads in process group
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20070605174838.21740.55720.stgit@farscape.rchland.ibm.com>
References: <20070605174831.21740.33119.stgit@farscape.rchland.ibm.com>
	<20070605174838.21740.55720.stgit@farscape.rchland.ibm.com>
Content-Type: text/plain
Date: Tue, 05 Jun 2007 13:17:14 -0500
Message-Id: <1181067435.18837.3.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, anton@samba.org
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Whoops..  sorry about any reply bounces, I flubbed the cc to
linuxppc-dev@ozlabs.org . 

-Will

On Tue, 2007-05-06 at 12:48 -0500, Will Schmidt wrote:
> When we get into a state where VM has ran out of memory, and it's time to
> thwack a process, we should take out the entire process group, rather than
> just one thread.
> 
> Tested on POWER5.
> 
> Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>
> ---
> 
>  arch/powerpc/mm/fault.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 03aeb3a..9afe871 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -392,8 +392,10 @@ out_of_memory:
>  		goto survive;
>  	}
>  	printk("VM: killing process %s\n", current->comm);
> -	if (user_mode(regs))
> +	if (user_mode(regs)) {
> +		zap_other_threads(current);
>  		do_exit(SIGKILL);
> +	}
>  	return SIGKILL;
>  
>  do_sigbus:
> 
> 
