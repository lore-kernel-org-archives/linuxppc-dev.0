Return-Path: <SRS0=w0cb=TX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E67C282CE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 May 2019 03:24:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A84682075E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 May 2019 03:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84682075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 458ZcF3NjhzDqRW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 May 2019 13:24:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=dyoung@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 458ZZp5fftzDqRF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2019 13:23:12 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 017E5C057F2F;
 Thu, 23 May 2019 03:23:10 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-185.pek2.redhat.com
 [10.72.12.185])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AED218687;
 Thu, 23 May 2019 03:23:06 +0000 (UTC)
Date: Thu, 23 May 2019 11:23:02 +0800
From: Dave Young <dyoung@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH] powerpc: Fix loading of kernel + initramfs with
 kexec_file_load()
Message-ID: <20190523032302.GD8174@dhcp-128-65.nay.redhat.com>
References: <20190522220158.18479-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522220158.18479-1-bauerman@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 23 May 2019 03:23:10 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Mimi Zohar <zohar@linux.ibm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 05/22/19 at 07:01pm, Thiago Jung Bauermann wrote:
> Commit b6664ba42f14 ("s390, kexec_file: drop arch_kexec_mem_walk()")
> changed kexec_add_buffer() to skip searching for a memory location if
> kexec_buf.mem is already set, and use the address that is there.
> 
> In powerpc code we reuse a kexec_buf variable for loading both the kernel
> and the initramfs by resetting some of the fields between those uses, but
> not mem. This causes kexec_add_buffer() to try to load the kernel at the
> same address where initramfs will be loaded, which is naturally rejected:
> 
>   # kexec -s -l --initrd initramfs vmlinuz
>   kexec_file_load failed: Invalid argument
> 
> Setting the mem field before every call to kexec_add_buffer() fixes this
> regression.
> 
> Fixes: b6664ba42f14 ("s390, kexec_file: drop arch_kexec_mem_walk()")
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>  arch/powerpc/kernel/kexec_elf_64.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/kexec_elf_64.c b/arch/powerpc/kernel/kexec_elf_64.c
> index ba4f18a43ee8..52a29fc73730 100644
> --- a/arch/powerpc/kernel/kexec_elf_64.c
> +++ b/arch/powerpc/kernel/kexec_elf_64.c
> @@ -547,6 +547,7 @@ static int elf_exec_load(struct kimage *image, struct elfhdr *ehdr,
>  		kbuf.memsz = phdr->p_memsz;
>  		kbuf.buf_align = phdr->p_align;
>  		kbuf.buf_min = phdr->p_paddr + base;
> +		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>  		ret = kexec_add_buffer(&kbuf);
>  		if (ret)
>  			goto out;
> @@ -581,7 +582,8 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>  	struct kexec_buf kbuf = { .image = image, .buf_min = 0,
>  				  .buf_max = ppc64_rma_size };
>  	struct kexec_buf pbuf = { .image = image, .buf_min = 0,
> -				  .buf_max = ppc64_rma_size, .top_down = true };
> +				  .buf_max = ppc64_rma_size, .top_down = true,
> +				  .mem = KEXEC_BUF_MEM_UNKNOWN };
>  
>  	ret = build_elf_exec_info(kernel_buf, kernel_len, &ehdr, &elf_info);
>  	if (ret)
> @@ -606,6 +608,7 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>  		kbuf.bufsz = kbuf.memsz = initrd_len;
>  		kbuf.buf_align = PAGE_SIZE;
>  		kbuf.top_down = false;
> +		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>  		ret = kexec_add_buffer(&kbuf);
>  		if (ret)
>  			goto out;
> @@ -638,6 +641,7 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>  	kbuf.bufsz = kbuf.memsz = fdt_size;
>  	kbuf.buf_align = PAGE_SIZE;
>  	kbuf.top_down = true;
> +	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>  	ret = kexec_add_buffer(&kbuf);
>  	if (ret)
>  		goto out;
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Reviewed-by: Dave Young <dyoung@redhat.com>

Thanks
Dave
