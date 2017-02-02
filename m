Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDRYd0WYzzDqGJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 15:17:56 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v124FwPW078829
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2017 23:17:55 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28bs69yfrm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Feb 2017 23:17:54 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 2 Feb 2017 14:17:52 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E593A2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 15:17:49 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v124Hfrm30867458
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Feb 2017 15:17:49 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v124HHJr014836
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Feb 2017 15:17:17 +1100
Subject: Re: [PATCH 2/7] cxl: Remove unused values in bare-metal environment.
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 imunsie@au1.ibm.com
References: <1485970213-25532-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1485970213-25532-3-git-send-email-clombard@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 2 Feb 2017 15:16:53 +1100
MIME-Version: 1.0
In-Reply-To: <1485970213-25532-3-git-send-email-clombard@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <a4060806-5ae1-e58b-3256-984cf7a66875@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/02/17 04:30, Christophe Lombard wrote:
> The two fields pid and tid of the structure cxl_irq_info are only used
> in the guest environment. To avoid confusion, it's not necessary
> to fill the fields in the bare-metal environment.
> The PSL Process and Thread Identification Register is only used when
> attaching a dedicated process for PSL8 only.
>
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>  drivers/misc/cxl/native.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
> index 09505f4..8a3ce99 100644
> --- a/drivers/misc/cxl/native.c
> +++ b/drivers/misc/cxl/native.c
> @@ -858,8 +858,6 @@ static int native_detach_process(struct cxl_context *ctx)
>
>  static int native_get_irq_info(struct cxl_afu *afu, struct cxl_irq_info *info)
>  {
> -	u64 pidtid;
> -
>  	/* If the adapter has gone away, we can't get any meaningful
>  	 * information.
>  	 */
> @@ -869,9 +867,6 @@ static int native_get_irq_info(struct cxl_afu *afu, struct cxl_irq_info *info)
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
