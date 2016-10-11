Return-Path: <jthumshirn@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3stZXF4zkrzDrSF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2016 22:29:33 +1100 (AEDT)
From: Johannes Thumshirn <jthumshirn@suse.de>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Hannes Reinecke <hare@suse.de>,
 Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
 Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
 Johannes Thumshirn <jthumshirn@suse.de>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND
 64-BIT))
Subject: [PATCH 24/44] ibmvfc: use fc_bsg_to_shost() to access a bsg_job's
 Scsi_Host
Date: Tue, 11 Oct 2016 13:28:55 +0200
Message-Id: <1dde8ee664be4578761f359e74cf52a7bf121145.1476180827.git.jthumshirn@suse.de>
In-Reply-To: <cover.1476180827.git.jthumshirn@suse.de>
References: <cover.1476180827.git.jthumshirn@suse.de>
In-Reply-To: <cover.1476180827.git.jthumshirn@suse.de>
References: <cover.1476180827.git.jthumshirn@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 1001d4a..f7b50af 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -1702,7 +1702,7 @@ static void ibmvfc_bsg_timeout_done(struct ibmvfc_event *evt)
  **/
 static int ibmvfc_bsg_timeout(struct fc_bsg_job *job)
 {
-	struct ibmvfc_host *vhost = shost_priv(job->shost);
+	struct ibmvfc_host *vhost = shost_priv(fc_bsg_to_shost(job));
 	unsigned long port_id = (unsigned long)job->dd_data;
 	struct ibmvfc_event *evt;
 	struct ibmvfc_tmf *tmf;
@@ -1815,7 +1815,7 @@ unlock_out:
  **/
 static int ibmvfc_bsg_request(struct fc_bsg_job *job)
 {
-	struct ibmvfc_host *vhost = shost_priv(job->shost);
+	struct ibmvfc_host *vhost = shost_priv(fc_bsg_to_shost(job));
 	struct fc_rport *rport = job->rport;
 	struct ibmvfc_passthru_mad *mad;
 	struct ibmvfc_event *evt;
-- 
1.8.5.6
