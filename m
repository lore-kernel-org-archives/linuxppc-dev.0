Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rnr4M3QLPzDqyy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 13:22:11 +1000 (AEST)
Date: Mon, 11 Jul 2016 11:22:03 +0800
From: Dave Young <dyoung@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v4 3/9] kexec_file: Factor out kexec_locate_mem_hole from
 kexec_add_buffer.
Message-ID: <20160711032203.GD2850@dhcp-128-65.nay.redhat.com>
References: <1467908615-18952-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1467908615-18952-4-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467908615-18952-4-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/07/16 at 01:23pm, Thiago Jung Bauermann wrote:
> kexec_locate_mem_hole will be used by the PowerPC kexec_file_load
> implementation to find free memory for the purgatory stack.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Dave Young <dyoung@redhat.com>
> ---
>  include/linux/kexec.h |  1 +
>  kernel/kexec_file.c   | 25 ++++++++++++++++++++-----
>  2 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index ff5fa7707bd7..803f563df81d 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -174,6 +174,7 @@ struct kexec_buf {
>  int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
>  			       int (*func)(u64, u64, void *));
>  extern int kexec_add_buffer(struct kexec_buf *kbuf);
> +int kexec_locate_mem_hole(struct kexec_buf *kbuf);
>  #endif /* CONFIG_KEXEC_FILE */
>  
>  struct kimage {
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 82ccfc4ee97e..3125d1689712 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -450,6 +450,23 @@ int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
>  }
>  
>  /**
> + * kexec_locate_mem_hole - find free memory for the purgatory or the next kernel
> + * @kbuf:	Parameters for the memory search.
> + *
> + * On success, kbuf->mem will have the start address of the memory region found.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +int kexec_locate_mem_hole(struct kexec_buf *kbuf)
> +{
> +	int ret;
> +
> +	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
> +
> +	return ret == 1 ? 0 : -EADDRNOTAVAIL;
> +}
> +
> +/**
>   * kexec_add_buffer - place a buffer in a kexec segment
>   * @kbuf:	Buffer contents and memory parameters.
>   *
> @@ -489,11 +506,9 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
>  	kbuf->buf_align = max(kbuf->buf_align, PAGE_SIZE);
>  
>  	/* Walk the RAM ranges and allocate a suitable range for the buffer */
> -	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
> -	if (ret != 1) {
> -		/* A suitable memory range could not be found for buffer */
> -		return -EADDRNOTAVAIL;
> -	}
> +	ret = kexec_locate_mem_hole(kbuf);
> +	if (ret)
> +		return ret;
>  
>  	/* Found a suitable memory range */
>  	ksegment = &kbuf->image->segment[kbuf->image->nr_segments];
> -- 
> 1.9.1
> 

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave
