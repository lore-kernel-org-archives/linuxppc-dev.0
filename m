Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3540CC433F5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Oct 2021 15:30:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D6E960F4B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Oct 2021 15:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5D6E960F4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HSjRB57bCz3ddC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Oct 2021 02:30:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HSjMv39yHz3c4X
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Oct 2021 02:27:23 +1100 (AEDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4HSjMB1FTVz9sTy;
 Mon, 11 Oct 2021 17:26:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AsxrHphiyLPy; Mon, 11 Oct 2021 17:26:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4HSjM30wYRz9sV1;
 Mon, 11 Oct 2021 17:26:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E420B8B775;
 Mon, 11 Oct 2021 17:26:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id FeFUPOjlFDO5; Mon, 11 Oct 2021 17:26:38 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.103])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 46F0F8B779;
 Mon, 11 Oct 2021 17:26:38 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19BFQWTu1585035
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 11 Oct 2021 17:26:32 +0200
Received: (from chleroy@localhost)
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19BFQWnt1585034;
 Mon, 11 Oct 2021 17:26:32 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to
 christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Morton <akpm@linux-foundation.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
 Kees Cook <keescook@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 08/10] lkdtm: Really write into kernel text in WRITE_KERN
Date: Mon, 11 Oct 2021 17:25:35 +0200
Message-Id: <624940395e5d81967246f911a65740b9a15b5a70.1633964380.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1633964380.git.christophe.leroy@csgroup.eu>
References: <cover.1633964380.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1633965929; l=1755; s=20211009;
 h=from:subject:message-id; bh=rbjcmdqW//k3GGJUaNfCP5ioRFNRJA1GdoGwljTgTIs=;
 b=VHxFrubt06zojvGrh4AyOrnUEfhxbTLmxNZmBOWwip5R264pE8YqB38E84FGVhXc4wANmW5UBtxz
 CVA20KJtC2xqR0+kY4IclmYKq96iNlIn+hUHQHurWpsTuS9/smte
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519;
 pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
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
Cc: linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

WRITE_KERN is supposed to overwrite some kernel text, namely
do_overwritten() function.

But at the time being it overwrites do_overwritten() function
descriptor, not function text.

Fix it by dereferencing the function descriptor to obtain
function text pointer.

And make do_overwritten() noinline so that it is really
do_overwritten() which is called by lkdtm_WRITE_KERN().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/misc/lkdtm/perms.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 60b3b2fe929d..442d60ed25ef 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -5,6 +5,7 @@
  * even non-readable regions.
  */
 #include "lkdtm.h"
+#include <linux/kallsyms.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/mman.h>
@@ -37,7 +38,7 @@ static noinline void do_nothing(void)
 }
 
 /* Must immediately follow do_nothing for size calculuations to work out. */
-static void do_overwritten(void)
+static noinline void do_overwritten(void)
 {
 	pr_info("do_overwritten wasn't overwritten!\n");
 	return;
@@ -113,8 +114,9 @@ void lkdtm_WRITE_KERN(void)
 	size_t size;
 	volatile unsigned char *ptr;
 
-	size = (unsigned long)do_overwritten - (unsigned long)do_nothing;
-	ptr = (unsigned char *)do_overwritten;
+	size = (unsigned long)dereference_symbol_descriptor(do_overwritten) -
+	       (unsigned long)dereference_symbol_descriptor(do_nothing);
+	ptr = dereference_symbol_descriptor(do_overwritten);
 
 	pr_info("attempting bad %zu byte write at %px\n", size, ptr);
 	memcpy((void *)ptr, (unsigned char *)do_nothing, size);
-- 
2.31.1

