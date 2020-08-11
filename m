Return-Path: <SRS0=HEEy=BV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F311C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2020 14:32:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98F9A204FD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2020 14:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FRFFB5+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F9A204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BQwKT0RvvzDqCK
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2020 00:32:45 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BQvjj5D7bzDqPW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2020 00:05:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.a=rsa-sha256 header.s=201702 header.b=FRFFB5+H; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BQvjf6Ncmz9sTq;
 Wed, 12 Aug 2020 00:05:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1597154711;
 bh=IWg9J4dzmIU629G1TFBY3rxGgkOp982GZz/P7rTZ6/4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FRFFB5+HkSbwW+C4hJBgR8dQnrx0LAa9pXRkAFx+T+m8clXSojPEV727BYjf+3AKz
 zo2OedWLIO45SPtrRp+KJwTOyOt0XYAOa0nnKiS0/wutooQBbSjlrvDeWGUmhrm8Rp
 pvRoxmL8bZju2wEVhHN4MpJzuGJikgjeFw150hxHEZ+vQX8XjoHw7bMk4lb/rspJTi
 /BfJIMByfuZEuqvd30HLc+ClCCETHJz23/HgAxgcggoLu67TzOI+iFXImmzJvT51uz
 4eNXdVvsnyfSDHluRdQij1kOQX8p/Z5RQbaSQOSHrBQyAHFpVfJ7o/5HiIaoub4Ejj
 q6A3ENvRMxNdg==
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 6/7] powerpc: unrel_branch_check.sh: fix up the file header
Date: Wed, 12 Aug 2020 00:04:33 +1000
Message-Id: <20200811140435.20957-7-sfr@canb.auug.org.au>
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

Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/tools/unrel_branch_check.sh | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/tools/unrel_branch_check.sh b/arch/powerpc/tools/unrel_branch_check.sh
index 54ebd05615d4..4489f16a443c 100755
--- a/arch/powerpc/tools/unrel_branch_check.sh
+++ b/arch/powerpc/tools/unrel_branch_check.sh
@@ -1,16 +1,9 @@
 #!/bin/bash
-# Copyright © 2016 IBM Corporation
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright © 2016,2020 IBM Corporation
 #
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License
-# as published by the Free Software Foundation; either version
-# 2 of the License, or (at your option) any later version.
-#
-# This script checks the relocations of a vmlinux for "suspicious"
-# branches from unrelocated code (head_64.S code).
-
-# Turn this on if you want more debug output:
-# set -x
+# This script checks the unrelocated code of a vmlinux for "suspicious"
+# branches to relocated code (head_64.S code).
 
 # Have Kbuild supply the path to objdump so we handle cross compilation.
 objdump="$1"
-- 
2.28.0

