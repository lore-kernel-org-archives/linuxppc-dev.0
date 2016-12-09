Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tZcLz4styzDw6j
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2016 13:56:27 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB92tjsA138716
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Dec 2016 21:56:22 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 277gu3batm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Dec 2016 21:56:22 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 8 Dec 2016 21:56:21 -0500
Subject: Re: [PATCH] ibmvscsi: add write memory barrier to CRQ processing
To: Johannes Thumshirn <jthumshirn@suse.de>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
References: <1481153486-5185-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <20161208090643.GC4789@linux-x5ow.site>
Cc: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 brking@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Thu, 8 Dec 2016 18:56:14 -0800
MIME-Version: 1.0
In-Reply-To: <20161208090643.GC4789@linux-x5ow.site>
Content-Type: text/plain; charset=windows-1252
Message-Id: <94f1d954-a47c-3354-c1c8-fc79a82eaa77@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/08/2016 01:06 AM, Johannes Thumshirn wrote:
> On Wed, Dec 07, 2016 at 05:31:26PM -0600, Tyrel Datwyler wrote:
>> The first byte of each CRQ entry is used to indicate whether an entry is
>> a valid response or free for the VIOS to use. After processing a
>> response the driver sets the valid byte to zero to indicate the entry is
>> now free to be reused. Add a memory barrier after this write to ensure
>> no other stores are reordered when updating the valid byte.
>>
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
>>  		while ((crq = crq_queue_next_crq(&hostdata->queue)) != NULL) {
>>  			ibmvscsi_handle_crq(crq, hostdata);
>>  			crq->valid = VIOSRP_CRQ_FREE;
>> +			wmb();
>>  		}
>>  
>>  		vio_enable_interrupts(vdev);
>> @@ -240,6 +241,7 @@ static void ibmvscsi_task(void *data)
>>  			vio_disable_interrupts(vdev);
>>  			ibmvscsi_handle_crq(crq, hostdata);
>>  			crq->valid = VIOSRP_CRQ_FREE;
>> +			wmb();
>>  		} else {
>>  			done = 1;
>>  		}
> 
> Is this something you have seen in the wild or just a "better save than sorry"
> barrier?

I myself have not observed or heard of anybody hitting an issue here.
However, based on conversation with the VIOS developers, who have
indicated it is required, this is a "better safe than sorry" scenario.
Further, it matches what we already do in the ibmvfc driver for the CRQ
processing logic.

-Tyrel

> 
> Thanks,
> 	Johannes
> 
