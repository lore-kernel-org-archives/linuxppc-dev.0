Return-Path: <hare@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t51mV2Kn6zDvR7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 22:31:21 +1100 (AEDT)
Subject: Re: [PATCH v2 02/16] scsi: don't use fc_bsg_job::request and
 fc_bsg_job::reply directly
To: Steffen Maier <maier@linux.vnet.ibm.com>,
 Johannes Thumshirn <jthumshirn@suse.de>
References: <cover.1476276823.git.jthumshirn@suse.de>
 <b92d12e4f78c4998bc8ad000359c127e673379f3.1476276823.git.jthumshirn@suse.de>
 <2ea07f3f-88eb-b795-fa37-a223bf80e581@linux.vnet.ibm.com>
 <20161013162405.aoxy3bdkc4bqtwsk@linux-x5ow.site>
 <4b411836-e76f-b67a-3d49-ad3d51b8f216@linux.vnet.ibm.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@infradead.org>,
 Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
 Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Johannes Thumshirn <jth@kernel.org>, James Smart
 <james.smart@avagotech.com>, Dick Kennedy <dick.kennedy@avagotech.com>,
 "supporter:QLOGIC QLA2XXX FC-SCSI DRIVER" <qla2xxx-upstream@qlogic.com>,
 "open list:S390 ZFCP DRIVER" <linux-s390@vger.kernel.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "open list:FCOE SUBSYSTEM (libfc, libfcoe, fcoe)"
 <fcoe-devel@open-fcoe.org>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
 Richard Biener <rguenther@suse.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d9a73963-1ade-2b6f-77bd-044e19675fd8@suse.de>
Date: Fri, 28 Oct 2016 13:31:12 +0200
MIME-Version: 1.0
In-Reply-To: <4b411836-e76f-b67a-3d49-ad3d51b8f216@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/28/2016 11:53 AM, Steffen Maier wrote:
> 
> 
> On 10/13/2016 06:24 PM, Johannes Thumshirn wrote:
>> On Thu, Oct 13, 2016 at 05:15:25PM +0200, Steffen Maier wrote:
>>> I'm puzzled.
>>>
>>> $ git bisect start fc_bsg master
> 
>>>> 3087864ce3d7282f59021245d8a5f83ef1caef18 is the first bad commit
>>>> commit 3087864ce3d7282f59021245d8a5f83ef1caef18
>>>> Author: Johannes Thumshirn <jthumshirn@suse.de>
>>>> Date:   Wed Oct 12 15:06:28 2016 +0200
>>>>
>>>>     scsi: don't use fc_bsg_job::request and fc_bsg_job::reply directly
>>>>
>>>>     Don't use fc_bsg_job::request and fc_bsg_job::reply directly,
>>>> but use
>>>>     helper variables bsg_request and bsg_reply. This will be
>>>> helpfull  when
>>>>     transitioning to bsg-lib.
>>>>
>>>>     Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
>>>>
>>>> :040000 040000 140c4b6829d5cfaec4079716e0795f63f8bc3bd2
>>>> 0d9fe225615679550be91fbd9f84c09ab1e280fc M    drivers
>>>
>>> From there (on the reverse bisect path) I get the following Oops,
>>> except for the full patch set having another stack trace as in my
>>> previous
>>> mail (dying in zfcp code).
>>>
>>
>> [...]
>>
>>>
>>>> @@ -3937,6 +3944,7 @@ fc_bsg_request_handler(struct request_queue
>>>> *q, struct Scsi_Host *shost,
>>>>      struct request *req;
>>>>      struct fc_bsg_job *job;
>>>>      enum fc_dispatch_result ret;
>>>> +    struct fc_bsg_reply *bsg_reply;
>>>>
>>>>      if (!get_device(dev))
>>>>          return;
>>>> @@ -3973,8 +3981,9 @@ fc_bsg_request_handler(struct request_queue
>>>> *q, struct Scsi_Host *shost,
>>>>          /* check if we have the msgcode value at least */
>>>>          if (job->request_len < sizeof(uint32_t)) {
>>>>              BUG_ON(job->reply_len < sizeof(uint32_t));
>>>> -            job->reply->reply_payload_rcv_len = 0;
>>>> -            job->reply->result = -ENOMSG;
>>>> +            bsg_reply = job->reply;
>>>> +            bsg_reply->reply_payload_rcv_len = 0;
>>>> +            bsg_reply->result = -ENOMSG;
> 
> Compiler optimization re-ordered above two lines and the first pointer
> derefence is bsg_reply->result [field offset 0] where bsg_reply is NULL.
> The assignment tries to write to memory at address NULL causing the
> kernel page fault.
> 
I spoke to our compiler people, and they strongly believed this not to
be the case. Or, put it the other way round, if such a thing would
happen it would be a compiler issue.

Have you checked the compiler output?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
