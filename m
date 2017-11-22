Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yhY0z4LQHzDr0W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 17:47:30 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAM6idWo066632
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 01:47:27 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ed3951rav-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 01:47:27 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 22 Nov 2017 06:47:26 -0000
Subject: Re: [PATCH] cxl: Check if vphb exists before iterating over AFU
 devices
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@au1.ibm.com>
References: <20171122054615.18092-1-vaibhav@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 22 Nov 2017 17:47:21 +1100
MIME-Version: 1.0
In-Reply-To: <20171122054615.18092-1-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <8c71f549-7000-857b-8b98-6e01976f153c@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22/11/17 16:46, Vaibhav Jain wrote:
> During an eeh a kernel-oops is reported if no vPHB to allocated to the
> AFU. This happens as during AFU init, an error in creation of vPHB is
> a non-fatal error. Hence afu->phb should always be checked for NULL
> before iterating over it for the virtual AFU pci devices.
> 
> This patch fixes the kenel-oops by adding a NULL pointer check for
> afu->phb before it is dereferenced.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Looks to me like we might need the same fix in 
cxl_vphb_error_detected()? It's called twice in 
cxl_pci_error_detected(), and in only one of those cases is it 
surrounded by an afu->phb NULL check.

> ---
>   drivers/misc/cxl/pci.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index bb7fd3f4edab..80ac40cdc31b 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -2265,6 +2265,9 @@ static pci_ers_result_t cxl_pci_slot_reset(struct pci_dev *pdev)
>   		if (cxl_afu_select_best_mode(afu))
>   			goto err;
> 
> +		if (afu->phb == NULL)
> +			continue;
> +
>   		list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
>   			/* Reset the device context.
>   			 * TODO: make this less disruptive
> @@ -2327,6 +2330,9 @@ static void cxl_pci_resume(struct pci_dev *pdev)
>   	for (i = 0; i < adapter->slices; i++) {
>   		afu = adapter->afu[i];
> 
> +		if (afu->phb != NULL)
> +			continue;
> +
>   		list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
>   			if (afu_dev->driver && afu_dev->driver->err_handler &&
>   			    afu_dev->driver->err_handler->resume)
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
