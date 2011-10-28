Return-Path: <hjk@hansjkoch.de>
Received: from www.hansjkoch.de (www.hansjkoch.de [178.63.77.200])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 753321007DB
 for <linuxppc-dev@ozlabs.org>; Sat, 29 Oct 2011 08:48:31 +1100 (EST)
Date: Fri, 28 Oct 2011 23:48:12 +0200
From: "Hans J. Koch" <hjk@hansjkoch.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH 1/2] uio: allow drivers to override the pgprot for
 mmap
Message-ID: <20111028214812.GD23092@local>
References: <1319817030-23992-1-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319817030-23992-1-git-send-email-galak@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>, hjk@hansjkoch.de, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 28, 2011 at 10:50:29AM -0500, Kumar Gala wrote:
> For some devices, the default behavior of pgprot_noncached() is not
> appropriate for all of its mappable regions. This provides a means for
> the kernel side of the UIO driver to override the flags without having
> to implement its own full mmap callback.

Thanks for also providing an example driver showing the use of this.
You should also post this driver in a mainline-ready version, I'm a bit
uncomfortable with adding a new function pointer without having any users.

And since you change uio_driver.h you should also update documentation
accordingly (Documentation/DocBook/uio-howto.tmpl).

Otherwise, I have no general objections.

Thanks,
Hans

> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: Geoff Thorpe <geoff@geoffthorpe.net>
> ---
>  drivers/uio/uio.c          |    6 +++++-
>  include/linux/uio_driver.h |    3 +++
>  2 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
> index dc27d89..0aebe27 100644
> --- a/drivers/uio/uio.c
> +++ b/drivers/uio/uio.c
> @@ -655,7 +655,11 @@ static int uio_mmap_physical(struct vm_area_struct *vma)
>  
>  	vma->vm_flags |= VM_IO | VM_RESERVED;
>  
> -	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +	if (idev->info->set_pgprot)
> +		vma->vm_page_prot = idev->info->set_pgprot(idev->info, mi,
> +							   vma->vm_page_prot);
> +	else
> +		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>  
>  	return remap_pfn_range(vma,
>  			       vma->vm_start,
> diff --git a/include/linux/uio_driver.h b/include/linux/uio_driver.h
> index fd99ff9..edfe7c8 100644
> --- a/include/linux/uio_driver.h
> +++ b/include/linux/uio_driver.h
> @@ -80,6 +80,7 @@ struct uio_device;
>   * @open:		open operation for this uio device
>   * @release:		release operation for this uio device
>   * @irqcontrol:		disable/enable irqs when 0/1 is written to /dev/uioX
> + * @set_pgprot:		allow driver to override default(noncached) pgprot
>   */
>  struct uio_info {
>  	struct uio_device	*uio_dev;
> @@ -95,6 +96,8 @@ struct uio_info {
>  	int (*open)(struct uio_info *info, struct inode *inode);
>  	int (*release)(struct uio_info *info, struct inode *inode);
>  	int (*irqcontrol)(struct uio_info *info, s32 irq_on);
> +	pgprot_t (*set_pgprot)(struct uio_info *uio, unsigned int mem_idx,
> +			       pgprot_t prot);
>  };
>  
>  extern int __must_check
> -- 
> 1.7.3.4
> 
> 
