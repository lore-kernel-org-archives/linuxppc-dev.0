Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425Xr24m15zF381
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 17:53:22 +1000 (AEST)
Date: Thu, 6 Sep 2018 09:53:19 +0200
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
Subject: Re: [RFC PATCH 11/29] memblock: replace alloc_bootmem_pages_nopanic
 with memblock_alloc_nopanic
Message-ID: <20180906075319.GT14951@dhcp22.suse.cz>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536163184-26356-12-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1536163184-26356-12-git-send-email-rppt@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 05-09-18 18:59:26, Mike Rapoport wrote:
> The alloc_bootmem_pages_nopanic(size) is a shortcut for
> __alloc_bootmem_nopanic(x, PAGE_SIZE, BOOTMEM_LOW_LIMIT) and can be
> replaced by memblock_alloc_nopanic(size, PAGE_SIZE)

It is not so straightforward because you really have to go deep down the
callpath to see they are doing the same thing essentially.

> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  drivers/usb/early/xhci-dbc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/early/xhci-dbc.c b/drivers/usb/early/xhci-dbc.c
> index e15e896..16df968 100644
> --- a/drivers/usb/early/xhci-dbc.c
> +++ b/drivers/usb/early/xhci-dbc.c
> @@ -94,7 +94,7 @@ static void * __init xdbc_get_page(dma_addr_t *dma_addr)
>  {
>  	void *virt;
>  
> -	virt = alloc_bootmem_pages_nopanic(PAGE_SIZE);
> +	virt = memblock_alloc_nopanic(PAGE_SIZE, PAGE_SIZE);
>  	if (!virt)
>  		return NULL;
>  
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
