Return-Path: <tripeaks@gmail.com>
Received: from mail-pz0-f42.google.com (mail-pz0-f42.google.com
 [209.85.210.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 78485B6FBA
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2012 16:28:17 +1000 (EST)
Received: by dalf4 with SMTP id f4so8159051dal.15
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2012 23:28:15 -0700 (PDT)
Sender: Yuasa Yoichi <tripeaks@gmail.com>
Date: Wed, 20 Jun 2012 15:27:59 +0900
From: Yoichi Yuasa <yuasa@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Paul Mundt <lethal@linux-sh.org>
Subject: [PATCH] MIPS: fix bug.h MIPS build regression
Message-Id: <20120620152759.2caceb8c.yuasa@linux-mips.org>
In-Reply-To: <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com>
References: <1339962373-3224-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Chris Zankel <chris@zankel.net>, Linux-sh list <linux-sh@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>, yuasa@linux-mips.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit: 3777808873b0c49c5cf27e44c948dfb02675d578 breaks all MIPS builds.

  CC      arch/mips/kernel/machine_kexec.o
In file included from include/linux/kernel.h:20:0,
                 from include/asm-generic/bug.h:35,
                 from /home/yuasa/src/linux/kernel/git/linux-2.6/arch/mips/include/asm/bug.h:41,
                 from /home/yuasa/src/linux/kernel/git/linux-2.6/arch/mips/include/asm/bitops.h:20,
                 from include/linux/bitops.h:22,
                 from include/linux/signal.h:38,
                 from include/linux/elfcore.h:5,
                 from include/linux/kexec.h:60,
                 from arch/mips/kernel/machine_kexec.c:9:
include/linux/log2.h: In function '__ilog2_u32':
include/linux/log2.h:34:2: error: implicit declaration of function 'fls' [-Werror=implicit-function-declaration]
include/linux/log2.h: In function '__ilog2_u64':
include/linux/log2.h:42:2: error: implicit declaration of function 'fls64' [-Werror=implicit-function-declaration]
include/linux/log2.h: In function '__roundup_pow_of_two':
include/linux/log2.h:63:2: error: implicit declaration of function 'fls_long' [-Werror=implicit-function-declaration]
In file included from include/linux/bitops.h:22:0,
                 from include/linux/signal.h:38,
                 from include/linux/elfcore.h:5,
                 from include/linux/kexec.h:60,
                 from arch/mips/kernel/machine_kexec.c:9:
/home/yuasa/src/linux/kernel/git/linux-2.6/arch/mips/include/asm/bitops.h: At top level:
/home/yuasa/src/linux/kernel/git/linux-2.6/arch/mips/include/asm/bitops.h:615:19: error: static declaration of 'fls' follows non-static declaration
include/linux/log2.h:34:9: note: previous implicit declaration of 'fls' was here
In file included from /home/yuasa/src/linux/kernel/git/linux-2.6/arch/mips/include/asm/bitops.h:651:0,
                 from include/linux/bitops.h:22,
                 from include/linux/signal.h:38,
                 from include/linux/elfcore.h:5,
                 from include/linux/kexec.h:60,
                 from arch/mips/kernel/machine_kexec.c:9:
include/asm-generic/bitops/fls64.h:18:28: error: static declaration of 'fls64' follows non-static declaration
include/linux/log2.h:42:9: note: previous implicit declaration of 'fls64' was here
In file included from include/linux/signal.h:38:0,
                 from include/linux/elfcore.h:5,
                 from include/linux/kexec.h:60,
                 from arch/mips/kernel/machine_kexec.c:9:
include/linux/bitops.h:160:24: error: conflicting types for 'fls_long'
include/linux/log2.h:63:16: note: previous implicit declaration of 'fls_long' was here
cc1: all warnings being treated as errors

make[2]: *** [arch/mips/kernel/machine_kexec.o] Error 1

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/include/asm/bitops.h |    1 -
 arch/mips/include/asm/io.h     |    1 +
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index 2e1ad4c..82ad35c 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -17,7 +17,6 @@
 #include <linux/irqflags.h>
 #include <linux/types.h>
 #include <asm/barrier.h>
-#include <asm/bug.h>
 #include <asm/byteorder.h>		/* sigh ... */
 #include <asm/cpu-features.h>
 #include <asm/sgidefs.h>
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 37a8379..100f9a3 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -17,6 +17,7 @@
 #include <linux/types.h>
 
 #include <asm/addrspace.h>
+#include <asm/bug.h>
 #include <asm/byteorder.h>
 #include <asm/cpu.h>
 #include <asm/cpu-features.h>
-- 
1.7.0.4
