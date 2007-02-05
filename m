Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 674ECDDEE6
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 06:51:59 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l15Jpv8X014381
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 12:51:57 -0700 (MST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Update udbg_progress() to display the integer
Date: Mon,  5 Feb 2007 13:51:55 -0600
Message-Id: <11707051151024-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Although udbg_progress() takes a string and a short as parameters, only
the string is displayed.  This patch also displays the integer, if it's not
equal to 0xFFFF.  This gives callers the option to display only the string.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/kernel/udbg.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index 5730906..c474961 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -121,6 +121,11 @@ void udbg_printf(const char *fmt, ...)
 void __init udbg_progress(char *s, unsigned short hex)
 {
 	udbg_puts(s);
+	if (hex != 0xffff) {
+		char buf[8];
+		sprintf(buf, " : %04X", hex);
+		udbg_puts(buf);
+	}
 	udbg_puts("\n");
 }
 
-- 
1.4.4
