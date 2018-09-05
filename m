Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424v4w2hq7zF31q
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 16:32:15 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w856TSLI096380
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Sep 2018 02:32:12 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ma94h2322-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Sep 2018 02:32:11 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Wed, 5 Sep 2018 07:32:10 +0100
Subject: Re: [PATCH v2] powerpc/powernv: Make possible for user to force a
 full ipl cec reboot
To: Vaibhav Jain <vaibhav@linux.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20180903102624.24344-1-vaibhav@linux.ibm.com>
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Date: Wed, 5 Sep 2018 12:02:03 +0530
MIME-Version: 1.0
In-Reply-To: <20180903102624.24344-1-vaibhav@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <2e8ec40d-76ca-97ad-6d7a-aded2eea6451@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/03/2018 03:56 PM, Vaibhav Jain wrote:
> Ever since fast reboot is enabled by default in opal,
> opal_cec_reboot() will use fast-reset instead of full IPL to perform
> system reboot. This leaves the user with no direct way to force a full
> IPL reboot except changing an nvram setting that persistently disables
> fast-reset for all subsequent reboots.
> 
> This patch provides a more direct way for the user to force a one-shot
> full IPL reboot by passing the command line argument 'full' to the
> reboot command. So the user will be able to tweak the reboot behavior
> via:
> 

.../...

> 
>   /* Argument to OPAL_PCI_TCE_KILL */
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

As discussed offline, please handle OPAL_SUCCESS case well.

-Vasant
