Return-Path: <SRS0=ATRk=5T=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91606C43331
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2020 09:58:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A66220737
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2020 09:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ODsvDfXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A66220737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48twNt2NjpzDsQ7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2020 20:58:22 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48twM36TB5zDqRK
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2020 20:56:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=ODsvDfXe; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 48twM34zPfz9sRR; Fri,  3 Apr 2020 20:56:47 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 48twM343jwz9sRY; Fri,  3 Apr 2020 20:56:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1585907807;
 bh=jSumDj8z5w2tac0LMZyFHulyVULCJ+neaSAiJrWtBXY=;
 h=From:To:Cc:Subject:Date:From;
 b=ODsvDfXeePfQyZwXYLziTUdBC+xXvJ6qRLuRnp/A93v/pCvrz6ZjGoeQPTazfuqv5
 clp7bSdIjRwyg0sMaOyYNSzOTk2a3bpbrzGoseOcLId3aoG+Fkcf4YL6xCU2w6PEhB
 ybDS9viiGDYiNWqnRuWYUs29j3SAiVqf8cp59TEiTdZOs5rzZuP+o7F2w90x0Ki0zb
 1zCLNddG2wHHUgvGtYSRW3DqPTWzgKNsJ2ratoImMraHqS6JrxbpunvrBz5AGsM5L1
 P8SImUV3uPnjmRojndR8z2lJa3oHX1d6aciR9HyCdSHJf9mJpnQAnBdKQJHsN6m+pF
 88mx6zmrDdlkQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] selftests/powerpc: Always build the tm-poison test 64-bit
Date: Fri,  3 Apr 2020 20:56:56 +1100
Message-Id: <20200403095656.3772005-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
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
Cc: gromero@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The tm-poison test includes inline asm which is 64-bit only, so the
test must be built 64-bit in order to work.

Otherwise it fails, eg:
  # file tm-poison
  tm-poison: ELF 32-bit MSB executable, PowerPC or cisco 4500, version 1 (SYSV) ...
  # ./tm-poison
  test: tm_poison_test
  Unknown value 0x1fff71150 leaked into f31!
  Unknown value 0x1fff710c0 leaked into vr31!
  failure: tm_poison_test

Fixes: a003365cab64 ("powerpc/tm: Add tm-poison test")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/tm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index 0b0db8d3857c..5881e97c73c1 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -25,6 +25,7 @@ $(OUTPUT)/tm-unavailable: CFLAGS += -O0 -pthread -m64 -Wno-error=uninitialized -
 $(OUTPUT)/tm-trap: CFLAGS += -O0 -pthread -m64
 $(OUTPUT)/tm-signal-context-force-tm: CFLAGS += -pthread -m64
 $(OUTPUT)/tm-signal-pagefault: CFLAGS += -pthread -m64
+$(OUTPUT)/tm-poison: CFLAGS += -m64
 
 SIGNAL_CONTEXT_CHK_TESTS := $(patsubst %,$(OUTPUT)/%,$(SIGNAL_CONTEXT_CHK_TESTS))
 $(SIGNAL_CONTEXT_CHK_TESTS): tm-signal.S

base-commit: c17eb4dca5a353a9dbbb8ad6934fe57af7165e91
-- 
2.25.1

