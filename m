Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C40B9DDFDF
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 02:42:05 +1000 (EST)
Message-ID: <483450D3.7050900@am.sony.com>
Date: Wed, 21 May 2008 09:41:55 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch v2] PS3: Fix memory hotplug
References: <4829C07A.4040407@am.sony.com> <482C9897.90709@am.sony.com>
In-Reply-To: <482C9897.90709@am.sony.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Levand wrote:
> A change was made to walk_memory_resource() in commit
> 4b119e21d0c66c22e8ca03df05d9de623d0eb50f that added a
> check of find_lmb().  Add the coresponding lmb_add()
> call to ps3_mm_add_memory() so that that check will
> succeed.
> 
> This fixes the condition where the PS3 boots up with
> only the 128 MiB of boot memory.
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> ---
> 
> v2: Add call to lmb_analyze().
> 
>  arch/powerpc/platforms/ps3/mm.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- a/arch/powerpc/platforms/ps3/mm.c
> +++ b/arch/powerpc/platforms/ps3/mm.c
> @@ -317,6 +317,9 @@ static int __init ps3_mm_add_memory(void
>  		return result;
>  	}
>  
> +	lmb_add(start_addr, map.r1.size);
> +	lmb_analyze();
> +
>  	result = online_pages(start_pfn, nr_pages);
>  
>  	if (result)
> 

Hi Paul,

Could you please merge this one in for 2.6.26.  Without it the
system boots with just 128 of the total 256 MiB of memory.

There is the concurrency problem as Ben commented on, but I
think not having the 128 MiB of memory is worse than having the
potential race, which we can work on as a separate fix.

-Geoff
