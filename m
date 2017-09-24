Return-Path: <keescook@google.com>
Received: from mail-it0-x232.google.com (mail-it0-x232.google.com
 [IPv6:2607:f8b0:4001:c0b::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y0cS313CSzDsN9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Sep 2017 05:17:54 +1000 (AEST)
Received: by mail-it0-x232.google.com with SMTP id o200so4989243itg.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Sep 2017 12:17:54 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20170921093729.1080368AC1@po15668-vm-win7.idsi0.si.c-s.fr>
References: <20170921093729.1080368AC1@po15668-vm-win7.idsi0.si.c-s.fr>
From: Kees Cook <keescook@chromium.org>
Date: Sun, 24 Sep 2017 12:17:51 -0700
Message-ID: <CAGXu5jJ54+bCcXaPK1ExsxtTDPHNn1+1gywb3TDbe-SEtt1zuQ@mail.gmail.com>
Subject: Re: [PATCH] mm: fix RODATA_TEST failure "rodata_test: test data was
 not read only"
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Jinbum Park <jinb.park7@gmail.com>, Linux-MM <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 21, 2017 at 2:37 AM, Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
> On powerpc, RODATA_TEST fails with message the following messages:
>
> [    6.199505] Freeing unused kernel memory: 528K
> [    6.203935] rodata_test: test data was not read only
>
> This is because GCC allocates it to .data section:
>
> c0695034 g     O .data  00000004 rodata_test_data

Uuuh... that seems like a compiler bug. It's marked "const" -- it
should never end up in .data. I would argue that this has done exactly
what it was supposed to do, and shows that something has gone wrong.
It should always be const. Adding "static" should just change
visibility. (I'm not opposed to the static change, but it seems to
paper over a problem with the compiler...)

-Kees

>
> Since commit 056b9d8a76924 ("mm: remove rodata_test_data export,
> add pr_fmt"), rodata_test_data is used only inside rodata_test.c
> By declaring it static, it gets properly allocated into .rodata
> section instead of .data:
>
> c04df710 l     O .rodata        00000004 rodata_test_data
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  mm/rodata_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/rodata_test.c b/mm/rodata_test.c
> index 6bb4deb12e78..d908c8769b48 100644
> --- a/mm/rodata_test.c
> +++ b/mm/rodata_test.c
> @@ -14,7 +14,7 @@
>  #include <linux/uaccess.h>
>  #include <asm/sections.h>
>
> -const int rodata_test_data = 0xC3;
> +static const int rodata_test_data = 0xC3;
>
>  void rodata_test(void)
>  {
> --
> 2.13.3
>



-- 
Kees Cook
Pixel Security
