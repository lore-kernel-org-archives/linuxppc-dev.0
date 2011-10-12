Return-Path: <hjk@hansjkoch.de>
Received: from www.hansjkoch.de (www.hansjkoch.de [178.63.77.200])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 65E20B6F85
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Oct 2011 03:17:56 +1100 (EST)
Date: Wed, 12 Oct 2011 17:35:36 +0200
From: "Hans J. Koch" <hjk@hansjkoch.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] UIO: Allow a UIO driver to override the default pgprot
 when we mmap
Message-ID: <20111012153536.GC21852@local>
References: <1318430616-20351-1-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318430616-20351-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, hjk@hansjkoch.de, gregkh@suse.de,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 12, 2011 at 09:43:36AM -0500, Kumar Gala wrote:
> For some devices the default behavior of pgprot_noncached is not
> the correct flags for the address space.

For what devices? Can you give a real world usecase where this is needed?

Thanks,
Hans

> Provide a means for the
> kernel side UIO driver to override the flags without having to
> implement its own full mmap callback.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  drivers/uio/uio.c          |    6 +++++-
>  include/linux/uio_driver.h |    2 ++
>  2 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
> index d2efe82..88f4444 100644
> --- a/drivers/uio/uio.c
> +++ b/drivers/uio/uio.c
> @@ -656,7 +656,11 @@ static int uio_mmap_physical(struct vm_area_struct *vma)
>  
>  	vma->vm_flags |= VM_IO | VM_RESERVED;
>  
> -	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +	if (idev->info->mem[mi].set_pgprot)
> +		vma->vm_page_prot =
> +			idev->info->mem[mi].set_pgprot(vma->vm_page_prot);
> +	else
> +		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>  
>  	return remap_pfn_range(vma,
>  			       vma->vm_start,
> diff --git a/include/linux/uio_driver.h b/include/linux/uio_driver.h
> index 665517c..4c618cd 100644
> --- a/include/linux/uio_driver.h
> +++ b/include/linux/uio_driver.h
> @@ -28,6 +28,7 @@ struct uio_map;
>   * @memtype:		type of memory addr points to
>   * @internal_addr:	ioremap-ped version of addr, for driver internal use
>   * @map:		for use by the UIO core only.
> + * @set_pgprot:		allow driver to override default(noncached) pgprot
>   */
>  struct uio_mem {
>  	const char		*name;
> @@ -36,6 +37,7 @@ struct uio_mem {
>  	int			memtype;
>  	void __iomem		*internal_addr;
>  	struct uio_map		*map;
> +	pgprot_t (*set_pgprot)(pgprot_t prot);
>  };
>  
>  #define MAX_UIO_MAPS	5
> -- 
> 1.7.3.4
> 
> 
