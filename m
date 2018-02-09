Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdJ6g21ZqzF0kn
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 01:56:26 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w19EuEBi016093
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Feb 2018 09:56:24 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g1dfgh203-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Feb 2018 09:56:23 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 9 Feb 2018 14:56:22 -0000
Subject: Re: [PATCH] cxl: Enable NORST bit in PSL_DEBUG register for PSL9
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@linux.ibm.com>
References: <20180209040916.14250-1-vaibhav@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Fri, 9 Feb 2018 15:56:18 +0100
MIME-Version: 1.0
In-Reply-To: <20180209040916.14250-1-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <eb4a47b4-804f-1e07-c189-00a412519688@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 09/02/2018 à 05:09, Vaibhav Jain a écrit :
> We enable the NORST bit by default for debug afu images to prevent
> reset of AFU trace-data on a PCI link drop. For production AFU images
> this bit is always ignored and PSL gets reconfigured anyways thereby
> resetting the trace data. So setting this bit for non-debug images
> doesn't have any impact.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

btw, we should start removing dd1 code, it's not like anybody is going 
to try that now.

   Fred

>   drivers/misc/cxl/pci.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 758842f65a1b..c983f23cc2ed 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -503,8 +503,12 @@ static int init_implementation_adapter_regs_psl9(struct cxl *adapter,
>   	if (cxl_is_power9_dd1()) {
>   		/* Disabling deadlock counter CAR */
>   		cxl_p1_write(adapter, CXL_PSL9_GP_CT, 0x0020000000000001ULL);
> -	} else
> -		cxl_p1_write(adapter, CXL_PSL9_DEBUG, 0x4000000000000000ULL);
> +		/* Enable NORST */
> +		cxl_p1_write(adapter, CXL_PSL9_DEBUG, 0x8000000000000000ULL);
> +	} else {
> +		/* Enable NORST and DD2 features */
> +		cxl_p1_write(adapter, CXL_PSL9_DEBUG, 0xC000000000000000ULL);
> +	}
> 
>   	return 0;
>   }
> 
