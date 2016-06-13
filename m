Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rSkW05X0XzDqWf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 17:12:28 +1000 (AEST)
Date: Mon, 13 Jun 2016 15:12:21 +0800
From: Dave Young <dyoung@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 2/8] kexec_file: Generalize kexec_add_buffer.
Message-ID: <20160613071221.GC4974@dhcp-128-65.nay.redhat.com>
References: <1465701022-11601-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1465701022-11601-3-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465701022-11601-3-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/12/16 at 12:10am, Thiago Jung Bauermann wrote:
> Allow architectures to specify different memory walking functions for
> kexec_add_buffer. Intel uses iomem to track reserved memory ranges,
> but PowerPC uses the memblock subsystem.
> 
> Also, factor kexec_locate_mem_hole out of kexec_add_buffer. It will be
> used by the PowerPC kexec_file_load implementation to find free memory
> for the purgatory stack.

Split factoring locate hole function to another patch will be clearer.

> 
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/kexec.h | 10 ++++++
>  kernel/kexec_file.c   | 96 +++++++++++++++++++++++++++++++++++++--------------
>  2 files changed, 81 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index e8acb2b43dd9..920e2cbe5bdd 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -210,6 +210,10 @@ extern asmlinkage long sys_kexec_load(unsigned long entry,
>  					struct kexec_segment __user *segments,
>  					unsigned long flags);
>  extern int kernel_kexec(void);
> +int kexec_locate_mem_hole(struct kimage *image, unsigned long size,
> +			  unsigned long align, unsigned long start,
> +			  unsigned long end, bool top_down,
> +			  unsigned long *addr);
>  extern int kexec_add_buffer(struct kimage *image, char *buffer,
>  			    unsigned long bufsz, unsigned long memsz,
>  			    unsigned long buf_align, unsigned long buf_min,
> @@ -315,6 +319,12 @@ int __weak arch_kexec_apply_relocations_add(const Elf_Ehdr *ehdr,
>  					Elf_Shdr *sechdrs, unsigned int relsec);
>  int __weak arch_kexec_apply_relocations(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>  					unsigned int relsec);
> +int __weak arch_walk_iomem(unsigned long desc, unsigned long start,
> +			   unsigned long end, bool top_down, void *data,
> +			   int (*func)(u64, u64, void *));
> +int __weak arch_walk_system_ram(unsigned long start, unsigned long end,
> +				bool top_down, void *data,
> +				int (*func)(u64, u64, void *));
>  void arch_kexec_protect_crashkres(void);
>  void arch_kexec_unprotect_crashkres(void);
>  
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index b6eec7527e9f..300f71cb4f72 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -428,6 +428,68 @@ static int locate_mem_hole_callback(u64 start, u64 end, void *arg)
>  	return locate_mem_hole_bottom_up(start, end, kbuf);
>  }
>  
> +int __weak arch_walk_iomem(unsigned long desc, unsigned long start,
> +			   unsigned long end, bool top_down, void *data,
> +			   int (*func)(u64, u64, void *))
> +{
> +	return walk_iomem_res_desc(desc,
> +				   IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> +				   start, end, data, func);
> +}
> +
> +int __weak arch_walk_system_ram(unsigned long start, unsigned long end,
> +				bool top_down, void *data,
> +				int (*func)(u64, u64, void *))
> +{
> +	return walk_system_ram_res(start, end, data, func);
> +}
> +
> +/**
> + * kexec_locate_mem_hole - find free memory to load segment or use in purgatory
> + * @image:	kexec image being updated.
> + * @size:	Memory size.
> + * @align:	Minimum alignment needed.
> + * @start:	Minimum starting address.
> + * @end:	Maximum end address.
> + * @top_down	Find the highest free memory region?
> + * @addr	On success, will have start address of the memory region found.
> + *
> + * Return: 0 on success, negative erro on failure.
> + */
> +int kexec_locate_mem_hole(struct kimage *image, unsigned long size,
> +			  unsigned long align, unsigned long start,
> +			  unsigned long end, bool top_down, unsigned long *addr)
> +{
> +	int ret;
> +	struct kexec_buf buf;
> +
> +	memset(&buf, 0, sizeof(struct kexec_buf));
> +	buf.image = image;
> +
> +	buf.memsz = size;
> +	buf.buf_align = align;
> +	buf.buf_min = start;
> +	buf.buf_max = end;
> +	buf.top_down = top_down;
> +
> +	/* Walk the RAM ranges and allocate a suitable range for the buffer */
> +	if (image->type == KEXEC_TYPE_CRASH)
> +		ret = arch_walk_iomem(crashk_res.desc, crashk_res.start,
> +				      crashk_res.end, top_down, &buf,
> +				      locate_mem_hole_callback);
> +	else
> +		ret = arch_walk_system_ram(0, -1, top_down, &buf,
> +					   locate_mem_hole_callback);
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
> @@ -439,8 +501,8 @@ int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
>  {
>  
>  	struct kexec_segment *ksegment;
> -	struct kexec_buf buf, *kbuf;
>  	int ret;
> +	unsigned long addr, align, size;
>  
>  	/* Currently adding segment this way is allowed only in file mode */
>  	if (!image->file_mode)
> @@ -461,36 +523,20 @@ int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
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
> -	/* Walk the RAM ranges and allocate a suitable range for the buffer */
> -	if (image->type == KEXEC_TYPE_CRASH)
> -		ret = walk_iomem_res_desc(crashk_res.desc,
> -				IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> -				crashk_res.start, crashk_res.end, kbuf,
> -				locate_mem_hole_callback);
> -	else
> -		ret = walk_system_ram_res(0, -1, kbuf,
> -					  locate_mem_hole_callback);
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
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
