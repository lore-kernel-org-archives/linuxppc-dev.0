Return-Path: <SRS0=qf4I=IN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8F7C433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Mar 2021 03:42:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6F4F64E64
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Mar 2021 03:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F4F64E64
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DzMgP0q2nz3cKK
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Mar 2021 14:42:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=b2xSk1jA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=b2xSk1jA; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DzMfz1ltJz30Gx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Mar 2021 14:42:02 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DzMfy30vrz9sVm; Mon, 15 Mar 2021 14:42:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1615779722;
 bh=xIfzvjYxdYj5kl+7E/yZx5Q+XM+XeDcoT7q8ah19n/0=;
 h=From:To:Cc:Subject:Date:From;
 b=b2xSk1jAVGoEoqXuxnd/KIxpFtszMlKa84QtgyJ6mni5r3D5t6Lw3qZkhdLMbwbJl
 dxDhJJHjnz4dukGcbEXmxFnRit3saY5gUTnMd8fdz8mrq/LWeVlICBB3EeEx67aqY5
 wSFv41JYqAdaaB1wu5AmAld8UBMIpEx55EAKDlET8iNG4G4IpW7Xji5/zblcsOM0CG
 3ShH8+BK+Rnq+yYroVDW9GPWFZnCV5aZhO5cJjtYc/GtExrk0uoeB0dFlkiEKbUtvx
 zZCjf8KYAw9eY9YuEAquXH5DMDggtRS6i7e0dljX0zeKMDh+reRzVst4+aaH/PmBh1
 7Fh4QgLta3t0g==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/kexec: Don't use .machine ppc64 in trampoline_64.S
Date: Mon, 15 Mar 2021 14:41:59 +1100
Message-Id: <20210315034159.315675-1-mpe@ellerman.id.au>
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
Cc: dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The ".machine" directive allows changing the machine for which code is
being generated. It's equivalent to passing an -mcpu option on the
command line.

Although it can be useful, it's generally a bad idea because it adds
another way to influence code generation separate from the flags
passed via the build system. ie. if we need to build different pieces
of code with different flags we should do that via our Makefiles, not
using ".machine".

However as best as I can tell the ".machine" directive in
trampoline_64.S is not necessary at all.

It was added in commit 0d97631392c2 ("powerpc: Add purgatory for
kexec_file_load() implementation."), which created the file based on
the kexec-tools purgatory. It may be/have-been necessary in the
kexec-tools version, but we have a completely different build system,
and we already pass the desired CPU flags, eg:

  gcc ... -m64 -Wl,-a64 -mabi=elfv2 -Wa,-maltivec -Wa,-mpower4 -Wa,-many
  ... arch/powerpc/purgatory/trampoline_64.S

So drop the ".machine" directive and rely on the assembler flags.

Reported-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/purgatory/trampoline_64.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/purgatory/trampoline_64.S b/arch/powerpc/purgatory/trampoline_64.S
index d956b8a35fd1..b35837c13852 100644
--- a/arch/powerpc/purgatory/trampoline_64.S
+++ b/arch/powerpc/purgatory/trampoline_64.S
@@ -12,7 +12,6 @@
 #include <asm/asm-compat.h>
 #include <asm/crashdump-ppc64.h>
 
-	.machine ppc64
 	.balign 256
 	.globl purgatory_start
 purgatory_start:
-- 
2.25.1

