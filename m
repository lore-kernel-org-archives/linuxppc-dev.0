Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB0871A006B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 19:12:56 +1100 (AEDT)
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 550F5140080
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2014 19:12:54 +1100 (AEDT)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 28 Oct 2014 13:42:48 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>, mpe <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 1/4] CXL: Disable secondary hash in segment table
In-Reply-To: <1414466730-15591-2-git-send-email-imunsie@au.ibm.com>
References: <1414466730-15591-1-git-send-email-imunsie@au.ibm.com>
 <1414466730-15591-2-git-send-email-imunsie@au.ibm.com>
Date: Tue, 28 Oct 2014 13:42:38 +0530
Message-ID: <87d29cy5mx.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: cbe-oss-dev <cbe-oss-dev@lists.ozlabs.org>, mikey <mikey@neuling.org>,
 arnd <arnd@arndb.de>, greg <greg@kroah.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, anton <anton@samba.org>,
 imunsie <imunsie@au1.ibm.com>, jk <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ian Munsie <imunsie@au1.ibm.com> writes:

> From: Ian Munsie <imunsie@au1.ibm.com>
>
> This patch simplifies the process of finding a free segment table entry
> by disabling the secondary hash. This reduces the number of possible
> entries in the segment table for a given address from 16 to 8.
>
> Due to the large segment sizes we use it is extremely unlikely that the
> secondary hash would ever have been used in practice, so this should not
> have any negative impacts and may even improve performance due to the
> reduced number of comparisons that software & hardware need to perform.
>
> This patch clears the SC bit in the hardware's state register
> (CXL_PSL_SR_An) to disable the secondary hash in the hardware since we
> can no longer fill out entries using it.

This could have also gone as a code comment.


>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> ---
>  drivers/misc/cxl/fault.c  | 30 ++++++++----------------------
>  drivers/misc/cxl/native.c |  4 ++--
>  2 files changed, 10 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
> index 69506eb..d0e97fd 100644
> --- a/drivers/misc/cxl/fault.c
> +++ b/drivers/misc/cxl/fault.c
> @@ -22,29 +22,19 @@
>  #include "cxl.h"
>  
>  static struct cxl_sste* find_free_sste(struct cxl_sste *primary_group,
> -				       bool sec_hash,
> -				       struct cxl_sste *secondary_group,
>  				       unsigned int *lru)
>  {
> -	unsigned int i, entry;
> +	unsigned int entry;
>  	struct cxl_sste *sste, *group = primary_group;
>  
> -	for (i = 0; i < 2; i++) {
> -		for (entry = 0; entry < 8; entry++) {
> -			sste = group + entry;
> -			if (!(be64_to_cpu(sste->esid_data) & SLB_ESID_V))
> -				return sste;
> -		}
> -		if (!sec_hash)
> -			break;
> -		group = secondary_group;
> +	for (entry = 0; entry < 8; entry++) {
> +		sste = group + entry;
> +		if (!(be64_to_cpu(sste->esid_data) & SLB_ESID_V))
> +			return sste;
>  	}
>  	/* Nothing free, select an entry to cast out */
> -	if (sec_hash && (*lru & 0x8))
> -		sste = secondary_group + (*lru & 0x7);
> -	else
> -		sste = primary_group + (*lru & 0x7);
> -	*lru = (*lru + 1) & 0xf;
> +	sste = primary_group + *lru;
> +	*lru = (*lru + 1) & 0x7;
>  
>  	return sste;
>  }
> @@ -53,22 +43,18 @@ static void cxl_load_segment(struct cxl_context *ctx, struct copro_slb *slb)
>  {
>  	/* mask is the group index, we search primary and secondary here. */
>  	unsigned int mask = (ctx->sst_size >> 7)-1; /* SSTP0[SegTableSize] */
> -	bool sec_hash = 1;
>  	struct cxl_sste *sste;
>  	unsigned int hash;
>  	unsigned long flags;
>  
>  
> -	sec_hash = !!(cxl_p1n_read(ctx->afu, CXL_PSL_SR_An) & CXL_PSL_SR_An_SC);
> -
>  	if (slb->vsid & SLB_VSID_B_1T)
>  		hash = (slb->esid >> SID_SHIFT_1T) & mask;
>  	else /* 256M */
>  		hash = (slb->esid >> SID_SHIFT) & mask;
>  
>  	spin_lock_irqsave(&ctx->sste_lock, flags);
> -	sste = find_free_sste(ctx->sstp + (hash << 3), sec_hash,
> -			      ctx->sstp + ((~hash & mask) << 3), &ctx->sst_lru);
> +	sste = find_free_sste(ctx->sstp + (hash << 3), &ctx->sst_lru);
>  
>  	pr_devel("CXL Populating SST[%li]: %#llx %#llx\n",
>  			sste - ctx->sstp, slb->vsid, slb->esid);
> diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
> index 623286a..d47532e 100644
> --- a/drivers/misc/cxl/native.c
> +++ b/drivers/misc/cxl/native.c
> @@ -417,7 +417,7 @@ static int attach_afu_directed(struct cxl_context *ctx, u64 wed, u64 amr)
>  	ctx->elem->haurp = 0; /* disable */
>  	ctx->elem->sdr = cpu_to_be64(mfspr(SPRN_SDR1));
>  
> -	sr = CXL_PSL_SR_An_SC;
> +	sr = 0;
>  	if (ctx->master)
>  		sr |= CXL_PSL_SR_An_MP;
>  	if (mfspr(SPRN_LPCR) & LPCR_TC)
> @@ -508,7 +508,7 @@ static int attach_dedicated(struct cxl_context *ctx, u64 wed, u64 amr)
>  	u64 sr;
>  	int rc;
>  
> -	sr = CXL_PSL_SR_An_SC;
> +	sr = 0;
>  	set_endian(sr);
>  	if (ctx->master)
>  		sr |= CXL_PSL_SR_An_MP;
> -- 
> 2.1.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
