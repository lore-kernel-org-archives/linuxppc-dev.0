Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rk56C2fCHzDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 10:55:46 +1000 (AEST)
Date: Tue, 5 Jul 2016 08:55:37 +0800
From: Dave Young <dyoung@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 2/9] kexec_file: Generalize kexec_add_buffer.
Message-ID: <20160705005537.GA8190@dhcp-128-65.nay.redhat.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160701183602.GA4553@dhcp-128-65.nay.redhat.com>
 <3789971.1TYeJNg8TK@hactar> <1923446.CtvhM7vr7E@hactar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1923446.CtvhM7vr7E@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/01/16 at 05:31pm, Thiago Jung Bauermann wrote:
> Am Freitag, 01 Juli 2016, 17:02:23 schrieb Thiago Jung Bauermann:
> > Am Freitag, 01 Juli 2016, 14:36:02 schrieb Dave Young:
> > > On 07/01/16 at 02:51pm, Thiago Jung Bauermann wrote:
> > > > Am Donnerstag, 30 Juni 2016, 17:43:57 schrieb Dave Young:
> > > > > On 06/30/16 at 01:42pm, Thiago Jung Bauermann wrote:
> > > > > > Am Donnerstag, 30 Juni 2016, 12:49:44 schrieb Thiago Jung Bauermann:
> > > > I understand that this is all somewhat subjective, so if you still
> > > > disagree with my points I can provide a patch set implementing the
> > > > change above.
> > > 
> > > I still feel it should be changed if more callbacks being introduced,
> > > though you can regard it is internal api, like above comment we do not
> > > need to assign them seperately, the member values can be assigned
> > > from the beginning.
> > 
> > Ok, I'll implement the changes and submit a v4. Thanks for your review.
> 
> Sorry for creating more email traffic, but it'll be better if I ask this 
> before I change all other places in the code. Is the code below what you
> have in mind?

Thanks for the update, almost except a nitpick :)

> 
> In particular, this version doesn't do the memset(&buf, 0, sizeof(buf))
> that the previous code I sent earlier did. Is that ok?
> 
> @@ -643,13 +632,14 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
>  				  unsigned long max, int top_down)
>  {
>  	struct purgatory_info *pi = &image->purgatory_info;
> -	unsigned long align, buf_align, bss_align, buf_sz, bss_sz, bss_pad;
> -	unsigned long memsz, entry, load_addr, curr_load_addr, bss_addr, offset;
> +	unsigned long align, bss_align, bss_sz, bss_pad;
> +	unsigned long entry, load_addr, curr_load_addr, bss_addr, offset;
>  	unsigned char *buf_addr, *src;
>  	int i, ret = 0, entry_sidx = -1;
>  	const Elf_Shdr *sechdrs_c;
>  	Elf_Shdr *sechdrs = NULL;
> -	void *purgatory_buf = NULL;
> +	struct kexec_buf buf = { .image = image, .buf_min = min,
> +				.buf_max = max, .top_down = top_down };
>  
>  	/*
>  	 * sechdrs_c points to section headers in purgatory and are read
> @@ -715,9 +705,9 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
>  	}
>  
>  	/* Determine how much memory is needed to load relocatable object. */
> -	buf_align = 1;
> +	buf.buf_align = 1;
>  	bss_align = 1;
> -	buf_sz = 0;
> +	buf.bufsz = 0;
>  	bss_sz = 0;

Above chunk can go to the initializatioin of struct kexec buf ealier.

>  
>  	for (i = 0; i < pi->ehdr->e_shnum; i++) {
> @@ -726,10 +716,10 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
>  
>  		align = sechdrs[i].sh_addralign;
>  		if (sechdrs[i].sh_type != SHT_NOBITS) {
> -			if (buf_align < align)
> -				buf_align = align;
> -			buf_sz = ALIGN(buf_sz, align);
> -			buf_sz += sechdrs[i].sh_size;
> +			if (buf.buf_align < align)
> +				buf.buf_align = align;
> +			buf.bufsz = ALIGN(buf.bufsz, align);
> +			buf.bufsz += sechdrs[i].sh_size;
>  		} else {
>  			/* bss section */
>  			if (bss_align < align)
> @@ -741,32 +731,31 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
>  
>  	/* Determine the bss padding required to align bss properly */
>  	bss_pad = 0;
> -	if (buf_sz & (bss_align - 1))
> -		bss_pad = bss_align - (buf_sz & (bss_align - 1));
> +	if (buf.bufsz & (bss_align - 1))
> +		bss_pad = bss_align - (buf.bufsz & (bss_align - 1));
>  
> -	memsz = buf_sz + bss_pad + bss_sz;
> +	buf.memsz = buf.bufsz + bss_pad + bss_sz;
>  
>  	/* Allocate buffer for purgatory */
> -	purgatory_buf = vzalloc(buf_sz);
> -	if (!purgatory_buf) {
> +	buf.buffer = vzalloc(buf.bufsz);
> +	if (!buf.buffer) {
>  		ret = -ENOMEM;
>  		goto out;
>  	}
>  
> -	if (buf_align < bss_align)
> -		buf_align = bss_align;
> +	if (buf.buf_align < bss_align)
> +		buf.buf_align = bss_align;
>  
>  	/* Add buffer to segment list */
> -	ret = kexec_add_buffer(image, purgatory_buf, buf_sz, memsz,
> -				buf_align, min, max, top_down,
> -				&pi->purgatory_load_addr);
> +	ret = kexec_add_buffer(&buf);
>  	if (ret)
>  		goto out;
> +	pi->purgatory_load_addr = buf.mem;
>  
>  	/* Load SHF_ALLOC sections */
> -	buf_addr = purgatory_buf;
> +	buf_addr = buf.buffer;
>  	load_addr = curr_load_addr = pi->purgatory_load_addr;
> -	bss_addr = load_addr + buf_sz + bss_pad;
> +	bss_addr = load_addr + buf.bufsz + bss_pad;
>  
>  	for (i = 0; i < pi->ehdr->e_shnum; i++) {
>  		if (!(sechdrs[i].sh_flags & SHF_ALLOC))
> @@ -812,11 +801,11 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
>  	 * Used later to identify which section is purgatory and skip it
>  	 * from checksumming.
>  	 */
> -	pi->purgatory_buf = purgatory_buf;
> +	pi->purgatory_buf = buf.buffer;
>  	return ret;
>  out:
>  	vfree(sechdrs);
> -	vfree(purgatory_buf);
> +	vfree(buf.buffer);
>  	return ret;
>  }
>  
> 
> []'s
> Thiago Jung Bauermann
> IBM Linux Technology Center
> 
