Message-ID: <3ECD5B84.9030807@mvista.com>
Date: Thu, 22 May 2003 16:21:40 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: linuxppc_2_4_devel patch for gt64260_eth
Content-Type: multipart/mixed;
 boundary="------------050900050008030805060602"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------050900050008030805060602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Minor patch to move macros that define the embedded ethernet & mpsc IRQ
values.

Mark
--

--------------050900050008030805060602
Content-Type: text/plain;
 name="gt_eth.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gt_eth.patch"

===== drivers/net/gt64260_eth.c 1.11 vs edited =====
--- 1.11/drivers/net/gt64260_eth.c	Tue Apr  1 12:43:14 2003
+++ edited/drivers/net/gt64260_eth.c	Tue May 13 15:42:47 2003
@@ -64,7 +64,8 @@

 #define BIT(n) (1<<(n))

-static unsigned char GT64260_ETH_irq[3] = { 32, 33, 34 };
+static unsigned char GT64260_ETH_irq[3] = {
+	GT64260_ETH_IRQ_0, GT64260_ETH_IRQ_1, GT64260_ETH_IRQ_2 };

 static const char *version = "gt64260_eth.c: v0.09";

===== include/asm-ppc/gt64260_defs.h 1.12 vs edited =====
--- 1.12/include/asm-ppc/gt64260_defs.h	Tue Apr  1 12:45:33 2003
+++ edited/include/asm-ppc/gt64260_defs.h	Tue May 13 15:39:36 2003
@@ -22,6 +22,12 @@
 /* Minimum window size supported by 64260 is 1MB */
 #define GT64260_WINDOW_SIZE_MIN                         0x00100000

+/* IRQ's for embedded controllers */
+#define	GT64260_ETH_IRQ_0	32
+#define	GT64260_ETH_IRQ_1	33
+#define	GT64260_ETH_IRQ_2	34
+#define	GT64260_SDMA_IRQ	36
+
 /*
  *****************************************************************************
  *

--------------050900050008030805060602--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
