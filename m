Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF23C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 19:51:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6B9C20825
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 19:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B9C20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42s9lH4378zDqVC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 06:51:39 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42s91v4mX2zF3Yx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Nov 2018 06:19:15 +1100 (AEDT)
Received: from 89-64-163-218.dynamic.chello.pl ([89.64.163.218]
 helo=barad-dur.angband.pl)
 by tartarus.angband.pl with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <kilobyte@angband.pl>)
 id 1gLC3r-000528-3q; Fri, 09 Nov 2018 20:03:20 +0100
Received: from kholdan.angband.pl ([2001:470:64f4::5])
 by barad-dur.angband.pl with smtp (Exim 4.89)
 (envelope-from <kilobyte@angband.pl>)
 id 1gLC3p-00059p-JZ; Fri, 09 Nov 2018 20:03:18 +0100
Received: by kholdan.angband.pl (sSMTP sendmail emulation);
 Fri, 09 Nov 2018 20:03:17 +0100
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
Date: Fri,  9 Nov 2018 20:02:51 +0100
Message-Id: <20181109190304.8573-4-kilobyte@angband.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181109190304.8573-1-kilobyte@angband.pl>
References: <20181109185953.xwyelyqnygbskkxk@angband.pl>
 <20181109190304.8573-1-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 89.64.163.218
X-SA-Exim-Mail-From: kilobyte@angband.pl
Subject: [PATCH 04/17] x86: Remove support for BZIP2 and LZMA compressed kernel
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

While bzip2 used to be good in its heyday, it's been drastically eclipsed
by newer algorithms.  In no case it's a rational choice anymore -- at any
point of the size-to-compression curve, there's something much better.
As we control the build process, any .configs that still select it will
harmlessly be adjusted, thus there's no risk of breakage.

Bare lzma is redundant with xz, lacks some improvements, and uses its own
copy of code instead using the common library.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 Documentation/x86/boot.txt        | 11 +++++------
 arch/x86/Kconfig                  |  2 --
 arch/x86/boot/compressed/Makefile | 12 +++---------
 arch/x86/boot/compressed/misc.c   |  8 --------
 arch/x86/include/asm/boot.h       |  4 +---
 5 files changed, 9 insertions(+), 28 deletions(-)

diff --git a/Documentation/x86/boot.txt b/Documentation/x86/boot.txt
index a47b6bae3356..fbd9720989e5 100644
--- a/Documentation/x86/boot.txt
+++ b/Documentation/x86/boot.txt
@@ -682,12 +682,11 @@ Protocol:	2.08+
   of the protected-mode code to the payload.
 
   The payload may be compressed. The format of both the compressed and
-  uncompressed data should be determined using the standard magic
-  numbers.  The currently supported compression formats are gzip
-  (magic numbers 1F 8B or 1F 9E), bzip2 (magic number 42 5A), LZMA
-  (magic number 5D 00), XZ (magic number FD 37), LZ4 (magic number
-  02 21) and ZSTD (magic number 28 B5). The uncompressed payload is
-  currently always ELF (magic number 7F 45 4C 46).
+  uncompressed data should be determined using the standard magic numbers.
+  The currently supported compression formats are gzip (magic numbers 1F 8B
+  or 1F 9E), XZ (magic number FD 37), LZ4 (magic number 02 21) and ZSTD
+  (magic number 28 B5). The uncompressed payload is currently always ELF
+  (magic number 7F 45 4C 46).
 
 Field name:	payload_length
 Type:		read
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 203f7467f5c4..a47af31bbc62 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -158,10 +158,8 @@ config X86
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK	if X86_64
 	select HAVE_IRQ_TIME_ACCOUNTING
-	select HAVE_KERNEL_BZIP2
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZ4
-	select HAVE_KERNEL_LZMA
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_XZ
 	select HAVE_KERNEL_ZSTD
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 6d2a8d2d378d..763aeb850658 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -7,13 +7,13 @@
 # vmlinuz is:
 #	decompression code (*.o)
 #	asm globals (piggy.S), including:
-#		vmlinux.bin.(gz|bz2|lzma|...)
+#		vmlinux.bin.(gz|zst|xz|...)
 #
 # vmlinux.bin is:
 #	vmlinux stripped of debugging and comments
 # vmlinux.bin.all is:
 #	vmlinux.bin + vmlinux.relocs
-# vmlinux.bin.(gz|bz2|lzma|...) is:
+# vmlinux.bin.(gz|zst|xz|...) is:
 #	(see scripts/Makefile.lib size_append)
 #	compressed vmlinux.bin.all + u32 size of vmlinux.bin.all
 
@@ -23,7 +23,7 @@ OBJECT_FILES_NON_STANDARD	:= y
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
 KCOV_INSTRUMENT		:= n
 
-targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
+targets := vmlinux vmlinux.bin vmlinux.bin.gz \
 	vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4 vmlinux.bin.zst
 
 KBUILD_CFLAGS := -m$(BITS) -O2
@@ -132,10 +132,6 @@ vmlinux.bin.all-$(CONFIG_X86_NEED_RELOCS) += $(obj)/vmlinux.relocs
 
 $(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,gzip)
-$(obj)/vmlinux.bin.bz2: $(vmlinux.bin.all-y) FORCE
-	$(call if_changed,bzip2)
-$(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y) FORCE
-	$(call if_changed,lzma)
 $(obj)/vmlinux.bin.xz: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,xzkern)
 $(obj)/vmlinux.bin.lzo: $(vmlinux.bin.all-y) FORCE
@@ -146,8 +142,6 @@ $(obj)/vmlinux.bin.zst: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,zstd)
 
 suffix-$(CONFIG_KERNEL_GZIP)	:= gz
-suffix-$(CONFIG_KERNEL_BZIP2)	:= bz2
-suffix-$(CONFIG_KERNEL_LZMA)	:= lzma
 suffix-$(CONFIG_KERNEL_XZ)	:= xz
 suffix-$(CONFIG_KERNEL_LZO) 	:= lzo
 suffix-$(CONFIG_KERNEL_LZ4) 	:= lz4
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index b6c8921100fb..c0d75b74f199 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -57,14 +57,6 @@ static int lines, cols;
 #include "../../../../lib/decompress_inflate.c"
 #endif
 
-#ifdef CONFIG_KERNEL_BZIP2
-#include "../../../../lib/decompress_bunzip2.c"
-#endif
-
-#ifdef CONFIG_KERNEL_LZMA
-#include "../../../../lib/decompress_unlzma.c"
-#endif
-
 #ifdef CONFIG_KERNEL_XZ
 #include "../../../../lib/decompress_unxz.c"
 #endif
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index d6dd43d25d9f..afbf3d60f22e 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -24,9 +24,7 @@
 # error "Invalid value for CONFIG_PHYSICAL_ALIGN"
 #endif
 
-#if defined(CONFIG_KERNEL_BZIP2)
-# define BOOT_HEAP_SIZE		0x400000
-#elif defined(CONFIG_KERNEL_ZSTD)
+#if defined(CONFIG_KERNEL_ZSTD)
 # define BOOT_HEAP_SIZE		 0x30000
 #else
 # define BOOT_HEAP_SIZE		 0x10000
-- 
2.19.1

