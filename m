Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rSkLg6QS8zDqW9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 17:05:15 +1000 (AEST)
Date: Mon, 13 Jun 2016 15:05:08 +0800
From: Dave Young <dyoung@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 1/8] kexec_file: Remove unused members from struct
 kexec_buf.
Message-ID: <20160613070508.GB4974@dhcp-128-65.nay.redhat.com>
References: <1465701022-11601-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1465701022-11601-2-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465701022-11601-2-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/12/16 at 12:10am, Thiago Jung Bauermann wrote:
> kexec_add_buffer uses kexec_buf.buffer and kexec_buf.bufsz to pass along
> its own arguments buffer and bufsz, but since they aren't used anywhere
> else, it's pointless.
> 
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/kexec_file.c     | 6 ++----
>  kernel/kexec_internal.h | 2 --
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 01ab82a40d22..b6eec7527e9f 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -464,8 +464,6 @@ int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
>  	memset(&buf, 0, sizeof(struct kexec_buf));
>  	kbuf = &buf;
>  	kbuf->image = image;
> -	kbuf->buffer = buffer;
> -	kbuf->bufsz = bufsz;
>  
>  	kbuf->memsz = ALIGN(memsz, PAGE_SIZE);
>  	kbuf->buf_align = max(buf_align, PAGE_SIZE);
> @@ -489,8 +487,8 @@ int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
>  
>  	/* Found a suitable memory range */
>  	ksegment = &image->segment[image->nr_segments];
> -	ksegment->kbuf = kbuf->buffer;
> -	ksegment->bufsz = kbuf->bufsz;
> +	ksegment->kbuf = buffer;
> +	ksegment->bufsz = bufsz;
>  	ksegment->mem = kbuf->mem;
>  	ksegment->memsz = kbuf->memsz;
>  	image->nr_segments++;
> diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
> index 0a52315d9c62..eefd5bf960c2 100644
> --- a/kernel/kexec_internal.h
> +++ b/kernel/kexec_internal.h
> @@ -26,8 +26,6 @@ struct kexec_sha_region {
>   */
>  struct kexec_buf {
>  	struct kimage *image;
> -	char *buffer;
> -	unsigned long bufsz;
>  	unsigned long mem;
>  	unsigned long memsz;
>  	unsigned long buf_align;
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave
