Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxWbQ1PLnzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Apr 2017 22:28:02 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v33CIhmi112014
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Apr 2017 08:27:49 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29kkmd3095-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Apr 2017 08:27:49 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 3 Apr 2017 13:27:46 +0100
Subject: Re: [PATCH V3 2/7] cxl: Remove unused values in bare-metal
 environment.
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com,
 andrew.donnellan@au1.ibm.com
References: <1490714052-18902-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1490714052-18902-3-git-send-email-clombard@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Mon, 3 Apr 2017 14:27:09 +0200
MIME-Version: 1.0
In-Reply-To: <1490714052-18902-3-git-send-email-clombard@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <cf01ebed-bb7f-3d0b-e147-5b6525d3d6da@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 28/03/2017 à 17:14, Christophe Lombard a écrit :
> The two fields pid and tid of the structure cxl_irq_info are only used
> in the guest environment. To avoid confusion, it's not necessary
> to fill the fields in the bare-metal environment. These two fields
> are renamed to 'reserved' to avoid undefined behavior on bare-metal.
> The PSL Process and Thread Identification Register (CXL_PSL_PID_TID_An)
> is only used when attaching a dedicated process for PSL8 only. This
> register goes away in CAIA2.
>
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> ---
>  drivers/misc/cxl/cxl.h    | 13 +++++++------
>  drivers/misc/cxl/hcalls.c |  4 ++--
>  drivers/misc/cxl/native.c |  5 -----
>  3 files changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index 79e60ec..2bbe077 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -895,19 +895,20 @@ int __detach_context(struct cxl_context *ctx);
>   * plpar_hcall9() in hvCall.S
>   * As a consequence:
>   * - we don't need to do any endianness conversion
> - * - the pid and tid are an exception. They are 32-bit values returned in
> - *   the same 64-bit register. So we do need to worry about byte ordering.
> + * - the pid (reserved0) and tid (reserved1) are an exception. They are
> + *   32-bit values returned in the same 64-bit register. So we do need
> + *   to worry about byte ordering.
>   */
>  struct cxl_irq_info {
>  	u64 dsisr;
>  	u64 dar;
>  	u64 dsr;
>  #ifndef CONFIG_CPU_LITTLE_ENDIAN
> -	u32 pid;
> -	u32 tid;
> +	u32 reserved0;
> +	u32 reserved1;
>  #else
> -	u32 tid;
> -	u32 pid;
> +	u32 reserved1;
> +	u32 reserved0;
>  #endif


The resulting structure looks weird/over-complicated. I think we could 
get rid of the #ifdef about endianess by just declaring:

struct cxl_irq_info {
	u64 dsisr;
	u64 dar;
	u64 dsr;
	u64 pid_tid
	u64 afu_err;
...

and just print the 64-bit value in hcalls.c and let the reader figure 
out the order. It's just informational anyway.


   Fred



>  	u64 afu_err;
>  	u64 errstat;
> diff --git a/drivers/misc/cxl/hcalls.c b/drivers/misc/cxl/hcalls.c
> index d6d11f4..142a095 100644
> --- a/drivers/misc/cxl/hcalls.c
> +++ b/drivers/misc/cxl/hcalls.c
> @@ -414,8 +414,8 @@ long cxl_h_collect_int_info(u64 unit_address, u64 process_token,
>  	switch (rc) {
>  	case H_SUCCESS:     /* The interrupt info is returned in return registers. */
>  		pr_devel("dsisr:%#llx, dar:%#llx, dsr:%#llx, pid:%u, tid:%u, afu_err:%#llx, errstat:%#llx\n",
> -			info->dsisr, info->dar, info->dsr, info->pid,
> -			info->tid, info->afu_err, info->errstat);
> +			info->dsisr, info->dar, info->dsr, info->reserved0,
> +			info->reserved1, info->afu_err, info->errstat);
>  		return 0;
>  	case H_PARAMETER:   /* An incorrect parameter was supplied. */
>  		return -EINVAL;
> diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
> index 7ae7105..7257e8b 100644
> --- a/drivers/misc/cxl/native.c
> +++ b/drivers/misc/cxl/native.c
> @@ -859,8 +859,6 @@ static int native_detach_process(struct cxl_context *ctx)
>
>  static int native_get_irq_info(struct cxl_afu *afu, struct cxl_irq_info *info)
>  {
> -	u64 pidtid;
> -
>  	/* If the adapter has gone away, we can't get any meaningful
>  	 * information.
>  	 */
> @@ -870,9 +868,6 @@ static int native_get_irq_info(struct cxl_afu *afu, struct cxl_irq_info *info)
>  	info->dsisr = cxl_p2n_read(afu, CXL_PSL_DSISR_An);
>  	info->dar = cxl_p2n_read(afu, CXL_PSL_DAR_An);
>  	info->dsr = cxl_p2n_read(afu, CXL_PSL_DSR_An);
> -	pidtid = cxl_p2n_read(afu, CXL_PSL_PID_TID_An);
> -	info->pid = pidtid >> 32;
> -	info->tid = pidtid & 0xffffffff;
>  	info->afu_err = cxl_p2n_read(afu, CXL_AFU_ERR_An);
>  	info->errstat = cxl_p2n_read(afu, CXL_PSL_ErrStat_An);
>  	info->proc_handle = 0;
>
