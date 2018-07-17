Return-Path: <keescook@google.com>
Received: from mail-yb0-x242.google.com (mail-yb0-x242.google.com
 [IPv6:2607:f8b0:4002:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41V60p62D3zF3Hb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 13:56:58 +1000 (AEST)
Received: by mail-yb0-x242.google.com with SMTP id c10-v6so14561221ybf.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2018 20:56:57 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180629185254.GA37557@beast>
References: <20180629185254.GA37557@beast>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 16 Jul 2018 20:56:54 -0700
Message-ID: <CAGXu5jKV-YAQZtN2heFdmiD9EOZ-AqrBc-NjC8fRYLSafovuyQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/msi: Remove VLA usage
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, Rob Herring <robh@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 29, 2018 at 11:52 AM, Kees Cook <keescook@chromium.org> wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> switches from an unchanging variable to a constant expression to eliminate
> the VLA generation.
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Friendly ping! Michael, can you take this?

-Kees


> ---
>  arch/powerpc/sysdev/msi_bitmap.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/msi_bitmap.c b/arch/powerpc/sysdev/msi_bitmap.c
> index 6243a7e537d0..e64a411d1a00 100644
> --- a/arch/powerpc/sysdev/msi_bitmap.c
> +++ b/arch/powerpc/sysdev/msi_bitmap.c
> @@ -225,22 +225,23 @@ static void __init test_of_node(void)
>         struct device_node of_node;
>         struct property prop;
>         struct msi_bitmap bmp;
> -       int size = 256;
> -       DECLARE_BITMAP(expected, size);
> +#define SIZE_EXPECTED 256
> +       DECLARE_BITMAP(expected, SIZE_EXPECTED);
>
>         /* There should really be a struct device_node allocator */
>         memset(&of_node, 0, sizeof(of_node));
>         of_node_init(&of_node);
>         of_node.full_name = node_name;
>
> -       WARN_ON(msi_bitmap_alloc(&bmp, size, &of_node));
> +       WARN_ON(msi_bitmap_alloc(&bmp, SIZE_EXPECTED, &of_node));
>
>         /* No msi-available-ranges, so expect > 0 */
>         WARN_ON(msi_bitmap_reserve_dt_hwirqs(&bmp) <= 0);
>
>         /* Should all still be free */
> -       WARN_ON(bitmap_find_free_region(bmp.bitmap, size, get_count_order(size)));
> -       bitmap_release_region(bmp.bitmap, 0, get_count_order(size));
> +       WARN_ON(bitmap_find_free_region(bmp.bitmap, SIZE_EXPECTED,
> +                                       get_count_order(SIZE_EXPECTED)));
> +       bitmap_release_region(bmp.bitmap, 0, get_count_order(SIZE_EXPECTED));
>
>         /* Now create a fake msi-available-ranges property */
>
> @@ -256,8 +257,8 @@ static void __init test_of_node(void)
>         WARN_ON(msi_bitmap_reserve_dt_hwirqs(&bmp));
>
>         /* Check we got the expected result */
> -       WARN_ON(bitmap_parselist(expected_str, expected, size));
> -       WARN_ON(!bitmap_equal(expected, bmp.bitmap, size));
> +       WARN_ON(bitmap_parselist(expected_str, expected, SIZE_EXPECTED));
> +       WARN_ON(!bitmap_equal(expected, bmp.bitmap, SIZE_EXPECTED));
>
>         msi_bitmap_free(&bmp);
>         kfree(bmp.bitmap);
> --
> 2.17.1
>
>
> --
> Kees Cook
> Pixel Security



-- 
Kees Cook
Pixel Security
