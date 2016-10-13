Return-Path: <jthumshirn@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svwzS0DSZzDt0d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 03:24:20 +1100 (AEDT)
Date: Thu, 13 Oct 2016 18:24:05 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Steffen Maier <maier@linux.vnet.ibm.com>
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
 Johannes Thumshirn <jth@kernel.org>,
 James Smart <james.smart@avagotech.com>,
 Dick Kennedy <dick.kennedy@avagotech.com>,
 "supporter:QLOGIC QLA2XXX FC-SCSI DRIVER" <qla2xxx-upstream@qlogic.com>,
 "open list:S390 ZFCP DRIVER" <linux-s390@vger.kernel.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "open list:FCOE SUBSYSTEM (libfc, libfcoe, fcoe)" <fcoe-devel@open-fcoe.org>
Subject: Re: [PATCH v2 02/16] scsi: don't use fc_bsg_job::request and
 fc_bsg_job::reply directly
Message-ID: <20161013162405.aoxy3bdkc4bqtwsk@linux-x5ow.site>
References: <cover.1476276823.git.jthumshirn@suse.de>
 <b92d12e4f78c4998bc8ad000359c127e673379f3.1476276823.git.jthumshirn@suse.de>
 <2ea07f3f-88eb-b795-fa37-a223bf80e581@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <2ea07f3f-88eb-b795-fa37-a223bf80e581@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 13, 2016 at 05:15:25PM +0200, Steffen Maier wrote:
> I'm puzzled.
> 
> $ git bisect start fc_bsg master
> Bisecting: 8 revisions left to test after this (roughly 3 steps)
> [005d51510eee6102636d5dbb06310531c5d46151] scsi: fc: implement kref backed
> reference counting
> $ git bisect bad
> Bisecting: 3 revisions left to test after this (roughly 2 steps)
> [bef6da201de1bb81bb4d9511f9a155862efc251f] scsi: Unify interfaces of
> fc_bsg_jobdone and bsg_job_done
> $ git bisect bad
> Bisecting: 1 revision left to test after this (roughly 1 step)
> [3087864ce3d7282f59021245d8a5f83ef1caef18] scsi: don't use
> fc_bsg_job::request and fc_bsg_job::reply directly
> $ git bisect bad
> Bisecting: 0 revisions left to test after this (roughly 0 steps)
> [81aea44720d22d2e0c4a2613ae8b1c256ef6b0cb] scsi: Get rid of struct
> fc_bsg_buffer
> > $ git bisect good
> > 3087864ce3d7282f59021245d8a5f83ef1caef18 is the first bad commit
> > commit 3087864ce3d7282f59021245d8a5f83ef1caef18
> > Author: Johannes Thumshirn <jthumshirn@suse.de>
> > Date:   Wed Oct 12 15:06:28 2016 +0200
> > 
> >     scsi: don't use fc_bsg_job::request and fc_bsg_job::reply directly
> > 
> >     Don't use fc_bsg_job::request and fc_bsg_job::reply directly, but use
> >     helper variables bsg_request and bsg_reply. This will be helpfull  when
> >     transitioning to bsg-lib.
> > 
> >     Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> > 
> > :040000 040000 140c4b6829d5cfaec4079716e0795f63f8bc3bd2 0d9fe225615679550be91fbd9f84c09ab1e280fc M	drivers
> 
> From there (on the reverse bisect path) I get the following Oops,
> except for the full patch set having another stack trace as in my previous
> mail (dying in zfcp code).
> 

[...]

> 
> > @@ -3937,6 +3944,7 @@ fc_bsg_request_handler(struct request_queue *q, struct Scsi_Host *shost,
> >  	struct request *req;
> >  	struct fc_bsg_job *job;
> >  	enum fc_dispatch_result ret;
> > +	struct fc_bsg_reply *bsg_reply;
> > 
> >  	if (!get_device(dev))
> >  		return;
> > @@ -3973,8 +3981,9 @@ fc_bsg_request_handler(struct request_queue *q, struct Scsi_Host *shost,
> >  		/* check if we have the msgcode value at least */
> >  		if (job->request_len < sizeof(uint32_t)) {
> >  			BUG_ON(job->reply_len < sizeof(uint32_t));
> > -			job->reply->reply_payload_rcv_len = 0;
> > -			job->reply->result = -ENOMSG;
> > +			bsg_reply = job->reply;
> > +			bsg_reply->reply_payload_rcv_len = 0;
> > +			bsg_reply->result = -ENOMSG;
> >  			job->reply_len = sizeof(uint32_t);
> >  			fc_bsg_jobdone(job);
> >  			spin_lock_irq(q->queue_lock);
> > 

Ahm and what exactly can break here? It's just assigning variables. Now
I'm puzzled too.

I'll have to look into it tomorrow.

Byte,
        Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
