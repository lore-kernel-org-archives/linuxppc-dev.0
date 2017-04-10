Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1dvb5WDlzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 15:26:19 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3A5Ig7S062912
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 01:26:06 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29r285km5r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 01:26:06 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 10 Apr 2017 15:26:04 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3A5PrZQ40763476
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 15:26:01 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3A5PTQR006607
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 15:25:29 +1000
Subject: Re: [PATCH V4 2/7] cxl: Remove unused values in bare-metal
 environment.
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 imunsie@au1.ibm.com
References: <1491574319-11852-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1491574319-11852-3-git-send-email-clombard@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 10 Apr 2017 15:25:04 +1000
MIME-Version: 1.0
In-Reply-To: <1491574319-11852-3-git-send-email-clombard@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <541ada67-8215-e58d-0cdb-69b966c0fbaf@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/04/17 00:11, Christophe Lombard wrote:
> The two previously fields pid and tid, located in the structure
> cxl_irq_info, are only used in the guest environment. To avoid confusion,
> it's not necessary to fill the fields in the bare-metal environment.
> Pid_tid is now renamed to 'reserved' to avoid undefined behavior on
> bare-metal. The PSL Process and Thread Identification Register
> (CXL_PSL_PID_TID_An) is only used when attaching a dedicated process
> for PSL8 only. This register goes away in CAIA2.
>
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>  drivers/misc/cxl/cxl.h    | 20 ++++----------------
>  drivers/misc/cxl/hcalls.c |  6 +++---
>  drivers/misc/cxl/native.c |  5 -----
>  3 files changed, 7 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index 79e60ec..36bc213 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -888,27 +888,15 @@ int __detach_context(struct cxl_context *ctx);
>  /*
>   * This must match the layout of the H_COLLECT_CA_INT_INFO retbuf defined
>   * in PAPR.
> - * A word about endianness: a pointer to this structure is passed when
> - * calling the hcall. However, it is not a block of memory filled up by
> - * the hypervisor. The return values are found in registers, and copied
> - * one by one when returning from the hcall. See the end of the call to
> - * plpar_hcall9() in hvCall.S
> - * As a consequence:
> - * - we don't need to do any endianness conversion
> - * - the pid and tid are an exception. They are 32-bit values returned in
> - *   the same 64-bit register. So we do need to worry about byte ordering.
> + * Field pid_tid is now 'reserved' because it's no more used on bare-metal.
> + * On a guest environment, PSL_PID_An is located on the upper 32 bits and
> + * PSL_TID_An register in the lower 32 bits.
>   */
>  struct cxl_irq_info {
>  	u64 dsisr;
>  	u64 dar;
>  	u64 dsr;
> -#ifndef CONFIG_CPU_LITTLE_ENDIAN
> -	u32 pid;
> -	u32 tid;
> -#else
> -	u32 tid;
> -	u32 pid;
> -#endif
> +	u64 reserved;
>  	u64 afu_err;
>  	u64 errstat;
>  	u64 proc_handle;
> diff --git a/drivers/misc/cxl/hcalls.c b/drivers/misc/cxl/hcalls.c
> index d6d11f4..9b8bb0f 100644
> --- a/drivers/misc/cxl/hcalls.c
> +++ b/drivers/misc/cxl/hcalls.c
> @@ -413,9 +413,9 @@ long cxl_h_collect_int_info(u64 unit_address, u64 process_token,
>
>  	switch (rc) {
>  	case H_SUCCESS:     /* The interrupt info is returned in return registers. */
> -		pr_devel("dsisr:%#llx, dar:%#llx, dsr:%#llx, pid:%u, tid:%u, afu_err:%#llx, errstat:%#llx\n",
> -			info->dsisr, info->dar, info->dsr, info->pid,
> -			info->tid, info->afu_err, info->errstat);
> +		pr_devel("dsisr:%#llx, dar:%#llx, dsr:%#llx, pid_tid:%#llx, afu_err:%#llx, errstat:%#llx\n",
> +			info->dsisr, info->dar, info->dsr, info->reserved,
> +			info->afu_err, info->errstat);
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

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
