Return-Path: <SRS0=nAOP=6W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B341C38A2A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2020 09:55:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0084021473
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2020 09:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0084021473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49JQg241HSzDr27
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2020 19:55:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=inria.fr (client-ip=192.134.164.104;
 helo=mail3-relais-sop.national.inria.fr; envelope-from=julia.lawall@inria.fr;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=inria.fr
X-Greylist: delayed 73 seconds by postgrey-1.36 at bilbo;
 Fri, 08 May 2020 19:53:41 AEST
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49JQdK4GTYzDqtK
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2020 19:53:41 +1000 (AEST)
X-IronPort-AV: E=Sophos;i="5.73,367,1583190000"; d="scan'208";a="348097894"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-SHA256;
 08 May 2020 11:52:21 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH] powerpc/spufs: adjust list element pointer type
Date: Fri,  8 May 2020 11:12:56 +0200
Message-Id: <1588929176-28527-1-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
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
Cc: Nic Volanschi <eugene.volanschi@inria.fr>, Arnd Bergmann <arnd@arndb.de>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Other uses of &gang->aff_list_head, eg in spufs_assert_affinity, indicate
that the list elements have type spu_context, not spu as used here.  Change
the type of tmp accordingly.

This has no impact on the execution, because tmp is not used in the body of
the loop.

Fixes: c5fc8d2a92461 ("[CELL] cell: add placement computation for scheduling of affinity contexts")
Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/powerpc/platforms/cell/spufs/sched.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index f18d5067cd0f..487fcb47f10d 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -344,8 +344,7 @@ static struct spu *aff_ref_location(struct spu_context *ctx, int mem_aff,
 static void aff_set_ref_point_location(struct spu_gang *gang)
 {
 	int mem_aff, gs, lowest_offset;
-	struct spu_context *ctx;
-	struct spu *tmp;
+	struct spu_context *tmp, *ctx;
 
 	mem_aff = gang->aff_ref_ctx->flags & SPU_CREATE_AFFINITY_MEM;
 	lowest_offset = 0;

