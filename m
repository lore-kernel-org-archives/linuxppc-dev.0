Return-Path: <RA8135@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7D7F12C0077
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 02:41:27 +1000 (EST)
Date: Tue, 25 Jun 2013 11:41:05 -0500
From: James Yang <James.Yang@freescale.com>
To: <benh@kernel.crashing.org>, <galak@kernel.crashing.org>, Scott Wood
 <scottwood@freescale.com>
Subject: [PATCH] Fix string emulation for 32-bit process on ppc64
Message-ID: <alpine.LRH.2.00.1306251133460.1506@ra8135-ec1.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

String instruction emulation would erroneously result in a segfault if
the upper bits of the EA are set and is so high that it fails access
check.  Truncate the EA to 32 bits if the process is 32-bit.

Signed-off-by: James Yang <James.Yang@freescale.com>
---
 arch/powerpc/kernel/traps.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index dce1bea..c72e7e9 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -840,6 +840,10 @@ static int emulate_string_inst(struct pt_regs *regs, u32 instword)
 		u8 val;
 		u32 shift = 8 * (3 - (pos & 0x3));
 
+		/* if process is 32-bit, clear upper 32 bits of EA */
+		if ((regs->msr & MSR_64BIT) == 0)
+			EA &= 0xFFFFFFFF;
+
 		switch ((instword & PPC_INST_STRING_MASK)) {
 			case PPC_INST_LSWX:
 			case PPC_INST_LSWI:
-- 
1.7.0.4
