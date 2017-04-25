Return-Path: <srs0=fmze=4b=google.com=keescook@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wC7S80qNPzDqKJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 02:08:56 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wC7S80Fytz8tbM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 02:08:56 +1000 (AEST)
Received: from mail-io0-x229.google.com (mail-io0-x229.google.com
 [IPv6:2607:f8b0:4001:c06::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wC7S73p9bz9s8c
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 02:08:55 +1000 (AEST)
Received: by mail-io0-x229.google.com with SMTP id a103so217660878ioj.1
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2017 09:08:55 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1493122181-20921-1-git-send-email-mpe@ellerman.id.au>
References: <1493122181-20921-1-git-send-email-mpe@ellerman.id.au>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 25 Apr 2017 09:08:51 -0700
Message-ID: <CAGXu5jLdkXZzfzESwxf5pFzXAGNAF9OmZjrF0kVX9fwYdWSo7g@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mm: Fix possible out-of-bounds shift in
 arch_mmap_rnd()
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Bhupesh Sharma <bhsharma@redhat.com>, Balbir Singh <bsingharora@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 25, 2017 at 5:09 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> The recent patch to add runtime configuration of the ASLR limits added a bug in
> arch_mmap_rnd() where we may shift an integer (32-bits) by up to 33 bits,
> leading to undefined behaviour.
>
> In practice it exhibits as every process seg faulting instantly, presumably
> because the rnd value hasn't been restricited by the modulus at all. We didn't
> notice because it only happens under certain kernel configurations and if the
> number of bits is actually set to a large value.
>
> Fix it by switching to unsigned long.
>
> Fixes: 9fea59bd7ca5 ("powerpc/mm: Add support for runtime configuration of ASLR limits")
> Reported-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/mm/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
> index 005aa8a44915..9dbd2a733d6b 100644
> --- a/arch/powerpc/mm/mmap.c
> +++ b/arch/powerpc/mm/mmap.c
> @@ -66,7 +66,7 @@ unsigned long arch_mmap_rnd(void)
>         if (is_32bit_task())
>                 shift = mmap_rnd_compat_bits;
>  #endif
> -       rnd = get_random_long() % (1 << shift);
> +       rnd = get_random_long() % (1ul << shift);
>
>         return rnd << PAGE_SHIFT;
>  }
> --
> 2.7.4

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees


-- 
Kees Cook
Pixel Security
