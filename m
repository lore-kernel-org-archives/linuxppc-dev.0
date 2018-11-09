Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B42C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 19:54:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B58420825
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 19:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B58420825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42s9ny3p3MzDsFc
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 06:53:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=angband.pl
 (client-ip=2001:41d0:602:dbe::8; helo=tartarus.angband.pl;
 envelope-from=kilobyte@angband.pl; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=angband.pl
Received: from tartarus.angband.pl (tartarus.angband.pl
 [IPv6:2001:41d0:602:dbe::8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42s9230xlhzF3Xt
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Nov 2018 06:19:20 +1100 (AEDT)
Received: from 89-64-163-218.dynamic.chello.pl ([89.64.163.218]
 helo=barad-dur.angband.pl)
 by tartarus.angband.pl with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <kilobyte@angband.pl>)
 id 1gLC3v-000537-7L; Fri, 09 Nov 2018 20:03:24 +0100
Received: from kholdan.angband.pl ([2001:470:64f4::5])
 by barad-dur.angband.pl with smtp (Exim 4.89)
 (envelope-from <kilobyte@angband.pl>)
 id 1gLC3t-00059y-MG; Fri, 09 Nov 2018 20:03:22 +0100
Received: by kholdan.angband.pl (sSMTP sendmail emulation);
 Fri, 09 Nov 2018 20:03:21 +0100
From: Adam Borowski <kilobyte@angband.pl>
To: linux-kernel@vger.kernel.org, Nick Terrell <terrelln@fb.com>,
 Russell King <linux@armlinux.org.uk>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
 Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 linux-sh@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org
Date: Fri,  9 Nov 2018 20:02:54 +0100
Message-Id: <20181109190304.8573-7-kilobyte@angband.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181109190304.8573-1-kilobyte@angband.pl>
References: <20181109185953.xwyelyqnygbskkxk@angband.pl>
 <20181109190304.8573-1-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 89.64.163.218
X-SA-Exim-Mail-From: kilobyte@angband.pl
Subject: [PATCH 07/17] s390: Remove support for BZIP2 and LZMA compressed
 kernel
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
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
Cc: Adam Borowski <kilobyte@angband.pl>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Made redundant by newer choices.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 arch/s390/Kconfig                        | 2 --
 arch/s390/boot/compressed/Makefile       | 8 +-------
 arch/s390/boot/compressed/decompressor.c | 8 --------
 3 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 5173366af8f3..96adb6127246 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -150,10 +150,8 @@ config S390
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_GCC_PLUGINS
-	select HAVE_KERNEL_BZIP2
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZ4
-	select HAVE_KERNEL_LZMA
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_UNCOMPRESSED
 	select HAVE_KERNEL_XZ
diff --git a/arch/s390/boot/compressed/Makefile b/arch/s390/boot/compressed/Makefile
index 593039620487..ddd9d44fb7a8 100644
--- a/arch/s390/boot/compressed/Makefile
+++ b/arch/s390/boot/compressed/Makefile
@@ -11,7 +11,7 @@ UBSAN_SANITIZE := n
 KASAN_SANITIZE := n
 
 obj-y	:= $(if $(CONFIG_KERNEL_UNCOMPRESSED),,decompressor.o) piggy.o info.o
-targets	:= vmlinux.lds vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2
+targets	:= vmlinux.lds vmlinux vmlinux.bin vmlinux.bin.gz
 targets += vmlinux.bin.xz vmlinux.bin.lzma vmlinux.bin.lzo vmlinux.bin.lz4
 targets += info.bin $(obj-y)
 
@@ -40,20 +40,14 @@ $(obj)/vmlinux.bin: vmlinux FORCE
 vmlinux.bin.all-y := $(obj)/vmlinux.bin
 
 suffix-$(CONFIG_KERNEL_GZIP)  := .gz
-suffix-$(CONFIG_KERNEL_BZIP2) := .bz2
 suffix-$(CONFIG_KERNEL_LZ4)  := .lz4
-suffix-$(CONFIG_KERNEL_LZMA)  := .lzma
 suffix-$(CONFIG_KERNEL_LZO)  := .lzo
 suffix-$(CONFIG_KERNEL_XZ)  := .xz
 
 $(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y)
 	$(call if_changed,gzip)
-$(obj)/vmlinux.bin.bz2: $(vmlinux.bin.all-y)
-	$(call if_changed,bzip2)
 $(obj)/vmlinux.bin.lz4: $(vmlinux.bin.all-y)
 	$(call if_changed,lz4)
-$(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y)
-	$(call if_changed,lzma)
 $(obj)/vmlinux.bin.lzo: $(vmlinux.bin.all-y)
 	$(call if_changed,lzo)
 $(obj)/vmlinux.bin.xz: $(vmlinux.bin.all-y)
diff --git a/arch/s390/boot/compressed/decompressor.c b/arch/s390/boot/compressed/decompressor.c
index 45046630c56a..3995a6fe60f5 100644
--- a/arch/s390/boot/compressed/decompressor.c
+++ b/arch/s390/boot/compressed/decompressor.c
@@ -42,18 +42,10 @@ static unsigned long free_mem_end_ptr = (unsigned long) _end + HEAP_SIZE;
 #include "../../../../lib/decompress_inflate.c"
 #endif
 
-#ifdef CONFIG_KERNEL_BZIP2
-#include "../../../../lib/decompress_bunzip2.c"
-#endif
-
 #ifdef CONFIG_KERNEL_LZ4
 #include "../../../../lib/decompress_unlz4.c"
 #endif
 
-#ifdef CONFIG_KERNEL_LZMA
-#include "../../../../lib/decompress_unlzma.c"
-#endif
-
 #ifdef CONFIG_KERNEL_LZO
 #include "../../../../lib/decompress_unlzo.c"
 #endif
-- 
2.19.1

