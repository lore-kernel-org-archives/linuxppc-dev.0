Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rXvqT0bClzDqhf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 12:26:13 +1000 (AEST)
Date: Mon, 20 Jun 2016 10:26:05 +0800
From: Dave Young <dyoung@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v2 2/9] kexec_file: Generalize kexec_add_buffer.
Message-ID: <20160620022605.GA3180@dhcp-128-65.nay.redhat.com>
References: <1465916349-3398-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <16133071.BqvF7Se0c2@hactar>
 <20160617073523.GA5091@dhcp-128-65.nay.redhat.com>
 <12025213.W8oVnaovm1@hactar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <12025213.W8oVnaovm1@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/17/16 at 05:51pm, Thiago Jung Bauermann wrote:
> Am Freitag, 17 Juni 2016, 15:35:23 schrieb Dave Young:
> > On 06/16/16 at 05:39pm, Thiago Jung Bauermann wrote:
> > > Am Donnerstag, 16 Juni 2016, 09:58:53 schrieb Dave Young:
> > > > On 06/15/16 at 01:21pm, Thiago Jung Bauermann wrote:
> > > > > +int __weak arch_kexec_walk_mem(unsigned int image_type, bool
> > > > > top_down,
> > > > > +			       void *data, int (*func)(u64, u64, void *))
> > > > > +{
> > > > 
> > > > top_down is also not used?
> > > 
> > > It's unused in the default implementation, but the powerpc implementation
> > > in patch 8 uses it:
> > Well, arch_kexec_walk_mem use kbuf as "data", you can even drop
> > "image_type" since kbuf has all you want kbuf->image->type, and
> > kbuf->top_down
> > 
> > int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
> > 			       int (*func)(u64, u64, void *))
> 
> Sounds good to me, but I had to move struct kexec_buf from
> kernel/kexec_internal.h to include/linux/kexec.h.
> 
> Here's the updated patch. What do you think?
> 
> []'s
> Thiago Jung Bauermann
> IBM Linux Technology Center
> 
> 
>     kexec_file: Generalize kexec_add_buffer.
>     
>     Allow architectures to specify different memory walking functions for
>     kexec_add_buffer. Intel uses iomem to track reserved memory ranges,
>     but PowerPC uses the memblock subsystem.
>     
>     Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
>     Cc: Eric Biederman <ebiederm@xmission.com>
>     Cc: Dave Young <dyoung@redhat.com>
>     Cc: kexec@lists.infradead.org
>     Cc: linux-kernel@vger.kernel.org
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index e8acb2b43dd9..d8df01107ae2 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -201,6 +201,20 @@ struct kimage {
>  #endif
>  };
>  
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

kexec_buf should go within #ifdef for kexec file like struct purgatory_info

Other than that it looks good.

Thanks
Dave
