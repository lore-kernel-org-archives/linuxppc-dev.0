Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sY9f06tJSzDrp3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 13:49:12 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8D3mHWR077459
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 23:49:10 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25dwtx6v5b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 23:49:10 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 13 Sep 2016 13:49:07 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AAD362CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 13:49:04 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8D3n40J1638900
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 13:49:04 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8D3n4w0012325
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 13:49:04 +1000
Subject: Re: [PATCH] cxl: Fix informational message
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
References: <1473676663-11057-1-git-send-email-fbarrat@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 13 Sep 2016 13:49:03 +1000
MIME-Version: 1.0
In-Reply-To: <1473676663-11057-1-git-send-email-fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <d8945782-7bd1-3fe5-221a-b4dbb20c31cc@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/09/16 20:37, Frederic Barrat wrote:
> When set_sl_ops() is called, the adapter data structure is not fully
> initialized yet. Therefore the device name is not showing up in the
> trace. Fix is simply to get the device name from the pci_dev
> structure.
>
> Fixes: 6d382616ac22 ("cxl: Abstract the differences between the PSL and XSL")
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>  drivers/misc/cxl/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 6f0c4ac..cd922a8 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -1530,11 +1530,11 @@ static void set_sl_ops(struct cxl *adapter, struct pci_dev *dev)
>  {
>  	if (dev->vendor == PCI_VENDOR_ID_MELLANOX && dev->device == 0x1013) {
>  		/* Mellanox CX-4 */
> -		dev_info(&adapter->dev, "Device uses an XSL\n");
> +		dev_info(&dev->dev, "Device uses an XSL\n");
>  		adapter->native->sl_ops = &xsl_ops;
>  		adapter->min_pe = 1; /* Workaround for CX-4 hardware bug */
>  	} else {
> -		dev_info(&adapter->dev, "Device uses a PSL\n");
> +		dev_info(&dev->dev, "Device uses a PSL\n");
>  		adapter->native->sl_ops = &psl_ops;
>  	}
>  }
>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
