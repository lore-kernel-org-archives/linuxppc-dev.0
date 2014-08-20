Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 153941A015E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 12:31:25 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 20 Aug 2014 08:01:23 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 15271E004B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 08:03:27 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7K2VhYK53543072
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 08:01:43 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7K2VJKd016665
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 08:01:19 +0530
Date: Wed, 20 Aug 2014 10:31:18 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH V7 02/17] PCI/IOV: Get VF BAR size from hardware directly
 when platform needs
Message-ID: <20140820023118.GB6904@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1406182947-11302-3-git-send-email-weiyang@linux.vnet.ibm.com>
 <20140819214459.GC6295@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140819214459.GC6295@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
 linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com, yan@linux.vnet.ibm.com,
 qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 19, 2014 at 03:44:59PM -0600, Bjorn Helgaas wrote:
>On Thu, Jul 24, 2014 at 02:22:12PM +0800, Wei Yang wrote:
>> Current implementation calculates VF BAR size from dividing the total size of
>> IOV BAR by total VF number. It won't work on PowerNV platform because we're
>> going to expand IOV BAR size for finely alignment.
>> 
>> The patch enforces getting IOV BAR size from hardware and then calculate
>> the VF BAR size based on that when platform wants so.
>> 
>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> ---
>>  drivers/pci/iov.c      |   28 ++++++++++++++++++++++++----
>>  include/linux/ioport.h |    1 +
>>  2 files changed, 25 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>> index 7566238..ef1c546 100644
>> --- a/drivers/pci/iov.c
>> +++ b/drivers/pci/iov.c
>> @@ -55,6 +55,9 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
>>  	struct resource *res;
>>  	struct pci_sriov *iov = dev->sriov;
>>  	struct pci_bus *bus;
>> +	struct resource tmp;
>> +	enum pci_bar_type type;
>> +	int reg;
>>  
>>  	mutex_lock(&iov->dev->sriov->lock);
>>  	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
>> @@ -80,12 +83,29 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
>>  			continue;
>>  		virtfn->resource[i].name = pci_name(virtfn);
>>  		virtfn->resource[i].flags = res->flags;
>> -		size = resource_size(res);
>> -		do_div(size, iov->total_VFs);
>> +		/* When res has IORESOURCE_ARCH, retrieve the IOV BAR size
>> +		 * from hardware directly.
>> +		 */
>> +		if (res->flags & IORESOURCE_ARCH) {
>> +			reg = pci_iov_resource_bar(dev, i + PCI_IOV_RESOURCES, &type);
>> +			__pci_read_base(dev, type, &tmp, reg);
>> +			size = resource_size(&tmp);
>> +			/* When __pci_read_base fails, flags is set to 0.
>> +			 * In this case, reset size to 0, which means the VF
>> +			 * will not be enabled.
>> +			 */
>> +			if (!tmp.flags)
>> +				size = 0;
>
>I don't like the IORESOURCE_ARCH flag because it really doesn't have any
>specific meaning.  You're using it to enable some arch-specific code here
>for this specific case.  But there are any number of other places that
>could do something similar, and there's no way to coordinate them all.
>
>I'd rather have some sort of pcibios_*() hook here where powerpc could
>override the default implementation.

Yep, got it. I will write a pcibios_sriov_resource_size() and override it in
powerpc arch.

>
>> +		} else {
>> +			size = resource_size(res);
>> +			do_div(size, iov->total_VFs);
>> +		}
>>  		virtfn->resource[i].start = res->start + size * id;
>>  		virtfn->resource[i].end = virtfn->resource[i].start + size - 1;
>> -		rc = request_resource(res, &virtfn->resource[i]);
>> -		BUG_ON(rc);
>> +		if (resource_size(&virtfn->resource[i])) {
>> +			rc = request_resource(res, &virtfn->resource[i]);
>> +			BUG_ON(rc);
>> +		}
>>  	}
>>  
>>  	if (reset)
>> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>> index 5e3a906..de8b57c 100644
>> --- a/include/linux/ioport.h
>> +++ b/include/linux/ioport.h
>> @@ -48,6 +48,7 @@ struct resource {
>>  #define IORESOURCE_MEM_64	0x00100000
>>  #define IORESOURCE_WINDOW	0x00200000	/* forwarded by bridge */
>>  #define IORESOURCE_MUXED	0x00400000	/* Resource is software muxed */
>> +#define IORESOURCE_ARCH		0x00800000	/* Resource arch tagged */
>>
>>  #define IORESOURCE_EXCLUSIVE	0x08000000	/* Userland may not map this resource */
>>  #define IORESOURCE_DISABLED	0x10000000
>> -- 
>> 1.7.9.5
>> 

-- 
Richard Yang
Help you, Help me
