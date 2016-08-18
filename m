Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFJz02Bm2zDr5t
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 18:23:56 +1000 (AEST)
Date: Thu, 18 Aug 2016 16:23:39 +0800
From: Dave Young <dyoung@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Vivek Goyal <vgoyal@redhat.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 David Laight <David.Laight@ACULAB.COM>,
 Eric Biederman <ebiederm@xmission.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] kexec: add dtb info to struct kimage
Message-ID: <20160818082339.GB845@dhcp-128-65.nay.redhat.com>
References: <1470956638-3589-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1470956638-3589-2-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470956638-3589-2-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/11/16 at 08:03pm, Thiago Jung Bauermann wrote:
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> Device tree blob must be passed to a second kernel on DTB-capable
> archs, like powerpc and arm64, but the current kernel interface
> lacks this support.
> 
> This patch adds dtb buffer information to struct kimage.
> When users don't specify dtb explicitly and the one used for the current
> kernel can be re-used, this change will be good enough for implementing
> kexec_file_load feature.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  include/linux/kexec.h | 3 +++
>  kernel/kexec_file.c   | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index d7437777baaa..4f85d284ed0b 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -192,6 +192,9 @@ struct kimage {
>  	char *cmdline_buf;
>  	unsigned long cmdline_buf_len;
>  
> +	void *dtb_buf;
> +	unsigned long dtb_buf_len;
> +
>  	/* File operations provided by image loader */
>  	struct kexec_file_ops *fops;
>  
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 503bc2d348e5..113af2f219b9 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -92,6 +92,9 @@ void kimage_file_post_load_cleanup(struct kimage *image)
>  	vfree(image->initrd_buf);
>  	image->initrd_buf = NULL;
>  
> +	vfree(image->dtb_buf);
> +	image->dtb_buf = NULL;
> +
>  	kfree(image->cmdline_buf);
>  	image->cmdline_buf = NULL;
>  
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
