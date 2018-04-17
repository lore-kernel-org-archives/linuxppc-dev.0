Return-Path: <alastair@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QD5j41x9zF21r
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 15:17:29 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3H5GWHH118982
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 01:17:27 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hd491nx9a-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 01:17:26 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Tue, 17 Apr 2018 06:17:24 +0100
Subject: Re: [PATCH] cxl: Configure PSL to not use APC virtual machines
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, Christophe Lombard
 <christophe_lombard@fr.ibm.com>, Philippe Bergheaud
 <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@linux.ibm.com>
Date: Tue, 17 Apr 2018 15:17:11 +1000
In-Reply-To: <20180417051102.7577-1-vaibhav@linux.vnet.ibm.com>
References: <20180417051102.7577-1-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1523942231.3246.1.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-04-17 at 10:41 +0530, Vaibhav Jain wrote:
> APC virtual machines arent used on POWER-9 chips and are already
> disabled in on-chip CAPP. They also need to be disabled on the PSL
> via
> 'PSL Data Send Control Register' by setting bit(47). This forces the
> PSL to send commands to CAPP with queue.id == 0.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
>  drivers/misc/cxl/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index c32432168e6b..af30ee848d35 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -516,9 +516,9 @@ static int
> init_implementation_adapter_regs_psl9(struct cxl *adapter,
>  	cxl_p1_write(adapter, CXL_PSL9_FIR_CNTL, psl_fircntl);
>  
>  	/* Setup the PSL to transmit packets on the PCIe before the
> -	 * CAPP is enabled
> +	 * CAPP is enabled. Make sure that CAPP virtual machines are
> disabled
>  	 */
> -	cxl_p1_write(adapter, CXL_PSL9_DSNDCTL,
> 0x0001001000002A10ULL);
> +	cxl_p1_write(adapter, CXL_PSL9_DSNDCTL,
> 0x0001001000012A10ULL);
>  
>  	/*
>  	 * A response to an ASB_Notify request is returned by the
> 

Reviewed-by: Alastair D'Silva <alastair@d-silva.org>

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australiamob: 0423 762 819
