Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4200C169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 04:27:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE3B2184D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 04:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE3B2184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qnJq2c03zDqWj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 15:27:39 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qnH01sGNzDqS2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 15:26:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43qnGz6QyHz9sBb;
 Thu, 31 Jan 2019 15:26:03 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] mm: add probe_user_read()
In-Reply-To: <39fb6c5a191025378676492e140dc012915ecaeb.1547652372.git.christophe.leroy@c-s.fr>
References: <39fb6c5a191025378676492e140dc012915ecaeb.1547652372.git.christophe.leroy@c-s.fr>
Date: Thu, 31 Jan 2019 15:26:03 +1100
Message-ID: <875zu5pi5g.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> In powerpc code, there are several places implementing safe
> access to user data. This is sometimes implemented using
> probe_kernel_address() with additional access_ok() verification,
> sometimes with get_user() enclosed in a pagefault_disable()/enable()
> pair, etc. :
>     show_user_instructions()
>     bad_stack_expansion()
>     p9_hmi_special_emu()
>     fsl_pci_mcheck_exception()
>     read_user_stack_64()
>     read_user_stack_32() on PPC64
>     read_user_stack_32() on PPC32
>     power_pmu_bhrb_to()
>
> In the same spirit as probe_kernel_read(), this patch adds
> probe_user_read().
>
> probe_user_read() does the same as probe_kernel_read() but
> first checks that it is really a user address.
>
> The patch defines this function as a static inline so the "size"
> variable can be examined for const-ness by the check_object_size()
> in __copy_from_user_inatomic()
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  v3: Moved 'Returns:" comment after description.
>      Explained in the commit log why the function is defined static inline
>
>  v2: Added "Returns:" comment and removed probe_user_address()
>
>  include/linux/uaccess.h | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 37b226e8df13..ef99edd63da3 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -263,6 +263,40 @@ extern long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count);
>  #define probe_kernel_address(addr, retval)		\
>  	probe_kernel_read(&retval, addr, sizeof(retval))
>  
> +/**
> + * probe_user_read(): safely attempt to read from a user location
> + * @dst: pointer to the buffer that shall take the data
> + * @src: address to read from
> + * @size: size of the data chunk
> + *
> + * Safely read from address @src to the buffer at @dst.  If a kernel fault
> + * happens, handle that and return -EFAULT.
> + *
> + * We ensure that the copy_from_user is executed in atomic context so that
> + * do_page_fault() doesn't attempt to take mmap_sem.  This makes
> + * probe_user_read() suitable for use within regions where the caller
> + * already holds mmap_sem, or other locks which nest inside mmap_sem.
> + *
> + * Returns: 0 on success, -EFAULT on error.
> + */
> +
> +#ifndef probe_user_read
> +static __always_inline long probe_user_read(void *dst, const void __user *src,
> +					    size_t size)
> +{
> +	long ret;
> +

I wonder if we should explicitly switch to USER_DS here?

That would be sort of unusual, but the whole reason for this helper
existing is to make sure we safely read from user memory and not
accidentally from kernel.

cheers

> +	if (!access_ok(src, size))
> +		return -EFAULT;
> +
> +	pagefault_disable();
> +	ret = __copy_from_user_inatomic(dst, src, size);
> +	pagefault_enable();
> +
> +	return ret ? -EFAULT : 0;
> +}
> +#endif
> +
>  #ifndef user_access_begin
>  #define user_access_begin(ptr,len) access_ok(ptr, len)
>  #define user_access_end() do { } while (0)
> -- 
> 2.13.3
