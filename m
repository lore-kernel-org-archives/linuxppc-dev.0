Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZLC74p08zDq66
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 20:18:11 +1000 (AEST)
Date: Wed, 22 Jun 2016 18:18:01 +0800
From: Dave Young <dyoung@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 3/9] kexec_file: Factor out kexec_locate_mem_hole from
 kexec_add_buffer.
Message-ID: <20160622101801.GB7752@dhcp-128-65.nay.redhat.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1466538521-31216-4-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466538521-31216-4-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/21/16 at 04:48pm, Thiago Jung Bauermann wrote:
> kexec_locate_mem_hole will be used by the PowerPC kexec_file_load
> implementation to find free memory for the purgatory stack.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/kexec.h |  4 ++++
>  kernel/kexec_file.c   | 66 ++++++++++++++++++++++++++++++++++++++-------------
>  2 files changed, 53 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 3d91bcfc180d..4ca6f5f95d66 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -227,6 +227,10 @@ extern asmlinkage long sys_kexec_load(unsigned long entry,
>  					struct kexec_segment __user *segments,
>  					unsigned long flags);
>  extern int kernel_kexec(void);
> +int kexec_locate_mem_hole(struct kimage *image, unsigned long size,
> +			  unsigned long align, unsigned long min_addr,
> +			  unsigned long max_addr, bool top_down,
> +			  unsigned long *addr);
>  extern int kexec_add_buffer(struct kimage *image, char *buffer,
>  			    unsigned long bufsz, unsigned long memsz,
>  			    unsigned long buf_align, unsigned long buf_min,
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index b1f1f6402518..85a515511925 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -449,6 +449,46 @@ int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
>  		return walk_system_ram_res(0, ULONG_MAX, kbuf, func);
>  }
>  
> +/**
> + * kexec_locate_mem_hole - find free memory to load segment or use in purgatory
> + * @image:	kexec image being updated.
> + * @size:	Memory size.
> + * @align:	Minimum alignment needed.
> + * @min_addr:	Minimum starting address.
> + * @max_addr:	Maximum end address.
> + * @top_down	Find the highest free memory region?
> + * @addr	On success, will have start address of the memory region found.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +int kexec_locate_mem_hole(struct kimage *image, unsigned long size,
> +			  unsigned long align, unsigned long min_addr,
> +			  unsigned long max_addr, bool top_down,
> +			  unsigned long *addr)
> +{
> +	int ret;
> +	struct kexec_buf buf;
> +
> +	memset(&buf, 0, sizeof(struct kexec_buf));
> +	buf.image = image;
> +
> +	buf.memsz = size;
> +	buf.buf_align = align;
> +	buf.buf_min = min_addr;
> +	buf.buf_max = max_addr;
> +	buf.top_down = top_down;

Since patch 2/9 moved kexec_buf from internal header file to kexec.h it
will be natural to passing a kexec_buf pointer intead of passing all
these arguments in kexec_locate_mem_hole.

kbuf.mem can be used for addr.

> +
> +	ret = arch_kexec_walk_mem(&buf, locate_mem_hole_callback);
> +	if (ret != 1) {
> +		/* A suitable memory range could not be found for buffer */
> +		return -EADDRNOTAVAIL;
> +	}
> +
> +	*addr = buf.mem;
> +
> +	return 0;
> +}
> +
>  /*
>   * Helper function for placing a buffer in a kexec segment. This assumes
>   * that kexec_mutex is held.
> @@ -460,8 +500,8 @@ int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
>  {
>  
>  	struct kexec_segment *ksegment;
> -	struct kexec_buf buf, *kbuf;
>  	int ret;
> +	unsigned long addr, align, size;
>  
>  	/* Currently adding segment this way is allowed only in file mode */
>  	if (!image->file_mode)
> @@ -482,29 +522,21 @@ int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
>  		return -EINVAL;
>  	}
>  
> -	memset(&buf, 0, sizeof(struct kexec_buf));
> -	kbuf = &buf;
> -	kbuf->image = image;
> -
> -	kbuf->memsz = ALIGN(memsz, PAGE_SIZE);
> -	kbuf->buf_align = max(buf_align, PAGE_SIZE);
> -	kbuf->buf_min = buf_min;
> -	kbuf->buf_max = buf_max;
> -	kbuf->top_down = top_down;
> +	size = ALIGN(memsz, PAGE_SIZE);
> +	align = max(buf_align, PAGE_SIZE);
>  
>  	/* Walk the RAM ranges and allocate a suitable range for the buffer */
> -	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
> -	if (ret != 1) {
> -		/* A suitable memory range could not be found for buffer */
> -		return -EADDRNOTAVAIL;
> -	}
> +	ret = kexec_locate_mem_hole(image, size, align, buf_min, buf_max,
> +				    top_down, &addr);
> +	if (ret)
> +		return ret;
>  
>  	/* Found a suitable memory range */
>  	ksegment = &image->segment[image->nr_segments];
>  	ksegment->kbuf = buffer;
>  	ksegment->bufsz = bufsz;
> -	ksegment->mem = kbuf->mem;
> -	ksegment->memsz = kbuf->memsz;
> +	ksegment->mem = addr;
> +	ksegment->memsz = size;
>  	image->nr_segments++;
>  	*load_addr = ksegment->mem;
>  	return 0;

Thanks
Dave
