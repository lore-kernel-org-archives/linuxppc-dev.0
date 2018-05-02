Return-Path: <rashmica.g@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bRDw3pWWzF2RN
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 15:10:40 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id p9-v6so6851713pgc.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 May 2018 22:10:40 -0700 (PDT)
Subject: Re: [resend] Revert "powerpc/powernv: Increase memory block size to
 1GB on radix"
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Michael Neuling <mikey@neuling.org>
References: <20180501025725.7441-1-bsingharora@gmail.com>
From: rashmica <rashmica.g@gmail.com>
Message-ID: <58c3feb3-390c-2461-2bca-5b71f8dd14df@gmail.com>
Date: Wed, 2 May 2018 15:10:33 +1000
MIME-Version: 1.0
In-Reply-To: <20180501025725.7441-1-bsingharora@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tested hot-unplugging dimm device on radix guest on p9 host with KVM.


On 01/05/18 12:57, Balbir Singh wrote:
> This commit was a stop-gap to prevent crashes on hotunplug, caused by
> the mismatch between the 1G mappings used for the linear mapping and the
> memory block size. Those issues are now resolved because we split the
> linear mapping at hotunplug time if necessary, as implemented in commit
> 4dd5f8a99e79 ("powerpc/mm/radix: Split linear mapping on hot-unplug").
>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
Tested-by: Rashmica Gupta <rashmica.g@gmail.com>
> ---
>
> Resend with a newer commit message grabbed from an email sent by mpe.
>
>  arch/powerpc/platforms/powernv/setup.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
> index ef8c9ce53a61..fa63d3fff14c 100644
> --- a/arch/powerpc/platforms/powernv/setup.c
> +++ b/arch/powerpc/platforms/powernv/setup.c
> @@ -356,15 +356,7 @@ static void pnv_kexec_cpu_down(int crash_shutdown, int secondary)
>  #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
>  static unsigned long pnv_memory_block_size(void)
>  {
> -	/*
> -	 * We map the kernel linear region with 1GB large pages on radix. For
> -	 * memory hot unplug to work our memory block size must be at least
> -	 * this size.
> -	 */
> -	if (radix_enabled())
> -		return 1UL * 1024 * 1024 * 1024;
> -	else
> -		return 256UL * 1024 * 1024;
> +	return 256UL * 1024 * 1024;
>  }
>  #endif
>  
