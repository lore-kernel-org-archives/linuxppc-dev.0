Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D06C8B6FA6
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Aug 2011 04:07:08 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: <greg@kroah.com>, <sfr@canb.auug.org.au>, <linux-next@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] [v2] tty/powerpc: fix build break with ehv_bytechan.c on
	allyesconfig
Date: Thu, 25 Aug 2011 13:06:57 -0500
Message-ID: <1314295617-2953-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ePAPR hypervisor byte channel driver is supposed to work on all
ePAPR-compliant embedded PowerPC systems, but it had a reference to the MSR_GS
bit, which is available only on Book-E systems.

Also fix a couple integer-to-pointer typecast problems.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/tty/ehv_bytechan.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/ehv_bytechan.c b/drivers/tty/ehv_bytechan.c
index e67f70b..f733718 100644
--- a/drivers/tty/ehv_bytechan.c
+++ b/drivers/tty/ehv_bytechan.c
@@ -226,10 +226,6 @@ void __init udbg_init_ehv_bc(void)
 	unsigned int rx_count, tx_count;
 	unsigned int ret;
 
-	/* Check if we're running as a guest of a hypervisor */
-	if (!(mfmsr() & MSR_GS))
-		return;
-
 	/* Verify the byte channel handle */
 	ret = ev_byte_channel_poll(CONFIG_PPC_EARLY_DEBUG_EHV_BC_HANDLE,
 				   &rx_count, &tx_count);
@@ -286,7 +282,7 @@ static int ehv_bc_console_byte_channel_send(unsigned int handle, const char *s,
 static void ehv_bc_console_write(struct console *co, const char *s,
 				 unsigned int count)
 {
-	unsigned int handle = (unsigned int)co->data;
+	unsigned int handle = (uintptr_t)co->data;
 	char s2[EV_BYTE_CHANNEL_MAX_BYTES];
 	unsigned int i, j = 0;
 	char c;
@@ -352,7 +348,7 @@ static int __init ehv_bc_console_init(void)
 			   CONFIG_PPC_EARLY_DEBUG_EHV_BC_HANDLE);
 #endif
 
-	ehv_bc_console.data = (void *)stdout_bc;
+	ehv_bc_console.data = (void *)(uintptr_t)stdout_bc;
 
 	/* add_preferred_console() must be called before register_console(),
 	   otherwise it won't work.  However, we don't want to enumerate all the
-- 
1.7.3.4
