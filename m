Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vmykP1CV6zDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 01:19:24 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2KEFDcA138704
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 10:19:15 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2990yp8bhf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 10:19:15 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 20 Mar 2017 14:19:13 -0000
Subject: Re: [PATCH V2 1/6] cxl: Remove unused values in bare-metal
 environment.
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com,
 andrew.donnellan@au1.ibm.com
References: <1489489722-935-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1489489722-935-2-git-send-email-clombard@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 15:18:43 +0100
MIME-Version: 1.0
In-Reply-To: <1489489722-935-2-git-send-email-clombard@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <9d9765d9-8654-703f-f6bd-f4c4c1a15c57@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 14/03/2017 à 12:08, Christophe Lombard a écrit :
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

Can we rename pid and tid to "reserved" in the struct cxl_irq_info?
By keeping them, they may be used in common code (bare-metal and guest), 
which will lead to undefined behavior on bare-metal.
Since the structure matches what is passed in a hcall, we can't get rid 
of them, but renaming would be safer.

   Fred
