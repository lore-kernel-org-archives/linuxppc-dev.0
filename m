Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (unknown [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42495950brzF36W
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2018 11:59:55 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w841wbGG086365
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Sep 2018 21:59:50 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m9b919y1g-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Sep 2018 21:59:49 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 4 Sep 2018 02:59:47 +0100
Subject: Re: [PATCH v2] powerpc/powernv: Make possible for user to force a
 full ipl cec reboot
To: Vaibhav Jain <vaibhav@linux.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>,
 "Oliver O'Halloran" <oohall@gmail.com>
References: <20180903102624.24344-1-vaibhav@linux.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 4 Sep 2018 11:59:41 +1000
MIME-Version: 1.0
In-Reply-To: <20180903102624.24344-1-vaibhav@linux.ibm.com>
Message-Id: <39220fff-0db2-f2f4-50ab-1257d27a7133@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/09/18 20:26, Vaibhav Jain wrote:
> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
> index adddde023622..650484e0940b 100644
> --- a/arch/powerpc/platforms/powernv/setup.c
> +++ b/arch/powerpc/platforms/powernv/setup.c
> @@ -224,7 +224,22 @@ static void  __noreturn pnv_restart(char *cmd)
>   	pnv_prepare_going_down();
>   
>   	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
> -		rc = opal_cec_reboot();
> +		/* See if we need to do a full IPL reboot */
> +		if (cmd && strcmp(cmd, "full") == 0)
> +			rc = opal_cec_reboot2(OPAL_REBOOT_FULL_IPL, NULL);
> +		else
> +			rc = OPAL_UNSUPPORTED;
> +
> +		if (!(rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT)) {
> +			if (cmd) {
> +				pr_warn("Couldn't do a '%s' reboot. Err=%ld\n",
> +					cmd, rc);
> +				/* reset cmd to force a cec_reboot now */
> +				cmd = NULL;
> +			}
> +			rc = opal_cec_reboot();
> +		}
> +

The logic here is a bit hard to follow, relying on if (cmd && strcmp...) 
failing then setting rc = OPAL_UNSUPPORTED in order to handle the normal 
case seems a bit backwards.

I think I would slightly prefer it if the !cmd case were handled first 
to make it clear that opal_cec_reboot() is the normal case.

But either way:

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
