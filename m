Return-Path: <michael@ellerman.id.au>
Date: Wed, 6 Mar 2013 14:24:54 +1100
From: Michael Ellerman <michael@ellerman.id.au>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Fix next available MSI IRQ
Message-ID: <20130306032454.GA3493@concordia>
References: <1362466756-16113-1-git-send-email-shangw@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1362466756-16113-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 05, 2013 at 02:59:16PM +0800, Gavin Shan wrote:
> The allocation of MSI is implemented based on bitmap and working
> like the mechanism of strict round through the traced next available
> cursor. However, the next available MSI is never updated in current
> implementation. The patch fixes the issue.
> 
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/pci.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index 6f464dc..9cf18c4 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -66,6 +66,11 @@ static unsigned int pnv_get_one_msi(struct pnv_phb *phb)
>  		rc = 0;
>  		goto out;
>  	}
> +
> +	if (id >= phb->msi_count - 1)
> +		phb->msi_next = 0;
> +	else
> +		phb->msi_next = id + 1;
>  	__set_bit(id, phb->msi_map);


There is code in arch/powerpc/sysdev/msi_bitmap.c that implements a
bitmap allocator for MSI. It may not do what you need but please take a
look at it if you haven't already.

cheers
