Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tZyQd4fP4zDsxm
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2016 03:30:49 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB9GUhhN125886
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Dec 2016 11:30:47 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 277ymha2yp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Dec 2016 11:30:47 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 9 Dec 2016 16:30:45 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id C76031B08023
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2016 16:33:09 +0000 (GMT)
Subject: Re: [PATCH v2] cxl: prevent read/write to AFU config space while AFU
 not configured
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20161209061850.23281-1-andrew.donnellan@au1.ibm.com>
Cc: ukrishn@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com, imunsie@au1.ibm.com
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Fri, 9 Dec 2016 17:30:40 +0100
MIME-Version: 1.0
In-Reply-To: <20161209061850.23281-1-andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <4f474dcc-8a85-858d-a536-67b25ea9b5a5@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
> index 3519ace..639a343 100644
> --- a/drivers/misc/cxl/vphb.c
> +++ b/drivers/misc/cxl/vphb.c
> @@ -76,23 +76,22 @@ static int cxl_pcie_cfg_record(u8 bus, u8 devfn)
>  	return (bus << 8) + devfn;
>  }
>
> -static int cxl_pcie_config_info(struct pci_bus *bus, unsigned int devfn,
> -				struct cxl_afu **_afu, int *_record)
> +static inline struct cxl_afu *pci_bus_to_afu(struct pci_bus *bus)
>  {
> -	struct pci_controller *phb;
> -	struct cxl_afu *afu;
> -	int record;
> +	struct pci_controller *phb = bus ? pci_bus_to_host(bus) : NULL;
>
> -	phb = pci_bus_to_host(bus);
> -	if (phb == NULL)
> -		return PCIBIOS_DEVICE_NOT_FOUND;
> +	return phb ? phb->private_data : NULL;
> +}
> +
> +static inline int cxl_pcie_config_info(struct pci_bus *bus, unsigned int devfn,
> +				       struct cxl_afu *afu, int *_record)
> +{
> +	int record;
>
> -	afu = (struct cxl_afu *)phb->private_data;
>  	record = cxl_pcie_cfg_record(bus->number, devfn);
>  	if (record > afu->crs_num)
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>
> -	*_afu = afu;
>  	*_record = record;
>  	return 0;
>  }


There's no reason to pass the afu parameter to that function, is it?
Pushing it further, do we need cxl_pcie_config_info()? It's now a simple 
wrapper around cxl_pcie_cfg_record()

   Fred
