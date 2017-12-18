Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z14RJ2BClzDsR6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 15:19:07 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBINhmSP034816
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 18:47:12 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2exmj46ekf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 18:47:11 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 18 Dec 2017 23:47:10 -0000
Subject: Re: [PATCH 11/13] cxl: Remove support for "Processing accelerators"
 class
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, mpe@ellerman.id.au,
 alastair@au1.ibm.com
References: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
 <199cdb186d837daa838a37d937c6586bb9cfe1a2.1513608243.git.fbarrat@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 19 Dec 2017 10:47:04 +1100
MIME-Version: 1.0
In-Reply-To: <199cdb186d837daa838a37d937c6586bb9cfe1a2.1513608243.git.fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <05f705cc-588c-58ea-27e2-8a992c62b298@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19/12/17 02:21, Frederic Barrat wrote:
> The cxl driver currently declares in its table of supported PCI
> devices the class "Processing accelerators". Therefore it may be
> called to probe for opencapi devices, which generates errors, as the
> config space of a cxl device is not compatible with opencapi.
> 
> So remove support for the generic class, as we now have (at least) two
> drivers for devices of the same class. Most cxl devices are FPGAs with
> a PSL which will show a known device ID of 0x477. Other devices are
> really supported by the cxlflash driver and are already listed in the
> table. So removing the class is expected to go unnoticed.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>   drivers/misc/cxl/pci.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 19969ee86d6f..758842f65a1b 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -125,8 +125,6 @@ static const struct pci_device_id cxl_pci_tbl[] = {
>   	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0601), },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0623), },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0628), },
> -	{ PCI_DEVICE_CLASS(0x120000, ~0), },
> -
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(pci, cxl_pci_tbl);
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
