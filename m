Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tth9k3383zDqHG
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 17:44:10 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v046i4gx036015
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 01:44:08 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27rmq7xwa5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jan 2017 01:44:07 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 4 Jan 2017 16:44:04 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5E58F2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 17:44:01 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v046i1r145088894
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 17:44:01 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v046i0Sl003035
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 17:44:01 +1100
Subject: Re: [RESEND] cxl: Force psl data-cache flush during device shutdown
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20170104061852.18512-1-vaibhav@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 frederic.barrat@fr.ibm.com, Ian Munsie <ianmunsi@au1.ibm.com>,
 Gregory Kurz <KURZGREG@fr.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 4 Jan 2017 17:43:58 +1100
MIME-Version: 1.0
In-Reply-To: <20170104061852.18512-1-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <61ab934e-12ba-2401-581e-1a2d17f5f9e2@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/01/17 17:18, Vaibhav Jain wrote:
> This change adds a force psl data cache flush during device shutdown
> callback. This should reduce a possibility of psl holding a dirty
> cache line while the CAPP is being reinitialized, which may result in
> a UE [load/store] machine check error.
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

Should this be cc: stable? (it does depend on aaa2245ed836 which only 
came in during 4.9)

Looks good.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>



> ---
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

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
