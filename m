Return-Path: <laurent@vivier.eu>
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D35AD1A0CED
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 22:31:48 +1100 (AEDT)
From: Laurent Vivier <laurent@vivier.eu>
To: benh@kernel.crashing.org,
	paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] powerpc/boot: allow wrapper to work on non-english system
Date: Thu,  5 Nov 2015 12:31:34 +0100
Message-Id: <1446723094-9910-1-git-send-email-laurent@vivier.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

if the language is not english objdump output is not parsed correctly
and format is "". Later, "ld -m $format" fails.

This patch adds "LANG=C" to force english output for objdump.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 arch/powerpc/boot/wrapper | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 3f50c27..1c0b6ec 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -137,7 +137,7 @@ if [ -z "$kernel" ]; then
     kernel=vmlinux
 fi
 
-elfformat="`${CROSS}objdump -p "$kernel" | grep 'file format' | awk '{print $4}'`"
+LANG=C elfformat="`${CROSS}objdump -p "$kernel" | grep 'file format' | awk '{print $4}'`"
 case "$elfformat" in
     elf64-powerpcle)	format=elf64lppc	;;
     elf64-powerpc)	format=elf32ppc	;;
-- 
2.5.0
