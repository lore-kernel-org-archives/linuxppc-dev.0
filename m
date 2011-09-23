Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 654141007D3
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Sep 2011 11:33:24 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: <greg@kroah.com>, <linuxppc-dev@ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] [v2] drivers/tty: don't use the byte channel handle as a
	parameter in ehv_bytechan.c
Date: Thu, 22 Sep 2011 20:33:13 -0500
Message-ID: <1316741593-24262-1-git-send-email-timur@freescale.com>
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

The ePAPR hypervisor byte channel console driver only supports one byte
channel as a console, and the byte channel handle is stored in a global
variable.  It doesn't make any sense to pass that handle as a parameter
to the console functions, since these functions already have access to the
global variable.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/tty/ehv_bytechan.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/ehv_bytechan.c b/drivers/tty/ehv_bytechan.c
index f733718..1595dba 100644
--- a/drivers/tty/ehv_bytechan.c
+++ b/drivers/tty/ehv_bytechan.c
@@ -282,7 +282,6 @@ static int ehv_bc_console_byte_channel_send(unsigned int handle, const char *s,
 static void ehv_bc_console_write(struct console *co, const char *s,
 				 unsigned int count)
 {
-	unsigned int handle = (uintptr_t)co->data;
 	char s2[EV_BYTE_CHANNEL_MAX_BYTES];
 	unsigned int i, j = 0;
 	char c;
@@ -295,14 +294,14 @@ static void ehv_bc_console_write(struct console *co, const char *s,
 
 		s2[j++] = c;
 		if (j >= (EV_BYTE_CHANNEL_MAX_BYTES - 1)) {
-			if (ehv_bc_console_byte_channel_send(handle, s2, j))
+			if (ehv_bc_console_byte_channel_send(stdout_bc, s2, j))
 				return;
 			j = 0;
 		}
 	}
 
 	if (j)
-		ehv_bc_console_byte_channel_send(handle, s2, j);
+		ehv_bc_console_byte_channel_send(stdout_bc, s2, j);
 }
 
 /*
@@ -348,8 +347,6 @@ static int __init ehv_bc_console_init(void)
 			   CONFIG_PPC_EARLY_DEBUG_EHV_BC_HANDLE);
 #endif
 
-	ehv_bc_console.data = (void *)(uintptr_t)stdout_bc;
-
 	/* add_preferred_console() must be called before register_console(),
 	   otherwise it won't work.  However, we don't want to enumerate all the
 	   byte channels here, either, since we only care about one. */
-- 
1.7.4.4
