Return-Path: <SRS0=HEEy=BV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E8CC433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2020 14:22:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A8B2076B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2020 14:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Grmr7jWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A8B2076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BQw5G51gMzDqLc
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2020 00:22:10 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BQvjV5f32zDqKL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2020 00:05:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.a=rsa-sha256 header.s=201702 header.b=Grmr7jWP; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BQvjS2l0qz9sVL;
 Wed, 12 Aug 2020 00:05:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1597154700;
 bh=JEiCaCfC550qhQNVVm4H2GKmV7e20tndGX+reW9DYDg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Grmr7jWPewoJ2wof6IdF8Wn2U4Lci+4zBbFGeW+dVdbMMEwtCRwJbKPgQMSCCLjEW
 2M+qkMcJVeJT+Q+2+II4K7+Dsn2+EjoumMF2ZXIIxVulY9LGB6YCPsCs6Gh2JNtA9B
 uz1YIDdO2/0S1+t0x/BgoR5IUtqPQA/vxOyb6CDbT5Rx26zzVLwec/AbMCtL8VttA9
 Tz6GST/JDnnbLO4zWhusFP6gcBlyUE0zmRr3Jfvbz2zk7MsyYVjmS80hipdyHMODTv
 Z/WCgKoFfae8P3iQn9UAUEvhL1k/ftoUrzB7bndXHzU2bxR3PVqItA+xDvhhGQna1l
 eF1pWJFzfhkng==
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 3/7] powerpc: unrel_branch_check.sh: simplify objdump's asm
 output
Date: Wed, 12 Aug 2020 00:04:30 +1000
Message-Id: <20200811140435.20957-4-sfr@canb.auug.org.au>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200811140435.20957-1-sfr@canb.auug.org.au>
References: <20200811140435.20957-1-sfr@canb.auug.org.au>
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
Cc: Linux PowerPC List <linuxppc-dev@lists.ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We don't use the raw hex instruction dump, so elide it and adjust the
following expressions.

Also use \s instead of [[:space:]] everywhere.

Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/tools/unrel_branch_check.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/tools/unrel_branch_check.sh b/arch/powerpc/tools/unrel_branch_check.sh
index d735e3875b5e..7e936e2cf70d 100755
--- a/arch/powerpc/tools/unrel_branch_check.sh
+++ b/arch/powerpc/tools/unrel_branch_check.sh
@@ -26,16 +26,16 @@ awk '$2 == "<__end_interrupts>:" { print $1 }'
 )
 
 BRANCHES=$(
-$objdump -R -D --start-address="$kstart" --stop-address="$end_intr" "$vmlinux" |
-grep -e "^c[0-9a-f]*:[[:space:]]*\([0-9a-f][0-9a-f][[:space:]]\)\{4\}[[:space:]]*b" |
+$objdump -R -D --no-show-raw-insn --start-address="$kstart" --stop-address="$end_intr" "$vmlinux" |
+grep -e "^c[0-9a-f]*:\s*b" |
 sed -e '/\<__start_initialization_multiplatform>/d' \
 	-e '/b.\?.\?ctr/d' \
 	-e '/b.\?.\?lr/d' \
-	-e 's/\bbt.\?[[:space:]]*[[:digit:]][[:digit:]]*,/beq/' \
-	-e 's/\bbf.\?[[:space:]]*[[:digit:]][[:digit:]]*,/bne/' \
-	-e 's/[[:space:]]0x/ /' \
+	-e 's/\bbt.\?\s*[[:digit:]][[:digit:]]*,/beq/' \
+	-e 's/\bbf.\?\s*[[:digit:]][[:digit:]]*,/bne/' \
+	-e 's/\s0x/ /' \
 	-e 's/://' |
-awk '{ print $1 ":" $6 ":0x" $7 ":" $8 " "}'
+awk '{ print $1 ":" $2 ":0x" $3 ":" $4 " "}'
 )
 
 for tuple in $BRANCHES; do
-- 
2.28.0

