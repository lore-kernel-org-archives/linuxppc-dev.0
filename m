Return-Path: <turtle.in.the.kernel@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tZcGb2nl3zDw6h
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2016 13:52:39 +1100 (AEDT)
Received: by mail-qk0-x243.google.com with SMTP id y205so620647qkb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Dec 2016 18:52:39 -0800 (PST)
Subject: Re: [PATCH] ibmvscsi: add write memory barrier to CRQ processing
To: Paolo Bonzini <pbonzini@redhat.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 james.bottomley@hansenpartnership.com
References: <1481153486-5185-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <272a1724-be64-9e5f-c5bb-3b71f389f029@redhat.com>
Cc: brking@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org,
 martin.petersen@oracle.com
From: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>
Message-ID: <7be3f12a-3d21-9160-983b-d794c77a07ad@gmail.com>
Date: Thu, 8 Dec 2016 18:52:34 -0800
MIME-Version: 1.0
In-Reply-To: <272a1724-be64-9e5f-c5bb-3b71f389f029@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/08/2016 03:29 PM, Paolo Bonzini wrote:
> 
> 
> On 08/12/2016 00:31, Tyrel Datwyler wrote:
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
> 
> Should this driver use virt_wmb instead?

Both virt_wmb and wmb reduce to a lwsync instruction under PowerPC.

-Tyrel

> 
> Paolo
> 
>>  		} else {
>>  			done = 1;
>>  		}
>>
