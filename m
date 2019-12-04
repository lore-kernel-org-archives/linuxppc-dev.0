Return-Path: <SRS0=KnCP=Z2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23267C43603
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Dec 2019 11:23:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BBF520637
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Dec 2019 11:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="XpMSckWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BBF520637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47Sc1Q14NlzDqNx
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Dec 2019 22:23:54 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47Sbx41vkCzDqMW
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Dec 2019 22:20:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.b="XpMSckWm"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 47Sbx25hk3z9sPn; Wed,  4 Dec 2019 22:20:06 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 47Sbx23pcmz9sR1; Wed,  4 Dec 2019 22:20:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1575458406;
 bh=RMWRAZwwgQN245RNDHoLGpEfZTTGRpaWbqsOmoV4m10=;
 h=From:To:Cc:Subject:Date:From;
 b=XpMSckWmnEfztrCYf+YqL1t0UyDy/krGzoeqHHG+Ddx23tDjETbuUfZZHy86k3JgS
 WHmJ9rB4KlU0yEU2JZQcuX6ZU9Utb++aJxcQpN9oyoJ93a7SvWCymGfvNymrEPKJmO
 S96+frlpOpYV3PbHZM2JatODfk22JOqbsatqtRc2/Yc26lm2q/sTU7EgrtoZhXxGSY
 JRX15DlckcNWn7Qz2bKTG80vev8E9NHRwB9fTmFhSeqSjKjisPrIZnM6blXFfQgTud
 0xYHxvX5n8Cgc4rDYe8S8cBYgXzMyW9SMkoENVTvTvpCCUIxOsKo3BkiD1Yas0CDPQ
 BzrtQN0bhoFDQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] docs/core-api: Remove possibly confusing sub-headings from
 Bit Operations
Date: Wed,  4 Dec 2019 22:19:57 +1100
Message-Id: <20191204111957.4754-1-mpe@ellerman.id.au>
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
Cc: linuxppc-dev@ozlabs.org, elver@google.com, corbet@lwn.net,
 linux-doc@vger.kernel.org, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The recent commit 81d2c6f81996 ("kasan: support instrumented bitops
combined with generic bitops"), split the KASAN instrumented bitops
into separate headers for atomic, non-atomic and locking operations.

This was done to allow arches to include just the instrumented bitops
they need, while also using some of the generic bitops in
asm-generic/bitops (which are automatically instrumented). The generic
bitops are already split into atomic, non-atomic and locking headers.

This split required an update to kernel-api.rst because it included
include/asm-generic/bitops-instrumented.h, which no longer exists. So
now kernel-api.rst includes all three instrumented headers to get the
definitions for all the bitops.

When adding the three headers it seemed sensible to add sub-headings
for each, ie. "Atomic", "Non-atomic" and "Locking".

The confusion is that test_bit() is (and always has been) in
non-atomic.h, but is documented elsewhere (atomic_bitops.txt) as being
atomic. So having it appear under the "Non-atomic" heading is possibly
confusing.

Probably test_bit() should move from bitops/non-atomic.h to atomic.h,
but that has flow on effects. For now just remove the newly added
sub-headings in the documentation, so we at least aren't adding to the
confusion about whether test_bit() is atomic or not.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 Documentation/core-api/kernel-api.rst | 9 ---------
 1 file changed, 9 deletions(-)

Just FYI. I've applied this to my topic/kasan-bitops branch which I plan to ask
Linus to pull before the end of the merge window.

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/log/?h=topic/kasan-bitops

cheers

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index 2caaeb55e8dd..4ac53a1363f6 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -57,21 +57,12 @@ The Linux kernel provides more basic utility functions.
 Bit Operations
 --------------
 
-Atomic Operations
-~~~~~~~~~~~~~~~~~
-
 .. kernel-doc:: include/asm-generic/bitops/instrumented-atomic.h
    :internal:
 
-Non-atomic Operations
-~~~~~~~~~~~~~~~~~~~~~
-
 .. kernel-doc:: include/asm-generic/bitops/instrumented-non-atomic.h
    :internal:
 
-Locking Operations
-~~~~~~~~~~~~~~~~~~
-
 .. kernel-doc:: include/asm-generic/bitops/instrumented-lock.h
    :internal:
 
-- 
2.21.0

