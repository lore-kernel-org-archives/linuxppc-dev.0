Return-Path: <vbordug@ru.mvista.com>
Received: from vitb.dev.rtsoft.ru (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 14183679E9
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 30 Apr 2006 04:32:50 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH] ppc32 CPM_UART: Fixed break send on SCC
Date: Sat, 29 Apr 2006 22:32:44 +0400
Message-Id: <20060429183244.8493.72175.stgit@vitb.ru.mvista.com>
Cc: david.jander@protonic.nl, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


SCC uart sends a break sequence each time it is stopped with the 
CPM_CR_STOP_TX command. That means that each time an application closes the 
serial device, a break is transmitted. To fix this, graceful tx stop is
issued for SCC.

Signed-off-by: David Jander <david.jander@protonic.nl>
Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 drivers/serial/cpm_uart/cpm_uart_core.c |    6 +++++-
 include/asm-ppc/commproc.h              |    1 +
 include/asm-ppc/cpm2.h                  |    2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index 2bdbcb3..969f949 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -473,7 +473,11 @@ static void cpm_uart_shutdown(struct uar
 		}
 
 		/* Shut them really down and reinit buffer descriptors */
-		cpm_line_cr_cmd(line, CPM_CR_STOP_TX);
+		if (IS_SMC(pinfo))
+			cpm_line_cr_cmd(line, CPM_CR_STOP_TX);
+		else
+			cpm_line_cr_cmd(line, CPM_CR_GRA_STOP_TX);
+
 		cpm_uart_initbd(pinfo);
 	}
 }
diff --git a/include/asm-ppc/commproc.h b/include/asm-ppc/commproc.h
index 973e609..31f3629 100644
--- a/include/asm-ppc/commproc.h
+++ b/include/asm-ppc/commproc.h
@@ -35,6 +35,7 @@
 #define CPM_CR_INIT_TX		((ushort)0x0002)
 #define CPM_CR_HUNT_MODE	((ushort)0x0003)
 #define CPM_CR_STOP_TX		((ushort)0x0004)
+#define CPM_CR_GRA_STOP_TX	((ushort)0x0005)
 #define CPM_CR_RESTART_TX	((ushort)0x0006)
 #define CPM_CR_CLOSE_RX_BD	((ushort)0x0007)
 #define CPM_CR_SET_GADDR	((ushort)0x0008)
diff --git a/include/asm-ppc/cpm2.h b/include/asm-ppc/cpm2.h
index b638b87..c70344b 100644
--- a/include/asm-ppc/cpm2.h
+++ b/include/asm-ppc/cpm2.h
@@ -69,7 +69,7 @@
 #define CPM_CR_INIT_TX		((ushort)0x0002)
 #define CPM_CR_HUNT_MODE	((ushort)0x0003)
 #define CPM_CR_STOP_TX		((ushort)0x0004)
-#define CPM_CR_GRA_STOP_TX      ((ushort)0x0005)
+#define CPM_CR_GRA_STOP_TX	((ushort)0x0005)
 #define CPM_CR_RESTART_TX	((ushort)0x0006)
 #define CPM_CR_SET_GADDR	((ushort)0x0008)
 #define CPM_CR_START_IDMA	((ushort)0x0009)
