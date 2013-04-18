Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 759E92C0170
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2013 16:33:59 +1000 (EST)
Message-ID: <1366266830.24994.80.camel@pasglop>
Subject: Re: [PATCH] powerpc/mm: Use tlbiel for 4KB pages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Thu, 18 Apr 2013 08:33:50 +0200
In-Reply-To: <1366263235-7787-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1366263235-7787-1-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-04-18 at 13:33 +0800, Gavin Shan wrote:
> The firmware should have supplied correct information for the kernel
> to figure out the page size array, which is traced by mmu_psize_defs[].
> Otherwise, the kernel will fail back to use solely 4KB page size
> and copy mmu_psize_defaults_old[] over to mmu_psize_defs[]. However,
> the "tlbiel" isn't enabled in mmu_psize_defaults_old[].

Did you actually find a problem here ? There is a reason we don't enable
tlbiel in there ... those old CPUs do not support it.

Ben.

> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/hash_utils_64.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 2d4a20c..8675ae5 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -130,7 +130,7 @@ static struct mmu_psize_def mmu_psize_defaults_old[] = {
>  		.sllp	= 0,
>  		.penc	= 0,
>  		.avpnm	= 0,
> -		.tlbiel = 0,
> +		.tlbiel = 1,
>  	},
>  };
>  
