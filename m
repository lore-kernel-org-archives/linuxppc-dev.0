Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vmdGq0CB1zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 12:12:50 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2K13f0Y001499
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Mar 2017 21:12:40 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 298wsfnqyp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Mar 2017 21:12:40 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 20 Mar 2017 11:12:37 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2K1CRIl53280928
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 12:12:35 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2K1C2r4020156
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 12:12:03 +1100
Subject: Re: [PATCH V2 1/6] cxl: Remove unused values in bare-metal
 environment.
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 imunsie@au1.ibm.com
References: <1489489722-935-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1489489722-935-2-git-send-email-clombard@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 20 Mar 2017 12:11:38 +1100
MIME-Version: 1.0
In-Reply-To: <1489489722-935-2-git-send-email-clombard@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <3a7300b9-9914-da76-877b-482511cb8749@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

On 14/03/17 22:08, Christophe Lombard wrote:
> The two fields pid and tid of the structure cxl_irq_info are only used
> in the guest environment. To avoid confusion, it's not necessary
> to fill the fields in the bare-metal environment.
> The PSL Process and Thread Identification Register is only used when
> attaching a dedicated process for PSL8 only.
>
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> ---
>  drivers/misc/cxl/native.c | 5 -----
>  1 file changed, 5 deletions(-)
>
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
