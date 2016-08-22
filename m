Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHf0F63SSzDqCZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 13:18:05 +1000 (AEST)
Date: Mon, 22 Aug 2016 11:17:45 +0800
From: Dave Young <dyoung@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>, x86@kernel.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Eric Richter <erichte@linux.vnet.ibm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-ima-devel@lists.sourceforge.net,
 Thomas Gleixner <tglx@linutronix.de>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v2 3/6] kexec_file: Allow skipping checksum calculation
 for some segments.
Message-ID: <20160822031745.GA30489@dhcp-128-65.nay.redhat.com>
References: <1471058305-30198-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1471058305-30198-4-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160818090330.GC845@dhcp-128-65.nay.redhat.com>
 <105132489.pljZvDuEBr@hactar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <105132489.pljZvDuEBr@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/18/16 at 06:09pm, Thiago Jung Bauermann wrote:
> Hello Dave,
> 
> Thanks for your review!
> 
> [ Trimming down Cc: list a little to try to clear the "too many recipients"   
>   mailing list restriction. ]

I also got "too many recipients".. Thanks for the trimming.

> 
> Am Donnerstag, 18 August 2016, 17:03:30 schrieb Dave Young:
> > On 08/13/16 at 12:18am, Thiago Jung Bauermann wrote:
> > > Adds checksum argument to kexec_add_buffer specifying whether the given
> > > segment should be part of the checksum calculation.
> > 
> > Since it is used with add buffer, could it be added to kbuf as a new
> > field?
> 
> I was on the fence about adding it as a new argument to kexec_add_buffer or 
> as a new field to struct kexec_buf. Both alternatives make sense to me. I 
> implemented your suggestion in the patch below, what do you think?
> 
> > Like kbuf.no_checksum, default value is 0 that means checksum is needed
> > if it is 1 then no need a checksum.
> 
> It's an interesting idea and I implemented it that way, though in practice 
> all current users of struct kexec_buf put it on the stack so the field needs 
> to be initialized explicitly.
> 
> -- 
> []'s
> Thiago Jung Bauermann
> IBM Linux Technology Center
> 
> 
> Subject: [PATCH v2 3/6] kexec_file: Allow skipping checksum calculation for
>  some segments.
> 
> Add skip_checksum member to struct kexec_buf to specify whether the
> corresponding segment should be part of the checksum calculation.
> 
> The next patch will add a way to update segments after a kimage is loaded.
> Segments that will be updated in this way should not be checksummed,
> otherwise they will cause the purgatory checksum verification to fail
> when the machine is rebooted.
> 
> As a bonus, we don't need to special-case the purgatory segment anymore
> to avoid checksumming it.
> 
> Adjust places using struct kexec_buf to set skip_checksum.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/kexec_elf_64.c |  5 +++--
>  arch/x86/kernel/crash.c            |  3 ++-
>  arch/x86/kernel/kexec-bzimage64.c  |  2 +-
>  include/linux/kexec.h              | 23 ++++++++++++++---------
>  kernel/kexec_file.c                | 15 +++++++--------
>  5 files changed, 27 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kexec_elf_64.c b/arch/powerpc/kernel/kexec_elf_64.c
> index 22afc7b5ee73..d009f5363968 100644
> --- a/arch/powerpc/kernel/kexec_elf_64.c
> +++ b/arch/powerpc/kernel/kexec_elf_64.c
> @@ -107,7 +107,7 @@ static int elf_exec_load(struct kimage *image, struct elfhdr *ehdr,
>  	int ret;
>  	size_t i;
>  	struct kexec_buf kbuf = { .image = image, .buf_max = ppc64_rma_size,
> -				  .top_down = false };
> +				  .top_down = false, .skip_checksum = false };

No need to set it as false because it will be initialized to 0 by
default?

>  
>  	/* Read in the PT_LOAD segments. */
>  	for (i = 0; i < ehdr->e_phnum; i++) {
> @@ -162,7 +162,8 @@ void *elf64_load(struct kimage *image, char *kernel_buf,
>  	struct elf_info elf_info;
>  	struct fdt_reserve_entry *rsvmap;
>  	struct kexec_buf kbuf = { .image = image, .buf_min = 0,
> -				  .buf_max = ppc64_rma_size };
> +				  .buf_max = ppc64_rma_size,
> +				  .skip_checksum = false };
>  
>  	ret = build_elf_exec_info(kernel_buf, kernel_len, &ehdr, &elf_info);
>  	if (ret)
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 38a1cdf6aa05..7b8f62c86651 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -617,7 +617,8 @@ int crash_load_segments(struct kimage *image)
>  {
>  	int ret;
>  	struct kexec_buf kbuf = { .image = image, .buf_min = 0,
> -				  .buf_max = ULONG_MAX, .top_down = false };
> +				  .buf_max = ULONG_MAX, .top_down = false,
> +				  .skip_checksum = false };
>  
>  	/*
>  	 * Determine and load a segment for backup area. First 640K RAM
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 4b3a75329fb6..449f433cd225 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -341,7 +341,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>  	unsigned int setup_hdr_offset = offsetof(struct boot_params, hdr);
>  	unsigned int efi_map_offset, efi_map_sz, efi_setup_data_offset;
>  	struct kexec_buf kbuf = { .image = image, .buf_max = ULONG_MAX,
> -				  .top_down = true };
> +				  .top_down = true, .skip_checksum = false };
>  
>  	header = (struct setup_header *)(kernel + setup_hdr_offset);
>  	setup_sects = header->setup_sects;
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 4559a1a01b0a..e5b3d99cbe50 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -100,6 +100,9 @@ struct kexec_segment {
>  	size_t bufsz;
>  	unsigned long mem;
>  	size_t memsz;
> +
> +	/* Whether this segment is ignored in the checksum calculation. */
> +	bool skip_checksum;
>  };
>  
>  #ifdef CONFIG_COMPAT
> @@ -151,15 +154,16 @@ struct kexec_file_ops {
>  
>  /**
>   * struct kexec_buf - parameters for finding a place for a buffer in memory
> - * @image:	kexec image in which memory to search.
> - * @buffer:	Contents which will be copied to the allocated memory.
> - * @bufsz:	Size of @buffer.
> - * @mem:	On return will have address of the buffer in memory.
> - * @memsz:	Size for the buffer in memory.
> - * @buf_align:	Minimum alignment needed.
> - * @buf_min:	The buffer can't be placed below this address.
> - * @buf_max:	The buffer can't be placed above this address.
> - * @top_down:	Allocate from top of memory.
> + * @image:		kexec image in which memory to search.
> + * @buffer:		Contents which will be copied to the allocated memory.
> + * @bufsz:		Size of @buffer.
> + * @mem:		On return will have address of the buffer in memory.
> + * @memsz:		Size for the buffer in memory.
> + * @buf_align:		Minimum alignment needed.
> + * @buf_min:		The buffer can't be placed below this address.
> + * @buf_max:		The buffer can't be placed above this address.
> + * @top_down:		Allocate from top of memory.
> + * @skip_checksum:	Don't verify checksum for this buffer in purgatory.
>   */
>  struct kexec_buf {
>  	struct kimage *image;
> @@ -171,6 +175,7 @@ struct kexec_buf {
>  	unsigned long buf_min;
>  	unsigned long buf_max;
>  	bool top_down;
> +	bool skip_checksum;
>  };
>  
>  int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index c8418d62e2fc..f6e9958bf578 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -658,6 +658,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
>  	ksegment->bufsz = kbuf->bufsz;
>  	ksegment->mem = kbuf->mem;
>  	ksegment->memsz = kbuf->memsz;
> +	ksegment->skip_checksum = kbuf->skip_checksum;
>  	kbuf->image->nr_segments++;
>  	return 0;
>  }
> @@ -672,7 +673,6 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  	char *digest;
>  	void *zero_buf;
>  	struct kexec_sha_region *sha_regions;
> -	struct purgatory_info *pi = &image->purgatory_info;
>  
>  	zero_buf = __va(page_to_pfn(ZERO_PAGE(0)) << PAGE_SHIFT);
>  	zero_buf_sz = PAGE_SIZE;
> @@ -712,11 +712,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  		struct kexec_segment *ksegment;
>  
>  		ksegment = &image->segment[i];
> -		/*
> -		 * Skip purgatory as it will be modified once we put digest
> -		 * info in purgatory.
> -		 */
> -		if (ksegment->kbuf == pi->purgatory_buf)
> +		if (ksegment->skip_checksum)
>  			continue;
>  
>  		ret = crypto_shash_update(desc, ksegment->kbuf,
> @@ -788,7 +784,7 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
>  	Elf_Shdr *sechdrs = NULL;
>  	struct kexec_buf kbuf = { .image = image, .bufsz = 0, .buf_align = 1,
>  				  .buf_min = min, .buf_max = max,
> -				  .top_down = top_down };
> +				  .top_down = top_down, .skip_checksum = true };
>  
>  	/*
>  	 * sechdrs_c points to section headers in purgatory and are read
> @@ -893,7 +889,10 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
>  	if (kbuf.buf_align < bss_align)
>  		kbuf.buf_align = bss_align;
>  
> -	/* Add buffer to segment list */
> +	/*
> +	 * Add buffer to segment list. Don't checksum the segment as
> +	 * it will be modified once we put digest info in purgatory.
> +	 */
>  	ret = kexec_add_buffer(&kbuf);
>  	if (ret)
>  		goto out;
> -- 
> 1.9.1
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
