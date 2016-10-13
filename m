Return-Path: <jthumshirn@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svv743LSYzDt0M
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 02:00:47 +1100 (AEDT)
From: Johannes Thumshirn <jthumshirn@suse.de>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Hannes Reinecke <hare@suse.de>,
 Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
 Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
 Johannes Thumshirn <jthumshirn@suse.de>,
 Steffen Maier <maier@linux.vnet.ibm.com>,
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
 qla2xxx-upstream@qlogic.com (supporter:QLOGIC QLA2XXX FC-SCSI DRIVER),
 linux-s390@vger.kernel.org (open list:S390 ZFCP DRIVER),
 linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND
 64-BIT)),
 fcoe-devel@open-fcoe.org (open list:FCOE SUBSYSTEM (libfc, libfcoe, fcoe))
Subject: [PATCH v3 03/16] scsi: fc: Export fc_bsg_jobdone and use it in FC
 drivers
Date: Thu, 13 Oct 2016 17:00:19 +0200
Message-Id: <b7afadab74451838c0b29cc857a7d47174f68c39.1476369687.git.jthumshirn@suse.de>
In-Reply-To: <cover.1476369687.git.jthumshirn@suse.de>
References: <cover.1476369687.git.jthumshirn@suse.de>
In-Reply-To: <cover.1476369687.git.jthumshirn@suse.de>
References: <cover.1476369687.git.jthumshirn@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Export fc_bsg_jobdone so drivers can use it directly instead of doing
the round-trip via struct fc_bsg_job::job_done() and use it in the LLDDs.

As we've converted all LLDDs over to use fc_bsg_jobdone() directly,
we can remove the function pointer from struct fc_bsg_job as well.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 drivers/s390/scsi/zfcp_fc.c      |  2 +-
 drivers/scsi/bfa/bfad_bsg.c      |  4 ++--
 drivers/scsi/ibmvscsi/ibmvfc.c   |  2 +-
 drivers/scsi/libfc/fc_lport.c    |  4 ++--
 drivers/scsi/lpfc/lpfc_bsg.c     | 38 +++++++++++++++++-----------------
 drivers/scsi/qla2xxx/qla_bsg.c   | 44 ++++++++++++++++++++--------------------
 drivers/scsi/scsi_transport_fc.c |  5 ++---
 include/scsi/scsi_transport_fc.h |  2 +-
 8 files changed, 50 insertions(+), 51 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
index 4c4023f..40d8f06 100644
--- a/drivers/s390/scsi/zfcp_fc.c
+++ b/drivers/s390/scsi/zfcp_fc.c
@@ -892,7 +892,7 @@ static void zfcp_fc_ct_els_job_handler(void *data)
 	jr->reply_payload_rcv_len = job->reply_payload.payload_len;
 	jr->reply_data.ctels_reply.status = FC_CTELS_STATUS_OK;
 	jr->result = zfcp_ct_els->status ? -EIO : 0;
-	job->job_done(job);
+	fc_bsg_jobdone(job);
 }
 
 static struct zfcp_fc_wka_port *zfcp_fc_job_wka_port(struct fc_bsg_job *job)
diff --git a/drivers/scsi/bfa/bfad_bsg.c b/drivers/scsi/bfa/bfad_bsg.c
index 48366d8..25889b9 100644
--- a/drivers/scsi/bfa/bfad_bsg.c
+++ b/drivers/scsi/bfa/bfad_bsg.c
@@ -3180,7 +3180,7 @@
 	bsg_reply->reply_payload_rcv_len = job->reply_payload.payload_len;
 	bsg_reply->result = rc;
 
-	job->job_done(job);
+	fc_bsg_jobdone(job);
 	return rc;
 error:
 	/* free the command buffer */
@@ -3556,7 +3556,7 @@ struct bfad_buf_info *
 	bsg_reply->result = rc;
 
 	if (rc == BFA_STATUS_OK)
-		job->job_done(job);
+		fc_bsg_jobdone(job);
 
 	return rc;
 }
diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 7c17a7e..f14e9c1 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -1945,7 +1945,7 @@ static int ibmvfc_bsg_request(struct fc_bsg_job *job)
 	ibmvfc_free_event(evt);
 	spin_unlock_irqrestore(vhost->host->host_lock, flags);
 	bsg_reply->result = rc;
-	job->job_done(job);
+	fc_bsg_jobdone(job);
 	rc = 0;
 out:
 	dma_unmap_sg(vhost->dev, job->request_payload.sg_list,
diff --git a/drivers/scsi/libfc/fc_lport.c b/drivers/scsi/libfc/fc_lport.c
index 23bb114..33e2881 100644
--- a/drivers/scsi/libfc/fc_lport.c
+++ b/drivers/scsi/libfc/fc_lport.c
@@ -1917,7 +1917,7 @@ static void fc_lport_bsg_resp(struct fc_seq *sp, struct fc_frame *fp,
 			-ECONNABORTED : -ETIMEDOUT;
 		job->reply_len = sizeof(uint32_t);
 		job->state_flags |= FC_RQST_STATE_DONE;
-		job->job_done(job);
+		fc_bsg_jobdone(job);
 		kfree(info);
 		return;
 	}
@@ -1952,7 +1952,7 @@ static void fc_lport_bsg_resp(struct fc_seq *sp, struct fc_frame *fp,
 				job->reply_payload.payload_len;
 		bsg_reply->result = 0;
 		job->state_flags |= FC_RQST_STATE_DONE;
-		job->job_done(job);
+		fc_bsg_jobdone(job);
 		kfree(info);
 	}
 	fc_frame_free(fp);
diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index 27b5930..1db9cca 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -371,7 +371,7 @@ struct lpfc_dmabufext {
 
 	if (job) {
 		bsg_reply->result = rc;
-		job->job_done(job);
+		fc_bsg_jobdone(job);
 	}
 	return;
 }
@@ -644,7 +644,7 @@ struct lpfc_dmabufext {
 
 	if (job) {
 		bsg_reply->result = rc;
-		job->job_done(job);
+		fc_bsg_jobdone(job);
 	}
 	return;
 }
@@ -1136,7 +1136,7 @@ struct lpfc_dmabufext {
 			job->dd_data = NULL;
 			/* complete the job back to userspace */
 			spin_unlock_irqrestore(&phba->ct_ev_lock, flags);
-			job->job_done(job);
+			fc_bsg_jobdone(job);
 			spin_lock_irqsave(&phba->ct_ev_lock, flags);
 		}
 	}
@@ -1361,7 +1361,7 @@ struct lpfc_dmabufext {
 	spin_unlock_irqrestore(&phba->ct_ev_lock, flags);
 	job->dd_data = NULL;
 	bsg_reply->result = 0;
-	job->job_done(job);
+	fc_bsg_jobdone(job);
 	return 0;
 
 job_error:
@@ -1458,7 +1458,7 @@ struct lpfc_dmabufext {
 
 	if (job) {
 		bsg_reply->result = rc;
-		job->job_done(job);
+		fc_bsg_jobdone(job);
 	}
 	return;
 }
@@ -1886,7 +1886,7 @@ struct lpfc_dmabufext {
 	bsg_reply->result = rc;
 	/* complete the job back to userspace if no error */
 	if (rc == 0)
-		job->job_done(job);
+		fc_bsg_jobdone(job);
 	return rc;
 }
 
@@ -2175,7 +2175,7 @@ struct lpfc_dmabufext {
 	bsg_reply->result = rc;
 	/* complete the job back to userspace if no error */
 	if (rc == 0)
-		job->job_done(job);
+		fc_bsg_jobdone(job);
 	return rc;
 }
 
@@ -2289,7 +2289,7 @@ struct lpfc_dmabufext {
 	bsg_reply->result = rc;
 	/* complete the job back to userspace if no error */
 	if (rc == 0)
-		job->job_done(job);
+		fc_bsg_jobdone(job);
 	return rc;
 }
 
@@ -2441,7 +2441,7 @@ struct lpfc_dmabufext {
 	bsg_reply->result = rc;
 	/* complete the job back to userspace if no error */
 	if (rc == 0)
-		job->job_done(job);
+		fc_bsg_jobdone(job);
 	return rc;
 }
 
@@ -3301,7 +3301,7 @@ static int lpfcdiag_loop_post_rxbufs(struct lpfc_hba *phba, uint16_t rxxri,
 	job->dd_data = NULL;
 	/* complete the job back to userspace if no error */
 	if (rc == IOCB_SUCCESS)
-		job->job_done(job);
+		fc_bsg_jobdone(job);
 	return rc;
 }
 
@@ -3344,7 +3344,7 @@ static int lpfcdiag_loop_post_rxbufs(struct lpfc_hba *phba, uint16_t rxxri,
 job_error:
 	bsg_reply->result = rc;
 	if (rc == 0)
-		job->job_done(job);
+		fc_bsg_jobdone(job);
 	return rc;
 }
 
@@ -3409,7 +3409,7 @@ static int lpfcdiag_loop_post_rxbufs(struct lpfc_hba *phba, uint16_t rxxri,
 
 	if (job) {
 		bsg_reply->result = 0;
-		job->job_done(job);
+		fc_bsg_jobdone(job);
 	}
 	return;
 }
@@ -3655,7 +3655,7 @@ static int lpfc_bsg_check_cmd_access(struct lpfc_hba *phba,
 
 	/* if the job is still active, call job done */
 	if (job)
-		job->job_done(job);
+		fc_bsg_jobdone(job);
 
 	return;
 }
@@ -3690,7 +3690,7 @@ static int lpfc_bsg_check_cmd_access(struct lpfc_hba *phba,
 
 	/* if the job is still active, call job done */
 	if (job)
-		job->job_done(job);
+		fc_bsg_jobdone(job);
 
 	return;
 }
@@ -4131,7 +4131,7 @@ static int lpfc_bsg_check_cmd_access(struct lpfc_hba *phba,
 	/* wait for additoinal external buffers */
 
 	bsg_reply->result = 0;
-	job->job_done(job);
+	fc_bsg_jobdone(job);
 	return SLI_CONFIG_HANDLED;
 
 job_error:
@@ -4357,7 +4357,7 @@ static int lpfc_bsg_check_cmd_access(struct lpfc_hba *phba,
 	}
 
 	bsg_reply->result = 0;
-	job->job_done(job);
+	fc_bsg_jobdone(job);
 
 	return SLI_CONFIG_HANDLED;
 }
@@ -4473,7 +4473,7 @@ static int lpfc_bsg_check_cmd_access(struct lpfc_hba *phba,
 
 	/* wait for additoinal external buffers */
 	bsg_reply->result = 0;
-	job->job_done(job);
+	fc_bsg_jobdone(job);
 	return SLI_CONFIG_HANDLED;
 
 job_error:
@@ -4941,7 +4941,7 @@ static int lpfc_bsg_check_cmd_access(struct lpfc_hba *phba,
 		/* job done */
 		bsg_reply->result = 0;
 		job->dd_data = NULL;
-		job->job_done(job);
+		fc_bsg_jobdone(job);
 	} else if (rc == 1)
 		/* job submitted, will complete later*/
 		rc = 0; /* return zero, no error */
@@ -5051,7 +5051,7 @@ static int lpfc_bsg_check_cmd_access(struct lpfc_hba *phba,
 
 	if (job) {
 		bsg_reply->result = rc;
-		job->job_done(job);
+		fc_bsg_jobdone(job);
 	}
 
 	return;
diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index 40f7c10..1bca77b 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -20,7 +20,7 @@
 	struct fc_bsg_reply *bsg_reply = bsg_job->reply;
 
 	bsg_reply->result = res;
-	bsg_job->job_done(bsg_job);
+	fc_bsg_jobdone(bsg_job);
 	sp->free(vha, sp);
 }
 
@@ -242,7 +242,7 @@
 	}
 exit_fcp_prio_cfg:
 	if (!ret)
-		bsg_job->job_done(bsg_job);
+		fc_bsg_jobdone(bsg_job);
 	return ret;
 }
 
@@ -939,7 +939,7 @@
 	    bsg_job->request_payload.sg_list,
 	    bsg_job->request_payload.sg_cnt, DMA_TO_DEVICE);
 	if (!rval)
-		bsg_job->job_done(bsg_job);
+		fc_bsg_jobdone(bsg_job);
 	return rval;
 }
 
@@ -972,7 +972,7 @@
 		ql_dbg(ql_dbg_user, vha, 0x7031,
 		    "Vendor request 84xx reset completed.\n");
 		bsg_reply->result = DID_OK;
-		bsg_job->job_done(bsg_job);
+		fc_bsg_jobdone(bsg_job);
 	}
 
 	return rval;
@@ -1085,7 +1085,7 @@
 		bsg_job->request_payload.sg_cnt, DMA_TO_DEVICE);
 
 	if (!rval)
-		bsg_job->job_done(bsg_job);
+		fc_bsg_jobdone(bsg_job);
 	return rval;
 }
 
@@ -1282,7 +1282,7 @@
 	dma_pool_free(ha->s_dma_pool, mn, mn_dma);
 
 	if (!rval)
-		bsg_job->job_done(bsg_job);
+		fc_bsg_jobdone(bsg_job);
 	return rval;
 }
 
@@ -1368,7 +1368,7 @@
 		}
 
 		bsg_reply->result = DID_OK;
-		bsg_job->job_done(bsg_job);
+		fc_bsg_jobdone(bsg_job);
 	}
 
 	return rval;
@@ -1476,7 +1476,7 @@
 	ha->optrom_buffer = NULL;
 	ha->optrom_state = QLA_SWAITING;
 	mutex_unlock(&ha->optrom_mutex);
-	bsg_job->job_done(bsg_job);
+	fc_bsg_jobdone(bsg_job);
 	return rval;
 }
 
@@ -1511,7 +1511,7 @@
 	ha->optrom_buffer = NULL;
 	ha->optrom_state = QLA_SWAITING;
 	mutex_unlock(&ha->optrom_mutex);
-	bsg_job->job_done(bsg_job);
+	fc_bsg_jobdone(bsg_job);
 	return rval;
 }
 
@@ -1561,7 +1561,7 @@
 done:
 	bsg_job->reply_len = sizeof(struct fc_bsg_reply);
 	bsg_reply->result = DID_OK << 16;
-	bsg_job->job_done(bsg_job);
+	fc_bsg_jobdone(bsg_job);
 
 	return 0;
 }
@@ -1610,7 +1610,7 @@
 	bsg_job->reply_len = sizeof(struct fc_bsg_reply);
 	bsg_reply->reply_payload_rcv_len = sizeof(*sr);
 	bsg_reply->result = DID_OK << 16;
-	bsg_job->job_done(bsg_job);
+	fc_bsg_jobdone(bsg_job);
 
 	return 0;
 }
@@ -1655,7 +1655,7 @@
 done:
 	bsg_job->reply_len = sizeof(struct fc_bsg_reply);
 	bsg_reply->result = DID_OK << 16;
-	bsg_job->job_done(bsg_job);
+	fc_bsg_jobdone(bsg_job);
 
 	return 0;
 }
@@ -1699,7 +1699,7 @@
 done:
 	bsg_job->reply_len = sizeof(struct fc_bsg_reply);
 	bsg_reply->result = DID_OK << 16;
-	bsg_job->job_done(bsg_job);
+	fc_bsg_jobdone(bsg_job);
 
 	return 0;
 }
@@ -1747,7 +1747,7 @@
 	bsg_job->reply_len = sizeof(struct fc_bsg_reply);
 	bsg_reply->reply_payload_rcv_len = sizeof(*i2c);
 	bsg_reply->result = DID_OK << 16;
-	bsg_job->job_done(bsg_job);
+	fc_bsg_jobdone(bsg_job);
 
 	return 0;
 }
@@ -1925,7 +1925,7 @@
 	bsg_job->reply_len = sizeof(struct fc_bsg_reply);
 	bsg_reply->reply_payload_rcv_len = 0;
 	bsg_reply->result = (DID_OK) << 16;
-	bsg_job->job_done(bsg_job);
+	fc_bsg_jobdone(bsg_job);
 	/* Always return success, vendor rsp carries correct status */
 	return 0;
 }
@@ -2090,7 +2090,7 @@
 
 	bsg_job->reply_len = sizeof(struct fc_bsg_reply);
 	bsg_reply->result = DID_OK << 16;
-	bsg_job->job_done(bsg_job);
+	fc_bsg_jobdone(bsg_job);
 	return 0;
 }
 
@@ -2131,7 +2131,7 @@
 
 	bsg_job->reply_len = sizeof(struct fc_bsg_reply);
 	bsg_reply->result = DID_OK << 16;
-	bsg_job->job_done(bsg_job);
+	fc_bsg_jobdone(bsg_job);
 	return 0;
 }
 
@@ -2162,7 +2162,7 @@
 
 	bsg_job->reply_len = sizeof(struct fc_bsg_reply);
 	bsg_reply->result = DID_OK << 16;
-	bsg_job->job_done(bsg_job);
+	fc_bsg_jobdone(bsg_job);
 	return 0;
 }
 
@@ -2207,7 +2207,7 @@
 
 	bsg_job->reply_len = sizeof(struct fc_bsg_reply);
 	bsg_reply->result = DID_OK << 16;
-	bsg_job->job_done(bsg_job);
+	fc_bsg_jobdone(bsg_job);
 	return 0;
 }
 
@@ -2265,7 +2265,7 @@
 
 	bsg_job->reply_len = sizeof(struct fc_bsg_reply);
 	bsg_reply->result = DID_OK << 16;
-	bsg_job->job_done(bsg_job);
+	fc_bsg_jobdone(bsg_job);
 	return 0;
 }
 
@@ -2321,7 +2321,7 @@
 
 	bsg_job->reply_len = sizeof(*bsg_reply);
 	bsg_reply->result = DID_OK << 16;
-	bsg_job->job_done(bsg_job);
+	fc_bsg_jobdone(bsg_job);
 
 	dma_free_coherent(&ha->pdev->dev, sizeof(*stats),
 		stats, stats_dma);
@@ -2364,7 +2364,7 @@
 
 	bsg_job->reply_len = sizeof(*bsg_reply);
 	bsg_reply->result = DID_OK << 16;
-	bsg_job->job_done(bsg_job);
+	fc_bsg_jobdone(bsg_job);
 
 	kfree(dd);
 
diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index eafc7555..4149dac 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -3583,8 +3583,7 @@ struct fc_vport *
  *                  completed
  * @job:	fc_bsg_job that is complete
  */
-static void
-fc_bsg_jobdone(struct fc_bsg_job *job)
+void fc_bsg_jobdone(struct fc_bsg_job *job)
 {
 	struct request *req = job->req;
 	struct request *rsp = req->next_rq;
@@ -3611,6 +3610,7 @@ struct fc_vport *
 	}
 	blk_complete_request(req);
 }
+EXPORT_SYMBOL_GPL(fc_bsg_jobdone);
 
 /**
  * fc_bsg_softirq_done - softirq done routine for destroying the bsg requests
@@ -3744,7 +3744,6 @@ static void fc_bsg_softirq_done(struct request *rq)
 		if (ret)
 			goto failjob_rls_rqst_payload;
 	}
-	job->job_done = fc_bsg_jobdone;
 	if (rport)
 		job->dev = &rport->dev;
 	else
diff --git a/include/scsi/scsi_transport_fc.h b/include/scsi/scsi_transport_fc.h
index 921b097..9ef583f 100644
--- a/include/scsi/scsi_transport_fc.h
+++ b/include/scsi/scsi_transport_fc.h
@@ -637,7 +637,6 @@ struct fc_bsg_job {
 	spinlock_t job_lock;
 	unsigned int state_flags;
 	unsigned int ref_cnt;
-	void (*job_done)(struct fc_bsg_job *);
 
 	struct fc_bsg_request *request;
 	struct fc_bsg_reply *reply;
@@ -842,5 +841,6 @@ struct fc_vport *fc_vport_create(struct Scsi_Host *shost, int channel,
 		struct fc_vport_identifiers *);
 int fc_vport_terminate(struct fc_vport *vport);
 int fc_block_scsi_eh(struct scsi_cmnd *cmnd);
+void fc_bsg_jobdone(struct fc_bsg_job *job);
 
 #endif /* SCSI_TRANSPORT_FC_H */
-- 
1.8.5.6
