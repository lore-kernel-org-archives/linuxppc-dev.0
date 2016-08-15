Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sCqrJ3DzNzDr0d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 08:28:00 +1000 (AEST)
Date: Mon, 15 Aug 2016 15:27:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-ima-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, Eric Biederman
 <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal
 <vgoyal@redhat.com>, Baoquan He <bhe@redhat.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Stewart Smith
 <stewart@linux.vnet.ibm.com>, Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, Eric Richter
 <erichte@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Petko Manolov
 <petkan@mip-labs.com>, David Laight <David.Laight@ACULAB.COM>, Balbir Singh
 <bsingharora@gmail.com>
Subject: Re: [PATCH v2 4/6] kexec_file: Add mechanism to update kexec segments.
Message-Id: <20160815152756.78ea7a61a3342547b9e694e5@linux-foundation.org>
In-Reply-To: <1471058305-30198-5-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1471058305-30198-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1471058305-30198-5-git-send-email-bauerman@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 13 Aug 2016 00:18:23 -0300 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> wrote:

> kexec_update_segment allows a given segment in kexec_image to have
> its contents updated. This is useful if the current kernel wants to
> send information to the next kernel that is up-to-date at the time of
> reboot.
> 
> ...
>
> @@ -721,6 +721,105 @@ static struct page *kimage_alloc_page(struct kimage *image,
>  	return page;
>  }
>  
> +/**
> + * kexec_update_segment - update the contents of a kimage segment
> + * @buffer:	New contents of the segment.
> + * @bufsz:	@buffer size.
> + * @load_addr:	Segment's physical address in the next kernel.
> + * @memsz:	Segment size.
> + *
> + * This function assumes kexec_mutex is held.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +int kexec_update_segment(const char *buffer, unsigned long bufsz,
> +			 unsigned long load_addr, unsigned long memsz)
> +{
> +	int i;
> +	unsigned long entry;
> +	unsigned long *ptr = NULL;
> +	void *dest = NULL;
> +
> +	if (kexec_image == NULL) {
> +		pr_err("Can't update segment: no kexec image loaded.\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * kexec_add_buffer rounds up segment sizes to PAGE_SIZE, so
> +	 * we have to do it here as well.
> +	 */
> +	memsz = ALIGN(memsz, PAGE_SIZE);
> +
> +	for (i = 0; i < kexec_image->nr_segments; i++)
> +		/* We only support updating whole segments. */
> +		if (load_addr == kexec_image->segment[i].mem &&
> +		    memsz == kexec_image->segment[i].memsz) {
> +			if (kexec_image->segment[i].do_checksum) {
> +				pr_err("Trying to update non-modifiable segment.\n");
> +				return -EINVAL;
> +			}
> +
> +			break;
> +		}
> +	if (i == kexec_image->nr_segments) {
> +		pr_err("Couldn't find segment to update: 0x%lx, size 0x%lx\n",
> +		       load_addr, memsz);
> +		return -EINVAL;
> +	}
> +
> +	for (entry = kexec_image->head; !(entry & IND_DONE) && memsz;
> +	     entry = *ptr++) {
> +		void *addr = (void *) (entry & PAGE_MASK);
> +
> +		switch (entry & IND_FLAGS) {
> +		case IND_DESTINATION:
> +			dest = addr;
> +			break;
> +		case IND_INDIRECTION:
> +			ptr = __va(addr);
> +			break;
> +		case IND_SOURCE:
> +			/* Shouldn't happen, but verify just to be safe. */
> +			if (dest == NULL) {
> +				pr_err("Invalid kexec entries list.");
> +				return -EINVAL;
> +			}
> +
> +			if (dest == (void *) load_addr) {
> +				struct page *page;
> +				char *ptr;
> +				size_t uchunk, mchunk;
> +
> +				page = kmap_to_page(addr);
> +
> +				ptr = kmap(page);

kmap_atomic() could be used here, and it is appreciably faster.


> +				ptr += load_addr & ~PAGE_MASK;
> +				mchunk = min_t(size_t, memsz,
> +					       PAGE_SIZE - (load_addr & ~PAGE_MASK));
> +				uchunk = min(bufsz, mchunk);
> +				memcpy(ptr, buffer, uchunk);
> +
> +				kunmap(page);
> +
> +				bufsz -= uchunk;
> +				load_addr += mchunk;
> +				buffer += mchunk;
> +				memsz -= mchunk;
> +			}
> +			dest += PAGE_SIZE;
> +		}
> +
> +		/* Shouldn't happen, but verify just to be safe. */
> +		if (ptr == NULL) {
> +			pr_err("Invalid kexec entries list.");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
