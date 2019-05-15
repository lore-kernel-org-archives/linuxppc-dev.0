Return-Path: <SRS0=9qWD=TP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6C1C04E53
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 May 2019 09:10:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B26220815
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 May 2019 09:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X4g8Gcvp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B26220815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 453pfZ5kD0zDqVM
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 May 2019 19:09:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=66.111.4.25; helo=out1-smtp.messagingengine.com;
 envelope-from=tobin@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="X4g8Gcvp"; dkim-atps=neutral
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 453pd51KLwzDqQM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2019 19:08:40 +1000 (AEST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id BC9412585C;
 Wed, 15 May 2019 05:08:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Wed, 15 May 2019 05:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=QzKWRK6NBMbQhyE5i
 rhebHpSXfQiq/oIHcfVwvxA9Y4=; b=X4g8GcvpmrFXvz4Gj+kjjbvd4BPxDWmlu
 mNe90vPHAMVXSibDmqRNLZb64qEOgU228oZwvNPD74T9V6CdAUsZ6J55nusBzdhC
 4vFb40XprJhib+5m3b0NFw65vVO1G0ZCPv+n+1STYqckkhDn+rNNvdhk1/PnIXng
 3B1bBP8iZhS+0AdcJ1Ih54UKFoX152+nrRB2/2lrqICOFdKpfzo6o5OLm0ScRsGN
 fqBu+46x5v7yePLyzOWBN7Xw48SwYG9nrUAAxAJc9zUiCLxDL9xm2zQQEFW7AcPb
 h2ju5oVCv1bJFlQqq6owvWKHsWkrIK0iT0cqgRml0610dGsw4qK4Q==
X-ME-Sender: <xms:E9fbXGVMGEptq4lh2RslL3ArPI-x-CuE5CUGVOIO_Dq_ox8-7U9b2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleekgddufecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucev
 rdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkphepud
 dvuddrgeegrddvvdefrddvuddunecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgsihhn
 sehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:E9fbXM7rxPa7ECgArhApF1fvOBPthKBeUL1zvWMDd9vcXBhU5uN0TQ>
 <xmx:E9fbXB5rLkY5YhKlE8JSgRqNgSDwtoWviUMDDS6UM_kNrDtIYRFbiQ>
 <xmx:E9fbXMHEWC3oc2unyDvSJsVOOO16s5StNp-bUos_MySsDuvlPtK1RA>
 <xmx:FNfbXA5U7c8WkVrzs-DrEv-MfDHDi9NwbMb_B6uBsxgtr_pM0CH8Eg>
Received: from eros.localdomain (ppp121-44-223-211.bras1.syd2.internode.on.net
 [121.44.223.211])
 by mail.messagingengine.com (Postfix) with ESMTPA id 1E8C81037C;
 Wed, 15 May 2019 05:08:32 -0400 (EDT)
From: "Tobin C. Harding" <tobin@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc: Remove double free
Date: Wed, 15 May 2019 19:07:50 +1000
Message-Id: <20190515090750.30647-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, "Tobin C. Harding" <tobin@kernel.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

kfree() after kobject_put().  Who ever wrote this was on crack.

Fixes: 7e8039795a80 ("powerpc/cacheinfo: Fix kobject memleak")
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---

FTR

git log --pretty=format:"%h%x09%an%x09%ad%x09%s" | grep 7e8039795a80
7e8039795a80	Tobin C. Harding	Tue Apr 30 11:09:23 2019 +1000	powerpc/cacheinfo: Fix kobject memleak

 arch/powerpc/kernel/cacheinfo.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
index f2ed3ef4b129..862e2890bd3d 100644
--- a/arch/powerpc/kernel/cacheinfo.c
+++ b/arch/powerpc/kernel/cacheinfo.c
@@ -767,7 +767,6 @@ static void cacheinfo_create_index_dir(struct cache *cache, int index,
 				  cache_dir->kobj, "index%d", index);
 	if (rc) {
 		kobject_put(&index_dir->kobj);
-		kfree(index_dir);
 		return;
 	}
 
-- 
2.21.0

