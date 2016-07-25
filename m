Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryyY925b5zDqhR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 09:45:16 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6PNhZ44031788
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 19:45:13 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24dnc5exur-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 19:45:11 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 26 Jul 2016 09:45:08 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D42573578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 09:45:06 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6PNj6YA30671088
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 09:45:06 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6PNj6xD001194
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 09:45:06 +1000
Date: Tue, 26 Jul 2016 09:45:05 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, Russell Currey <ruscur@russell.cc>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powernv/pci: Add PHB register dump debugfs handle
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20160722052336.3340-1-ruscur@russell.cc>
 <20160722063655.GA28438@gwshan>
 <5796522D.9040601@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5796522D.9040601@linux.vnet.ibm.com>
Message-Id: <20160725234505.GA4217@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 25, 2016 at 10:53:49AM -0700, Tyrel Datwyler wrote:
>On 07/21/2016 11:36 PM, Gavin Shan wrote:
>> On Fri, Jul 22, 2016 at 03:23:36PM +1000, Russell Currey wrote:
>>> On EEH events the kernel will print a dump of relevant registers.
>>> If EEH is unavailable (i.e. CONFIG_EEH is disabled, a new platform
>>> doesn't have EEH support, etc) this information isn't readily available.
>>>
>>> Add a new debugfs handler to trigger a PHB register dump, so that this
>>> information can be made available on demand.
>>>
>>> Signed-off-by: Russell Currey <ruscur@russell.cc>
>> 
>> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> 
>>> ---
>>> arch/powerpc/platforms/powernv/pci-ioda.c | 35 +++++++++++++++++++++++++++++++
>>> 1 file changed, 35 insertions(+)
>>>
>>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>> index 891fc4a..ada2f3c 100644
>>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>> @@ -3018,6 +3018,38 @@ static void pnv_ioda_setup_pe_seg(struct pnv_ioda_pe *pe)
>>> 	}
>>> }
>>>
>>> +#ifdef CONFIG_DEBUG_FS
>>> +static ssize_t pnv_pci_debug_write(struct file *filp,
>>> +				   const char __user *user_buf,
>>> +				   size_t count, loff_t *ppos)
>>> +{
>>> +	struct pci_controller *hose = filp->private_data;
>>> +	struct pnv_phb *phb;
>>> +	int ret = 0;
>> 
>> Needn't initialize @ret in advance. The code might be simpler, but it's
>> only a personal preference:
>
>I believe its actually preferred that it not be initialized in advance
>so that the tooling can warn you about conditional code paths where you
>may have forgotten to set a value. Or as Gavin suggests to explicitly
>use error values in the return statements.
>

Yeah, the data type should be int64_t as well.

Thanks,
Gavin
