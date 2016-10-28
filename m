Return-Path: <maier@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t4zdH2tJkzDvSt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 20:54:57 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9S9stOs014429
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 05:54:55 -0400
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26c2rfmdm0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 05:54:54 -0400
Received: from localhost
 by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maier@linux.vnet.ibm.com>;
 Fri, 28 Oct 2016 10:53:51 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 94A862190056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 10:53:05 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9S9roE811403612
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 09:53:50 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9S9rm75026543
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 03:53:49 -0600
Subject: Re: [PATCH v2 02/16] scsi: don't use fc_bsg_job::request and
 fc_bsg_job::reply directly
To: Johannes Thumshirn <jthumshirn@suse.de>
References: <cover.1476276823.git.jthumshirn@suse.de>
 <b92d12e4f78c4998bc8ad000359c127e673379f3.1476276823.git.jthumshirn@suse.de>
 <2ea07f3f-88eb-b795-fa37-a223bf80e581@linux.vnet.ibm.com>
 <20161013162405.aoxy3bdkc4bqtwsk@linux-x5ow.site>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@infradead.org>, Hannes Reinecke <hare@suse.de>,
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
 "open list:FCOE SUBSYSTEM (libfc, libfcoe, fcoe)" <fcoe-devel@open-fcoe.org>
From: Steffen Maier <maier@linux.vnet.ibm.com>
Date: Fri, 28 Oct 2016 11:53:46 +0200
MIME-Version: 1.0
In-Reply-To: <20161013162405.aoxy3bdkc4bqtwsk@linux-x5ow.site>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <4b411836-e76f-b67a-3d49-ad3d51b8f216@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10/13/2016 06:24 PM, Johannes Thumshirn wrote:
> On Thu, Oct 13, 2016 at 05:15:25PM +0200, Steffen Maier wrote:
>> I'm puzzled.
>>
>> $ git bisect start fc_bsg master

>>> 3087864ce3d7282f59021245d8a5f83ef1caef18 is the first bad commit
>>> commit 3087864ce3d7282f59021245d8a5f83ef1caef18
>>> Author: Johannes Thumshirn <jthumshirn@suse.de>
>>> Date:   Wed Oct 12 15:06:28 2016 +0200
>>>
>>>     scsi: don't use fc_bsg_job::request and fc_bsg_job::reply directl=
y
>>>
>>>     Don't use fc_bsg_job::request and fc_bsg_job::reply directly, but=
 use
>>>     helper variables bsg_request and bsg_reply. This will be helpfull=
  when
>>>     transitioning to bsg-lib.
>>>
>>>     Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
>>>
>>> :040000 040000 140c4b6829d5cfaec4079716e0795f63f8bc3bd2 0d9fe22561567=
9550be91fbd9f84c09ab1e280fc M	drivers
>>
>> From there (on the reverse bisect path) I get the following Oops,
>> except for the full patch set having another stack trace as in my prev=
ious
>> mail (dying in zfcp code).
>>
>
> [...]
>
>>
>>> @@ -3937,6 +3944,7 @@ fc_bsg_request_handler(struct request_queue *q,=
 struct Scsi_Host *shost,
>>>  	struct request *req;
>>>  	struct fc_bsg_job *job;
>>>  	enum fc_dispatch_result ret;
>>> +	struct fc_bsg_reply *bsg_reply;
>>>
>>>  	if (!get_device(dev))
>>>  		return;
>>> @@ -3973,8 +3981,9 @@ fc_bsg_request_handler(struct request_queue *q,=
 struct Scsi_Host *shost,
>>>  		/* check if we have the msgcode value at least */
>>>  		if (job->request_len < sizeof(uint32_t)) {
>>>  			BUG_ON(job->reply_len < sizeof(uint32_t));
>>> -			job->reply->reply_payload_rcv_len =3D 0;
>>> -			job->reply->result =3D -ENOMSG;
>>> +			bsg_reply =3D job->reply;
>>> +			bsg_reply->reply_payload_rcv_len =3D 0;
>>> +			bsg_reply->result =3D -ENOMSG;

Compiler optimization re-ordered above two lines and the first pointer=20
derefence is bsg_reply->result [field offset 0] where bsg_reply is NULL.
The assignment tries to write to memory at address NULL causing the=20
kernel page fault.

Does your suggested change for [PATCH v3 02/16], shuffling the=20
job->request_len checks, address above kernel page fault?

>>>  			job->reply_len =3D sizeof(uint32_t);
>>>  			fc_bsg_jobdone(job);
>>>  			spin_lock_irq(q->queue_lock);
>>>
>
> Ahm and what exactly can break here? It's just assigning variables. Now=

> I'm puzzled too.


--=20
Mit freundlichen Gr=FC=DFen / Kind regards
Steffen Maier

Linux on z Systems Development

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Martina Koederitz
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
