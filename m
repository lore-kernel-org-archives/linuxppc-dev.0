Return-Path: <brking@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xK13t6NCSzDrVW
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 06:42:02 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6SKd1kw088112
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 16:42:00 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c0cfyr45k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 16:41:59 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Fri, 28 Jul 2017 16:41:59 -0400
Subject: Re: blk_mq_sched_insert_request: inconsistent {SOFTIRQ-ON-W} ->
 {IN-SOFTIRQ-W} usage
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Brian J King <bjking1@us.ibm.com>, Jens Axboe <axboe@kernel.dk>,
 Bart Van Assche <Bart.VanAssche@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <87a83qfosu.fsf@concordia.ellerman.id.au>
 <073ed79c-11ce-e86c-a905-91fd28675d47@kernel.dk>
 <1501166846.2516.1.camel@wdc.com>
 <5b85a365-faa1-3987-9b6b-270399c30686@kernel.dk>
 <87lgn9dqx3.fsf@concordia.ellerman.id.au>
 <92379297-9667-ae52-b05c-6c8a0ce4751c@kernel.dk>
 <OF186C0C54.7E077412-ON8625816B.0053C88E-8625816B.00540312@notes.na.collabserv.com>
From: Brian King <brking@linux.vnet.ibm.com>
Date: Fri, 28 Jul 2017 15:41:55 -0500
MIME-Version: 1.0
In-Reply-To: <OF186C0C54.7E077412-ON8625816B.0053C88E-8625816B.00540312@notes.na.collabserv.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <5dcfe3ac-50c7-86a6-e571-fe5a1c1dc316@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/28/2017 10:17 AM, Brian J King wrote:
> Jens Axboe <axboe@kernel.dk> wrote on 07/28/2017 09:25:48 AM:
> 
>> Can you try the below fix? Should be more palatable than the previous
>> one. Brian, maybe you can take a look at the IRQ issue mentioned above?

Michael,

Does this address the issue you are seeing?

Thanks,

Brian

8<

Index: linux-2.6.git/drivers/scsi/ipr.c
===================================================================
--- linux-2.6.git.orig/drivers/scsi/ipr.c
+++ linux-2.6.git/drivers/scsi/ipr.c
@@ -3351,6 +3351,16 @@ static void ipr_worker_thread(struct wor
 		return;
 	}
 
+	if (ioa_cfg->scsi_unblock) {
+		ioa_cfg->scsi_unblock = 0;
+		ioa_cfg->scsi_blocked = 0;
+		spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
+		scsi_unblock_requests(ioa_cfg->host);
+		spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
+		if (ioa_cfg->scsi_blocked)
+			scsi_block_requests(ioa_cfg->host);
+	}
+
 	if (!ioa_cfg->scan_enabled) {
 		spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
 		return;
@@ -7211,9 +7221,8 @@ static int ipr_ioa_bringdown_done(struct
 	ENTER;
 	if (!ioa_cfg->hrrq[IPR_INIT_HRRQ].removing_ioa) {
 		ipr_trace;
-		spin_unlock_irq(ioa_cfg->host->host_lock);
-		scsi_unblock_requests(ioa_cfg->host);
-		spin_lock_irq(ioa_cfg->host->host_lock);
+		ioa_cfg->scsi_unblock = 1;
+		schedule_work(&ioa_cfg->work_q);
 	}
 
 	ioa_cfg->in_reset_reload = 0;
@@ -7287,13 +7296,7 @@ static int ipr_ioa_reset_done(struct ipr
 	list_add_tail(&ipr_cmd->queue, &ipr_cmd->hrrq->hrrq_free_q);
 	wake_up_all(&ioa_cfg->reset_wait_q);
 
-	spin_unlock(ioa_cfg->host->host_lock);
-	scsi_unblock_requests(ioa_cfg->host);
-	spin_lock(ioa_cfg->host->host_lock);
-
-	if (!ioa_cfg->hrrq[IPR_INIT_HRRQ].allow_cmds)
-		scsi_block_requests(ioa_cfg->host);
-
+	ioa_cfg->scsi_unblock = 1;
 	schedule_work(&ioa_cfg->work_q);
 	LEAVE;
 	return IPR_RC_JOB_RETURN;
@@ -9249,8 +9252,11 @@ static void _ipr_initiate_ioa_reset(stru
 		spin_unlock(&ioa_cfg->hrrq[i]._lock);
 	}
 	wmb();
-	if (!ioa_cfg->hrrq[IPR_INIT_HRRQ].removing_ioa)
+	if (!ioa_cfg->hrrq[IPR_INIT_HRRQ].removing_ioa) {
+		ioa_cfg->scsi_unblock = 0;
+		ioa_cfg->scsi_blocked = 1;
 		scsi_block_requests(ioa_cfg->host);
+	}
 
 	ipr_cmd = ipr_get_free_ipr_cmnd(ioa_cfg);
 	ioa_cfg->reset_cmd = ipr_cmd;
@@ -9306,9 +9312,8 @@ static void ipr_initiate_ioa_reset(struc
 			wake_up_all(&ioa_cfg->reset_wait_q);
 
 			if (!ioa_cfg->hrrq[IPR_INIT_HRRQ].removing_ioa) {
-				spin_unlock_irq(ioa_cfg->host->host_lock);
-				scsi_unblock_requests(ioa_cfg->host);
-				spin_lock_irq(ioa_cfg->host->host_lock);
+				ioa_cfg->scsi_unblock = 1;
+				schedule_work(&ioa_cfg->work_q);
 			}
 			return;
 		} else {
Index: linux-2.6.git/drivers/scsi/ipr.h
===================================================================
--- linux-2.6.git.orig/drivers/scsi/ipr.h
+++ linux-2.6.git/drivers/scsi/ipr.h
@@ -1488,6 +1488,8 @@ struct ipr_ioa_cfg {
 	u8 cfg_locked:1;
 	u8 clear_isr:1;
 	u8 probe_done:1;
+	u8 scsi_unblock:1;
+	u8 scsi_blocked:1;
 
 	u8 revid;
 
