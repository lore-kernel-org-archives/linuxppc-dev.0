Date: Fri, 28 Sep 2001 14:33:01 +0900 (JST)
Message-Id: <20010928.143301.74755222.tkoba@ike-dyn.ritsumei.ac.jp>
To: linuxppc-dev@lists.linuxppc.org
Subject: Problem serial.c on module
From: "KOBAYASHI R. Taizo" <tkoba@ike-dyn.ritsumei.ac.jp>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Fri_Sep_28_14:33:01_2001_586)--"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


----Next_Part(Fri_Sep_28_14:33:01_2001_586)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi

Since /drivers/char/serial.c was updated to "5.05c","2001-07-08",
system clash when pcmcia modem cards ejects.

I examined this problem and had a question.
Dose it need following branch?
================L5375==
#ifdef CONFIG_ALL_PPC
        /* early PowerMacs would machine check */
        if (_machine == _MACH_Pmac) {
                printk(KERN_INFO "serial.c: nothing to do on PowerMacs.\n");
                return 0;
        }
#endif
=======================

Anyway, pcmcia modem card on my TiBook seems work fine with following patch.

Thanks.

Taizo


----Next_Part(Fri_Sep_28_14:33:01_2001_586)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="2.4.10-ppc-serial.diff"

--- linux/drivers/char/serial.c.orig	Fri Sep 28 13:57:02 2001
+++ linux/drivers/char/serial.c	Fri Sep 28 13:46:41 2001
@@ -4015,7 +4015,10 @@
  * seems to be mainly needed on card using the PLX which also use I/O
  * mapped memory.
  */
-static int __devinit
+static int
+#ifndef MODULE
+__devinit
+#endif
 pci_plx9050_fn(struct pci_dev *dev, struct pci_board *board, int enable)
 {
 	u8 data, *p, irq_config;
@@ -4079,7 +4082,10 @@
 #define PCI_DEVICE_ID_SIIG_1S_10x (PCI_DEVICE_ID_SIIG_1S_10x_550 & 0xfffc)
 #define PCI_DEVICE_ID_SIIG_2S_10x (PCI_DEVICE_ID_SIIG_2S_10x_550 & 0xfff8)

-static int __devinit
+static int
+#ifndef MODULE
+__devinit
+#endif
 pci_siig10x_fn(struct pci_dev *dev, struct pci_board *board, int enable)
 {
        u16 data, *p;
@@ -4108,7 +4114,10 @@
 #define PCI_DEVICE_ID_SIIG_2S_20x (PCI_DEVICE_ID_SIIG_2S_20x_550 & 0xfffc)
 #define PCI_DEVICE_ID_SIIG_2S1P_20x (PCI_DEVICE_ID_SIIG_2S1P_20x_550 & 0xfffc)

-static int __devinit
+static int
+#ifndef MODULE
+__devinit
+#endif
 pci_siig20x_fn(struct pci_dev *dev, struct pci_board *board, int enable)
 {
        u8 data;
@@ -4129,7 +4138,10 @@
 }

 /* Added for EKF Intel i960 serial boards */
-static int __devinit
+static int
+#ifndef MODULE
+__devinit
+#endif
 pci_inteli960ni_fn(struct pci_dev *dev,
 		   struct pci_board *board,
 		   int enable)
@@ -4187,7 +4199,10 @@
 	{ 0, 0 }
 };

-static int __devinit
+static int
+#ifndef MODULE
+__devinit
+#endif
 pci_timedia_fn(struct pci_dev *dev, struct pci_board *board, int enable)
 {
 	int	i, j;
@@ -4208,7 +4223,10 @@
 	return 0;
 }

-static int __devinit
+static int
+#ifndef MODULE
+__devinit
+#endif
 pci_xircom_fn(struct pci_dev *dev, struct pci_board *board, int enable)
 {
 	__set_current_state(TASK_UNINTERRUPTIBLE);
@@ -5372,7 +5390,8 @@
 #endif
 	show_serial_version();

-#ifdef CONFIG_ALL_PPC
+#if 0
+//#ifdef CONFIG_ALL_PPC
 	/* early PowerMacs would machine check */
 	if (_machine == _MACH_Pmac) {
 		printk(KERN_INFO "serial.c: nothing to do on PowerMacs.\n");

----Next_Part(Fri_Sep_28_14:33:01_2001_586)----

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
