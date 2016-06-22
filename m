Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZLGJ0Yp5zDq66
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 20:20:56 +1000 (AEST)
Date: Wed, 22 Jun 2016 18:20:47 +0800
From: Dave Young <dyoung@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 2/9] kexec_file: Generalize kexec_add_buffer.
Message-ID: <20160622102046.GC7752@dhcp-128-65.nay.redhat.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1466538521-31216-3-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466538521-31216-3-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The patch looks good, but could the subject be more specific?

For example just like the first sentence of the patch descriotion:
Allow architectures to specify their own memory walking function

On 06/21/16 at 04:48pm, Thiago Jung Bauermann wrote:
> Allow architectures to specify different memory walking functions for
> kexec_add_buffer. Intel uses iomem to track reserved memory ranges,
> but PowerPC uses the memblock subsystem.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/kexec.h   | 19 ++++++++++++++++++-
>  kernel/kexec_file.c     | 30 ++++++++++++++++++++++--------
>  kernel/kexec_internal.h | 14 --------------
>  3 files changed, 40 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index e8acb2b43dd9..3d91bcfc180d 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -146,7 +146,24 @@ struct kexec_file_ops {
>  	kexec_verify_sig_t *verify_sig;
>  #endif
>  };
> -#endif
> +
> +/*
> + * Keeps track of buffer parameters as provided by caller for requesting
> + * memory placement of buffer.
> + */
> +struct kexec_buf {
> +	struct kimage *image;
> +	unsigned long mem;
> +	unsigned long memsz;
> +	unsigned long buf_align;
> +	unsigned long buf_min;
> +	unsigned long buf_max;
> +	bool top_down;		/* allocate from top of memory hole */
> +};
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

Thanks
Dave
