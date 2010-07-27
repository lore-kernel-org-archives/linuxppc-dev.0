Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 9536FB6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Jul 2010 20:00:35 +1000 (EST)
From: Milton Miller <miltonm@bga.com>
To: WANG Cong <amwang@redhat.com>
Subject: Re: [Patch v2] kexec: increase max of kexec segments and use dynamic
	allocation
In-Reply-To: <20100727082321.5813.84456.sendpatchset@localhost.localdomain>
Message-Id: <kexec-nrseg-reply1@mdm.bga.com>
Date: Tue, 27 Jul 2010 05:00:32 -0500
Cc: Neil Horman <nhorman@redhat.com>, Neil Horman <nhorman@tuxdriver.com>,
	huang ying <huang.ying.caritas@gmail.com>,
	linux-kernel@vger.kernel.org, kexec@lists.infadead.org,
	"Eric W. Biederman" <ebiederm@xmission.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ Added kexec at lists.infradead.org and linuxppc-dev@lists.ozlabs.org ]

> 
> Currently KEXEC_SEGMENT_MAX is only 16 which is too small for machine with
> many memory ranges.  When hibernate on a machine with disjoint memory we do
> need one segment for each memory region. Increase this hard limit to 16K
> which is reasonably large.
> 
> And change ->segment from a static array to a dynamically allocated memory.
> 
> Cc: Neil Horman <nhorman@redhat.com>
> Cc: huang ying <huang.ying.caritas@gmail.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: WANG Cong <amwang@redhat.com>
> 
> ---
> diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
> index ed31a29..f115585 100644
> --- a/arch/powerpc/kernel/machine_kexec_64.c
> +++ b/arch/powerpc/kernel/machine_kexec_64.c
> @@ -131,10 +131,7 @@ static void copy_segments(unsigned long ind)
>  void kexec_copy_flush(struct kimage *image)
>  {
>  	long i, nr_segments = image->nr_segments;
> -	struct  kexec_segment ranges[KEXEC_SEGMENT_MAX];
> -
> -	/* save the ranges on the stack to efficiently flush the icache */
> -	memcpy(ranges, image->segment, sizeof(ranges));
> +	struct  kexec_segment range;

I'm glad you found our copy on the stack and removed the stack overflow
that comes with this bump, but ...

>  
>  	/*
>  	 * After this call we may not use anything allocated in dynamic
> @@ -148,9 +145,11 @@ void kexec_copy_flush(struct kimage *image)
>  	 * we need to clear the icache for all dest pages sometime,
>  	 * including ones that were in place on the original copy
>  	 */
> -	for (i = 0; i < nr_segments; i++)
> -		flush_icache_range((unsigned long)__va(ranges[i].mem),
> -			(unsigned long)__va(ranges[i].mem + ranges[i].memsz));
> +	for (i = 0; i < nr_segments; i++) {
> +		memcpy(&range, &image->segment[i], sizeof(range));
> +		flush_icache_range((unsigned long)__va(range.mem),
> +			(unsigned long)__va(range.mem + range.memsz));
> +	}
>  }

This is executed after the copy, so as it says,
"we may not use anything allocated in dynamic memory".

We could allocate control pages to copy the segment list into.
Actually ppc64 doesn't use the existing control page, but that
is only 4kB today.

We need the list to icache flush all the pages in all the segments.
The as the indirect list doesn't have pages that were allocated at
their destination.

Or maybe the icache flush should be done in the generic code
like it does for crash load segments?


>  
>  #ifdef CONFIG_SMP
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 03e8e8d..26b70ff 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -57,7 +57,7 @@ typedef unsigned long kimage_entry_t;
>  #define IND_DONE         0x4
>  #define IND_SOURCE       0x8
>  
> -#define KEXEC_SEGMENT_MAX 16
> +#define KEXEC_SEGMENT_MAX (1024*16)
>  struct kexec_segment {
>  	void __user *buf;
>  	size_t bufsz;
> @@ -86,7 +86,7 @@ struct kimage {
>  	struct page *swap_page;
>  
>  	unsigned long nr_segments;
> -	struct kexec_segment segment[KEXEC_SEGMENT_MAX];
> +	struct kexec_segment *segment;
>  
>  	struct list_head control_pages;
>  	struct list_head dest_pages;
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 131b170..3f97309 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -131,6 +131,11 @@ static int do_kimage_alloc(struct kimage **rimage, unsigned long entry,
>  	if (!image)
>  		goto out;
>  
> +	image->segment = kzalloc(nr_segments * sizeof(struct kexec_segment),
> +				 GFP_KERNEL);
> +	if (!image->segment)
> +		goto out;
> +
>  	image->head = 0;
>  	image->entry = &image->head;
>  	image->last_entry = &image->head;
> @@ -216,8 +221,10 @@ static int do_kimage_alloc(struct kimage **rimage, unsigned long entry,
>  out:
>  	if (result == 0)
>  		*rimage = image;
> -	else
> +	else if (image) {
> +		kfree(image->segment);
>  		kfree(image);
> +	}
>  
>  	return result;
>  
> @@ -261,8 +268,10 @@ static int kimage_normal_alloc(struct kimage **rimage, unsigned long entry,
>   out:
>  	if (result == 0)
>  		*rimage = image;
> -	else
> +	else if (image) {
> +		kfree(image->segment);
>  		kfree(image);
> +	}
>  
>  	return result;
>  }
> @@ -330,8 +339,10 @@ static int kimage_crash_alloc(struct kimage **rimage, unsigned long entry,
>  out:
>  	if (result == 0)
>  		*rimage = image;
> -	else
> +	else if (image) {
> +		kfree(image->segment);
>  		kfree(image);
> +	}
>  
>  	return result;
>  }
> @@ -656,6 +667,7 @@ static void kimage_free(struct kimage *image)
>  
>  	/* Free the kexec control pages... */
>  	kimage_free_page_list(&image->control_pages);
> +	kfree(image->segment);
>  	kfree(image);
>  }
>  

milton
