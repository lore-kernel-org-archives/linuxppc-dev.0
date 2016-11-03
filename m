Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8zXH6cq2zDvJQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 09:04:31 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA3M3t2h109733
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Nov 2016 18:04:29 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26g5dhpaqb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Nov 2016 18:04:29 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 3 Nov 2016 18:04:28 -0400
Subject: Re: [PATCH v3 03/16] scsi: fc: Export fc_bsg_jobdone and use it in FC
 drivers
To: Johannes Thumshirn <jthumshirn@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <cover.1476369687.git.jthumshirn@suse.de>
 <b7afadab74451838c0b29cc857a7d47174f68c39.1476369687.git.jthumshirn@suse.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 "open list:S390 ZFCP DRIVER" <linux-s390@vger.kernel.org>,
 Dick Kennedy <dick.kennedy@avagotech.com>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
 Christoph Hellwig <hch@infradead.org>,
 "open list:FCOE SUBSYSTEM libfc, libfcoe, fcoe" <fcoe-devel@open-fcoe.org>,
 Steffen Maier <maier@linux.vnet.ibm.com>, Hannes Reinecke <hare@suse.de>,
 "supporter:QLOGIC QLA2XXX FC-SCSI DRIVER" <qla2xxx-upstream@qlogic.com>,
 Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
 Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
 Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
 James Smart <james.smart@avagotech.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Johannes Thumshirn <jth@kernel.org>,
 "open list:LINUX FOR POWERPC 32-BIT AND 64-BIT"
 <linuxppc-dev@lists.ozlabs.org>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Thu, 3 Nov 2016 15:04:18 -0700
MIME-Version: 1.0
In-Reply-To: <b7afadab74451838c0b29cc857a7d47174f68c39.1476369687.git.jthumshirn@suse.de>
Content-Type: text/plain; charset=windows-1252
Message-Id: <3ad74dab-5f10-63a5-80c2-121448b2f9d0@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/13/2016 08:00 AM, Johannes Thumshirn wrote:
> Export fc_bsg_jobdone so drivers can use it directly instead of doing
> the round-trip via struct fc_bsg_job::job_done() and use it in the LLDDs.
> 
> As we've converted all LLDDs over to use fc_bsg_jobdone() directly,
> we can remove the function pointer from struct fc_bsg_job as well.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Hannes Reinecke <hare@suse.com>

For ibmvfc parts,

Acked-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com
