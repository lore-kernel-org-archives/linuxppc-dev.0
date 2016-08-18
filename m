Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFKsF4CqqzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 19:04:01 +1000 (AEST)
Date: Thu, 18 Aug 2016 17:03:30 +0800
From: Dave Young <dyoung@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Balbir Singh <bsingharora@gmail.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-ima-devel@lists.sourceforge.net,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>,
 Petko Manolov <petkan@mip-labs.com>, Thomas Gleixner <tglx@linutronix.de>,
 Eric Richter <erichte@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 David Laight <David.Laight@ACULAB.COM>,
 Eric Biederman <ebiederm@xmission.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 3/6] kexec_file: Allow skipping checksum calculation
 for some segments.
Message-ID: <20160818090330.GC845@dhcp-128-65.nay.redhat.com>
References: <1471058305-30198-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1471058305-30198-4-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471058305-30198-4-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/13/16 at 12:18am, Thiago Jung Bauermann wrote:
> Adds checksum argument to kexec_add_buffer specifying whether the given
> segment should be part of the checksum calculation.
> 

Since it is used with add buffer, could it be added to kbuf as a new
field?

Like kbuf.no_checksum, default value is 0 that means checksum is needed
if it is 1 then no need a checksum.

> The next patch will add a way to update segments after a kimage is loaded.
> Segments that will be updated in this way should not be checksummed,
> otherwise they will cause the purgatory checksum verification to fail
> when the machine is rebooted.
> 
> As a bonus, we don't need to special-case the purgatory segment anymore
> to avoid checksumming it.
> 
> Adjust call sites for the new argument.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/kexec_elf_64.c |  6 +++---
>  arch/x86/kernel/crash.c            |  4 ++--
>  arch/x86/kernel/kexec-bzimage64.c  |  6 +++---
>  include/linux/kexec.h              | 10 +++++++---
>  kernel/kexec_file.c                | 23 ++++++++++++-----------
>  5 files changed, 27 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kexec_elf_64.c b/arch/powerpc/kernel/kexec_elf_64.c
> index 22afc7b5ee73..4c528c81b076 100644
> --- a/arch/powerpc/kernel/kexec_elf_64.c
> +++ b/arch/powerpc/kernel/kexec_elf_64.c
> @@ -128,7 +128,7 @@ static int elf_exec_load(struct kimage *image, struct elfhdr *ehdr,
>  		kbuf.memsz = phdr->p_memsz;
>  		kbuf.buf_align = phdr->p_align;
>  		kbuf.buf_min = phdr->p_paddr + base;
> -		ret = kexec_add_buffer(&kbuf);
> +		ret = kexec_add_buffer(&kbuf, true);
>  		if (ret)
>  			goto out;
>  		load_addr = kbuf.mem;
> @@ -188,7 +188,7 @@ void *elf64_load(struct kimage *image, char *kernel_buf,
>  		kbuf.bufsz = kbuf.memsz = initrd_len;
>  		kbuf.buf_align = PAGE_SIZE;
>  		kbuf.top_down = false;
> -		ret = kexec_add_buffer(&kbuf);
> +		ret = kexec_add_buffer(&kbuf, true);
>  		if (ret)
>  			goto out;
>  		initrd_load_addr = kbuf.mem;
> @@ -245,7 +245,7 @@ void *elf64_load(struct kimage *image, char *kernel_buf,
>  	kbuf.bufsz = kbuf.memsz = fdt_size;
>  	kbuf.buf_align = PAGE_SIZE;
>  	kbuf.top_down = true;
> -	ret = kexec_add_buffer(&kbuf);
> +	ret = kexec_add_buffer(&kbuf, true);
>  	if (ret)
>  		goto out;
>  	fdt_load_addr = kbuf.mem;
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 38a1cdf6aa05..634ab16377b1 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -642,7 +642,7 @@ int crash_load_segments(struct kimage *image)
>  		 * copied in purgatory after crash. Just add a zero filled
>  		 * segment for now to make sure checksum logic works fine.
>  		 */
> -		ret = kexec_add_buffer(&kbuf);
> +		ret = kexec_add_buffer(&kbuf, true);
>  		if (ret)
>  			return ret;
>  		image->arch.backup_load_addr = kbuf.mem;
> @@ -661,7 +661,7 @@ int crash_load_segments(struct kimage *image)
>  
>  	kbuf.memsz = kbuf.bufsz;
>  	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
> -	ret = kexec_add_buffer(&kbuf);
> +	ret = kexec_add_buffer(&kbuf, true);
>  	if (ret) {
>  		vfree((void *)image->arch.elf_headers);
>  		return ret;
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 4b3a75329fb6..a46e3fbb0639 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -422,7 +422,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>  	kbuf.memsz = kbuf.bufsz;
>  	kbuf.buf_align = 16;
>  	kbuf.buf_min = MIN_BOOTPARAM_ADDR;
> -	ret = kexec_add_buffer(&kbuf);
> +	ret = kexec_add_buffer(&kbuf, true);
>  	if (ret)
>  		goto out_free_params;
>  	bootparam_load_addr = kbuf.mem;
> @@ -435,7 +435,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>  	kbuf.memsz = PAGE_ALIGN(header->init_size);
>  	kbuf.buf_align = header->kernel_alignment;
>  	kbuf.buf_min = MIN_KERNEL_LOAD_ADDR;
> -	ret = kexec_add_buffer(&kbuf);
> +	ret = kexec_add_buffer(&kbuf, true);
>  	if (ret)
>  		goto out_free_params;
>  	kernel_load_addr = kbuf.mem;
> @@ -449,7 +449,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>  		kbuf.bufsz = kbuf.memsz = initrd_len;
>  		kbuf.buf_align = PAGE_SIZE;
>  		kbuf.buf_min = MIN_INITRD_LOAD_ADDR;
> -		ret = kexec_add_buffer(&kbuf);
> +		ret = kexec_add_buffer(&kbuf, true);
>  		if (ret)
>  			goto out_free_params;
>  		initrd_load_addr = kbuf.mem;
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 4559a1a01b0a..37eea32fdff1 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -100,6 +100,9 @@ struct kexec_segment {
>  	size_t bufsz;
>  	unsigned long mem;
>  	size_t memsz;
> +
> +	/* Whether this segment is part of the checksum calculation. */
> +	bool do_checksum;
>  };
>  
>  #ifdef CONFIG_COMPAT
> @@ -175,7 +178,7 @@ struct kexec_buf {
>  
>  int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
>  			       int (*func)(u64, u64, void *));
> -extern int kexec_add_buffer(struct kexec_buf *kbuf);
> +extern int kexec_add_buffer(struct kexec_buf *kbuf, bool checksum);
>  int kexec_locate_mem_hole(struct kexec_buf *kbuf);
>  int __weak arch_kexec_verify_buffer(enum kexec_file_type type, const void *buf,
>  				    unsigned long size);
> @@ -393,7 +396,7 @@ bool __weak kexec_can_hand_over_buffer(void);
>  int __weak arch_kexec_add_handover_buffer(struct kimage *image,
>  					  unsigned long load_addr,
>  					  unsigned long size);
> -int kexec_add_handover_buffer(struct kexec_buf *kbuf);
> +int kexec_add_handover_buffer(struct kexec_buf *kbuf, bool checksum);
>  int __weak kexec_get_handover_buffer(void **addr, unsigned long *size);
>  int __weak kexec_free_handover_buffer(void);
>  #else
> @@ -402,7 +405,8 @@ static inline bool kexec_can_hand_over_buffer(void)
>  	return false;
>  }
>  
> -static inline int kexec_add_handover_buffer(struct kexec_buf *kbuf)
> +static inline int kexec_add_handover_buffer(struct kexec_buf *kbuf,
> +					    bool checksum)
>  {
>  	return -ENOTSUPP;
>  }
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index c8418d62e2fc..aed51175915f 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -161,6 +161,7 @@ int __weak arch_kexec_add_handover_buffer(struct kimage *image,
>  /**
>   * kexec_add_handover_buffer - add buffer to be used by the next kernel
>   * @kbuf:	Buffer contents and memory parameters.
> + * @checksum:	Should the segment checksum be verified by the purgatory?
>   *
>   * This function assumes that kexec_mutex is held.
>   * On successful return, @kbuf->mem will have the physical address of
> @@ -168,14 +169,14 @@ int __weak arch_kexec_add_handover_buffer(struct kimage *image,
>   *
>   * Return: 0 on success, negative errno on error.
>   */
> -int kexec_add_handover_buffer(struct kexec_buf *kbuf)
> +int kexec_add_handover_buffer(struct kexec_buf *kbuf, bool checksum)
>  {
>  	int ret;
>  
>  	if (!kexec_can_hand_over_buffer())
>  		return -ENOTSUPP;
>  
> -	ret = kexec_add_buffer(kbuf);
> +	ret = kexec_add_buffer(kbuf, checksum);
>  	if (ret)
>  		return ret;
>  
> @@ -611,6 +612,7 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
>  /**
>   * kexec_add_buffer - place a buffer in a kexec segment
>   * @kbuf:	Buffer contents and memory parameters.
> + * @checksum:	Should the segment checksum be verified by the purgatory?
>   *
>   * This function assumes that kexec_mutex is held.
>   * On successful return, @kbuf->mem will have the physical address of
> @@ -618,7 +620,7 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
>   *
>   * Return: 0 on success, negative errno on error.
>   */
> -int kexec_add_buffer(struct kexec_buf *kbuf)
> +int kexec_add_buffer(struct kexec_buf *kbuf, bool checksum)
>  {
>  
>  	struct kexec_segment *ksegment;
> @@ -658,6 +660,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
>  	ksegment->bufsz = kbuf->bufsz;
>  	ksegment->mem = kbuf->mem;
>  	ksegment->memsz = kbuf->memsz;
> +	ksegment->do_checksum = checksum;
>  	kbuf->image->nr_segments++;
>  	return 0;
>  }
> @@ -672,7 +675,6 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  	char *digest;
>  	void *zero_buf;
>  	struct kexec_sha_region *sha_regions;
> -	struct purgatory_info *pi = &image->purgatory_info;
>  
>  	zero_buf = __va(page_to_pfn(ZERO_PAGE(0)) << PAGE_SHIFT);
>  	zero_buf_sz = PAGE_SIZE;
> @@ -712,11 +714,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  		struct kexec_segment *ksegment;
>  
>  		ksegment = &image->segment[i];
> -		/*
> -		 * Skip purgatory as it will be modified once we put digest
> -		 * info in purgatory.
> -		 */
> -		if (ksegment->kbuf == pi->purgatory_buf)
> +		if (!ksegment->do_checksum)
>  			continue;
>  
>  		ret = crypto_shash_update(desc, ksegment->kbuf,
> @@ -893,8 +891,11 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
>  	if (kbuf.buf_align < bss_align)
>  		kbuf.buf_align = bss_align;
>  
> -	/* Add buffer to segment list */
> -	ret = kexec_add_buffer(&kbuf);
> +	/*
> +	 * Add buffer to segment list. Don't checksum the segment as
> +	 * it will be modified once we put digest info in purgatory.
> +	 */
> +	ret = kexec_add_buffer(&kbuf, false);
>  	if (ret)
>  		goto out;
>  	pi->purgatory_load_addr = kbuf.mem;
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
