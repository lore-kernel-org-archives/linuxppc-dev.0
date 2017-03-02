Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYZvw0k26zDqLm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 12:48:11 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v221i3D6112314
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 20:48:09 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28x62hgseq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Mar 2017 20:48:08 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 2 Mar 2017 11:48:06 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AF6B22CE805B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 12:48:00 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v221lqWN37552194
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Mar 2017 12:48:00 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v221lQWH015145
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Mar 2017 12:47:27 +1100
Subject: Re: [RESEND-RFC v2 3/3] cxl: Reset freeze counters before adapter
 PERST for flashing new image
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 capi-linux <capi-linux@lists.linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Russell Currey <ruscur@russell.cc>
References: <20170301112452.15798-1-vaibhav@linux.vnet.ibm.com>
 <20170301112452.15798-4-vaibhav@linux.vnet.ibm.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 2 Mar 2017 12:46:59 +1100
MIME-Version: 1.0
In-Reply-To: <20170301112452.15798-4-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <4276cf0d-c39c-9155-e73d-4a117f43c85a@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/03/17 22:24, Vaibhav Jain wrote:
> The patch resets the freeze counter on eeh_pe struct for PHB
> associated with the cxl pci adapter. This would enable re-flashing of
> the cxl-adapter beyond the default limit of 5.
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
> Change-log:
>
> v1 -> v2
> Changes as suggested by Russell Currey:
> - Changed new variable names inline with eeh code nomenclature.
> - Removed the dev_info logging the PHB being reset. The log message is now
>   moved to eeh_handle_normal_event()

In eeh_pe_reset_freeze_counter() to be precise.

> ---
>  drivers/misc/cxl/pci.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index ce54dab..7960fd64 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -22,6 +22,7 @@
>  #include <asm/pnv-pci.h>
>  #include <asm/io.h>
>  #include <asm/reg.h>
> +#include <asm/eeh.h>
>
>  #include "cxl.h"
>  #include <misc/cxl.h>
> @@ -1231,6 +1232,8 @@ static void cxl_pci_remove_afu(struct cxl_afu *afu)
>  int cxl_pci_reset(struct cxl *adapter)
>  {
>  	struct pci_dev *dev = to_pci_dev(adapter->dev.parent);
> +	struct eeh_dev *edev = pci_dev_to_eeh_dev(dev);
> +	struct eeh_pe *pe = eeh_dev_to_pe(edev);
>  	int rc;
>
>  	if (adapter->perst_same_image) {
> @@ -1244,6 +1247,17 @@ int cxl_pci_reset(struct cxl *adapter)
>  	/* the adapter is about to be reset, so ignore errors */
>  	cxl_data_cache_flush(adapter);
>
> +	/* If loading a new image, reset freeze counters for the PHB
> +	 * associated with the adapter.
> +	 */
> +	if (pe && adapter->perst_loads_image) {
> +		/* Find the pe associated with the device PHB */
> +		while (pe->parent != NULL && (pe->type & EEH_PE_PHB) == 0)
> +			pe = pe->parent;
> +
> +		eeh_pe_reset_freeze_counter(pe);
> +	}
> +
>  	/* pcie_warm_reset requests a fundamental pci reset which includes a
>  	 * PERST assert/deassert.  PERST triggers a loading of the image
>  	 * if "user" or "factory" is selected in sysfs */
>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
