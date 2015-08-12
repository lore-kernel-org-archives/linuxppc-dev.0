Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 28B681A0567
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 16:30:38 +1000 (AEST)
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 94EC91401C7
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 16:30:37 +1000 (AEST)
Received: by pawu10 with SMTP id u10so7780115paw.1
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2015 23:30:35 -0700 (PDT)
Date: Wed, 12 Aug 2015 16:31:28 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, Manoj Kumar
 <kumarmn@us.ibm.com>, mikey@neuling.org, imunsie@au.ibm.com
Subject: Re: [PATCH v3 01/11] cxl: Convert MMIO read/write macros to inline
 functions
Message-ID: <20150812163128.531d2391@camb691>
In-Reply-To: <1439340500-18610-2-git-send-email-dja@axtens.net>
References: <1439340500-18610-1-git-send-email-dja@axtens.net>
 <1439340500-18610-2-git-send-email-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 12 Aug 2015 10:48:10 +1000
Daniel Axtens <dja@axtens.net> wrote:

> We're about to make these more complex, so make them functions
> first.
> 

Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  drivers/misc/cxl/cxl.h | 51 ++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 35 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index 4fd66cabde1e..6a93bfbcd826 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -537,10 +537,15 @@ static inline void __iomem *_cxl_p1_addr(struct cxl *cxl, cxl_p1_reg_t reg)
>  	return cxl->p1_mmio + cxl_reg_off(reg);
>  }
>  
> -#define cxl_p1_write(cxl, reg, val) \
> -	out_be64(_cxl_p1_addr(cxl, reg), val)
> -#define cxl_p1_read(cxl, reg) \
> -	in_be64(_cxl_p1_addr(cxl, reg))
> +static inline void cxl_p1_write(struct cxl *cxl, cxl_p1_reg_t reg, u64 val)
> +{
> +	out_be64(_cxl_p1_addr(cxl, reg), val);
> +}
> +
> +static inline u64 cxl_p1_read(struct cxl *cxl, cxl_p1_reg_t reg)
> +{
> +	return in_be64(_cxl_p1_addr(cxl, reg));
> +}
>  
>  static inline void __iomem *_cxl_p1n_addr(struct cxl_afu *afu, cxl_p1n_reg_t reg)
>  {
> @@ -548,26 +553,40 @@ static inline void __iomem *_cxl_p1n_addr(struct cxl_afu *afu, cxl_p1n_reg_t reg
>  	return afu->p1n_mmio + cxl_reg_off(reg);
>  }
>  
> -#define cxl_p1n_write(afu, reg, val) \
> -	out_be64(_cxl_p1n_addr(afu, reg), val)
> -#define cxl_p1n_read(afu, reg) \
> -	in_be64(_cxl_p1n_addr(afu, reg))
> +static inline void cxl_p1n_write(struct cxl_afu *afu, cxl_p1n_reg_t reg, u64 val)
> +{
> +	out_be64(_cxl_p1n_addr(afu, reg), val);
> +}
> +
> +static inline u64 cxl_p1n_read(struct cxl_afu *afu, cxl_p1n_reg_t reg)
> +{
> +	return in_be64(_cxl_p1n_addr(afu, reg));
> +}
>  
>  static inline void __iomem *_cxl_p2n_addr(struct cxl_afu *afu, cxl_p2n_reg_t reg)
>  {
>  	return afu->p2n_mmio + cxl_reg_off(reg);
>  }
>  
> -#define cxl_p2n_write(afu, reg, val) \
> -	out_be64(_cxl_p2n_addr(afu, reg), val)
> -#define cxl_p2n_read(afu, reg) \
> -	in_be64(_cxl_p2n_addr(afu, reg))
> +static inline void cxl_p2n_write(struct cxl_afu *afu, cxl_p2n_reg_t reg, u64 val)
> +{
> +	out_be64(_cxl_p2n_addr(afu, reg), val);
> +}
>  
> +static inline u64 cxl_p2n_read(struct cxl_afu *afu, cxl_p2n_reg_t reg)
> +{
> +	return in_be64(_cxl_p2n_addr(afu, reg));
> +}
>  
> -#define cxl_afu_cr_read64(afu, cr, off) \
> -	in_le64((afu)->afu_desc_mmio + (afu)->crs_offset + ((cr) * (afu)->crs_len) + (off))
> -#define cxl_afu_cr_read32(afu, cr, off) \
> -	in_le32((afu)->afu_desc_mmio + (afu)->crs_offset + ((cr) * (afu)->crs_len) + (off))
> +static inline u64 cxl_afu_cr_read64(struct cxl_afu *afu, int cr, u64 off)
> +{
> +	return in_le64((afu)->afu_desc_mmio + (afu)->crs_offset + ((cr) * (afu)->crs_len) + (off));
> +}
> +
> +static inline u32 cxl_afu_cr_read32(struct cxl_afu *afu, int cr, u64 off)
> +{
> +	return in_le32((afu)->afu_desc_mmio + (afu)->crs_offset + ((cr) * (afu)->crs_len) + (off));
> +}
>  u16 cxl_afu_cr_read16(struct cxl_afu *afu, int cr, u64 off);
>  u8 cxl_afu_cr_read8(struct cxl_afu *afu, int cr, u64 off);
>  
