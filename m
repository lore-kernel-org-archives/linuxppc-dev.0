Return-Path: <mukesh02@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tk3480v1PzDwT9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 16:24:23 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBL5O6iY004009
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 00:24:21 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27fgs51x87-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 00:24:21 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mukesh02@linux.vnet.ibm.com>;
 Wed, 21 Dec 2016 15:24:19 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0FBDB3578053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 16:24:16 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBL5OFYn49217776
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 16:24:15 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBL5OFgD004701
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 16:24:15 +1100
Received: from [9.124.35.243] (mukesh-thinkpad-t450.in.ibm.com [9.124.35.243])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 uBL5OEAF004673
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 16:24:15 +1100
Subject: Re: [PATCH] powernv/opal: Handle OPAL_WRONG_STATE error from OPAL
 fails
To: linuxppc-dev@lists.ozlabs.org
References: <1482243419-23041-1-git-send-email-vipin@linux.vnet.ibm.com>
From: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>
Date: Wed, 21 Dec 2016 10:54:09 +0530
MIME-Version: 1.0
In-Reply-To: <1482243419-23041-1-git-send-email-vipin@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <6343cad1-6fb5-8013-1229-e2a73afd019f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 20 December 2016 07:46 PM, Vipin K Parashar wrote:
> Added check for OPAL_WRONG_STATE error code returned from OPAL.
> Currently Linux flashes "unexpected error" over console for this
> error. This will avoid throwing such message and return I/O error
> for such OPAL failures.
>
> Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/opal.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 2822935..ab91d53 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -866,9 +866,10 @@ int opal_error_code(int rc)
>   	case OPAL_NO_MEM:		return -ENOMEM;
>   	case OPAL_PERMISSION:		return -EPERM;
>
> -	case OPAL_UNSUPPORTED:		return -EIO;
> -	case OPAL_HARDWARE:		return -EIO;
> -	case OPAL_INTERNAL_ERROR:	return -EIO;
> +	case OPAL_UNSUPPORTED:
> +	case OPAL_HARDWARE:
> +	case OPAL_INTERNAL_ERROR:
> +	case OPAL_WRONG_STATE:		return -EIO;

Looks good.

Reviewed-by: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>

>   	default:
>   		pr_err("%s: unexpected OPAL error %d\n", __func__, rc);
>   		return -EIO;
