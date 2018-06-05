Return-Path: <fbarrat@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410WzW715VzDrpC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 22:57:11 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w55Csvi0127323
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jun 2018 08:57:08 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jdsfnm77q-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Jun 2018 08:57:07 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Tue, 5 Jun 2018 13:57:06 +0100
Subject: Re: [PATCH -next] ocxl: Fix missing unlock on error in
 afu_ioctl_enable_p9_wait()
To: Wei Yongjun <weiyongjun1@huawei.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Alastair D'Silva" <alastair@d-silva.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <1528190181-15745-1-git-send-email-weiyongjun1@huawei.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Tue, 5 Jun 2018 14:57:00 +0200
MIME-Version: 1.0
In-Reply-To: <1528190181-15745-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <eb4f541f-cd2a-2af6-0770-fc8cc4f4063b@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 05/06/2018 à 11:16, Wei Yongjun a écrit :
> Add the missing unlock before return from function
> afu_ioctl_enable_p9_wait() in the error handling case.
> 
> Fixes: e948e06fc63a ("ocxl: Expose the thread_id needed for wait on POWER9")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>   drivers/misc/ocxl/file.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
> index 33ae46c..e6a6074 100644
> --- a/drivers/misc/ocxl/file.c
> +++ b/drivers/misc/ocxl/file.c
> @@ -139,8 +139,10 @@ static long afu_ioctl_enable_p9_wait(struct ocxl_context *ctx,
>   		// Locks both status & tidr
>   		mutex_lock(&ctx->status_mutex);
>   		if (!ctx->tidr) {
> -			if (set_thread_tidr(current))
> +			if (set_thread_tidr(current)) {
> +				mutex_unlock(&ctx->status_mutex);
>   				return -ENOENT;
> +			}

O_o   Thanks for fixing it

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>


>   			ctx->tidr = current->thread.tidr;
>   		}
> 
