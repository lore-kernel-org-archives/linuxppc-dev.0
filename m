Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409cY11jb0zF2DL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 03:53:56 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2RGpM9u119981
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 12:53:54 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gys1rtbme-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 12:53:53 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 27 Mar 2018 17:53:52 +0100
Subject: Re: [PATCH] cxl: remove a dead branch
To: Mathieu Malaterre <malat@debian.org>
Cc: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
References: <20180322210528.22017-1-malat@debian.org>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Tue, 27 Mar 2018 18:53:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180322210528.22017-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <e41ef8c7-2813-17ed-fce7-06d53fd4157a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 22/03/2018 à 22:05, Mathieu Malaterre a écrit :
> In commit 14baf4d9c739 ("cxl: Add guest-specific code") the following code
> was added:
> 
> 	if (afu->crs_len < 0) {
> 		dev_err(&afu->dev, "Unexpected configuration record size value\n");
> 		return -EINVAL;
> 	}
> 
> However the variable `crs_len` is of type u64 and cannot be compared < 0.
> Remove the dead code section. Fix the following warning treated as error
> with W=1:


Thanks for reporting it. The test, as is, is indeed useless.
However, instead of just dropping it, we are discussing on improving it.

   Fred



> ../drivers/misc/cxl/guest.c:919:19: error: comparison of unsigned expression < 0 is always false [-Werror=type-limits]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   drivers/misc/cxl/guest.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
> index f58b4b6c79f2..48103fcff0b5 100644
> --- a/drivers/misc/cxl/guest.c
> +++ b/drivers/misc/cxl/guest.c
> @@ -916,11 +916,6 @@ static int afu_properties_look_ok(struct cxl_afu *afu)
>   		return -EINVAL;
>   	}
> 
> -	if (afu->crs_len < 0) {
> -		dev_err(&afu->dev, "Unexpected configuration record size value\n");
> -		return -EINVAL;
> -	}
> -
>   	return 0;
>   }
> 
