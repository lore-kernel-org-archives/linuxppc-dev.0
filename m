Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538C4C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 10:29:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C06112147C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 10:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="iiC3rd9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C06112147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wF0Y3nSZzDqRy
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 21:29:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=jannh@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="iiC3rd9a"; 
 dkim-atps=neutral
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wDyV6ZrCzDqQy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 21:27:08 +1100 (AEDT)
Received: by mail-ot1-x343.google.com with SMTP id k98so17393009otk.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Feb 2019 02:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KQVJ0Qx0jz4OgVw+39LjkotjVwynNqSsNpBV0A3AeRE=;
 b=iiC3rd9agn3fFWTEACayeEOzX/qIU3OUfTULp016nf/Pt9wZ13bomD4YfSTmmB6CfE
 V/y2oKetpYWIw1Ok/H6Tie+qdiJgS+Jmh8vLMJ8/GJpsV0EfhUOnAxBC1Bh9tPEKk5dj
 aHQQeBcHuYDjv+Pg0mnbbmHKZjlkauMBuAIqORuxyYvcdpMTrsB0UuuygbgANOb4EJpj
 Cz5Gyy3s6wEJsKWsy9/wjcUf5sy1hn3fqkv1FhiHmH97lUeAZSy7Sqk99afWYoY1qWkq
 axUzREfdptBlzxELLkk9VXDLa0A0vq6BqqzI9+xQc9h/UoaEPlgr83H7GznZszMTdixI
 CvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KQVJ0Qx0jz4OgVw+39LjkotjVwynNqSsNpBV0A3AeRE=;
 b=lUej0TvqkCB/29K0z9wml1ryOf8VLk7ZAz6BKgpTyXKh+joyq7gr0mKEMeueONmQwD
 3XPz1GCAzaGw/FnQjeUiBU+xShwI5KHlI0vYkPhlPyfKzKWg2RmkBeHEVyq4Vo29BnPZ
 4zNLqXuf06+/74m7OvcR5QF4oVaSkifwNiWwLnLQjWVAWpaf5I2wEkSXi7qg0NbpvVSS
 0VVnQXgenGe+i3mTZgWF4gB/Y4qkd/BXGJxMi87iAyvAt1YjOtUPO1tPP2QDwutz3PlW
 1wgpFoWUpI3dh8s2dP22Mo/gv7wjYVQRKP6avk4X4BWoaiAfY3pdx95sR6040okjDR8w
 dowA==
X-Gm-Message-State: AHQUAuZBbVn8CJJKwSJFHycC7fNJTCCGPDBGJsGmVrkY2/62Up6h49B6
 +CfVb+gu+sBiSUlWZP77DjPvfpGZukCZsKT12IdSew==
X-Google-Smtp-Source: AHgI3IbAjKvQxulqhIkAuOqdf95N7/LHxBrA5Kg81BCJVsQ4ajeb4xF6iL//RLLe9VbzWYskUcY5fo6qcLiAtEr0Kkg=
X-Received: by 2002:aca:e003:: with SMTP id x3mr2231660oig.39.1549535226052;
 Thu, 07 Feb 2019 02:27:06 -0800 (PST)
MIME-Version: 1.0
References: <39fb6c5a191025378676492e140dc012915ecaeb.1547652372.git.christophe.leroy@c-s.fr>
In-Reply-To: <39fb6c5a191025378676492e140dc012915ecaeb.1547652372.git.christophe.leroy@c-s.fr>
From: Jann Horn <jannh@google.com>
Date: Thu, 7 Feb 2019 11:26:39 +0100
Message-ID: <CAG48ez1gXgsBG6bYGG5+B4Dqkhk_iVaYLqt63RaxURxE0yt9eA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: add probe_user_read()
To: Christophe Leroy <christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Kees Cook <keescook@chromium.org>,
 kernel list <linux-kernel@vger.kernel.org>, Mike Rapoport <rppt@linux.ibm.com>,
 Linux-MM <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 7, 2019 at 10:22 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
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
>  #define probe_kernel_address(addr, retval)             \
>         probe_kernel_read(&retval, addr, sizeof(retval))
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
> +                                           size_t size)
> +{
> +       long ret;
> +
> +       if (!access_ok(src, size))
> +               return -EFAULT;

If this happens in code that's running with KERNEL_DS, the access_ok()
is a no-op. If this helper is only intended for accessing real
userspace memory, it would be more robust to add
set_fs(USER_DS)/set_fs(oldfs) around this thing. Looking at the
functions you're referring to in the commit message, e.g.
show_user_instructions() does an explicit `__access_ok(pc,
NR_INSN_TO_PRINT * sizeof(int), USER_DS)` to get the same effect.
(However, __access_ok() looks like it's horribly broken on x86 from
what I can tell, because it's going to use the generic version that
always returns 1...)

> +       pagefault_disable();
> +       ret = __copy_from_user_inatomic(dst, src, size);
> +       pagefault_enable();
> +
> +       return ret ? -EFAULT : 0;
> +}
> +#endif
> +
>  #ifndef user_access_begin
>  #define user_access_begin(ptr,len) access_ok(ptr, len)
>  #define user_access_end() do { } while (0)
> --
> 2.13.3
>
>
