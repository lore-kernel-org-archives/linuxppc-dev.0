Message-Id: <sc84a63e.016@gw_tms_syd2.pty.tms.thomson-csf.com>
Date: Tue, 05 Mar 2002 11:04:11 +1100
From: "Jeremy Rosen" <Jeremy.Rosen@au.thalesgroup.com>
To: "Jeremy Rosen" <Jeremy.Rosen@au.thalesgroup.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] use of /proc/iomem in 8xx boards
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_4518F09E.C3A2CA9D"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a MIME message. If you are reading this text, you may want to
consider changing to a mail reader or gateway that understands how to
properly handle MIME multipart messages.

--=_4518F09E.C3A2CA9D
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline

ooops, forgot the patch

>>> "Jeremy Rosen" <Jeremy.Rosen@au.thalesgroup.com> 03/05/02 10:59am
>>>

Here is a patch to have the memory map displayed in /proc/iomem.
it was mainly adapted from arch/ppc/i386/kernel/setup.c

I have tested it with my board ( FADS with an 860T ) but I didn't test
for other board.
This also mean that the names for the IO regions of other board were
my
best guess :-)

Thx

Jeremy



--=_4518F09E.C3A2CA9D
Content-Type: text/plain
Content-Disposition: attachment; filename="iomem.patch"

--- oldlinux/arch/ppc/kernel/m8xx_setup.c	Mon Jan  7 09:41:16 2002
+++ linux/arch/ppc/kernel/m8xx_setup.c	Tue Mar  5 11:52:26 2002
@@ -47,6 +47,8 @@
 #include <asm/time.h>
 #include "ppc8xx_pic.h"

+#include <linux/ioport.h>
+
 static int m8xx_set_rtc_time(unsigned long time);
 static unsigned long m8xx_get_rtc_time(void);
 void m8xx_calibrate_decr(void);
@@ -315,9 +328,40 @@
  * All of this fits into the same 4Mbyte region, so it only
  * requires one page table page.  (or at least it used to  -- paulus)
  */
+struct resource standard_io_resources[] = {
+	{ "IMAP", IMAP_ADDR, IMAP_ADDR + IMAP_SIZE -1, IORESOURCE_BUSY },
+#ifdef CONFIG_MBX
+	{ "NVRAM", NVRAM_ADDR, NVRAM_ADDR + NVRAM_SIZE -1, IORESOURCE_BUSY },
+	{ "MBX CSR", MBX_CSR_ADDR, MBX_CSR_ADDR + MBX_CSR_SIZE -1, IORESOURCE_BUSY },
+	{ "PCI CSR", PCI_CSR_ADDR, PCI_CSR_ADDR + PCI_CSR_SIZE -1, IORESOURCE_BUSY },
+	{ "PCI ISA IO", PCI_ISA_IO_ADDR, PCI_ISA_IO_ADDR + 0x4000 -1, IORESOURCE_BUSY },
+	{ "PCI IDE Address", PCI_IDE_ADDR, PCI_IDE_ADDR + 0x4000 -1, IORESOURCE_BUSY },
+#endif
+#if defined(CONFIG_RPXLITE) || defined(CONFIG_RPXCLASSIC)
+	{ "RPX CSR", RPX_CSR_ADDR, RPX_CSR_ADDR + RPX_CSR_SIZE -1, IORESOURCE_BUSY },
+#if !defined(CONFIG_PCI)
+	{ "IO map", _IO_BASE, _IO_BASE + _IO_BASE_SIZE -1, IORESOURCE_BUSY },
+#endif
+#endif
+#ifdef CONFIG_HTDMSOUND
+	{ "HTDM CSR", HIOX_CSR_ADDR, HIOX_CSR_ADDR + HIOX_CSR_SIZE -1, IORESOURCE_BUSY },
+#endif
+#ifdef CONFIG_FADS
+	{ "FADS BCSR", BCSR_ADDR, BCSR_ADDR + BCSR_SIZE -1, IORESOURCE_BUSY },
+#endif
+#ifdef CONFIG_PCI
+	{ "PCI CSR", PCI_CSR_ADDR, PCI_CSR_ADDR + PCI_CSR_SIZE -1, IORESOURCE_BUSY }
+#endif
+};
+#define STANDARD_IO_RESOURCES (sizeof(standard_io_resources)/sizeof(struct resource))
+
 static void __init
 m8xx_map_io(void)
 {
+
+	int i;
+	for (i = 0; i < STANDARD_IO_RESOURCES; i++)
+		request_resource(&iomem_resource, standard_io_resources+i);
         io_block_mapping(IMAP_ADDR, IMAP_ADDR, IMAP_SIZE, _PAGE_IO);
 #ifdef CONFIG_MBX
         io_block_mapping(NVRAM_ADDR, NVRAM_ADDR, NVRAM_SIZE, _PAGE_IO);

--=_4518F09E.C3A2CA9D--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
