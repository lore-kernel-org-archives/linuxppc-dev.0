Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vt74b2lPszDq93
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 10:53:01 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2SNmnDL035025
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 19:52:56 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29ft6fm0vn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 19:52:55 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 29 Mar 2017 09:52:53 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2SNqgbQ42926188
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 10:52:50 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2SNqIER025412
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 10:52:18 +1100
Subject: Re: [PATCH V3 1/7] cxl: Read vsec perst load image
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 imunsie@au1.ibm.com
References: <1490714052-18902-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1490714052-18902-2-git-send-email-clombard@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 29 Mar 2017 10:51:53 +1100
MIME-Version: 1.0
In-Reply-To: <1490714052-18902-2-git-send-email-clombard@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <973f703c-3294-345e-96e2-6c2f2b5d60aa@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

On 29/03/17 02:14, Christophe Lombard wrote:
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

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
