Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkkYy53PyzDqrZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 12:03:34 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u661wvVg103090
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2016 22:03:32 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 240nbyd5w0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Jul 2016 22:03:31 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 6 Jul 2016 12:03:27 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7C3882BB005D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 12:03:23 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6623NAZ12845530
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 12:03:23 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6623M92014784
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 12:03:23 +1000
Subject: Re: [PATCH 02/14] cxl: Add cxl_slot_is_supported API
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
 <1467638532-9250-3-git-send-email-imunsie@au.ibm.com>
Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 6 Jul 2016 12:02:51 +1000
MIME-Version: 1.0
In-Reply-To: <1467638532-9250-3-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <58879160-9bea-e202-7767-d2b7084f9ff5@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/07/16 23:22, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
>
> This extends the check that the adapter is in a CAPI capable slot so
> that it may be called by external users in the kernel API. This will be
> used by the upcoming Mellanox CX4 support, which needs to know ahead of
> time if the card can be switched to cxl mode so that it can leave it in
> PCI mode if it is not.
>
> This API takes a parameter to check if CAPP DMA mode is supported, which
> it currently only allows on P8NVL systems, since that mode currently has
> issues accessing memory < 4GB on P8, and we cannot realistically avoid
> that.
>
> This API does not currently check if a CAPP unit is available (i.e. not
> already assigned to another PHB) on P8. Doing so would be racy since it
> is assigned on a first come first serve basis, and so long as CAPP DMA
> mode is not supported on P8 we don't need this, since the only
> anticipated user of this API requires CAPP DMA mode.
>
> Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>  drivers/misc/cxl/pci.c | 37 +++++++++++++++++++++++++++++++++++++
>  include/misc/cxl.h     | 15 +++++++++++++++
>  2 files changed, 52 insertions(+)
>
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 3a5f980..9530280 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -1426,6 +1426,43 @@ static int cxl_slot_is_switched(struct pci_dev *dev)
>  	return (depth > CXL_MAX_PCIEX_PARENT);
>  }
>
> +bool cxl_slot_is_supported(struct pci_dev *dev, int flags)
> +{
> +	if (!cpu_has_feature(CPU_FTR_HVMODE))
> +		return false;
> +
> +	if ((flags & CXL_SLOT_FLAG_DMA) && (!pvr_version_is(PVR_POWER8NVL))) {
> +		/*
> +		 * CAPP DMA mode is technically supported on regular P8, but
> +		 * will EEH if the card attempts to acccess memory < 4GB, which

access

> +		 * we cannot realistically avoid. We might be able to work
> +		 * around the issue, but until then return unsupported:
> +		 */
> +		return false;
> +	}
> +
> +	if (cxl_slot_is_switched(dev))
> +		return false;
> +
> +	/*
> +	 * XXX: This gets a little tricky on regular P8 (not POWER8NVL) since
> +	 * the CAPP can be connected to PHB 0, 1 or 2 on a first come first
> +	 * served basis, which is racy to check from here. If we need to
> +	 * support this in future we might need to consider having this
> +	 * function effectively reserve it ahead of time.
> +	 *
> +	 * Currently, the only user of this API is the Mellanox CX4, which is
> +	 * only supported on P8NVL due to the above mentioned limitation of
> +	 * CAPP DMA mode and therefore does not need to worry about thi. If the

this

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
