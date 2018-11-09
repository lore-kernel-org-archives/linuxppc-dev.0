Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD28C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 19:58:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5821920825
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 19:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5821920825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42s9tj6L2wzDqwm
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 06:58:05 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42s92F3fSwzF3Xt
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Nov 2018 06:19:32 +1100 (AEDT)
Received: from 89-64-163-218.dynamic.chello.pl ([89.64.163.218]
 helo=barad-dur.angband.pl)
 by tartarus.angband.pl with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <kilobyte@angband.pl>)
 id 1gLC47-00058o-Kd; Fri, 09 Nov 2018 20:03:37 +0100
Received: from kholdan.angband.pl ([2001:470:64f4::5])
 by barad-dur.angband.pl with smtp (Exim 4.89)
 (envelope-from <kilobyte@angband.pl>)
 id 1gLC46-0005AP-2u; Fri, 09 Nov 2018 20:03:35 +0100
Received: by kholdan.angband.pl (sSMTP sendmail emulation);
 Fri, 09 Nov 2018 20:03:34 +0100
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
Date: Fri,  9 Nov 2018 20:03:03 +0100
Message-Id: <20181109190304.8573-16-kilobyte@angband.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181109190304.8573-1-kilobyte@angband.pl>
References: <20181109185953.xwyelyqnygbskkxk@angband.pl>
 <20181109190304.8573-1-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 89.64.163.218
X-SA-Exim-Mail-From: kilobyte@angband.pl
Subject: [PATCH 16/17] Kconfig: Update the prose for selection of compression
 algorithm
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

It was really obsolete, and some entries contradicted each other.

Let's not recommend ZSTD for kernel compression yet as it's available
only on x86, and some distros might not have the tool installed.
Proposing ZSTD for initrd is safer but let's test it first.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 init/Kconfig | 25 +++++++++++++------------
 usr/Kconfig  | 24 +++++++++++-------------
 2 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 412ba93673fa..7c0180c41a3c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -153,26 +153,27 @@ choice
 	  version of this functionality (bzip2 only), for 2.4, was
 	  supplied by Christian Ludwig)
 
-	  High compression options are mostly useful for users, who
-	  are low on disk space (embedded systems), but for whom ram
-	  size matters less.
+	  High compression options tend to be more useful in most cases,
+	  as bootloaders are often egregiously slow to read the kernel
+	  from the disk/SD card/network/etc, overcoming any boot time
+	  savings you would get from faster decompression.
 
-	  If in doubt, select 'gzip'
+	  If in doubt, select 'xz'
 
 config KERNEL_GZIP
 	bool "Gzip"
 	depends on HAVE_KERNEL_GZIP
 	help
-	  The old and tried gzip compression. It provides a good balance
-	  between compression ratio and decompression speed.
+	  The old and tried gzip compression. You generally want it if
+	  some tool you use doesn't support more modern compressors.
 
 config KERNEL_LZMA
 	bool "LZMA"
 	depends on HAVE_KERNEL_LZMA
 	help
-	  This compression algorithm's ratio is best.  Decompression speed
-	  is between gzip and bzip2.  Compression is slowest.
-	  The kernel size is about 33% smaller with LZMA in comparison to gzip.
+	  An old version of xz, like it providing strong compression at slow
+	  speed. It lacks a header and support for filters or uncompressed
+	  blocks, thus it's usually better to pick xz.
 
 config KERNEL_XZ
 	bool "XZ"
@@ -193,9 +194,9 @@ config KERNEL_LZO
 	bool "LZO"
 	depends on HAVE_KERNEL_LZO
 	help
-	  Its compression ratio is the poorest among the choices. The kernel
-	  size is about 10% bigger than gzip; however its speed
-	  (both compression and decompression) is the fastest.
+	  Its compression ratio is pretty poor (but still better than
+	  LZ4). You want to pick ZSTD (similar speed but much better
+	  compression) or LZ4 (much better speed) instead.
 
 config KERNEL_LZ4
 	bool "LZ4"
diff --git a/usr/Kconfig b/usr/Kconfig
index 8d99edacabc9..f6e871585f05 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -131,17 +131,15 @@ config INITRAMFS_COMPRESSION_NONE
 	  on those architectures that support this. However, not compressing the
 	  initramfs may lead to slightly higher memory consumption during a
 	  short time at boot, while both the cpio image and the unpacked
-	  filesystem image will be present in memory simultaneously
+	  filesystem image will be present in memory simultaneously.
 
 config INITRAMFS_COMPRESSION_GZIP
 	bool "Gzip"
 	depends on RD_GZIP
 	help
-	  Use the old and well tested gzip compression algorithm. Gzip provides
-	  a good balance between compression ratio and decompression speed and
-	  has a reasonable compression speed. It is also more likely to be
-	  supported by your build system as the gzip tool is present by default
-	  on most distros.
+	  Use the old and well tested gzip compression algorithm. Gzip doesn't
+	  provide very good compression nor speed, but it's the safest choice,
+	  with wide support.
 
 config INITRAMFS_COMPRESSION_XZ
 	bool "XZ"
@@ -150,20 +148,20 @@ config INITRAMFS_COMPRESSION_XZ
 	  XZ uses the LZMA2 algorithm and has a large dictionary which may cause
 	  problems on memory constrained systems. The initramfs size is about
 	  30% smaller with XZ in comparison to gzip. Decompression speed is
-	  better than that of bzip2 but worse than gzip and LZO. Compression is
-	  slow.
+	  okayish but still slowest of all currently available algorithms.
+	  Compression is slow.
 
-	  If you choose this, keep in mind that you may need to install the xz
-	  tool to be able to compress the initram.
+	  Any modern distro provides xz in its default install, but on
+	  minimal build systems you might need to install xz-utils to be
+	  able to compress the initram.
 
 config INITRAMFS_COMPRESSION_LZO
 	bool "LZO"
 	depends on RD_LZO
 	help
 	  It's compression ratio is the second poorest amongst the choices. The
-	  kernel size is about 10% bigger than gzip. Despite that, it's
-	  decompression speed is the second fastest and it's compression speed
-	  is quite fast too.
+	  kernel size is about 10% bigger than gzip. Pick ZSTD instead, or LZ4
+	  if speed is paramount.
 
 	  If you choose this, keep in mind that you may need to install the lzop
 	  tool to be able to compress the initram.
-- 
2.19.1

