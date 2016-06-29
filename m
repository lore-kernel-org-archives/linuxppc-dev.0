Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rftWR5ZbtzDqnQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 05:48:03 +1000 (AEST)
Date: Wed, 29 Jun 2016 15:47:51 -0400
From: Dave Young <dyoung@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 2/9] kexec_file: Generalize kexec_add_buffer.
Message-ID: <20160629194751.GB5488@dhcp-128-65.nay.redhat.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <3343161.EAM0BCreCn@hactar>
 <20160623022506.GA12575@dhcp-128-11.nay.redhat.com>
 <2060648.f0n9OPAato@hactar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2060648.f0n9OPAato@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/28/16 at 07:18pm, Thiago Jung Bauermann wrote:
> Am Donnerstag, 23 Juni 2016, 10:25:06 schrieb Dave Young:
> > On 06/22/16 at 08:30pm, Thiago Jung Bauermann wrote:
> > > Am Mittwoch, 22 Juni 2016, 18:20:47 schrieb Dave Young:
> > > > The patch looks good, but could the subject be more specific?
> > > > 
> > > > For example just like the first sentence of the patch descriotion:
> > > > Allow architectures to specify their own memory walking function
> > > 
> > > Ok, What about this? I also changed the description to refer to x86 arch
> > > instead of Intel arch.
> > 
> > It looks good to me.
> 
> This version has the struct kexec_buf documentation comments that were
> in patch 3/9. I fixed the names of the struct members, and changed their
> descriptions to try to be clearer.
> -- 
> []'s
> Thiago Jung Bauermann
> IBM Linux Technology Center
> 
> 
> Subject: [PATCH 2/9] kexec_file: Allow arch-specific memory walking for
>  kexec_add_buffer
> 
> Allow architectures to specify a different memory walking function for
> kexec_add_buffer. x86 uses iomem to track reserved memory ranges, but
> PowerPC uses the memblock subsystem.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/kexec.h   | 25 ++++++++++++++++++++++++-
>  kernel/kexec_file.c     | 30 ++++++++++++++++++++++--------
>  kernel/kexec_internal.h | 14 --------------
>  3 files changed, 46 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index e8acb2b43dd9..e16d845d587f 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -146,7 +146,30 @@ struct kexec_file_ops {
>  	kexec_verify_sig_t *verify_sig;
>  #endif
>  };
> -#endif
> +
> +/**
> + * struct kexec_buf - parameters for finding a place for a buffer in memory
> + * @image:	kexec image in which memory to search.
> + * @mem:	On return will have address of the buffer in memory.
> + * @memsz:	Size for the buffer in memory.
> + * @buf_align:	Minimum alignment needed.
> + * @buf_min:	The buffer can't be placed below this address.
> + * @buf_max:	The buffer can't be placed above this address.
> + * @top_down:	Allocate from top of memory.
> + */
> +struct kexec_buf {
> +	struct kimage *image;
> +	unsigned long mem;
> +	unsigned long memsz;
> +	unsigned long buf_align;
> +	unsigned long buf_min;
> +	unsigned long buf_max;
> +	bool top_down;
> +};

Rethink about the first patch, you dropped the user buffer in kexec_buf
But later your passing IMA digests buffer patchset may need use it.

So keep it in kexec_buf should be better.

For the IMA buffer patchset I'm still reading and learning the
background, will reply them later.

> +
> +int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
> +			       int (*func)(u64, u64, void *));
> +#endif /* CONFIG_KEXEC_FILE */
>  
>  struct kimage {
>  	kimage_entry_t head;
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index b6eec7527e9f..b1f1f6402518 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -428,6 +428,27 @@ static int locate_mem_hole_callback(u64 start, u64 end, void *arg)
>  	return locate_mem_hole_bottom_up(start, end, kbuf);
>  }
>  
> +/**
> + * arch_kexec_walk_mem - call func(data) on free memory regions
> + * @kbuf:	Context info for the search. Also passed to @func.
> + * @func:	Function to call for each memory region.
> + *
> + * Return: The memory walk will stop when func returns a non-zero value
> + * and that value will be returned. If all free regions are visited without
> + * func returning non-zero, then zero will be returned.
> + */
> +int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
> +			       int (*func)(u64, u64, void *))
> +{
> +	if (kbuf->image->type == KEXEC_TYPE_CRASH)
> +		return walk_iomem_res_desc(crashk_res.desc,
> +					   IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> +					   crashk_res.start, crashk_res.end,
> +					   kbuf, func);
> +	else
> +		return walk_system_ram_res(0, ULONG_MAX, kbuf, func);
> +}
> +
>  /*
>   * Helper function for placing a buffer in a kexec segment. This assumes
>   * that kexec_mutex is held.
> @@ -472,14 +493,7 @@ int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
>  	kbuf->top_down = top_down;
>  
>  	/* Walk the RAM ranges and allocate a suitable range for the buffer */
> -	if (image->type == KEXEC_TYPE_CRASH)
> -		ret = walk_iomem_res_desc(crashk_res.desc,
> -				IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> -				crashk_res.start, crashk_res.end, kbuf,
> -				locate_mem_hole_callback);
> -	else
> -		ret = walk_system_ram_res(0, -1, kbuf,
> -					  locate_mem_hole_callback);
> +	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
>  	if (ret != 1) {
>  		/* A suitable memory range could not be found for buffer */
>  		return -EADDRNOTAVAIL;
> diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
> index eefd5bf960c2..4cef7e4706b0 100644
> --- a/kernel/kexec_internal.h
> +++ b/kernel/kexec_internal.h
> @@ -20,20 +20,6 @@ struct kexec_sha_region {
>  	unsigned long len;
>  };
>  
> -/*
> - * Keeps track of buffer parameters as provided by caller for requesting
> - * memory placement of buffer.
> - */
> -struct kexec_buf {
> -	struct kimage *image;
> -	unsigned long mem;
> -	unsigned long memsz;
> -	unsigned long buf_align;
> -	unsigned long buf_min;
> -	unsigned long buf_max;
> -	bool top_down;		/* allocate from top of memory hole */
> -};
> -
>  void kimage_file_post_load_cleanup(struct kimage *image);
>  #else /* CONFIG_KEXEC_FILE */
>  static inline void kimage_file_post_load_cleanup(struct kimage *image) { }
> -- 
> 1.9.1
> 
> 

Thanks
Dave
