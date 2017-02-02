Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDRWn4bG4zDqGH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 15:16:21 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v124DrH7043964
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2017 23:16:19 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28bmwa0cum-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Feb 2017 23:16:18 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 2 Feb 2017 14:16:16 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1352A2BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 15:16:13 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v124G47233226840
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Feb 2017 15:16:12 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v124FfuC010037
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Feb 2017 15:15:41 +1100
Subject: Re: [PATCH 1/7] cxl: Read vsec perst load image
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 imunsie@au1.ibm.com
References: <1485970213-25532-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1485970213-25532-2-git-send-email-clombard@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 2 Feb 2017 15:15:15 +1100
MIME-Version: 1.0
In-Reply-To: <1485970213-25532-2-git-send-email-clombard@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <9e566edc-a20d-1a17-2aac-11e6bdab6945@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 02/02/17 04:30, Christophe Lombard wrote:
> This bit is used to cause a flash image load for programmable
> CAIA-compliant implementation. If this bit is set to ‘0’, a power
> cycle of the adapter is required to load a programmable CAIA-com-
> pliant implementation from flash.
> This field will be used by the following patches.
>
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>  drivers/misc/cxl/pci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 80a87ab..853925b 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -1323,6 +1323,7 @@ static int cxl_read_vsec(struct cxl *adapter, struct pci_dev *dev)
>  	CXL_READ_VSEC_IMAGE_STATE(dev, vsec, &image_state);
>  	adapter->user_image_loaded = !!(image_state & CXL_VSEC_USER_IMAGE_LOADED);
>  	adapter->perst_select_user = !!(image_state & CXL_VSEC_USER_IMAGE_LOADED);
> +	adapter->perst_loads_image = !!(image_state & CXL_VSEC_PERST_LOADS_IMAGE);
>
>  	CXL_READ_VSEC_NAFUS(dev, vsec, &adapter->slices);
>  	CXL_READ_VSEC_AFU_DESC_OFF(dev, vsec, &afu_desc_off);
>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
