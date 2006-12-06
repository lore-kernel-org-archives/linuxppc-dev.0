Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 6B23B67BFD
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 08:50:46 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	kB6LoiNT022945
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 14:50:44 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id kB6Lohg3022726
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 15:50:43 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	kB6LZ3XN002518
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 15:35:03 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 4584F4B924
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Dec 2006 15:50:42 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	kB6LogZ6013706
	for linuxppc-dev@ozlabs.org; Wed, 6 Dec 2006 15:50:42 -0600
Date: Wed, 6 Dec 2006 15:50:42 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH/RFC] Change the program check exception from EXC_XFER_STD to
	EXC_XFER_EE.
Message-ID: <20061206215042.GA13675@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch causes interrupts to be enabled in program_check_exception()
if they were enabled in the faulting context.  This is required because
do_mathemu() calls get_user(), which can sleep, and thus triggers an
assertion if called with interrupts disabled.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
Is there any reason why ProgramCheck needs to be EXC_XFER_STD?  Has
nobody ever used math emulation with CONFIG_DEBUG_SPINLOCK_SLEEP before?

 arch/powerpc/kernel/head_32.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 99507a8..4d58552 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -432,7 +432,7 @@ Alignment:
 	EXC_XFER_EE(0x600, alignment_exception)
 
 /* Program check exception */
-	EXCEPTION(0x700, ProgramCheck, program_check_exception, EXC_XFER_STD)
+	EXCEPTION(0x700, ProgramCheck, program_check_exception, EXC_XFER_EE)
 
 /* Floating-point unavailable */
 	. = 0x800
-- 
1.4.2.3
