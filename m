Return-Path: <hare@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svpq45gp4zDt03
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 22:46:40 +1100 (AEDT)
Subject: Re: [PATCH v2 13/16] scsi: fc: use bsg_job_done
To: Johannes Thumshirn <jthumshirn@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <cover.1476276823.git.jthumshirn@suse.de>
 <42378ae44b685dfc03f8730017c48701e7187785.1476276823.git.jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
 Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
 Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
 Steffen Maier <maier@linux.vnet.ibm.com>,
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
From: Hannes Reinecke <hare@suse.de>
Message-ID: <f627ae5e-0875-f539-4be0-05cef950abe9@suse.de>
Date: Thu, 13 Oct 2016 13:46:36 +0200
MIME-Version: 1.0
In-Reply-To: <42378ae44b685dfc03f8730017c48701e7187785.1476276823.git.jthumshirn@suse.de>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/12/2016 03:06 PM, Johannes Thumshirn wrote:
> fc_bsg_jobdone() and bsg_job_done() are 1:1 copies now so use the bsg-lib one
> instead of the FC private implementation.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/s390/scsi/zfcp_fc.c      |  2 +-
>  drivers/scsi/bfa/bfad_bsg.c      |  4 ++--
>  drivers/scsi/ibmvscsi/ibmvfc.c   |  2 +-
>  drivers/scsi/libfc/fc_lport.c    |  4 ++--
>  drivers/scsi/lpfc/lpfc_bsg.c     | 38 +++++++++++++++++-----------------
>  drivers/scsi/qla2xxx/qla_bsg.c   | 44 ++++++++++++++++++++--------------------
>  drivers/scsi/scsi_transport_fc.c | 41 +++----------------------------------
>  include/scsi/scsi_transport_fc.h |  2 --
>  8 files changed, 50 insertions(+), 87 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
