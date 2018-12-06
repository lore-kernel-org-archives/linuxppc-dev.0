Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428D3C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 05:12:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BF0A20838
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 05:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF0A20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439NyQ4R8tzDr7B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 16:12:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439Nw83BRtzDr5Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 16:10:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 439Nw816zVz9s7W; Thu,  6 Dec 2018 16:10:32 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 439Nw80MfHz9s7h; Thu,  6 Dec 2018 16:10:31 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/boot: Fix build failures with -j 1
Date: Thu,  6 Dec 2018 16:10:28 +1100
Message-Id: <20181206051028.8974-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.17.2
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
Cc: joel@jms.id.au, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In commit 5e9dcb6188a4 ("powerpc/boot: Expose Kconfig symbols to
wrapper") we added a dependency to serial.c on autoconf.h:

  $(obj)/serial.c: $(obj)/autoconf.h

This works when building in-tree (ie. with KBUILD_OUTPUT unset)
because the obj tree is the src tree.

But when building with eg. O=build and -j 1 the build fails:

  gcc ... -I../arch/powerpc/boot -c -o arch/powerpc/boot/serial.o arch/powerpc/boot/serial.c
  gcc: error: arch/powerpc/boot/serial.c: No such file or directory

Why this is only happening with -j 1 is not clear, when building with
-j greater than 1 somehow we decide to look for serial.c in the src
tree (../), eg:

  gcc -I../arch/powerpc/boot -c -o arch/powerpc/boot/serial.o ../arch/powerpc/boot/serial.c

Regardless we shouldn't be specifying a dependency on serial.c in the
build tree, we want to add a dependency to the version in $(srctree)
so fix the rule to say that.

Fixes: 5e9dcb6188a4 ("powerpc/boot: Expose Kconfig symbols to wrapper")
Tested-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/boot/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 39354365f54a..ed9883169190 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -197,7 +197,7 @@ $(addprefix $(obj)/,$(libfdt) $(libfdtheader)): $(obj)/%: $(srctree)/scripts/dtc
 $(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds : $(obj)/%: $(srctree)/$(src)/%.S
 	$(Q)cp $< $@
 
-$(obj)/serial.c: $(obj)/autoconf.h
+$(srctree)/$(src)/serial.c: $(obj)/autoconf.h
 
 $(obj)/autoconf.h: $(obj)/%: $(objtree)/include/generated/%
 	$(Q)cp $< $@
-- 
2.17.2

