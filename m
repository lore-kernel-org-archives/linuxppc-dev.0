Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxWVv04HQzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Apr 2017 22:24:06 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v33CJ5G1120051
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Apr 2017 08:24:01 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29kdqfdb52-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Apr 2017 08:24:01 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 3 Apr 2017 13:23:59 +0100
Subject: Re: [PATCH V3 1/7] cxl: Read vsec perst load image
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com,
 andrew.donnellan@au1.ibm.com
References: <1490714052-18902-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1490714052-18902-2-git-send-email-clombard@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Mon, 3 Apr 2017 14:23:27 +0200
MIME-Version: 1.0
In-Reply-To: <1490714052-18902-2-git-send-email-clombard@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d7614dc7-edfc-fde2-b8cd-2fed6ec3f4a7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 28/03/2017 à 17:14, Christophe Lombard a écrit :
> This bit is used to cause a flash image load for programmable
> CAIA-compliant implementation. If this bit is set to ‘0’, a power
> cycle of the adapter is required to load a programmable CAIA-com-
> pliant implementation from flash.
> This field will be used by the following patches.
>
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> ---

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>


>  drivers/misc/cxl/pci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 91f6459..e82a207 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -1332,6 +1332,7 @@ static int cxl_read_vsec(struct cxl *adapter, struct pci_dev *dev)
>  	CXL_READ_VSEC_IMAGE_STATE(dev, vsec, &image_state);
>  	adapter->user_image_loaded = !!(image_state & CXL_VSEC_USER_IMAGE_LOADED);
>  	adapter->perst_select_user = !!(image_state & CXL_VSEC_USER_IMAGE_LOADED);
> +	adapter->perst_loads_image = !!(image_state & CXL_VSEC_PERST_LOADS_IMAGE);
>
>  	CXL_READ_VSEC_NAFUS(dev, vsec, &adapter->slices);
>  	CXL_READ_VSEC_AFU_DESC_OFF(dev, vsec, &afu_desc_off);
>
