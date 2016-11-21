Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMyvp6vdyzDvrt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 06:14:30 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uALJEA8Y126902
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 14:14:28 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26v5j4mauw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 14:14:28 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Mon, 21 Nov 2016 12:14:28 -0700
Subject: Re: [PATCH RESEND v4 02/15] scsi: don't use fc_bsg_job::request and
 fc_bsg_job::reply directly
To: Johannes Thumshirn <jthumshirn@suse.de>,
 James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <cover.1479374719.git.jthumshirn@suse.de>
 <70cda0c20ecedf82323ff96e62ed6250a4cb575d.1479374719.git.jthumshirn@suse.de>
Cc: "open list:S390 ZFCP DRIVER" <linux-s390@vger.kernel.org>,
 Dick Kennedy <dick.kennedy@avagotech.com>,
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
 Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
 Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
 "supporter:QLOGIC QLA2XXX FC-SCSI DRIVER" <qla2xxx-upstream@qlogic.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
 "open list:FCOE SUBSYSTEM libfc, libfcoe, fcoe" <fcoe-devel@open-fcoe.org>,
 Christoph Hellwig <hch@infradead.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 James Smart <james.smart@avagotech.com>,
 Paul Mackerras <paulus@samba.org>, Hannes Reinecke <hare@suse.de>,
 Steffen Maier <maier@linux.vnet.ibm.com>,
 Johannes Thumshirn <jth@kernel.org>,
 "open list:LINUX FOR POWERPC 32-BIT AND 64-BIT"
 <linuxppc-dev@lists.ozlabs.org>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Mon, 21 Nov 2016 11:14:18 -0800
MIME-Version: 1.0
In-Reply-To: <70cda0c20ecedf82323ff96e62ed6250a4cb575d.1479374719.git.jthumshirn@suse.de>
Content-Type: text/plain; charset=windows-1252
Message-Id: <ab8ba289-f102-dee1-9c04-44849f867c12@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/17/2016 07:09 AM, Johannes Thumshirn wrote:
> Don't use fc_bsg_job::request and fc_bsg_job::reply directly, but use
> helper variables bsg_request and bsg_reply. This will be helpfull  when
> transitioning to bsg-lib.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/s390/scsi/zfcp_fc.c      |   9 +-
>  drivers/scsi/bfa/bfad_bsg.c      |  40 +++---
>  drivers/scsi/ibmvscsi/ibmvfc.c   |  22 ++--
>  drivers/scsi/libfc/fc_lport.c    |  23 ++--
>  drivers/scsi/lpfc/lpfc_bsg.c     | 199 ++++++++++++++++++-----------
>  drivers/scsi/qla2xxx/qla_bsg.c   | 264 ++++++++++++++++++++++-----------------
>  drivers/scsi/qla2xxx/qla_iocb.c  |   5 +-
>  drivers/scsi/qla2xxx/qla_isr.c   |  46 ++++---
>  drivers/scsi/qla2xxx/qla_mr.c    |  10 +-
>  drivers/scsi/scsi_transport_fc.c |  55 ++++----
>  10 files changed, 398 insertions(+), 275 deletions(-)

For ibmvfc portion...

Acked-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
