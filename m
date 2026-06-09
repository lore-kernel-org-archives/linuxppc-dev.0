Return-Path: <linuxppc-dev+bounces-22384-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23630CD8CB9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 04:40:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZtNv4YnNz3bpM;
	Wed, 10 Jun 2026 14:39:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::864"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781005811;
	cv=none; b=U6S+mppz34Ieun2PW3TEvqZ+1T7y2X96EGjm/an8vpLyzJ7Ws3CO9QTnW/x03sXyIhsx//2a8sN8mCxNT8olOuQ9FzwlIWRtn0ueOl+pEU0l/DF4jz38fwQFv8pmByvYFuRlLYw+mkZ25hGCYu0pUt+3lFKG4QiPKoUt47G6w9K9szrS1SNh/Ux7c2EQ0RLC0+kDr650NegWJ6g9Ggt4LrsHCkbSqp+lU9QN46wmFutuB6B8FyYbaA58ZvYaDhv23M90/xn3YmQdPw7VAjWamIqV0qK0W+d/75qSQHpkxnFzswAMmtVFHf1UBRSFSTMhXZC69YvliogFGEZG3sGwXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781005811; c=relaxed/relaxed;
	bh=fLAZlEa/gpJjIgpIJ2e9Ooy6MTW++uhKEEc/j768mlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9Mq84/bpxO9tMhSESzDV62rUCxsJJP/MJhpOWuCS9wJIcoxxo4I7OvMoyEArkbPD8R9ow4KWRlyobt+BShg657XcKB4GGTwu5qYPvk7hb75XynHxYvzF+65hRPENEEoUtYZ50PDFlHvKpAQEUmnh1yGjn5CPqIo9Fg+5R4ViQEU7AhA/BZXLKrtNvU7fIxfbewK+s2S4yjIy+VYHdTFsEP9oxGrWIE6eQCdVwvUuVThzKEPXh9Tj7j/xJhid1eSQZyUQl6ApwsrvbKkW17Vs3/FpfZGafeAV3Hu8qtSv3Y1zPFPJNTNDFfGe/y+/3hPvELIt8RNdEzZNr1sRjThBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=a+Bhz9ro; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::864; helo=mail-qt1-x864.google.com; envelope-from=sumit.saxena@broadcom.com; receiver=lists.ozlabs.org) smtp.mailfrom=broadcom.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=a+Bhz9ro;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=broadcom.com (client-ip=2607:f8b0:4864:20::864; helo=mail-qt1-x864.google.com; envelope-from=sumit.saxena@broadcom.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x864.google.com (mail-qt1-x864.google.com [IPv6:2607:f8b0:4864:20::864])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZRzj75Ddz2ySf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 21:50:09 +1000 (AEST)
Received: by mail-qt1-x864.google.com with SMTP id d75a77b69052e-51764768c36so73074111cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 04:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781005807; x=1781610607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLAZlEa/gpJjIgpIJ2e9Ooy6MTW++uhKEEc/j768mlo=;
        b=cyoo+8CG4Ee+EzdtcYw3g/xrS1P16xx6xaYVws8oc94yOV8LkUA2jQH9X/N78gwjfC
         Tg7hQGIRr2kqJGPKE2T/535qYAHtjeXnm9qTB3+YvaTW8LTyr4vTTf0exOSTFTog/vVx
         ymkX/EUlY+vUf05hwGMcvtrLniGUlBOaLSDVxFJoav1kYQ9Q4nocRYq6rxcgMlvybbao
         3c1bSzPMMVQQyGn6e8ar1Vxg86SU96uuBxVoUKX1G0o7uB1nbnXMcXJEPYvrAYnwuhxQ
         tCWdOKawAs5Y/TSiAabxaFfJdbCq25nKkhJuBlkjUGljD+JjO+vbnsdwRP69rX5nP5e9
         z7oA==
X-Forwarded-Encrypted: i=1; AFNElJ+0RSByrNteQN/FoudcMc/XUFCymhWjhkZjnep7xl7ZIrLFlJ4tk2GTxL4DzguXaW8D4J4A2htzjH8WkB0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzuh9QIQHWXeYFte2E60FOZIXJZDc7t0Pwi7W6pFAqPj1Zi1klh
	1w4Xm2BhtmQnpTQfEySTAMcuky+VuKt7hDELKScMmK3r/gRevNMzDnrfxe1SA7NGd1eEva8bl/y
	dk23KLX4xkWq+KGsoNPyaYmJmJt8sOpUlTg2RseUGjmMwKcdArCpsyzRFVf/Ub0KWyQ5RlsAFe9
	9xaILwmRxqZ48FgirDpu/QwSTsoc+LBiHBDzXzDdqfhrG4yNzb7es5jNVC1EQBUMXxavCXt4OjK
	XruiUefnfzobGqp3swH
X-Gm-Gg: Acq92OFghrJvAgyXLH82QLVLp+vdvSt4lkrY2DfFlSgCcaFKCuOvYmzDdHpvR7OXe0B
	oPPuM8F3rVp4TikQqw3hXi9v/4N1ahFIuCj8kuMUx0jbfrc1kgV97lvWIezUmMaNuBi2Jki2MmN
	jwZmvjSusxXKmWzebSDLLzLGYB74+yxJEJtDWLzXgEdhORpOQyPuyW5H4y6AM9vYc4tLv9Aakh4
	l1pm37gOFOvZ4Yjiw3TJCwi20N+ZOe9rmFMbJUUbi1FL1YkRGvw+I7eOoXWizX2rYTddJ/Aqpx6
	j4U3U5EJ7zKm/NEvClr8MM4SVzh4yo915KARv6iGhKsLc26HlQjbhu+Zn8jGiigmFhY+3XMB/2O
	ruZSq5mPttN5EnNunhyHPZpzWus8de5DptwugCN6iH6We6++P1zD4thEiQNRMhXfO19k3NEDoZu
	DNB0YTjvsfcwdcJQG5gR6wqlFrKQN9sskuHOqp+yh9kkMF5si0BbatlbMde/fpF6rYePE=
X-Received: by 2002:a05:622a:2448:b0:517:6d82:ceff with SMTP id d75a77b69052e-51795b81158mr284429491cf.13.1781005807212;
        Tue, 09 Jun 2026 04:50:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8cecd034db1sm10652416d6.25.2026.06.09.04.50.06
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2026 04:50:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36d98b5a68fso9680828a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 04:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781005806; x=1781610606; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLAZlEa/gpJjIgpIJ2e9Ooy6MTW++uhKEEc/j768mlo=;
        b=a+Bhz9roDlLEX+mrnQn0GAJB4dg/JHWJPpTDYolSMjYaMHY+bM9bMpuSkdRlF6UV8g
         WCsjl6AYtZkA2kkYA281xLk47D6+D9XbG4ZWqKtFgjgjDeydFTu7uKoFoVtaOnB+h57V
         AMtQeR+TPmFkRc/KoFUcE5hUpuhSA4HPXz5Jc=
X-Forwarded-Encrypted: i=1; AFNElJ9k7IATjknBHQugdvi8PIz5Xg78ZOPPmqi6uTXYyMQc/BEEhw6I6DyO1kmn3T3mNuSEKUApdTJd8dikupw=@lists.ozlabs.org
X-Received: by 2002:a17:90b:57c4:b0:36b:75:6387 with SMTP id 98e67ed59e1d1-370eea202f0mr20609594a91.8.1781005805632;
        Tue, 09 Jun 2026 04:50:05 -0700 (PDT)
X-Received: by 2002:a17:90b:57c4:b0:36b:75:6387 with SMTP id 98e67ed59e1d1-370eea202f0mr20609495a91.8.1781005805070;
        Tue, 09 Jun 2026 04:50:05 -0700 (PDT)
Received: from sumit_ws.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf903fasm18898075a91.2.2026.06.09.04.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 04:50:03 -0700 (PDT)
From: Sumit Saxena <sumit.saxena@broadcom.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	Adam Radford <aradford@gmail.com>,
	Khalid Aziz <khalid@gonehiking.org>,
	Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
	Matthew Wilcox <willy@infradead.org>,
	Hannes Reinecke <hare@suse.com>,
	"Juergen E . Fischer" <fischer@norbit.de>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Finn Thain <fthain@linux-m68k.org>,
	Michael Schmitz <schmitzmic@gmail.com>,
	Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
	Oliver Neukum <oliver@neukum.org>,
	Ali Akcaagac <aliakc@web.de>,
	Jamie Lenehan <lenehan@twibble.org>,
	Ram Vegesna <ram.vegesna@broadcom.com>,
	target-devel@vger.kernel.org,
	Bradley Grove <linuxdrivers@attotech.com>,
	Satish Kharat <satishkh@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	Yihang Li <liyihang9@h-partners.com>,
	Don Brace <don.brace@microchip.com>,
	storagedev@microchip.com,
	HighPoint Linux Team <linux@highpoint-tech.com>,
	Tyrel Datwyler <tyreld@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	Brian King <brking@us.ibm.com>,
	Lee Duncan <lduncan@suse.com>,
	Chris Leech <cleech@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	open-iscsi@googlegroups.com,
	Justin Tee <justin.tee@broadcom.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth Patil <chandrakanth.patil@broadcom.com>,
	megaraidlinux.pdl@broadcom.com,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	Ranjan Kumar <ranjan.kumar@broadcom.com>,
	MPT-FusionLinux.pdl@broadcom.com,
	Daniel Palmer <daniel@thingy.jp>,
	GOTO Masanori <gotom@debian.or.jp>,
	YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Geoff Levand <geoff@infradead.org>,
	Michael Reed <mdr@sgi.com>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Narsimhulu Musini <nmusini@cisco.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	Vishal Bhakta <vishal.bhakta@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 4/4] scsi: use percpu counters for iostat counters in struct scsi_device
Date: Tue,  9 Jun 2026 17:48:03 +0530
Message-ID: <20260609121806.2121755-5-sumit.saxena@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260609121806.2121755-1-sumit.saxena@broadcom.com>
References: <20260609121806.2121755-1-sumit.saxena@broadcom.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

iorequest_cnt and iodone_cnt are updated on every command dispatch and
completion, often from different CPUs on high queue depth workloads.
Using adjacent atomic_t fields causes cache line contention between the
submission and completion paths.

Extend the same treatment to ioerr_cnt and iotmo_cnt so all four iostat
counters in struct scsi_device use struct percpu_counter.

Suggested-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
---
 drivers/scsi/scsi_error.c  |  4 ++--
 drivers/scsi/scsi_lib.c    | 10 +++++-----
 drivers/scsi/scsi_scan.c   |  8 ++++++++
 drivers/scsi/scsi_sysfs.c  | 23 ++++++++++++++---------
 drivers/scsi/sd.c          |  2 +-
 include/scsi/scsi_device.h |  9 +++++----
 6 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 147127fb4db9..b1aa7da2ba7c 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -349,7 +349,7 @@ enum blk_eh_timer_return scsi_timeout(struct request *req)
 	trace_scsi_dispatch_cmd_timeout(scmd);
 	scsi_log_completion(scmd, TIMEOUT_ERROR);
 
-	atomic_inc(&scmd->device->iotmo_cnt);
+	percpu_counter_inc(&scmd->device->iotmo_cnt);
 	if (host->eh_deadline != -1 && !host->last_reset)
 		host->last_reset = jiffies;
 
@@ -370,7 +370,7 @@ enum blk_eh_timer_return scsi_timeout(struct request *req)
 	 */
 	if (test_and_set_bit(SCMD_STATE_COMPLETE, &scmd->state))
 		return BLK_EH_DONE;
-	atomic_inc(&scmd->device->iodone_cnt);
+	percpu_counter_inc(&scmd->device->iodone_cnt);
 	if (scsi_abort_command(scmd) != SUCCESS) {
 		set_host_byte(scmd, DID_TIME_OUT);
 		scsi_eh_scmd_add(scmd);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 6e8c7a42603e..979fdace33ac 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1554,9 +1554,9 @@ static void scsi_complete(struct request *rq)
 
 	INIT_LIST_HEAD(&cmd->eh_entry);
 
-	atomic_inc(&cmd->device->iodone_cnt);
+	percpu_counter_inc(&cmd->device->iodone_cnt);
 	if (cmd->result)
-		atomic_inc(&cmd->device->ioerr_cnt);
+		percpu_counter_inc(&cmd->device->ioerr_cnt);
 
 	disposition = scsi_decide_disposition(cmd);
 	if (disposition != SUCCESS && scsi_cmd_runtime_exceeced(cmd))
@@ -1592,7 +1592,7 @@ static enum scsi_qc_status scsi_dispatch_cmd(struct scsi_cmnd *cmd)
 	struct Scsi_Host *host = cmd->device->host;
 	int rtn = 0;
 
-	atomic_inc(&cmd->device->iorequest_cnt);
+	percpu_counter_inc(&cmd->device->iorequest_cnt);
 
 	/* check if the device is still usable */
 	if (unlikely(cmd->device->sdev_state == SDEV_DEL)) {
@@ -1614,7 +1614,7 @@ static enum scsi_qc_status scsi_dispatch_cmd(struct scsi_cmnd *cmd)
 		 */
 		SCSI_LOG_MLQUEUE(3, scmd_printk(KERN_INFO, cmd,
 			"queuecommand : device blocked\n"));
-		atomic_dec(&cmd->device->iorequest_cnt);
+		percpu_counter_dec(&cmd->device->iorequest_cnt);
 		return SCSI_MLQUEUE_DEVICE_BUSY;
 	}
 
@@ -1647,7 +1647,7 @@ static enum scsi_qc_status scsi_dispatch_cmd(struct scsi_cmnd *cmd)
 	trace_scsi_dispatch_cmd_start(cmd);
 	rtn = host->hostt->queuecommand(host, cmd);
 	if (rtn) {
-		atomic_dec(&cmd->device->iorequest_cnt);
+		percpu_counter_dec(&cmd->device->iorequest_cnt);
 		trace_scsi_dispatch_cmd_error(cmd, rtn);
 		if (rtn != SCSI_MLQUEUE_DEVICE_BUSY &&
 		    rtn != SCSI_MLQUEUE_TARGET_BUSY)
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 121a14d5fdb8..bc885c72f01e 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -350,6 +350,14 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
 
 	scsi_sysfs_device_initialize(sdev);
 
+	if (percpu_counter_init(&sdev->iorequest_cnt, 0, GFP_KERNEL) ||
+	    percpu_counter_init(&sdev->iodone_cnt, 0, GFP_KERNEL) ||
+	    percpu_counter_init(&sdev->ioerr_cnt, 0, GFP_KERNEL) ||
+	    percpu_counter_init(&sdev->iotmo_cnt, 0, GFP_KERNEL)) {
+		ret = -ENOMEM;
+		goto out_device_destroy;
+	}
+
 	if (scsi_device_is_pseudo_dev(sdev))
 		return sdev;
 
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index dfc3559e7e04..f652edd16497 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -516,6 +516,10 @@ static void scsi_device_dev_release(struct device *dev)
 	if (vpd_pgb7)
 		kfree_rcu(vpd_pgb7, rcu);
 	kfree(sdev->inquiry);
+	percpu_counter_destroy(&sdev->iotmo_cnt);
+	percpu_counter_destroy(&sdev->ioerr_cnt);
+	percpu_counter_destroy(&sdev->iodone_cnt);
+	percpu_counter_destroy(&sdev->iorequest_cnt);
 	kfree(sdev);
 
 	if (parent)
@@ -936,26 +940,27 @@ static ssize_t
 show_iostat_counterbits(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
-	return snprintf(buf, 20, "%d\n", (int)sizeof(atomic_t) * 8);
+	/* iostat counters are per-CPU sums (s64).  Report width for tools. */
+	return sysfs_emit(buf, "%zu\n", sizeof(s64) * 8);
 }
 
 static DEVICE_ATTR(iocounterbits, S_IRUGO, show_iostat_counterbits, NULL);
 
-#define show_sdev_iostat(field)						\
+#define show_sdev_iostat_percpu(field)					\
 static ssize_t								\
 show_iostat_##field(struct device *dev, struct device_attribute *attr,	\
 		    char *buf)						\
 {									\
 	struct scsi_device *sdev = to_scsi_device(dev);			\
-	unsigned long long count = atomic_read(&sdev->field);		\
-	return snprintf(buf, 20, "0x%llx\n", count);			\
+	unsigned long long count = percpu_counter_sum(&sdev->field);	\
+	return sysfs_emit(buf, "0x%llx\n", count);			\
 }									\
-static DEVICE_ATTR(field, S_IRUGO, show_iostat_##field, NULL)
+static DEVICE_ATTR(field, 0444, show_iostat_##field, NULL)
 
-show_sdev_iostat(iorequest_cnt);
-show_sdev_iostat(iodone_cnt);
-show_sdev_iostat(ioerr_cnt);
-show_sdev_iostat(iotmo_cnt);
+show_sdev_iostat_percpu(iorequest_cnt);
+show_sdev_iostat_percpu(iodone_cnt);
+show_sdev_iostat_percpu(ioerr_cnt);
+show_sdev_iostat_percpu(iotmo_cnt);
 
 static ssize_t
 sdev_show_modalias(struct device *dev, struct device_attribute *attr, char *buf)
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index adc3fa55ca2c..b7ce01de17b3 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -4043,7 +4043,7 @@ static int sd_probe(struct scsi_device *sdp)
 	sdkp->index = index;
 	sdkp->max_retries = SD_MAX_RETRIES;
 	atomic_set(&sdkp->openers, 0);
-	atomic_set(&sdkp->device->ioerr_cnt, 0);
+	percpu_counter_set(&sdkp->device->ioerr_cnt, 0);
 
 	if (!sdp->request_queue->rq_timeout) {
 		if (sdp->type != TYPE_MOD)
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 029f5115b2ea..4be36bf2a475 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -9,6 +9,7 @@
 #include <scsi/scsi.h>
 #include <scsi/scsi_common.h>
 #include <linux/atomic.h>
+#include <linux/percpu_counter.h>
 #include <linux/sbitmap.h>
 
 struct bsg_device;
@@ -272,10 +273,10 @@ struct scsi_device {
 	unsigned int max_device_blocked; /* what device_blocked counts down from  */
 #define SCSI_DEFAULT_DEVICE_BLOCKED	3
 
-	atomic_t iorequest_cnt;
-	atomic_t iodone_cnt;
-	atomic_t ioerr_cnt;
-	atomic_t iotmo_cnt;
+	struct percpu_counter iorequest_cnt;
+	struct percpu_counter iodone_cnt;
+	struct percpu_counter ioerr_cnt;
+	struct percpu_counter iotmo_cnt;
 
 	struct device		sdev_gendev,
 				sdev_dev;
-- 
2.43.7


