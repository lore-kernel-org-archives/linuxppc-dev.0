Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41K3YN31ZjzF1LQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2018 20:35:19 +1000 (AEST)
Received: by mail-oi0-f67.google.com with SMTP id c6-v6so15452127oiy.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Jul 2018 03:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1530519301.git.fthain@telegraphics.com.au>
 <720e9899186bed184fb9b5cce070e2dc519f9665.1530519301.git.fthain@telegraphics.com.au>
In-Reply-To: <720e9899186bed184fb9b5cce070e2dc519f9665.1530519301.git.fthain@telegraphics.com.au>
From: Mathieu Malaterre <malat@debian.org>
Date: Mon, 2 Jul 2018 12:35:04 +0200
Message-ID: <CA+7wUsyfkC3FvbFyt9JRdBas3s+52tp7OH8h2jiJM9z+ynoyyw@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] macintosh/via-pmu: Fix section mismatch warning
To: fthain@telegraphics.com.au
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Schmitz <schmitzmic@gmail.com>,
 linux-m68k@lists.linux-m68k.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
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

On Mon, Jul 2, 2018 at 10:25 AM Finn Thain <fthain@telegraphics.com.au> wrote:
>
> The pmu_init() function has the __init qualifier, but the ops struct
> that holds a pointer to it does not. This causes a build warning.
> The driver works fine because the pointer is only dereferenced early.
>
> The function is so small that there's negligible benefit from using
> the __init qualifier. Remove it to fix the warning, consistent with
> the other ADB drivers.

Would you mind copy/pasting the warning you are seeing.

Make sure you have:

58935176ad17 powerpc/via-pmu: Fix section mismatch warning

Thanks

> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/macintosh/via-pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
> index 25c1ce811053..f8a2c917201f 100644
> --- a/drivers/macintosh/via-pmu.c
> +++ b/drivers/macintosh/via-pmu.c
> @@ -378,7 +378,7 @@ static int pmu_probe(void)
>         return vias == NULL? -ENODEV: 0;
>  }
>
> -static int __init pmu_init(void)
> +static int pmu_init(void)
>  {
>         if (vias == NULL)
>                 return -ENODEV;
> --
> 2.16.4
>
