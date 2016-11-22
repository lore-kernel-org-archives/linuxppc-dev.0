Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN5yh2pWZzDvs3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:32:28 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAM0SvnD075852
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 19:32:26 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26v54ds439-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 19:32:25 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 22 Nov 2016 10:32:23 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id CD4962BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:32:20 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAM0WKe43146208
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:32:20 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAM0WKc3004537
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:32:20 +1100
Subject: Re: [PATCH 2/2] cxl: Set VPD timeout to avoid access failures
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1479762225-51440-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1479762606-51632-1-git-send-email-mrochs@linux.vnet.ibm.com>
Cc: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 22 Nov 2016 11:32:18 +1100
MIME-Version: 1.0
In-Reply-To: <1479762606-51632-1-git-send-email-mrochs@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <24ea6084-35e7-677f-a083-a6909adf881e@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22/11/16 08:10, Matthew R. Ochs wrote:
> Some IBM CXL devices can take up to ~120ms to complete a VPD access

Which devices?

> transaction when under heavy load. With an existing default VPD timeout
> of 50ms, reads/writes can fail despite there not being an issue with the
> underlying hardware.
>
> To avoid these false failures, increase the VPD wait timeout for certain
> CXL devices to a value that allows appropriate VPD access delay when faced
> with a worst-case scenario.
>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>

Contingent on Bjorn applying patch 1, and with comment below:

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>  drivers/misc/cxl/pci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index e96be9c..56a67cf 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -1675,6 +1675,10 @@ bool cxl_slot_is_supported(struct pci_dev *dev, int flags)
>  }
>  EXPORT_SYMBOL_GPL(cxl_slot_is_supported);
>
> +static bool cxl_pci_is_slow_vpd_device(struct pci_dev *dev)
> +{
> +	return dev->device == 0x0601;

Comment with device name.

> +}
>
>  static int cxl_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  {
> @@ -1692,6 +1696,9 @@ static int cxl_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  		return -ENODEV;
>  	}
>
> +	if (cxl_pci_is_slow_vpd_device(dev))
> +		pci_set_vpd_timeout(dev, msecs_to_jiffies(125));
> +
>  	if (cxl_verbose)
>  		dump_cxl_config_space(dev);
>
>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
