Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425XZ62BN2zF38S
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 17:41:18 +1000 (AEST)
Date: Thu, 6 Sep 2018 09:41:14 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>,
 Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 09/29] memblock: replace alloc_bootmem_low with
 memblock_alloc_low
Message-ID: <20180906074114.GR14951@dhcp22.suse.cz>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536163184-26356-10-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1536163184-26356-10-git-send-email-rppt@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 05-09-18 18:59:24, Mike Rapoport wrote:
> The functions are equivalent, just the later does not require nobootmem
> translation layer.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

modulo @memblock_alloc_low@@memblock_virt_alloc_low@
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/x86/kernel/tce_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/tce_64.c b/arch/x86/kernel/tce_64.c
> index f386bad..54c9b5a 100644
> --- a/arch/x86/kernel/tce_64.c
> +++ b/arch/x86/kernel/tce_64.c
> @@ -173,7 +173,7 @@ void * __init alloc_tce_table(void)
>  	size = table_size_to_number_of_entries(specified_table_size);
>  	size *= TCE_ENTRY_SIZE;
>  
> -	return __alloc_bootmem_low(size, size, 0);
> +	return memblock_alloc_low(size, size);
>  }
>  
>  void __init free_tce_table(void *tbl)
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
