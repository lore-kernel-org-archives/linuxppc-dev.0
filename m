Return-Path: <SRS0=3mqf=PO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F190FC433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Oct 2021 13:46:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B7860EB4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Oct 2021 13:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 27B7860EB4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HdtQL5hN8z3bbv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Oct 2021 00:46:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HdtPq4193z2yLJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Oct 2021 00:45:48 +1100 (AEDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4HdtPj2vm6z9s33;
 Tue, 26 Oct 2021 15:45:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OIkVzqmB5DZX; Tue, 26 Oct 2021 15:45:45 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by pegase1.c-s.fr (Postfix) with ESMTPS id 4HdtPj1Brcz9s2p;
 Tue, 26 Oct 2021 15:45:45 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19QDjisC008082
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 26 Oct 2021 15:45:44 +0200
Received: (from chleroy@localhost)
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19QDjGSL008051;
 Tue, 26 Oct 2021 15:45:16 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to
 christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2] powerpc/boot: Set LANG=C in wrapper script
Date: Tue, 26 Oct 2021 15:45:15 +0200
Message-Id: <3e19eba55da250b6cdb4753b6eb0a1fbc44365e6.1635255903.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1635255914; l=2415; s=20211009;
 h=from:subject:message-id; bh=KCIcUl2jQvofbybmMV+kTeemiMBLMWNPIfXhCCAegRg=;
 b=0WJty1Wmf+LkGiOF2a/cnffT6sfLzHFArT7vpI9/NSOzN20U720vJMb5V02TrCDWGN9qvKKQXtJV
 GHtdvNibDpiHQ0REp1tySTR9aCCIbkfs5AmeJCfEikbeSbmCjTqa
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

While trying to build a simple Image for ACADIA platform, I got the
following error:

	  WRAP    arch/powerpc/boot/simpleImage.acadia
	INFO: Uncompressed kernel (size 0x6ae7d0) overlaps the address of the wrapper(0x400000)
	INFO: Fixing the link_address of wrapper to (0x700000)
	powerpc64-linux-gnu-ld : mode d'émulation non reconnu : -T
	Émulations prises en charge : elf64ppc elf32ppc elf32ppclinux elf32ppcsim elf64lppc elf32lppc elf32lppclinux elf32lppcsim
	make[1]: *** [arch/powerpc/boot/Makefile:424 : arch/powerpc/boot/simpleImage.acadia] Erreur 1
	make: *** [arch/powerpc/Makefile:285 : simpleImage.acadia] Erreur 2

Trying again with V=1 shows the following command

	powerpc64-linux-gnu-ld -m -T arch/powerpc/boot/zImage.lds -Ttext 0x700000 --no-dynamic-linker -o arch/powerpc/boot/simpleImage.acadia -Map wrapper.map arch/powerpc/boot/fixed-head.o arch/powerpc/boot/simpleboot.o ./zImage.3278022.o arch/powerpc/boot/wrapper.a

The argument of '-m' is missing.

This is due to the wrapper script calling 'objdump -p vmlinux' and
looking for 'file format', whereas the output of objdump is:

	vmlinux:     format de fichier elf32-powerpc

	En-tête de programme:
	    LOAD off    0x00010000 vaddr 0xc0000000 paddr 0x00000000 align 2**16
	         filesz 0x0069e1d4 memsz 0x006c128c flags rwx
	    NOTE off    0x0064591c vaddr 0xc063591c paddr 0x0063591c align 2**2
	         filesz 0x00000054 memsz 0x00000054 flags ---

Add LC_ALL=C at the beginning of the wrapper script in order to get the
output expected by the script:

	vmlinux:     file format elf32-powerpc

	Program Header:
	    LOAD off    0x00010000 vaddr 0xc0000000 paddr 0x00000000 align 2**16
	         filesz 0x0069e1d4 memsz 0x006c128c flags rwx
	    NOTE off    0x0064591c vaddr 0xc063591c paddr 0x0063591c align 2**2
	         filesz 0x00000054 memsz 0x00000054 flags ---

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Use LC_ALL=C per Segher
---
 arch/powerpc/boot/wrapper | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 1cd82564c996..9184eda780fd 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -26,6 +26,8 @@
 # Stop execution if any command fails
 set -e
 
+export LC_ALL=C
+
 # Allow for verbose output
 if [ "$V" = 1 ]; then
     set -x
-- 
2.31.1

