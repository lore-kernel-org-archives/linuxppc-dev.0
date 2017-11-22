Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yhqBs15kWzDr4W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 04:26:59 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAMHNsiK003164
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 12:26:56 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2edbk2ya7w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 12:26:55 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 22 Nov 2017 17:26:53 -0000
Subject: Re: [RESEND][PATCH v2] cxl: Check if vphb exists before iterating
 over AFU devices
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>, stable@vger.kernel.org,
 "Alastair D'Silva" <alastair@linux.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
References: <20171122121744.18697-1-vaibhav@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 22 Nov 2017 18:26:48 +0100
MIME-Version: 1.0
In-Reply-To: <20171122121744.18697-1-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <df2375e6-94fe-b41f-e439-0665de319d3f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 22/11/2017 à 13:17, Vaibhav Jain a écrit :
> During an eeh a kernel-oops is reported if no vPHB to allocated to the

typo, "to allocated". Not important, but....

> AFU. This happens as during AFU init, an error in creation of vPHB is
> a non-fatal error. Hence afu->phb should always be checked for NULL
> before iterating over it for the virtual AFU pci devices.
> 
> This patch fixes the kenel-oops by adding a NULL pointer check for
> afu->phb before it is dereferenced.
> 
> Fixes: 9e8df8a2196("cxl: EEH support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
> Changelog:
> 
> Resend -> Added the 'Fixes' info and marking the patch to stable tree [Mpe]
> v2     -> Added the vphb NULL check to cxl_vphb_error_detected() [Andrew]
> ---
>   drivers/misc/cxl/pci.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index bb7fd3f4edab..18773343ab3e 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -2083,6 +2083,9 @@ static pci_ers_result_t cxl_vphb_error_detected(struct cxl_afu *afu,
>   	/* There should only be one entry, but go through the list
>   	 * anyway
>   	 */
> +	if (afu->phb == NULL)
> +		return result;
> +
>   	list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
>   		if (!afu_dev->driver)
>   			continue;
> @@ -2124,8 +2127,7 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>   			 * Tell the AFU drivers; but we don't care what they
>   			 * say, we're going away.
>   			 */
> -			if (afu->phb != NULL)
> -				cxl_vphb_error_detected(afu, state);
> +			cxl_vphb_error_detected(afu, state);
>   		}
>   		return PCI_ERS_RESULT_DISCONNECT;
>   	}
> @@ -2265,6 +2267,9 @@ static pci_ers_result_t cxl_pci_slot_reset(struct pci_dev *pdev)
>   		if (cxl_afu_select_best_mode(afu))
>   			goto err;
> 
> +		if (afu->phb == NULL)
> +			continue;
> +
>   		list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
>   			/* Reset the device context.
>   			 * TODO: make this less disruptive
> @@ -2327,6 +2332,9 @@ static void cxl_pci_resume(struct pci_dev *pdev)
>   	for (i = 0; i < adapter->slices; i++) {
>   		afu = adapter->afu[i];
> 
> +		if (afu->phb != NULL)
> +			continue;
> +

.. that one is more annoying.
afu->phb == NULL?

   Fred

>   		list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
>   			if (afu_dev->driver && afu_dev->driver->err_handler &&
>   			    afu_dev->driver->err_handler->resume)
> 
