Return-Path: <srs0=mrlv=22=gmail.com=ddstreet@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vl9bt26TVzDqZD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Mar 2017 03:22:34 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vl9bt18FVz8syH
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Mar 2017 03:22:34 +1100 (AEDT)
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com
 [IPv6:2a00:1450:4010:c07::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vl9bs153Mz9s2s
 for <linuxppc-dev@ozlabs.org>; Sat, 18 Mar 2017 03:22:33 +1100 (AEDT)
Received: by mail-lf0-x242.google.com with SMTP id r36so5879241lfi.0
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Mar 2017 09:22:32 -0700 (PDT)
MIME-Version: 1.0
Sender: ddstreet@gmail.com
In-Reply-To: <1489721642-5657-3-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1489721642-5657-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1489721642-5657-3-git-send-email-sukadev@linux.vnet.ibm.com>
From: Dan Streetman <ddstreet@ieee.org>
Date: Fri, 17 Mar 2017 12:21:47 -0400
Message-ID: <CALZtONDYTvFdUxw-CsZaGOQ0d9fk94UPNZxOe3WVdBdSHReZ6A@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] Move GET_FIELD/SET_FIELD to vas.h
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 linuxppc-dev@ozlabs.org, apopple@au1.ibm.com,
 "Oliver O'Halloran" <oohall@gmail.com>,
 Michael Neuling <michael.neuling@au1.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 16, 2017 at 11:33 PM, Sukadev Bhattiprolu
<sukadev@linux.vnet.ibm.com> wrote:
> Move the GET_FIELD and SET_FIELD macros to vas.h as VAS and other
> users of VAS, including NX-842 can use those macros.
>
> There is a lot of related code between the VAS/NX kernel drivers
> and skiboot. For consistency switch the order of parameters in
> SET_FIELD to match the order in skiboot.
>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Reviewed-by: Dan Streetman <ddstreet@ieee.org>

also, can you change the MAINTAINERS file owner of the IBM Power 842
accelerator to yourself, or someone else at IBM?  I no longer have
access to any of the ppc hardware, so it hardly makes sense for me to
remain the maintainer of it.

> ---
>
> Changelog[v3]
>         - Fix order of parameters in nx-842 driver.
> ---
>  arch/powerpc/include/asm/vas.h     | 8 +++++++-
>  drivers/crypto/nx/nx-842-powernv.c | 7 ++++---
>  drivers/crypto/nx/nx-842.h         | 5 -----
>  3 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/vas.h b/arch/powerpc/include/asm/vas.h
> index 6d35ce6..184eeb2 100644
> --- a/arch/powerpc/include/asm/vas.h
> +++ b/arch/powerpc/include/asm/vas.h
> @@ -37,7 +37,13 @@ enum vas_cop_type {
>         VAS_COP_TYPE_MAX,
>  };
>
> +/*
> + * Get/Set bit fields
> + */
> +#define GET_FIELD(m, v)                (((v) & (m)) >> MASK_LSH(m))
> +#define MASK_LSH(m)            (__builtin_ffsl(m) - 1)
> +#define SET_FIELD(m, v, val)   \
> +               (((v) & ~(m)) | ((((typeof(v))(val)) << MASK_LSH(m)) & (m)))
>
>  #endif /* __KERNEL__ */
> -
>  #endif
> diff --git a/drivers/crypto/nx/nx-842-powernv.c b/drivers/crypto/nx/nx-842-powernv.c
> index 1710f80..3abb045 100644
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
> @@ -424,9 +425,9 @@ static int nx842_powernv_function(const unsigned char *in, unsigned int inlen,
>
>         /* set up CCW */
>         ccw = 0;
> -       ccw = SET_FIELD(ccw, CCW_CT, nx842_ct);
> -       ccw = SET_FIELD(ccw, CCW_CI_842, 0); /* use 0 for hw auto-selection */
> -       ccw = SET_FIELD(ccw, CCW_FC_842, fc);
> +       ccw = SET_FIELD(CCW_CT, ccw, nx842_ct);
> +       ccw = SET_FIELD(CCW_CI_842, ccw, 0); /* use 0 for hw auto-selection */
> +       ccw = SET_FIELD(CCW_FC_842, ccw, fc);
>
>         /* set up CRB's CSB addr */
>         csb_addr = nx842_get_pa(csb) & CRB_CSB_ADDRESS;
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
