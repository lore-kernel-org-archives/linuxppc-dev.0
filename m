Return-Path: <SRS0=O865=6M=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A06C83000
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2020 17:13:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8184820730
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2020 17:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8184820730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49BSsJ0mJLzDqwn
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2020 03:13:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49BSqJ6nZ1zDqkk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2020 03:11:39 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3B91C68CF0; Tue, 28 Apr 2020 19:11:34 +0200 (CEST)
Date: Tue, 28 Apr 2020 19:11:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [RFC PATCH] powerpc/spufs: fix copy_to_user while atomic
Message-ID: <20200428171133.GA17445@lst.de>
References: <20200427200626.1622060-2-hch@lst.de>
 <20200428120207.15728-1-jk@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428120207.15728-1-jk@ozlabs.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, "Eric W . Biederman" <ebiederm@xmission.com>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

FYI, these little hunks reduce the difference to my version, maybe
you can fold them in?

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index c62d77ddaf7d3..1861436a6091d 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -2107,7 +2107,6 @@ static const struct file_operations spufs_wbox_info_fops = {
 static void ___spufs_dma_info_read(struct spu_context *ctx,
 		struct spu_dma_info *info)
 {
-	struct mfc_cq_sr *qp, *spuqp;
 	int i;
 
 	info->dma_info_type = ctx->csa.priv2.spu_tag_status_query_RW;
@@ -2116,8 +2115,8 @@ static void ___spufs_dma_info_read(struct spu_context *ctx,
 	info->dma_info_stall_and_notify = ctx->csa.spu_chnldata_RW[25];
 	info->dma_info_atomic_command_status = ctx->csa.spu_chnldata_RW[27];
 	for (i = 0; i < 16; i++) {
-		qp = &info->dma_info_command_data[i];
-		spuqp = &ctx->csa.priv2.spuq[i];
+		struct mfc_cq_sr *qp = &info->dma_info_command_data[i];
+		struct mfc_cq_sr *qp, *spuqp = &ctx->csa.priv2.spuq[i];
 
 		qp->mfc_cq_data0_RW = spuqp->mfc_cq_data0_RW;
 		qp->mfc_cq_data1_RW = spuqp->mfc_cq_data1_RW;
@@ -2166,7 +2165,7 @@ static const struct file_operations spufs_dma_info_fops = {
 };
 
 static void ___spufs_proxydma_info_read(struct spu_context *ctx,
-	struct spu_proxydma_info *info)
+		struct spu_proxydma_info *info)
 {
 	int i;
 
