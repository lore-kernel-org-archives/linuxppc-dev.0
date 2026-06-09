Return-Path: <linuxppc-dev+bounces-22383-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660F9CD8C90
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 04:39:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZtNm5qFSz30FP;
	Wed, 10 Jun 2026 14:39:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f62"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781005788;
	cv=none; b=ig1Fqs+DWJtNYIYYEAI9dqiKlBUM0TJMogwnqAoD1xfJ8XSoyfDZg8gCldLazAS3cMtkvnF9JltzNDbZ2JKjxuNS3VfCJ9UkoP5h3fvXEVCKCPGQSxjlHhoofKPzd8NYoxDw8sDcHvhBTctiKXjhwo8kC4hUXJaBsrEcPKsHPbqE2XKq6tAiWpkEukJGs/0sd66pb80LbH9hxMitUiIcjzPL69UC1FB9GKcL37ozWiPDKdH0sCBlpapr7OTADzrEW23cPwrP03lFCTMwHYbPLqEizArLARh/HSiEsm94r6oQJ4vVsAoFkk4+WDYBOvNmr9OcKiZLilhMYvBzzUipxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781005788; c=relaxed/relaxed;
	bh=d7jf3E3dEVwQVNqBXvyK4i7zv9F+advmarrjrg+nD7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4HmBGPcMR1MoMmEm3OP13GWCFIsl2Z4MVLnVAKWI1/LPrKxfu+LFUanf7REXf02JFf0TSD9G/2fy1GUyCqCT6YRMhBPXd5RzoixmLGHd2v8226foVSxYSUxUiJJwjAjYzE4VECtgW6gztUz/L4b6VZWBsGrZwFioLs/v8qmTP0i+8v3mZ0tdiBxXrQLDNFJxf3HqqWy+p9hibOj8lMaWATg0L01p0rZsABCbDP2u3l+2PB5B7jzhGsEfA2Eyrg2LaC0vKzh2XgAxmIi3FZgRype4g/vjx8J4yLXwpGtLFkF962ZRdnTctJ8ZaSbvY/bCengEn2nNS2mCH1n41VnPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=QvUrgFjk; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f62; helo=mail-qv1-xf62.google.com; envelope-from=sumit.saxena@broadcom.com; receiver=lists.ozlabs.org) smtp.mailfrom=broadcom.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=QvUrgFjk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=broadcom.com (client-ip=2607:f8b0:4864:20::f62; helo=mail-qv1-xf62.google.com; envelope-from=sumit.saxena@broadcom.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf62.google.com (mail-qv1-xf62.google.com [IPv6:2607:f8b0:4864:20::f62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZRzH54x9z2ySf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 21:49:47 +1000 (AEST)
Received: by mail-qv1-xf62.google.com with SMTP id 6a1803df08f44-8ccdef9f3d4so61931886d6.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 04:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781005785; x=1781610585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d7jf3E3dEVwQVNqBXvyK4i7zv9F+advmarrjrg+nD7g=;
        b=PlxsqGVm5Tvan7o881NnR93OHsSqH02jN6d3dC8dw+dPdUvgGT4VBmn8ggjFQQRce8
         ECoTk0E1x63rRGKwZdkCD2YATKqx85vf7WF0iSCheIJQSkq1YZ3gxHD5Q/BcFqgFjn/d
         TvzRXN34nB//kisdTP8PVoGvGN/rnj5Nogfb7jqJmUD4WIv6MK2tOd8+X5GAJ2jbsUpF
         nr6S/t2UwQqfO6Ip+LUWtFP2ml0+W6YxH5K0w68pdkx/mSH0EKgUZT4DU5Um0HmXBz0c
         ktB6Yo4Uo1ApX+P1XvdPPUFcPhC+27NfCjOjsuRl5eripYSZM8pY6hsPc1hTclMFlDkP
         TcmA==
X-Forwarded-Encrypted: i=1; AFNElJ83Bd9ZhyFYoZkekA074GNLUytbxkbDUYAYVG7grxWVX8L0c29TWafQTr9lYnecH0vupQoQbdEAMOkAfqI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz1ZvINjaTbq/3TUEmgJdxNBMNC8/7t+AZdD2+AnmfJvx1hKbTy
	X/b0Ee+CisSeWdPHl16yCSHqmCFgckubdLde5zdgTwodpwTgUwpLCqHrazxKCJQ1qPOMohvTpU4
	Yb22gjFWpqIhav8LOLm/8aKRXsDvnQY9yh6V0j8jRvtX0dD2/qEMHGnYf1ukpxkSQ1nCicwZpn0
	V93lHEHLvYaJtwjKP06HY5fypdS05jgOLNZ15cmxM14aeZ01scfzKT2Jn0c3KK6E327oKYYfW3x
	x2UMcX5+ssQjUgZMoHE
X-Gm-Gg: Acq92OEAv6AmxKRAVdNPk50an46y1YR5fVeScBZtSw/HSKJY75/RZBTWLyQ45FPp6KR
	8LgP7asM82XkLrcWKkycrnnAnjCsMyg5un1gN8kCQAM122zsFQcOkKJEzeYB3bDHtRcEuUbAOEk
	okOi6bT4Z5zONmC19dMSh7piWoNfacDvUFYRS7el0ivtNOQ/hcJrzB0zOFJOJMbo2oHHxtEbzka
	avsbe9NZZqo2g0UV+gZtM2QRYiEI4jRi6ZsENc11MvhRyGb7QQrWPgXfvWRdFYuWDmJwPXlnDTx
	9VvDjliNN7h/e0bVQcgpuMVpQjlmomZF9yq+3KFh89tp0434QHo94RV9qAyafWDr2JSMlgu4IKf
	Zd7woD1S8hUsTpwIYmltvuXcPxM0YJ9E553YUG6Q/wnAYg/ab+07hLCL4WyBKrXXBSfmToyjDUX
	sYLx3sXfEEBqf6cvktGfKLKDflnefPymJO8KW4DMZw515laeabbNC66Ty+lG+0mRHQGabyrg==
X-Received: by 2002:a05:6214:301a:b0:8cc:f0e0:f90b with SMTP id 6a1803df08f44-8cee629be9emr295084206d6.40.1781005785076;
        Tue, 09 Jun 2026 04:49:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8ceccbaa13dsm10703186d6.7.2026.06.09.04.49.44
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2026 04:49:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36d97a4e08fso5087602a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 04:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781005784; x=1781610584; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7jf3E3dEVwQVNqBXvyK4i7zv9F+advmarrjrg+nD7g=;
        b=QvUrgFjk61tYZ7lWPJZKnhYwFIUSAQtsdPeQICa9WjYeT2V4qaJBbfPrqL1+afYIcC
         IyoGuAirEWzgrYKpEcMpB66F8VtX76C8swY66XRc56tzNkRV/SKpcv/ueMceWc64EHwg
         at/SuiTpvziOFumSyDA6ca0kR2qiYiFuKyIwc=
X-Forwarded-Encrypted: i=1; AFNElJ9uzXptAEpBaYNITzXXVdYesiZ7QY6+H5aRX3XfaLlTl008wR9DjNWhi0obVgFXx8/lIkEnUB417SbHCjc=@lists.ozlabs.org
X-Received: by 2002:a17:90b:3503:b0:369:7f25:cec0 with SMTP id 98e67ed59e1d1-370ebff34bcmr20900046a91.0.1781005783415;
        Tue, 09 Jun 2026 04:49:43 -0700 (PDT)
X-Received: by 2002:a17:90b:3503:b0:369:7f25:cec0 with SMTP id 98e67ed59e1d1-370ebff34bcmr20900004a91.0.1781005782876;
        Tue, 09 Jun 2026 04:49:42 -0700 (PDT)
Received: from sumit_ws.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf903fasm18898075a91.2.2026.06.09.04.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 04:49:41 -0700 (PDT)
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
	Bart Van Assche <bvanassche@acm.org>,
	Sumit Saxena <sumit.saxena@broadcom.com>
Subject: [PATCH v3 3/4] block: drop shared-tag fairness throttling
Date: Tue,  9 Jun 2026 17:48:02 +0530
Message-ID: <20260609121806.2121755-4-sumit.saxena@broadcom.com>
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

From: Bart Van Assche <bvanassche@acm.org>

Original patch [1] by Bart Van Assche; this version is rebased onto the
current tree.  In testing it improves IOPS by roughly 16-18% by removing
the fair-sharing throttle on shared tag queues.

This patch removes the following code and structure members:
- The function hctx_may_queue().
- blk_mq_hw_ctx.nr_active and request_queue.nr_active_requests_shared_tags
  and also all the code that modifies these two member variables.

[1]: https://lore.kernel.org/linux-block/20240529213921.3166462-1-bvanassche@acm.org/

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
---
 block/blk-core.c       |   2 -
 block/blk-mq-debugfs.c |  22 ++++++++-
 block/blk-mq-tag.c     |   4 --
 block/blk-mq.c         |  17 +------
 block/blk-mq.h         | 100 -----------------------------------------
 include/linux/blk-mq.h |   6 ---
 include/linux/blkdev.h |   2 -
 7 files changed, 22 insertions(+), 131 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 17450058ea6d..129acc1b27e5 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -421,8 +421,6 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
 
 	q->node = node_id;
 
-	atomic_set(&q->nr_active_requests_shared_tags, 0);
-
 	timer_setup(&q->timeout, blk_rq_timed_out_timer, 0);
 	INIT_WORK(&q->timeout_work, blk_timeout_work);
 	INIT_LIST_HEAD(&q->icq_list);
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 047ec887456b..8b85a7f8e987 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -468,11 +468,31 @@ static int hctx_sched_tags_bitmap_show(void *data, struct seq_file *m)
 	return 0;
 }
 
+struct count_active_params {
+	struct blk_mq_hw_ctx	*hctx;
+	int			*active;
+};
+
+static bool hctx_count_active(struct request *rq, void *data)
+{
+	const struct count_active_params *params = data;
+
+	if (rq->mq_hctx == params->hctx)
+		(*params->active)++;
+
+	return true;
+}
+
 static int hctx_active_show(void *data, struct seq_file *m)
 {
 	struct blk_mq_hw_ctx *hctx = data;
+	int active = 0;
+	struct count_active_params params = { .hctx = hctx, .active = &active };
+
+	blk_mq_all_tag_iter(hctx->sched_tags ?: hctx->tags, hctx_count_active,
+			    &params);
 
-	seq_printf(m, "%d\n", __blk_mq_active_requests(hctx));
+	seq_printf(m, "%d\n", active);
 	return 0;
 }
 
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 33946cdb5716..bfd27cc6249b 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -109,10 +109,6 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
 			    struct sbitmap_queue *bt)
 {
-	if (!data->q->elevator && !(data->flags & BLK_MQ_REQ_RESERVED) &&
-			!hctx_may_queue(data->hctx, bt))
-		return BLK_MQ_NO_TAG;
-
 	if (data->shallow_depth)
 		return sbitmap_queue_get_shallow(bt, data->shallow_depth);
 	else
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4c5c16cce4f8..bbac59a06044 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -489,8 +489,6 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data)
 		}
 	} while (data->nr_tags > nr);
 
-	if (!(data->rq_flags & RQF_SCHED_TAGS))
-		blk_mq_add_active_requests(data->hctx, nr);
 	/* caller already holds a reference, add for remainder */
 	percpu_ref_get_many(&data->q->q_usage_counter, nr - 1);
 	data->nr_tags -= nr;
@@ -587,8 +585,6 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 		goto retry;
 	}
 
-	if (!(data->rq_flags & RQF_SCHED_TAGS))
-		blk_mq_inc_active_requests(data->hctx);
 	rq = blk_mq_rq_ctx_init(data, blk_mq_tags_from_data(data), tag);
 	blk_mq_rq_time_init(rq, alloc_time_ns);
 	return rq;
@@ -763,8 +759,6 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	tag = blk_mq_get_tag(&data);
 	if (tag == BLK_MQ_NO_TAG)
 		goto out_queue_exit;
-	if (!(data.rq_flags & RQF_SCHED_TAGS))
-		blk_mq_inc_active_requests(data.hctx);
 	rq = blk_mq_rq_ctx_init(&data, blk_mq_tags_from_data(&data), tag);
 	blk_mq_rq_time_init(rq, alloc_time_ns);
 	rq->__data_len = 0;
@@ -807,10 +801,8 @@ static void __blk_mq_free_request(struct request *rq)
 	blk_pm_mark_last_busy(rq);
 	rq->mq_hctx = NULL;
 
-	if (rq->tag != BLK_MQ_NO_TAG) {
-		blk_mq_dec_active_requests(hctx);
+	if (rq->tag != BLK_MQ_NO_TAG)
 		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
-	}
 	if (sched_tag != BLK_MQ_NO_TAG)
 		blk_mq_put_tag(hctx->sched_tags, ctx, sched_tag);
 	blk_mq_sched_restart(hctx);
@@ -1188,8 +1180,6 @@ static inline void blk_mq_flush_tag_batch(struct blk_mq_hw_ctx *hctx,
 {
 	struct request_queue *q = hctx->queue;
 
-	blk_mq_sub_active_requests(hctx, nr_tags);
-
 	blk_mq_put_tags(hctx->tags, tag_array, nr_tags);
 	percpu_ref_put_many(&q->q_usage_counter, nr_tags);
 }
@@ -1875,9 +1865,6 @@ bool __blk_mq_alloc_driver_tag(struct request *rq)
 	if (blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags, rq->internal_tag)) {
 		bt = &rq->mq_hctx->tags->breserved_tags;
 		tag_offset = 0;
-	} else {
-		if (!hctx_may_queue(rq->mq_hctx, bt))
-			return false;
 	}
 
 	tag = __sbitmap_queue_get(bt);
@@ -1885,7 +1872,6 @@ bool __blk_mq_alloc_driver_tag(struct request *rq)
 		return false;
 
 	rq->tag = tag + tag_offset;
-	blk_mq_inc_active_requests(rq->mq_hctx);
 	return true;
 }
 
@@ -4058,7 +4044,6 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
 	if (!zalloc_cpumask_var_node(&hctx->cpumask, gfp, node))
 		goto free_hctx;
 
-	atomic_set(&hctx->nr_active, 0);
 	if (node == NUMA_NO_NODE)
 		node = set->numa_node;
 	hctx->numa_node = node;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index aa15d31aaae9..8dfb67c55f5d 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -291,70 +291,9 @@ static inline int blk_mq_get_rq_budget_token(struct request *rq)
 	return -1;
 }
 
-static inline void __blk_mq_add_active_requests(struct blk_mq_hw_ctx *hctx,
-						int val)
-{
-	if (blk_mq_is_shared_tags(hctx->flags))
-		atomic_add(val, &hctx->queue->nr_active_requests_shared_tags);
-	else
-		atomic_add(val, &hctx->nr_active);
-}
-
-static inline void __blk_mq_inc_active_requests(struct blk_mq_hw_ctx *hctx)
-{
-	__blk_mq_add_active_requests(hctx, 1);
-}
-
-static inline void __blk_mq_sub_active_requests(struct blk_mq_hw_ctx *hctx,
-		int val)
-{
-	if (blk_mq_is_shared_tags(hctx->flags))
-		atomic_sub(val, &hctx->queue->nr_active_requests_shared_tags);
-	else
-		atomic_sub(val, &hctx->nr_active);
-}
-
-static inline void __blk_mq_dec_active_requests(struct blk_mq_hw_ctx *hctx)
-{
-	__blk_mq_sub_active_requests(hctx, 1);
-}
-
-static inline void blk_mq_add_active_requests(struct blk_mq_hw_ctx *hctx,
-					      int val)
-{
-	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
-		__blk_mq_add_active_requests(hctx, val);
-}
-
-static inline void blk_mq_inc_active_requests(struct blk_mq_hw_ctx *hctx)
-{
-	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
-		__blk_mq_inc_active_requests(hctx);
-}
-
-static inline void blk_mq_sub_active_requests(struct blk_mq_hw_ctx *hctx,
-					      int val)
-{
-	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
-		__blk_mq_sub_active_requests(hctx, val);
-}
-
-static inline void blk_mq_dec_active_requests(struct blk_mq_hw_ctx *hctx)
-{
-	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
-		__blk_mq_dec_active_requests(hctx);
-}
-
-static inline int __blk_mq_active_requests(struct blk_mq_hw_ctx *hctx)
-{
-	if (blk_mq_is_shared_tags(hctx->flags))
-		return atomic_read(&hctx->queue->nr_active_requests_shared_tags);
-	return atomic_read(&hctx->nr_active);
-}
 static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
 					   struct request *rq)
 {
-	blk_mq_dec_active_requests(hctx);
 	blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
 	rq->tag = BLK_MQ_NO_TAG;
 }
@@ -396,45 +335,6 @@ static inline void blk_mq_free_requests(struct list_head *list)
 	}
 }
 
-/*
- * For shared tag users, we track the number of currently active users
- * and attempt to provide a fair share of the tag depth for each of them.
- */
-static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
-				  struct sbitmap_queue *bt)
-{
-	unsigned int depth, users;
-
-	if (!hctx || !(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
-		return true;
-
-	/*
-	 * Don't try dividing an ant
-	 */
-	if (bt->sb.depth == 1)
-		return true;
-
-	if (blk_mq_is_shared_tags(hctx->flags)) {
-		struct request_queue *q = hctx->queue;
-
-		if (!test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
-			return true;
-	} else {
-		if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
-			return true;
-	}
-
-	users = READ_ONCE(hctx->tags->active_queues);
-	if (!users)
-		return true;
-
-	/*
-	 * Allow at least some tags
-	 */
-	depth = max((bt->sb.depth + users - 1) / users, 4U);
-	return __blk_mq_active_requests(hctx) < depth;
-}
-
 /* run the code block in @dispatch_ops with rcu/srcu read lock held */
 #define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops)	\
 do {								\
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 18a2388ba581..ccbb07559402 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -432,12 +432,6 @@ struct blk_mq_hw_ctx {
 	/** @queue_num: Index of this hardware queue. */
 	unsigned int		queue_num;
 
-	/**
-	 * @nr_active: Number of active requests. Only used when a tag set is
-	 * shared across request queues.
-	 */
-	atomic_t		nr_active;
-
 	/** @cpuhp_online: List to store request if CPU is going to die */
 	struct hlist_node	cpuhp_online;
 	/** @cpuhp_dead: List to store request if some CPU die. */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 890128cdea1c..95525b1d7b74 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -567,8 +567,6 @@ struct request_queue {
 	struct timer_list	timeout;
 	struct work_struct	timeout_work;
 
-	atomic_t		nr_active_requests_shared_tags;
-
 	struct blk_mq_tags	*sched_shared_tags;
 
 	struct list_head	icq_list;
-- 
2.43.7


