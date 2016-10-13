Return-Path: <maier@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svwLB4fQnzDt0N
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 02:55:30 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9DFtLe5017299
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 11:55:28 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26286w3yeb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 11:55:25 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maier@linux.vnet.ibm.com>;
 Thu, 13 Oct 2016 16:55:16 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3375B2190023
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 16:54:31 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9DFtDt46947008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 15:55:13 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9DEtEOB020882
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 08:55:15 -0600
Subject: Re: [PATCH v3 02/16] scsi: don't use fc_bsg_job::request and
 fc_bsg_job::reply directly
To: Johannes Thumshirn <jthumshirn@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <cover.1476369687.git.jthumshirn@suse.de>
 <bbc682928173d64848ab0cbff689b1ad3d715fb7.1476369687.git.jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Hannes Reinecke <hare@suse.de>,
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
Date: Thu, 13 Oct 2016 17:55:11 +0200
MIME-Version: 1.0
In-Reply-To: <bbc682928173d64848ab0cbff689b1ad3d715fb7.1476369687.git.jthumshirn@suse.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <ebc46cfa-0bee-aa71-ba0b-d7c86628df0c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hm, still behaves for me like I reported for v2:
http://marc.info/?l=3Dlinux-scsi&m=3D147637177902937&w=3D2

On 10/13/2016 05:00 PM, Johannes Thumshirn wrote:
> Don't use fc_bsg_job::request and fc_bsg_job::reply directly, but use
> helper variables bsg_request and bsg_reply. This will be helpfull  when=

> transitioning to bsg-lib.
>
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/s390/scsi/zfcp_fc.c      |   9 +-
>  drivers/scsi/bfa/bfad_bsg.c      |  40 +++---
>  drivers/scsi/ibmvscsi/ibmvfc.c   |  22 ++--
>  drivers/scsi/libfc/fc_lport.c    |  23 ++--
>  drivers/scsi/lpfc/lpfc_bsg.c     | 194 +++++++++++++++++-----------
>  drivers/scsi/qla2xxx/qla_bsg.c   | 264 ++++++++++++++++++++++---------=
--------
>  drivers/scsi/qla2xxx/qla_iocb.c  |   5 +-
>  drivers/scsi/qla2xxx/qla_isr.c   |  46 ++++---
>  drivers/scsi/qla2xxx/qla_mr.c    |  10 +-
>  drivers/scsi/scsi_transport_fc.c |  37 +++---
>  10 files changed, 387 insertions(+), 263 deletions(-)

> diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_trans=
port_fc.c
> index 8ff2067..eafc7555 100644
> --- a/drivers/scsi/scsi_transport_fc.c
> +++ b/drivers/scsi/scsi_transport_fc.c

> @@ -3973,8 +3981,9 @@ enum fc_dispatch_result {
>  		/* check if we have the msgcode value at least */
>  		if (job->request_len < sizeof(uint32_t)) {
>  			BUG_ON(job->reply_len < sizeof(uint32_t));
> -			job->reply->reply_payload_rcv_len =3D 0;
> -			job->reply->result =3D -ENOMSG;
> +			bsg_reply =3D job->reply;
> +			bsg_reply->reply_payload_rcv_len =3D 0;
> +			bsg_reply->result =3D -ENOMSG;
>  			job->reply_len =3D sizeof(uint32_t);
>  			fc_bsg_jobdone(job);
>  			spin_lock_irq(q->queue_lock);
>

--=20
Mit freundlichen Gr=FC=DFen / Kind regards
Steffen Maier

Linux on z Systems Development

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Martina Koederitz
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
