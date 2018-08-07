Return-Path: <michaele@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lDMp0GjnzDqBx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 22:28:50 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w77COctD115639
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Aug 2018 08:28:47 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kqaq0j22r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Aug 2018 08:28:47 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <michaele@au1.ibm.com>;
 Tue, 7 Aug 2018 13:28:46 +0100
From: Michael Ellerman <michaele@au1.ibm.com>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, gregkh@linuxfoundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Bryant G. Ly" <bryantly@linux.ibm.com>
Subject: Re: [PATCH] misc: ibmvsm: Fix wrong assignment of return code
In-Reply-To: <1533562260-11456-1-git-send-email-bryantly@linux.vnet.ibm.com>
References: <1533562260-11456-1-git-send-email-bryantly@linux.vnet.ibm.com>
Date: Tue, 07 Aug 2018 22:28:40 +1000
MIME-Version: 1.0
Message-Id: <87y3dibbt3.fsf@concordia.ellerman.id.au>
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Bryant G. Ly" <bryantly@linux.vnet.ibm.com> writes:

> From: "Bryant G. Ly" <bryantly@linux.ibm.com>
>
> Currently the assignment is flipped and rc is always 0.

If you'd left rc uninitialised at the start of the function the compiler
would have caught it for you.

And what is the consequence of the bug? Nothing, complete system crash,
subtle data corruption?

Also this should be tagged:

Fixes: 0eca353e7ae7 ("misc: IBM Virtual Management Channel Driver (VMC)")

cheers

> diff --git a/drivers/misc/ibmvmc.c b/drivers/misc/ibmvmc.c
> index 8f82bb9..b8aaa68 100644
> --- a/drivers/misc/ibmvmc.c
> +++ b/drivers/misc/ibmvmc.c
> @@ -2131,7 +2131,7 @@ static int ibmvmc_init_crq_queue(struct crq_server_adapter *adapter)
>  	retrc = plpar_hcall_norets(H_REG_CRQ,
>  				   vdev->unit_address,
>  				   queue->msg_token, PAGE_SIZE);
> -	retrc = rc;
> +	rc = retrc;
>  
>  	if (rc == H_RESOURCE)
>  		rc = ibmvmc_reset_crq_queue(adapter);
