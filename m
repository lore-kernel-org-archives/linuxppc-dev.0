Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 9B547B7BDF
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Oct 2009 19:25:23 +1000 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 1B9831C1545C
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Oct 2009 11:25:21 +0200 (CEST)
Received: from whitebox.home (DSL01.83.171.164.227.ip-pool.NEFkom.net
	[83.171.164.227])
	by mail.mnet-online.de (Postfix) with ESMTP id 8225F90193
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Oct 2009 11:25:21 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: fix segment mapping in vdso32
Date: Sat, 03 Oct 2009 11:25:31 +0200
Message-ID: <m2bpkoomlw.fsf@whitebox.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Due to missing segment assignments the .text section was put in the NOTES
segment (and marked as NOTE section), and the .got was put in the DYNAMIC
segment.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 arch/powerpc/kernel/vdso32/vdso32.lds.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/vdso32/vdso32.lds.S b/arch/powerpc/kernel/vdso32/vdso32.lds.S
index 904ef13..0546bcd 100644
--- a/arch/powerpc/kernel/vdso32/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso32/vdso32.lds.S
@@ -25,7 +25,7 @@ SECTIONS
 	. = ALIGN(16);
 	.text		: {
 		*(.text .stub .text.* .gnu.linkonce.t.* __ftr_alt_*)
-	}
+	}		      	      			:text
 	PROVIDE(__etext = .);
 	PROVIDE(_etext = .);
 	PROVIDE(etext = .);
@@ -56,7 +56,7 @@ SECTIONS
 	.fixup		: { *(.fixup) }
 
 	.dynamic	: { *(.dynamic) }		:text	:dynamic
-	.got		: { *(.got) }
+	.got		: { *(.got) }			:text
 	.plt		: { *(.plt) }
 
 	_end = .;
-- 
1.6.4.4

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
