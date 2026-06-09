Return-Path: <linuxppc-dev+bounces-22381-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63EACD8C90
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 04:39:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZtNS33SGz2xl6;
	Wed, 10 Jun 2026 14:39:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::663"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781005745;
	cv=none; b=YsCE6Vva9BMO35MJ0WYIVHnGtK+M7IV1wJiNROeJwjJaM4OGnFuuJbSepFpM7+36plI4wOTTTKn2I3T0IBHYEApCEx4NxwJ3O/qZUflV4puFGmuZSyS8q05pydzUGySErr7Hdhk0H/eadPCo114oi8r4mfrkjW5Kevd0v6OeekIt17DwefwknyNFJgNWACpLW1alpKkaUr1vp7SSu3Xv4LF2BRHGNGUhcz8Tfnv1hS4eZ9jojCuQudn5bGdbTeEOkmNUhZ7VODy9QBKkaMuHXt+3gYgfE011nH4R/w8VVZFxkt6ThTdnM0UtGjwmn5CSjTuKCCcFIncj79pFcIYRxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781005745; c=relaxed/relaxed;
	bh=Cij0f7XK3gPTc98cKs5ll/gp5Fj5YlFQkChYuGOVaaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLKY6F3Q04rleHuV1htezCQa0s10QDAH/dPUiOmD61+XQkTpRYO+QYecuq+VitSXNG4KrovSNke7WNXBQnoUUDKPAGfPy43AsIuAoG4kJIslVOZSGrcVHZyrUrRX0WvONeOMXX7oC81Q2M5gz1pAdrDUxLNng8Wy/jX5zW5Sc7wvjBpEnAn7pI6Txsb9LezzxtIKHxFdsFkx+R1WrlQ0ny/bgptNR5bjkd7mhJjwccbN/c6cm2IEFMRk9AgT9Kl+3BFtkuH08H7Gj5jWaONpKN7I/KsxaMJxeVkxjuU5jFF8EXpGA+wnNe0f/mUkWCiWGdlX1S1QHMHAHOa2Yxh/uw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=bAqAD6tV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::663; helo=mail-pl1-x663.google.com; envelope-from=sumit.saxena@broadcom.com; receiver=lists.ozlabs.org) smtp.mailfrom=broadcom.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=bAqAD6tV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=broadcom.com (client-ip=2607:f8b0:4864:20::663; helo=mail-pl1-x663.google.com; envelope-from=sumit.saxena@broadcom.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x663.google.com (mail-pl1-x663.google.com [IPv6:2607:f8b0:4864:20::663])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZRyS3d0Hz2ySf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 21:49:04 +1000 (AEST)
Received: by mail-pl1-x663.google.com with SMTP id d9443c01a7336-2c0b944f6edso55801645ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 04:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781005742; x=1781610542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cij0f7XK3gPTc98cKs5ll/gp5Fj5YlFQkChYuGOVaaM=;
        b=MbZ1cu36I56tgfjlWwOH4iz4Pu9X+LspKloD9dMe5cvedQhf2FFcfgR1cI/ThGa+9B
         kOkJ7QtvKisTqF3EB1AUAlUM2A2VESN+3+nyEthhmGG5F40fuBS+wOVFG+Wr0BvnuRV9
         bNyixQDrylPIwfOyPPEuTHGJhcQLENGOzDedPhrSBBj+e2AkMX1X1xPFpvX7JrOBwwQ2
         EpwOc2VWKJb7LfDGRKqfVIf70dukdJd6RbCjPBbFxH93UV1Dpdx9Ln7fCnARqKJUFM3L
         H99j5Xw4KEPibp65M/Kumrwu8CPuT6uUwhMjH9V2WJ+MST02YK3ZVzFGHQUByZCzcOTR
         JwYw==
X-Forwarded-Encrypted: i=1; AFNElJ+qbFMGzqloD26DtN6phd+mu98o0dTXNCST/dlwlE/bUPAHrbBH6TMBRTfHG/IKHWdMW1AYTimMZMxiu18=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YymWJWeOuhDxjwEkiJxMKLYxYF2mLzls0wxzjcaZRMJnlsmAyT3
	HP86P1u4FCFOFXfEioAS214vbfaScF/6g/Mc9FpUUagx/bCmS10UxeadrFABngG9glzB6+FMKFC
	KJ8K4Obvq+WkYnAuGAJ4pGbCxknoef9D0hlY93nKYJEPz31fXG4ywrj5HFToUVnE+/itRa/lCcY
	pM1DZ2IzFQ7GbAPrNuNgJ5tJrXnBMvVbPUyA1pPJjJyLwcRD+LSPA5TaVRc2d225EUys7q/vYZC
	uFsrnUFoDwlP4PXutN1
X-Gm-Gg: Acq92OHyaTRtlndHpt+Nd0+HYpYQFKONhp0BFWtRPp4uyfGW2BnOuCGcU7tQHClVoU3
	8CPpY6cltpvbkclUP+gn/SLtd64NRXqeyiyQjvt9vy9KX0MFpRAIs4kChK/jRj1HttN0li4NdBW
	sa5aGjwLW6J1U354mFaPa4dbhbnmvBVMolgDPJ83DnISfsbffSVA2dv1mEfWsYk8pd2O4Hfqc9m
	/ewNau/es1Ja/HFBLPCuj3R9LmmzA7iSLeRfvff+5NttjMtnne/XOLpX18MKkYwskma2kpjfJhb
	gRfaGBG9cfgcM3ye8A5GtRhmwXNQ/gyUtfzki3/buICjJrybgKeTdQXZl8gWuoSqCa+2M8QOK2H
	2yEbJnxTWU0fmmDufaDkExlBmONlnJT0kTBTkeVprs2kzSEc9Z1AGuLovweYsTVjiMos8qcqqIt
	zRuIu6KL9DAiZjPv8=
X-Received: by 2002:a05:6a21:a38b:b0:39c:126c:93b4 with SMTP id adf61e73a8af0-3b4cccf74a7mr25092972637.9.1781005741911;
        Tue, 09 Jun 2026 04:49:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c85df027c85sm1215742a12.1.2026.06.09.04.49.01
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2026 04:49:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36bc54005a7so7346501a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 04:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781005740; x=1781610540; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cij0f7XK3gPTc98cKs5ll/gp5Fj5YlFQkChYuGOVaaM=;
        b=bAqAD6tVB7x2UZ/ZzDcAgEdNOboBxTTthb1a8WbPC5y/+WpwtJWqdjpTXx/YZXZCwS
         nu085y8CTvKAYiCuS2UzqIiwY3x2dLLfO9QUqRpneiCTh43dtasqBnvHOTK4oMFdTic2
         3y4+69R3pfX7573Mc8MzGq5UgVAMm9bNg77mo=
X-Forwarded-Encrypted: i=1; AFNElJ9pIupcyr+2goB4+w21waDuslYsCeHm8wZAxOkYdFp6Qu5rqGyiwnD9fU6T5IrLlmW3yW5mVn1HHwWdXyc=@lists.ozlabs.org
X-Received: by 2002:a17:90b:5787:b0:36b:8824:d7cc with SMTP id 98e67ed59e1d1-370f057a115mr22377767a91.20.1781005739372;
        Tue, 09 Jun 2026 04:48:59 -0700 (PDT)
X-Received: by 2002:a17:90b:5787:b0:36b:8824:d7cc with SMTP id 98e67ed59e1d1-370f057a115mr22377714a91.20.1781005738858;
        Tue, 09 Jun 2026 04:48:58 -0700 (PDT)
Received: from sumit_ws.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf903fasm18898075a91.2.2026.06.09.04.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 04:48:57 -0700 (PDT)
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
	James Rizzo <james.rizzo@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>
Subject: [PATCH v3 1/4] scsi: scan: allocate sdev and starget on the NUMA node of the host adapter
Date: Tue,  9 Jun 2026 17:48:00 +0530
Message-ID: <20260609121806.2121755-2-sumit.saxena@broadcom.com>
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

From: James Rizzo <james.rizzo@broadcom.com>

When a host adapter is attached to a specific NUMA node, allocating
scsi_device and scsi_target via kzalloc() may place them on a remote
node.  All hot-path I/O accesses to these structures then cross the NUMA
interconnect, adding latency and consuming inter-node bandwidth.

Use kzalloc_node() with dev_to_node(shost->dma_dev) so allocations land
on the same node as the HBA, reducing cross-node traffic and improving
I/O performance on NUMA systems.

Signed-off-by: James Rizzo <james.rizzo@broadcom.com>
Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
---
 drivers/scsi/scsi_scan.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index e27da038603a..121a14d5fdb8 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -34,6 +34,7 @@
 #include <linux/kthread.h>
 #include <linux/spinlock.h>
 #include <linux/async.h>
+#include <linux/topology.h>
 #include <linux/slab.h>
 #include <linux/unaligned.h>
 
@@ -287,8 +288,8 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
 	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
 	struct queue_limits lim;
 
-	sdev = kzalloc(sizeof(*sdev) + shost->transportt->device_size,
-		       GFP_KERNEL);
+	sdev = kzalloc_node(sizeof(*sdev) + shost->transportt->device_size,
+		       GFP_KERNEL, dev_to_node(shost->dma_dev));
 	if (!sdev)
 		goto out;
 
@@ -502,7 +503,7 @@ static struct scsi_target *scsi_alloc_target(struct device *parent,
 	struct scsi_target *found_target;
 	int error, ref_got;
 
-	starget = kzalloc(size, GFP_KERNEL);
+	starget = kzalloc_node(size, GFP_KERNEL, dev_to_node(shost->dma_dev));
 	if (!starget) {
 		printk(KERN_ERR "%s: allocation failure\n", __func__);
 		return NULL;
-- 
2.43.7


