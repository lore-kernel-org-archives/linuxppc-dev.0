Return-Path: <ebiederm@xmission.com>
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTRsD2hXKzDrpn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 12:16:00 +1000 (AEST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-ima-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Baoquan He <bhe@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Eric Richter <erichte@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Balbir Singh <bsingharora@gmail.com>
References: <1472579105-26296-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1472579105-26296-4-git-send-email-bauerman@linux.vnet.ibm.com>
Date: Tue, 06 Sep 2016 20:30:31 -0500
In-Reply-To: <1472579105-26296-4-git-send-email-bauerman@linux.vnet.ibm.com>
 (Thiago Jung Bauermann's message of "Tue, 30 Aug 2016 14:45:03 -0300")
Message-ID: <87eg4wlcnc.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v4 3/5] kexec_file: Allow skipping checksum calculation
 for some segments.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:

2> Add skip_checksum member to struct kexec_buf to specify whether the
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
> Places using struct kexec_buf get false as the default value for
> skip_checksum since they all use designated initializers.  Therefore,
> there is no behavior change with this patch and all segments except the
> purgatory are checksummed.

What is the world.  This fundamentally makes kexec unsafe to use.  If
any updates need to be made they should be made before they are part of
the entire image checksum.

No way should this be merged anywhere ever.

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---
>  include/linux/kexec.h | 23 ++++++++++++++---------
>  kernel/kexec_file.c   | 15 +++++++--------
>  2 files changed, 21 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 16561e96a6d7..edadff6c86ff 100644
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
> index f5684adfad07..0e90d1446cb0 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -584,6 +584,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
>  	ksegment->bufsz = kbuf->bufsz;
>  	ksegment->mem = kbuf->mem;
>  	ksegment->memsz = kbuf->memsz;
> +	ksegment->skip_checksum = kbuf->skip_checksum;
>  	kbuf->image->nr_segments++;
>  	return 0;
>  }
> @@ -598,7 +599,6 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  	char *digest;
>  	void *zero_buf;
>  	struct kexec_sha_region *sha_regions;
> -	struct purgatory_info *pi = &image->purgatory_info;
>  
>  	zero_buf = __va(page_to_pfn(ZERO_PAGE(0)) << PAGE_SHIFT);
>  	zero_buf_sz = PAGE_SIZE;
> @@ -638,11 +638,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
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
> @@ -714,7 +710,7 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
>  	Elf_Shdr *sechdrs = NULL;
>  	struct kexec_buf kbuf = { .image = image, .bufsz = 0, .buf_align = 1,
>  				  .buf_min = min, .buf_max = max,
> -				  .top_down = top_down };
> +				  .top_down = top_down, .skip_checksum = true };
>  
>  	/*
>  	 * sechdrs_c points to section headers in purgatory and are read
> @@ -819,7 +815,10 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
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
