Return-Path: <SRS0=IY60=O4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD493C433EF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Oct 2021 16:59:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF99160F21
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Oct 2021 16:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CF99160F21
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HQvYy2QK7z3c6s
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Oct 2021 03:59:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HQvYP59CYz2yg4
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Oct 2021 03:59:19 +1100 (AEDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4HQvYJ1W05z9sSf;
 Fri,  8 Oct 2021 18:59:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7suNWJT6mezi; Fri,  8 Oct 2021 18:59:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4HQvYJ0N2gz9sST;
 Fri,  8 Oct 2021 18:59:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E46BB8B780;
 Fri,  8 Oct 2021 18:59:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id IiSHFEJI4zlE; Fri,  8 Oct 2021 18:59:15 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.75])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 996268B763;
 Fri,  8 Oct 2021 18:59:15 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 198Gwtpf1171169
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 8 Oct 2021 18:58:55 +0200
Received: (from chleroy@localhost)
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 198Gws7t1171165;
 Fri, 8 Oct 2021 18:58:54 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to
 christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Kees Cook <keescook@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] lkdtm: Fix content of section containing
 lkdtm_rodata_do_nothing()
Date: Fri,  8 Oct 2021 18:58:40 +0200
Message-Id: <8900731fbc05fb8b0de18af7133a8fc07c3c53a1.1633712176.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
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
Cc: Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers <ndesaulniers@google.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On a kernel without CONFIG_STRICT_KERNEL_RWX, running EXEC_RODATA
test leads to "Illegal instruction" failure.

Looking at the content of rodata_objcopy.o, we see that the
function content zeroes only:

	Disassembly of section .rodata:

	0000000000000000 <.lkdtm_rodata_do_nothing>:
	   0:	00 00 00 00 	.long 0x0

Add the contents flag in order to keep the content of the section
while renaming it.

	Disassembly of section .rodata:

	0000000000000000 <.lkdtm_rodata_do_nothing>:
	   0:	4e 80 00 20 	blr

Fixes: e9e08a07385e ("lkdtm: support llvm-objcopy")
Cc: stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/misc/lkdtm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index aa12097668d3..e2984ce51fe4 100644
--- a/drivers/misc/lkdtm/Makefile
+++ b/drivers/misc/lkdtm/Makefile
@@ -20,7 +20,7 @@ CFLAGS_REMOVE_rodata.o		+= $(CC_FLAGS_LTO)
 
 OBJCOPYFLAGS :=
 OBJCOPYFLAGS_rodata_objcopy.o	:= \
-			--rename-section .noinstr.text=.rodata,alloc,readonly,load
+			--rename-section .noinstr.text=.rodata,alloc,readonly,load,contents
 targets += rodata.o rodata_objcopy.o
 $(obj)/rodata_objcopy.o: $(obj)/rodata.o FORCE
 	$(call if_changed,objcopy)
-- 
2.31.1

