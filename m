Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rypln6yQHzDqQM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 03:53:57 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6PHhLC0143234
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 13:53:55 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24dnc553ef-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 13:53:54 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Mon, 25 Jul 2016 11:53:54 -0600
Subject: Re: [PATCH] powernv/pci: Add PHB register dump debugfs handle
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, Russell Currey <ruscur@russell.cc>
References: <20160722052336.3340-1-ruscur@russell.cc>
 <20160722063655.GA28438@gwshan>
Cc: linuxppc-dev@lists.ozlabs.org
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Mon, 25 Jul 2016 10:53:49 -0700
MIME-Version: 1.0
In-Reply-To: <20160722063655.GA28438@gwshan>
Content-Type: text/plain; charset=utf-8
Message-Id: <5796522D.9040601@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/21/2016 11:36 PM, Gavin Shan wrote:
> On Fri, Jul 22, 2016 at 03:23:36PM +1000, Russell Currey wrote:
>> On EEH events the kernel will print a dump of relevant registers.
>> If EEH is unavailable (i.e. CONFIG_EEH is disabled, a new platform
>> doesn't have EEH support, etc) this information isn't readily available.
>>
>> Add a new debugfs handler to trigger a PHB register dump, so that this
>> information can be made available on demand.
>>
>> Signed-off-by: Russell Currey <ruscur@russell.cc>
> 
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> 
>> ---
>> arch/powerpc/platforms/powernv/pci-ioda.c | 35 +++++++++++++++++++++++++++++++
>> 1 file changed, 35 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 891fc4a..ada2f3c 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -3018,6 +3018,38 @@ static void pnv_ioda_setup_pe_seg(struct pnv_ioda_pe *pe)
>> 	}
>> }
>>
>> +#ifdef CONFIG_DEBUG_FS
>> +static ssize_t pnv_pci_debug_write(struct file *filp,
>> +				   const char __user *user_buf,
>> +				   size_t count, loff_t *ppos)
>> +{
>> +	struct pci_controller *hose = filp->private_data;
>> +	struct pnv_phb *phb;
>> +	int ret = 0;
> 
> Needn't initialize @ret in advance. The code might be simpler, but it's
> only a personal preference:

I believe its actually preferred that it not be initialized in advance
so that the tooling can warn you about conditional code paths where you
may have forgotten to set a value. Or as Gavin suggests to explicitly
use error values in the return statements.

-Tyrel

> 
> 	struct pci_controller *hose = filp->private_data;
> 	struct pnv_phb *phb = hose ? hose->private_data : NULL;
> 
> 	if (!phb)
> 		return -ENODEV;
> 
>> +
>> +	if (!hose)
>> +		return -EFAULT;
>> +
>> +	phb = hose->private_data;
>> +	if (!phb)
>> +		return -EFAULT;
>> +
>> +	ret = opal_pci_get_phb_diag_data2(phb->opal_id, phb->diag.blob,
>> +					  PNV_PCI_DIAG_BUF_SIZE);
>> +
>> +	if (!ret)
>> +		pnv_pci_dump_phb_diag_data(phb->hose, phb->diag.blob);
>> +
>> +	return ret < 0 ? ret : count;
> 
> return ret == OPAL_SUCCESS ? count : -EIO;
> 
>> +}
>> +
>> +static const struct file_operations pnv_pci_debug_ops = {
>> +	.open	= simple_open,
>> +	.llseek	= no_llseek,
>> +	.write	= pnv_pci_debug_write,
> 
> It might be reasonable to dump the diag-data on read if it is trying
> to do it on write.
> 
>> +};
>> +#endif /* CONFIG_DEBUG_FS */
>> +
>> static void pnv_pci_ioda_create_dbgfs(void)
>> {
>> #ifdef CONFIG_DEBUG_FS
>> @@ -3036,6 +3068,9 @@ static void pnv_pci_ioda_create_dbgfs(void)
>> 		if (!phb->dbgfs)
>> 			pr_warning("%s: Error on creating debugfs on PHB#%x\n",
>> 				__func__, hose->global_number);
>> +
>> +		debugfs_create_file("regdump", 0200, phb->dbgfs, hose,
>> +				    &pnv_pci_debug_ops);
> 
> "diag-data" might be indicating or a better one you can name :)
> 
> Thanks,
> Gavin
> 
>> 	}
>> #endif /* CONFIG_DEBUG_FS */
>> }
>> -- 
>> 2.9.0
>>
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
