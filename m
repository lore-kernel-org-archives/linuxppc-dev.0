Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40fnMh5xr7zF1Rv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 01:58:08 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w47FsElX131835
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 May 2018 11:58:05 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2htqp2egrp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 May 2018 11:58:05 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Mon, 7 May 2018 16:58:03 +0100
Subject: Re: [PATCH] cxl: Configure PSL to not use APC virtual machines
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@linux.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
References: <20180417051102.7577-1-vaibhav@linux.vnet.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Mon, 7 May 2018 17:57:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180417051102.7577-1-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c0c8e359-91d5-ae93-f427-427c15337e88@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 17/04/2018 à 07:11, Vaibhav Jain a écrit :
> APC virtual machines arent used on POWER-9 chips and are already
> disabled in on-chip CAPP. They also need to be disabled on the PSL via
> 'PSL Data Send Control Register' by setting bit(47). This forces the
> PSL to send commands to CAPP with queue.id == 0.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
>   drivers/misc/cxl/pci.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index c32432168e6b..af30ee848d35 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -516,9 +516,9 @@ static int init_implementation_adapter_regs_psl9(struct cxl *adapter,
>   	cxl_p1_write(adapter, CXL_PSL9_FIR_CNTL, psl_fircntl);
> 
>   	/* Setup the PSL to transmit packets on the PCIe before the
> -	 * CAPP is enabled
> +	 * CAPP is enabled. Make sure that CAPP virtual machines are disabled
>   	 */
> -	cxl_p1_write(adapter, CXL_PSL9_DSNDCTL, 0x0001001000002A10ULL);
> +	cxl_p1_write(adapter, CXL_PSL9_DSNDCTL, 0x0001001000012A10ULL);
> 
>   	/*
>   	 * A response to an ASB_Notify request is returned by the
> 

Thanks

Reviewed-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
