Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436CCECDE3D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 15:44:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC2412086E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 15:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JsQ/G5nM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2412086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42c9Fz4XJBzF3bx
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Oct 2018 02:44:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JsQ/G5nM";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::c44; helo=mail-yw1-xc44.google.com;
 envelope-from=keescook@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="JsQ/G5nM";
 dkim-atps=neutral
Received: from mail-yw1-xc44.google.com (mail-yw1-xc44.google.com
 [IPv6:2607:f8b0:4864:20::c44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42c9CG6hhrzF3Sc
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Oct 2018 02:42:18 +1100 (AEDT)
Received: by mail-yw1-xc44.google.com with SMTP id 130-v6so1990180ywl.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 08:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=x9ZKFla8glrDERS4Gs9Sgo77xKF/nEALFb2B2FNwP6w=;
 b=JsQ/G5nMt9hQeWn2BZJqDbJ6yQLI0Xwl/sQkKSnsbMOmBF3K9vv1IjavLLHO+TqHpQ
 7cl/f/pBeHwPc2G8FFjTxqqXhvsML3P+GY/gF7bM8sueAk+J8S2uWEWOq84fY14TtVtM
 cfo71NRrLwRF8iBE+e6Uckf12wvRKzP4oFG/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=x9ZKFla8glrDERS4Gs9Sgo77xKF/nEALFb2B2FNwP6w=;
 b=IdbFY/vomDbg6t/KZMSkzczVUUxZNHbPelEjnRhu/ZLSfj+T7k3q+3jmSboqwkF45U
 kVn8BRNAGW8kQPVJLOEoacr4Mkp7EG47tnpPakqJBV6BCXiJu8TIE7Z9XLlNBnRaF0V9
 rXkGGwDOvZ1/NXpBiY+N7U8B27GZc7SYsrL3fL2Od7qN91b1XqRoip1KRaNdevW9sFTw
 i+dzYdZfwg1Tq3SaOH8VkpQXRXQ8aBxMgm2AkfzVA2/UoRscNPQYJW6iG5OhsjPbBo0U
 ZoxMi4llfs/BSu9P/YwaXx0UhlkLxy8t1tuu8PlmdX93US2r1H1GZTXZ3DCRqEBYnupu
 agTQ==
X-Gm-Message-State: ABuFfoiFkjSQ5KJe5LpOFIaJE908AFjvpDaqpOiq+SE6fapZX3sEKSoR
 BAUQmdGvl5LapQ0sahgUi/KZNf9aDQ0=
X-Google-Smtp-Source: ACcGV61QwHUOINU/1rGeZ1UZ2g80FnmhxsAgd2BfBi2MbV9Mt08K7rhDdvwnpyyHxjjXFSRSEHQi/A==
X-Received: by 2002:a81:2e55:: with SMTP id
 u82-v6mr23035794ywu.127.1539963735625; 
 Fri, 19 Oct 2018 08:42:15 -0700 (PDT)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com.
 [209.85.161.48])
 by smtp.gmail.com with ESMTPSA id z124-v6sm5737508ywb.39.2018.10.19.08.42.14
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Oct 2018 08:42:14 -0700 (PDT)
Received: by mail-yw1-f48.google.com with SMTP id g4-v6so338799ywe.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 08:42:14 -0700 (PDT)
X-Received: by 2002:a0d:d302:: with SMTP id
 v2-v6mr24279039ywd.124.1539963733716; 
 Fri, 19 Oct 2018 08:42:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Fri, 19 Oct 2018 08:42:12
 -0700 (PDT)
In-Reply-To: <336eb81e62d6c683a69d312f533899dcb6bcf770.1539959864.git.christophe.leroy@c-s.fr>
References: <336eb81e62d6c683a69d312f533899dcb6bcf770.1539959864.git.christophe.leroy@c-s.fr>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 19 Oct 2018 08:42:12 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJzp0v_Ox4gJcSdMVT7Rzuoy4mH-J3tPfrpeyCTi4o5YQ@mail.gmail.com>
Message-ID: <CAGXu5jJzp0v_Ox4gJcSdMVT7Rzuoy4mH-J3tPfrpeyCTi4o5YQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: add probe_user_read() and probe_user_address()
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
Cc: Andrew Morton <akpm@linux-foundation.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 19, 2018 at 8:14 AM, Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
> In the powerpc, there are several places implementing safe
> access to user data. This is sometimes implemented using
> probe_kerne_address() with additional access_ok() verification,
> sometimes with get_user() enclosed in a pagefault_disable()/enable()
> pair, etc... :
>     show_user_instructions()
>     bad_stack_expansion()
>     p9_hmi_special_emu()
>     fsl_pci_mcheck_exception()
>     read_user_stack_64()
>     read_user_stack_32() on PPC64
>     read_user_stack_32() on PPC32
>     power_pmu_bhrb_to()
>
> In the same spirit as probe_kernel_read() and probe_kernel_address(),
> this patch adds probe_user_read() and probe_user_address().
>
> probe_user_read() does the same as probe_kernel_read() but
> first checks that it is really a user address.
>
> probe_user_address() is a shortcut to probe_user_read()
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  include/linux/uaccess.h | 10 ++++++++++
>  mm/maccess.c            | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
>
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index efe79c1cdd47..fb00e3f847d7 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -266,6 +266,16 @@ extern long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count);
>  #define probe_kernel_address(addr, retval)             \
>         probe_kernel_read(&retval, addr, sizeof(retval))
>
> +/**
> + * probe_user_address(): safely attempt to read from a user location
> + * @addr: address to read from
> + * @retval: read into this variable
> + *
> + * Returns 0 on success, or -EFAULT.
> + */
> +#define probe_user_address(addr, retval)               \
> +       probe_user_read(&(retval), addr, sizeof(retval))
> +
>  #ifndef user_access_begin
>  #define user_access_begin() do { } while (0)
>  #define user_access_end() do { } while (0)
> diff --git a/mm/maccess.c b/mm/maccess.c
> index ec00be51a24f..85d4a88a6917 100644
> --- a/mm/maccess.c
> +++ b/mm/maccess.c
> @@ -67,6 +67,39 @@ long __probe_kernel_write(void *dst, const void *src, size_t size)
>  EXPORT_SYMBOL_GPL(probe_kernel_write);
>
>  /**
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
> + */
> +
> +long __weak probe_user_read(void *dst, const void *src, size_t size)
> +       __attribute__((alias("__probe_user_read")));

Let's use #defines to deal with per-arch aliases so we can keep the
inline I'm suggesting below...

> +
> +long __probe_user_read(void *dst, const void __user *src, size_t size)

Please make this __always_inline so the "size" variable can be
examined for const-ness by the check_object_size() in
__copy_from_user_inatomic().

-Kees

-- 
Kees Cook
Pixel Security
