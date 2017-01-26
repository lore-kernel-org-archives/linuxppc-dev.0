Return-Path: <ddstreet@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8TWs5C6WzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 04:32:41 +1100 (AEDT)
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com
 [IPv6:2a00:1450:4010:c07::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3v8TWr5PqYz9tk2
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Jan 2017 04:32:40 +1100 (AEDT)
Received: by mail-lf0-x242.google.com with SMTP id x1so24302548lff.0
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Jan 2017 09:32:40 -0800 (PST)
MIME-Version: 1.0
Sender: ddstreet@gmail.com
In-Reply-To: <1485394688-31129-3-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1485394688-31129-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1485394688-31129-3-git-send-email-sukadev@linux.vnet.ibm.com>
From: Dan Streetman <ddstreet@ieee.org>
Date: Thu, 26 Jan 2017 12:31:57 -0500
Message-ID: <CALZtONABwicMRdArkBqdJQhHnsLtvtzqvQeBGnuD=W00M-ZJbw@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] Move GET_FIELD/SET_FIELD to vas.h
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 linuxppc-dev@ozlabs.org, apopple@au1.ibm.com, oohall@gmail.com,
 michael.neuling@au1.ibm.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 25, 2017 at 8:38 PM, Sukadev Bhattiprolu
<sukadev@linux.vnet.ibm.com> wrote:
>
> Move the GET_FIELD and SET_FIELD macros to vas.h as VAS and other
> users of VAS, including NX-842 can use those macros.
>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Reviewed-by: Dan Streetman <dan.streetman@canonical.com>

> ---
>  arch/powerpc/include/asm/vas.h     | 8 ++++++++
>  drivers/crypto/nx/nx-842-powernv.c | 1 +
>  drivers/crypto/nx/nx-842.h         | 5 -----
>  3 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/vas.h b/arch/powerpc/include/asm/vas.h
> index 1c10437..fef9e87 100644
> --- a/arch/powerpc/include/asm/vas.h
> +++ b/arch/powerpc/include/asm/vas.h
> @@ -37,4 +37,12 @@ enum vas_thresh_ctl {
>         VAS_THRESH_FIFO_GT_EIGHTH_FULL,
>  };
>
> +/*
> + * Get/Set bit fields
> + */
> +#define GET_FIELD(m, v)                (((v) & (m)) >> MASK_LSH(m))
> +#define MASK_LSH(m)            (__builtin_ffsl(m) - 1)
> +#define SET_FIELD(m, v, val)   \
> +               (((v) & ~(m)) | ((((typeof(v))(val)) << MASK_LSH(m)) & (m)))
> +
>  #endif
> diff --git a/drivers/crypto/nx/nx-842-powernv.c b/drivers/crypto/nx/nx-842-powernv.c
> index 1710f80..ea6fb6c 100644
> --- a/drivers/crypto/nx/nx-842-powernv.c
> +++ b/drivers/crypto/nx/nx-842-powernv.c
> @@ -22,6 +22,7 @@
>
>  #include <asm/prom.h>
>  #include <asm/icswx.h>
> +#include <asm/vas.h>
>
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Dan Streetman <ddstreet@ieee.org>");
> diff --git a/drivers/crypto/nx/nx-842.h b/drivers/crypto/nx/nx-842.h
> index a4eee3b..30929bd 100644
> --- a/drivers/crypto/nx/nx-842.h
> +++ b/drivers/crypto/nx/nx-842.h
> @@ -100,11 +100,6 @@ static inline unsigned long nx842_get_pa(void *addr)
>         return page_to_phys(vmalloc_to_page(addr)) + offset_in_page(addr);
>  }
>
> -/* Get/Set bit fields */
> -#define MASK_LSH(m)            (__builtin_ffsl(m) - 1)
> -#define GET_FIELD(v, m)                (((v) & (m)) >> MASK_LSH(m))
> -#define SET_FIELD(v, m, val)   (((v) & ~(m)) | (((val) << MASK_LSH(m)) & (m)))
> -
>  /**
>   * This provides the driver's constraints.  Different nx842 implementations
>   * may have varying requirements.  The constraints are:
> --
> 2.7.4
>
