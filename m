Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tkMHx6Y2RzDwXT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2016 04:35:41 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBLHYQHS100275
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 12:35:38 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27fts7cetu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 12:35:37 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 21 Dec 2016 10:35:37 -0700
Subject: Re: [PATCH] ibmvscsi: add write memory barrier to CRQ processing
To: benh@au1.ibm.com, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 james.bottomley@hansenpartnership.com
References: <1481153486-5185-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1481318452.17253.27.camel@au1.ibm.com>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 brking@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Wed, 21 Dec 2016 09:35:30 -0800
MIME-Version: 1.0
In-Reply-To: <1481318452.17253.27.camel@au1.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <f39396cb-995e-acbb-5a17-e67924adfaa9@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/09/2016 01:20 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2016-12-07 at 17:31 -0600, Tyrel Datwyler wrote:
>> The first byte of each CRQ entry is used to indicate whether an entry is
>> a valid response or free for the VIOS to use. After processing a
>> response the driver sets the valid byte to zero to indicate the entry is
>> now free to be reused. Add a memory barrier after this write to ensure
>> no other stores are reordered when updating the valid byte.
> 
> Which "other stores" specifically ? This smells fishy without that
> precision. It's important to always understand what exactly barriers
> order with.

So, this patch initially came about while chasing a data integrity issue
based on the observation that we were already doing this same write
barrier in the virtual fibre channel driver.

However, the more I stare at it I agree it does seem fishy and I can't
see any other stores that we need to order with here. In terms of the
16byte CRQ entries we only ever write to the first byte as a sort of
doorbell to tell the VIOS that we have processed the data and the entry
is free to be re-used. The remainder of the CRQ is only ever read from.

The wmb() in the ibmvfc driver was part of a commit from Brian that also
involved a necessary rmb() that prevented stale data from load
re-ordering by ensuring that a read from the first byte completed and
contained a valid value prior to doing any other reads of the CRQ entry.

I'd have to defer to Brian as to whether he remembers a legitimate
reason for the wmb().

-Tyrel

> 
> Cheers,
> Ben.
> 
>> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
>> ---
>>  drivers/scsi/ibmvscsi/ibmvscsi.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
>> index d9534ee..2f5b07e 100644
>> --- a/drivers/scsi/ibmvscsi/ibmvscsi.c
>> +++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
>> @@ -232,6 +232,7 @@ static void ibmvscsi_task(void *data)
>>>  		while ((crq = crq_queue_next_crq(&hostdata->queue)) != NULL) {
>>>  			ibmvscsi_handle_crq(crq, hostdata);
>>>  			crq->valid = VIOSRP_CRQ_FREE;
>>> +			wmb();
>>>  		}
>>  
>>>  		vio_enable_interrupts(vdev);
>> @@ -240,6 +241,7 @@ static void ibmvscsi_task(void *data)
>>>  			vio_disable_interrupts(vdev);
>>>  			ibmvscsi_handle_crq(crq, hostdata);
>>>  			crq->valid = VIOSRP_CRQ_FREE;
>>> +			wmb();
>>>  		} else {
>>>  			done = 1;
>>>  		}
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
