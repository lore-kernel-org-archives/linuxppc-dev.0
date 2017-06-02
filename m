Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfV9v1CqSzDqJV
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Jun 2017 02:32:34 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v52GT3sg085470
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Jun 2017 12:32:27 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2aua8pbk5k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Jun 2017 12:32:27 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Sat, 3 Jun 2017 02:32:25 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v52GWEFG56098974
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 3 Jun 2017 02:32:22 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v52GVmZ2014415
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 3 Jun 2017 02:31:48 +1000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, andrew.donnellan@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org, clombard@linux.vnet.ibm.com,
 philippe.bergheaud@fr.ibm.com
Subject: Re: [PATCH] cxl: Fix error path on bad ioctl
In-Reply-To: <20170602161523.14052-1-fbarrat@linux.vnet.ibm.com>
References: <20170602161523.14052-1-fbarrat@linux.vnet.ibm.com>
Date: Fri, 02 Jun 2017 22:01:22 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87wp8ul5b9.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Fred,

Good catch.

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:

> Fix error path if we can't copy user structure on
> CXL_IOCTL_START_WORK ioctl.
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/misc/cxl/file.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
> index 17b433f1ce23..caa44adfa60e 100644
> --- a/drivers/misc/cxl/file.c
> +++ b/drivers/misc/cxl/file.c
> @@ -160,10 +160,8 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
>  	/* Do this outside the status_mutex to avoid a circular dependency with
>  	 * the locking in cxl_mmap_fault() */
>  	if (copy_from_user(&work, uwork,
> -			   sizeof(struct cxl_ioctl_start_work))) {
> -		rc = -EFAULT;
> -		goto out;
> -	}
> +			   sizeof(struct cxl_ioctl_start_work)))

Bike-shedding a bit, but
s/sizeof(struct cxl_ioctl_start_work)))/sizeof(work)/
would look much cleaner


Reviewed-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
