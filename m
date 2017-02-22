Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTDrN3bKzzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 11:00:03 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1MNwgaI051971
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:00:01 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28ruy1c9gq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:00:01 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 23 Feb 2017 09:59:58 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B63482CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 10:59:56 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1MNxmax44761298
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 10:59:56 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1MNxOsS003631
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 10:59:24 +1100
Subject: Re: [PATCH] cxl: Route eeh events to all slices for
 pci_channel_io_perm_failure state
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20170222105105.11676-1-vaibhav@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 frederic.barrat@fr.ibm.com, Ian Munsie <ianmunsi@au1.ibm.com>,
 Andrew Donnellan <andonnel@au1.ibm.com>,
 Gregory Kurz <KURZGREG@fr.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 23 Feb 2017 10:58:58 +1100
MIME-Version: 1.0
In-Reply-To: <20170222105105.11676-1-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <a60e0fd2-69b0-4a9d-f9ce-3afe0c2bddb5@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22/02/17 21:51, Vaibhav Jain wrote:
> Fix a boundary condition where in some cases an eeh event with
> state == pci_channel_io_perm_failure wont be passed on to a driver
> attached to the virtual pci device associated with a slice. This will
> happen in case the slice just before (n-1) doesn't have any vph bus

s/vph/vPHB/?

> associated with it, that results in an early return from
> cxl_pci_error_detected callback.
>
> This also simplifies branch that handles this eeh state by returning
> PCI_ERS_RESULT_DISCONNECTED in all cases as the adapter is will be
> removed irrespective of the return value of cxl_pci_error_detected
> callback.

Agree with Matthew that this could be simplified a bit. If I'm 
interpreting this correctly, we could reword it something like:

"As the adapter will be removed irrespective of the return value of 
cxl_vphb_error_detected(), return PCI_ERS_RESULT_DISCONNECT in all 
cases, even if the AFU isn't using a vPHB (in which case we currently 
return PCI_ERS_RESULT_NONE)."

>
> Fixes: e4f5fc001a6("cxl: Do not create vPHB if there are no AFU configuration records")
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

Fix looks reasonable to me!

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>  drivers/misc/cxl/pci.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 80a87ab..679afc9 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -1780,15 +1780,13 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>
>  	/* If we're permanently dead, give up. */
>  	if (state == pci_channel_io_perm_failure) {
> -		/* Tell the AFU drivers; but we don't care what they
> -		 * say, we're going away.
> -		 */
>  		for (i = 0; i < adapter->slices; i++) {
>  			afu = adapter->afu[i];
> -			/* Only participate in EEH if we are on a virtual PHB */
> -			if (afu->phb == NULL)
> -				return PCI_ERS_RESULT_NONE;
> -			cxl_vphb_error_detected(afu, state);
> +			/* Tell the AFU drivers; but we don't care what they
> +			 * say, we're going away.
> +			 */
> +			if (afu->phb != NULL)
> +				cxl_vphb_error_detected(afu, state);
>  		}
>  		return PCI_ERS_RESULT_DISCONNECT;
>  	}
>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
