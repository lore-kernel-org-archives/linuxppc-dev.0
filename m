Return-Path: <SRS0=HEEy=BV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A538FC433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2020 14:15:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C8E206C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2020 14:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kpGr4zXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C8E206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BQvxP4VL2zDqRD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2020 00:15:21 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BQvjP5RZXzDqKL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2020 00:04:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.a=rsa-sha256 header.s=201702 header.b=kpGr4zXq; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BQvjL1w4qz9sTW;
 Wed, 12 Aug 2020 00:04:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1597154694;
 bh=F39woJCZMBkygpxOek1ThAwjDi+p7mNCpABduvHY+/Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kpGr4zXqojSoiUiNx8PRmmspoGM8JN6V/rQ5W+dSOKvef/9bYarucQtUvFzWo+02p
 gwQwaAAE3e1woxO4S1Nf4aGEnoJjskI497gY83GVLqDyockyt9WF4rJLAijNWQTp0P
 RjaYex6ofLro1YT0Cbej1ispcL+6m5gAss0kDr6sN1WRJFzqkW5FhXf7UscHB815MR
 nu6ci6sGTfeF8Av6v94R+GAGIaSgN802Wtk7le0kn+LiEm+cvbPwJHa2gVxfOQMA7a
 xxwST52S5e0dgOOtRILAthwhyCzYJ16vf0H1h5fhvLUyVtofEzhJlJww/CHzdFV+Z7
 qobO1XMEo/Qpg==
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 1/7] powerpc: unrel_branch_check.sh: fix shellcheck complaints
Date: Wed, 12 Aug 2020 00:04:28 +1000
Message-Id: <20200811140435.20957-2-sfr@canb.auug.org.au>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200811140435.20957-1-sfr@canb.auug.org.au>
References: <20200811140435.20957-1-sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Linux PowerPC List <linuxppc-dev@lists.ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

No functional change

Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/tools/unrel_branch_check.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/tools/unrel_branch_check.sh b/arch/powerpc/tools/unrel_branch_check.sh
index 6e6a30aea3ed..4c1e04ba5081 100755
--- a/arch/powerpc/tools/unrel_branch_check.sh
+++ b/arch/powerpc/tools/unrel_branch_check.sh
@@ -1,3 +1,4 @@
+#!/bin/bash
 # Copyright © 2016 IBM Corporation
 #
 # This program is free software; you can redistribute it and/or
@@ -26,7 +27,7 @@ awk '{print $1}'
 
 BRANCHES=$(
 $objdump -R "$vmlinux" -D --start-address=0xc000000000000000           \
-		--stop-address=${end_intr} |
+		--stop-address="$end_intr" |
 grep -e "^c[0-9a-f]*:[[:space:]]*\([0-9a-f][0-9a-f][[:space:]]\)\{4\}[[:space:]]*b" |
 grep -v '\<__start_initialization_multiplatform>' |
 grep -v -e 'b.\?.\?ctr' |
@@ -40,12 +41,12 @@ awk '{ print $1 ":" $6 ":0x" $7 ":" $8 " "}'
 
 for tuple in $BRANCHES
 do
-	from=`echo $tuple | cut -d':' -f1`
-	branch=`echo $tuple | cut -d':' -f2`
-	to=`echo $tuple | cut -d':' -f3 | sed 's/cr[0-7],//'`
-	sym=`echo $tuple | cut -d':' -f4`
+	from=$(echo "$tuple" | cut -d':' -f1)
+	branch=$(echo "$tuple" | cut -d':' -f2)
+	to=$(echo "$tuple" | cut -d':' -f3 | sed 's/cr[0-7],//')
+	sym=$(echo "$tuple" | cut -d':' -f4)
 
-	if (( $to > $end_intr ))
+	if (( to > end_intr ))
 	then
 		if [ -z "$bad_branches" ]; then
 			echo "WARNING: Unrelocated relative branches"
-- 
2.28.0

