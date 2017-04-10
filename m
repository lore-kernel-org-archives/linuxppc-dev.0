Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1c2H6ssWzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 14:01:59 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3A3x2pF114796
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 00:01:44 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29qqqmk8ek-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 00:01:44 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 10 Apr 2017 14:01:41 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3A41Vcf47251662
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 14:01:39 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3A412un004342
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 14:01:03 +1000
Subject: Re: [PATCH V4 1/7] cxl: Read vsec perst load image
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 imunsie@au1.ibm.com
References: <1491574319-11852-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1491574319-11852-2-git-send-email-clombard@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 10 Apr 2017 14:00:42 +1000
MIME-Version: 1.0
In-Reply-To: <1491574319-11852-2-git-send-email-clombard@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <7592f376-c01a-1181-d4b8-380034fbec1a@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

On 08/04/17 00:11, Christophe Lombard wrote:
> This bit is used to cause a flash image load for programmable
> CAIA-compliant implementation. If this bit is set to ‘0’, a power
> cycle of the adapter is required to load a programmable CAIA-com-
> pliant implementation from flash.
> This field will be used by the following patches.
>
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> ---
>  drivers/misc/cxl/pci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index b27ea98..1f4c351 100644
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

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
