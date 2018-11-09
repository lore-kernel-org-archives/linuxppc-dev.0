Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA73C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 19:40:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC8F920883
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 19:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8F920883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42s9VQ4v1BzF3g2
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 06:40:30 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42s91R5BYVzF3bP
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Nov 2018 06:18:51 +1100 (AEDT)
Received: from 89-64-163-218.dynamic.chello.pl ([89.64.163.218]
 helo=barad-dur.angband.pl)
 by tartarus.angband.pl with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <kilobyte@angband.pl>)
 id 1gLC3s-00052P-G0; Fri, 09 Nov 2018 20:03:22 +0100
Received: from kholdan.angband.pl ([2001:470:64f4::5])
 by barad-dur.angband.pl with smtp (Exim 4.89)
 (envelope-from <kilobyte@angband.pl>)
 id 1gLC3q-00059s-VN; Fri, 09 Nov 2018 20:03:20 +0100
Received: by kholdan.angband.pl (sSMTP sendmail emulation);
 Fri, 09 Nov 2018 20:03:18 +0100
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
Date: Fri,  9 Nov 2018 20:02:52 +0100
Message-Id: <20181109190304.8573-5-kilobyte@angband.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181109190304.8573-1-kilobyte@angband.pl>
References: <20181109185953.xwyelyqnygbskkxk@angband.pl>
 <20181109190304.8573-1-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 89.64.163.218
X-SA-Exim-Mail-From: kilobyte@angband.pl
Subject: [PATCH 05/17] mips: Remove support for BZIP2 and LZMA compressed
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
 arch/mips/Kconfig                      |  2 --
 arch/mips/boot/Makefile                | 27 --------------------------
 arch/mips/boot/compressed/Makefile     |  2 --
 arch/mips/boot/compressed/decompress.c |  8 --------
 4 files changed, 39 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8272ea4c7264..8f774bb9d22f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1834,9 +1834,7 @@ endif # CPU_LOONGSON2F
 config SYS_SUPPORTS_ZBOOT
 	bool
 	select HAVE_KERNEL_GZIP
-	select HAVE_KERNEL_BZIP2
 	select HAVE_KERNEL_LZ4
-	select HAVE_KERNEL_LZMA
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_XZ
 
diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index 35704c28a28b..9c5f380a6c20 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -24,9 +24,7 @@ strip-flags   := $(addprefix --remove-section=,$(drop-sections))
 hostprogs-y := elf2ecoff
 
 suffix-y			:= bin
-suffix-$(CONFIG_KERNEL_BZIP2)	:= bz2
 suffix-$(CONFIG_KERNEL_GZIP)	:= gz
-suffix-$(CONFIG_KERNEL_LZMA)	:= lzma
 suffix-$(CONFIG_KERNEL_LZO)	:= lzo
 
 targets := vmlinux.ecoff
@@ -54,20 +52,12 @@ UIMAGE_ENTRYADDR = $(VMLINUX_ENTRY_ADDRESS)
 # Compressed vmlinux images
 #
 
-extra-y += vmlinux.bin.bz2
 extra-y += vmlinux.bin.gz
-extra-y += vmlinux.bin.lzma
 extra-y += vmlinux.bin.lzo
 
-$(obj)/vmlinux.bin.bz2: $(obj)/vmlinux.bin FORCE
-	$(call if_changed,bzip2)
-
 $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,gzip)
 
-$(obj)/vmlinux.bin.lzma: $(obj)/vmlinux.bin FORCE
-	$(call if_changed,lzma)
-
 $(obj)/vmlinux.bin.lzo: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,lzo)
 
@@ -77,23 +67,15 @@ $(obj)/vmlinux.bin.lzo: $(obj)/vmlinux.bin FORCE
 
 targets += uImage
 targets += uImage.bin
-targets += uImage.bz2
 targets += uImage.gz
-targets += uImage.lzma
 targets += uImage.lzo
 
 $(obj)/uImage.bin: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,uimage,none)
 
-$(obj)/uImage.bz2: $(obj)/vmlinux.bin.bz2 FORCE
-	$(call if_changed,uimage,bzip2)
-
 $(obj)/uImage.gz: $(obj)/vmlinux.bin.gz FORCE
 	$(call if_changed,uimage,gzip)
 
-$(obj)/uImage.lzma: $(obj)/vmlinux.bin.lzma FORCE
-	$(call if_changed,uimage,lzma)
-
 $(obj)/uImage.lzo: $(obj)/vmlinux.bin.lzo FORCE
 	$(call if_changed,uimage,lzo)
 
@@ -122,7 +104,6 @@ $(obj)/vmlinux.its.S: $(addprefix $(srctree)/arch/mips/$(PLATFORM)/,$(ITS_INPUTS
 
 targets += vmlinux.its
 targets += vmlinux.gz.its
-targets += vmlinux.bz2.its
 targets += vmlinux.lzmo.its
 targets += vmlinux.lzo.its
 
@@ -142,19 +123,11 @@ $(obj)/vmlinux.its: $(obj)/vmlinux.its.S $(VMLINUX) FORCE
 $(obj)/vmlinux.gz.its: $(obj)/vmlinux.its.S $(VMLINUX) FORCE
 	$(call if_changed,cpp_its_S,gzip,vmlinux.bin.gz)
 
-$(obj)/vmlinux.bz2.its: $(obj)/vmlinux.its.S $(VMLINUX)  FORCE
-	$(call if_changed,cpp_its_S,bzip2,vmlinux.bin.bz2)
-
-$(obj)/vmlinux.lzma.its: $(obj)/vmlinux.its.S $(VMLINUX) FORCE
-	$(call if_changed,cpp_its_S,lzma,vmlinux.bin.lzma)
-
 $(obj)/vmlinux.lzo.its: $(obj)/vmlinux.its.S $(VMLINUX) FORCE
 	$(call if_changed,cpp_its_S,lzo,vmlinux.bin.lzo)
 
 targets += vmlinux.itb
 targets += vmlinux.gz.itb
-targets += vmlinux.bz2.itb
-targets += vmlinux.lzma.itb
 targets += vmlinux.lzo.itb
 
 quiet_cmd_itb-image = ITB     $@
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 3c453a1f1ff1..a7448d74fe7b 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -62,9 +62,7 @@ $(obj)/vmlinux.bin: $(KBUILD_IMAGE) FORCE
 	$(call if_changed,objcopy)
 
 tool_$(CONFIG_KERNEL_GZIP)    = gzip
-tool_$(CONFIG_KERNEL_BZIP2)   = bzip2
 tool_$(CONFIG_KERNEL_LZ4)     = lz4
-tool_$(CONFIG_KERNEL_LZMA)    = lzma
 tool_$(CONFIG_KERNEL_LZO)     = lzo
 tool_$(CONFIG_KERNEL_XZ)      = xzkern
 
diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
index 81df9047e110..ac6978d210e6 100644
--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -56,18 +56,10 @@ void error(char *x)
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

