Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tvVnN1fxLzDqQH
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jan 2017 01:44:23 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v05Eg8No103153
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jan 2017 09:44:20 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27smdxkgxv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Jan 2017 09:44:20 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Thu, 5 Jan 2017 14:44:18 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4FEA6219005F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 14:43:24 +0000 (GMT)
Subject: Re: [RESEND] cxl: Force psl data-cache flush during device shutdown
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20170104061852.18512-1-vaibhav@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 frederic.barrat@fr.ibm.com, Ian Munsie <ianmunsi@au1.ibm.com>,
 Andrew Donnellan <andonnel@au1.ibm.com>,
 Gregory Kurz <KURZGREG@fr.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Thu, 5 Jan 2017 15:44:12 +0100
MIME-Version: 1.0
In-Reply-To: <20170104061852.18512-1-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <e0f8afec-dc4e-b8f0-61b1-6298c2265d8a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 04/01/2017 à 07:18, Vaibhav Jain a écrit :
> This change adds a force psl data cache flush during device shutdown
> callback. This should reduce a possibility of psl holding a dirty
> cache line while the CAPP is being reinitialized, which may result in
> a UE [load/store] machine check error.
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---

Looks good to me, thanks!

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>


> Resend: Fixed the author ident.
> ---
>  drivers/misc/cxl/pci.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 80a87ab..73432e7 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -1610,6 +1610,9 @@ static void cxl_pci_remove_adapter(struct cxl *adapter)
>  	cxl_sysfs_adapter_remove(adapter);
>  	cxl_debugfs_adapter_remove(adapter);
>
> +	/* Flush adapter datacache as its about to be removed */
> +	cxl_data_cache_flush(adapter);
> +
>  	cxl_deconfigure_adapter(adapter);
>
>  	device_unregister(&adapter->dev);
>
