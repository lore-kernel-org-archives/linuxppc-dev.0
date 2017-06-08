Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjvp03qNlzDqFH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 15:57:12 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v585sQXb074573
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Jun 2017 01:57:08 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2axvmx1b96-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jun 2017 01:57:08 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 8 Jun 2017 15:57:06 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v585utFk56950868
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Jun 2017 15:57:03 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v585uVlA028959
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Jun 2017 15:56:31 +1000
Subject: Re: [PATCH v2] cxl: Fix error path on bad ioctl
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 vaibhav@linux.vnet.ibm.com, clombard@linux.vnet.ibm.com,
 philippe.bergheaud@fr.ibm.com
References: <20170606094341.14629-1-fbarrat@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 8 Jun 2017 15:56:06 +1000
MIME-Version: 1.0
In-Reply-To: <20170606094341.14629-1-fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <9ea4f7eb-60f0-7de7-60eb-d9d1a593b900@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

On 06/06/17 19:43, Frederic Barrat wrote:
> Fix error path if we can't copy user structure on CXL_IOCTL_START_WORK
> ioctl. We shouldn't unlock the context status mutex as it was not
> locked (yet).
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Cc: stable@vger.kernel.org
> Fixes: 0712dc7e73e5 ("cxl: Fix issues when unmapping contexts")
> ---
> Changelog:
> v2: change sizeof() parameter (Vaibhav)
>     tweak commit message and add 'Fixes:' (mpe)
>
>  drivers/misc/cxl/file.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
> index 17b433f1ce23..0761271d68c5 100644
> --- a/drivers/misc/cxl/file.c
> +++ b/drivers/misc/cxl/file.c
> @@ -159,11 +159,8 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
>
>  	/* Do this outside the status_mutex to avoid a circular dependency with
>  	 * the locking in cxl_mmap_fault() */
> -	if (copy_from_user(&work, uwork,
> -			   sizeof(struct cxl_ioctl_start_work))) {
> -		rc = -EFAULT;
> -		goto out;
> -	}
> +	if (copy_from_user(&work, uwork, sizeof(work)))
> +		return -EFAULT;
>
>  	mutex_lock(&ctx->status_mutex);
>  	if (ctx->status != OPENED) {
>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
