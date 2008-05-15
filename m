Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 14362DDEFD
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 16:49:02 +1000 (EST)
Subject: Re: PS3: Fix memory hotplug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <4829C07A.4040407@am.sony.com>
References: <4829C07A.4040407@am.sony.com>
Content-Type: text/plain
Date: Wed, 14 May 2008 23:48:45 -0700
Message-Id: <1210834125.8297.80.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-05-13 at 09:23 -0700, Geoff Levand wrote:
> A change was made to walk_memory_resource() in commit
> 4b119e21d0c66c22e8ca03df05d9de623d0eb50f that added a
> check of find_lmb().  Add the corresponding lmb_add()
> call to ps3_mm_add_memory() so that that check will
> succeed.
> 
> This fixes the condition where the PS3 boots up with
> just the 128 MiB of boot memory.
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> ---

When you do an lmb_add you should probably also do an lmb_analyze to
update the total memory count etc...

That leads to some interesting issues such as the LMB stuff wasn't
really meant to be dynamically modified after boot, and thus the kernel
has no locks in there. That can be an issue...

Paul, any thoughts here ? Should we add a lock ? That would mean being
careful as the LMB stuff can be called very early, and spinlock wants
things like PACA and possibly lockdep to be around.. 

Ben.

> Paul,
> 
> Please send this one upstream at your earliest convenience.
> 
> -Geoff
> 
>  arch/powerpc/platforms/ps3/mm.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- a/arch/powerpc/platforms/ps3/mm.c
> +++ b/arch/powerpc/platforms/ps3/mm.c
> @@ -317,6 +317,8 @@ static int __init ps3_mm_add_memory(void
>  		return result;
>  	}
>  
> +	lmb_add(start_addr, map.r1.size);
> +
>  	result = online_pages(start_pfn, nr_pages);
>  
>  	if (result)
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
