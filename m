Message-ID: <3719E651.63B17AF1@talknet.de>
Date: Sun, 18 Apr 1999 14:04:01 +0000
From: Alois Fertl <alois_fertl@TalkNet.de>
MIME-Version: 1.0
To: Cort Dougan <cort@persephone.cs.nmt.edu>
CC: LinuxppcDev <linuxppc-dev@lists.linuxppc.org>
Subject: Trouble with Vger 2.2.5 kernel on PREP hardware
Content-Type: multipart/mixed; boundary="------------A51D2D9399B8BADD6DF67399"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------A51D2D9399B8BADD6DF67399
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Cort,

yesterday I updated my vger sources from cvs.samba.org to the latest of
linux-2.2.5. With this source I have the following problems on Motorola
PReP hardware (tested on RiscPC Blackhawk but I strongly assume that
VME boards are also affected):

Error in "arch/ppc/kernel/indirect_pci.c":
The Kernel fails in ncr53c8xx driver during boot. The reason is that
the relocation of PCI addresses no longer works because "indirect_pcibios_write_config_dword" defines the parameter asshort
instead of int. The attached first patch fixes this problem.

Interrupts lost from second 8259 and wrong IDE byte swapping on
Motorola hardware:
The code for "prep_do_IRQ" in prep_setup.c seems to miss interrupts
from the cascaded interrupt chip.
Also the handling of IDE does not work for Motorola PReP hardware.
On a Blackhawk the default IRQ for the nonPCI chip is 14. In addition
to this the hardware does no byte swapping so the software has to set
up the swapped versions for insw and outsw and has to engage fix_driveid.
The second patch attached provides the necessary changes.

Kernels without IDE configured hang very early during boot.
The reason is asm-ppc/ide.h which redefines the inb and outb macros
to use the ISA-I/O base from ppc_ide_md.io_base. If CONFIG_BLK_DEV_IDE
is not set, the value for this variable is not initialized to the
correct value. For the kernel this means that after including
asm-ppc/ide.h all following inb/outb operations access wrong locations
which results in the kernel not booting at all.
Question is if these undefs and redefs for inb/outb inb_p/outb_p in
ide.h are really required or if they can go away.
I dropped this lines and than tested recompiled IDE and non-IDE kernels
which both woirked fine for me.
I did not do a patch for this because I think ide.h also breaks insw and
outsw if it is included without CONFIG_BLK_DEV_IDE defined.

Alois
--------------A51D2D9399B8BADD6DF67399
Content-Type: text/plain; charset=us-ascii; name="prep1.patch"
Content-Disposition: inline; filename="prep1.patch"
Content-Transfer-Encoding: 7bit

--- linux-2.2.5/arch/ppc/kernel/indirect_pci.c.org	Sat Apr 17 21:20:47 1999
+++ linux-2.2.5/arch/ppc/kernel/indirect_pci.c	Sat Apr 17 21:21:55 1999
@@ -103,7 +103,7 @@
 }
 
 int indirect_pcibios_write_config_dword(unsigned char bus, unsigned char dev_fn,
-			     unsigned char offset, unsigned short val)
+			     unsigned char offset, unsigned int val)
 {
 	unsigned flags;
 

--------------A51D2D9399B8BADD6DF67399
Content-Type: text/plain; charset=us-ascii; name="prep2.patch"
Content-Disposition: inline; filename="prep2.patch"
Content-Transfer-Encoding: 7bit

--- linux-2.2.5/arch/ppc/kernel/prep_setup.c.org	Sun Apr 18 12:56:03 1999
+++ linux-2.2.5/arch/ppc/kernel/prep_setup.c	Sun Apr 18 12:56:24 1999
@@ -609,7 +609,14 @@
                  * acknowledge on controller 2
                  */
                 outb(0x0C, 0xA0);                      
-                irq = (inb(0xA0) & 7) + 8;
+                irq = inb(0xA0);
+		while ( irq & 0x80 )
+		{
+			ppc_irq_dispatch_handler( regs, (irq & 7) + 8 );
+			outb(0x0C, 0xA0);                      
+			irq = inb(0xA0);
+		}
+		return;
         }
         else if (irq==7)                                
         {
@@ -659,11 +666,23 @@
 	_outsw((unsigned short *)((port)+_IO_BASE), buf, ns);
 }
 
+void
+prep_mot_ide_insw(ide_ioreg_t port, void *buf, int ns)
+{
+	ide_insw(port+_IO_BASE, buf, ns);
+}
+
+void
+prep_mot_ide_outsw(ide_ioreg_t port, void *buf, int ns)
+{
+	ide_outsw(port+_IO_BASE, buf, ns);
+}
+
 int
 prep_ide_default_irq(ide_ioreg_t base)
 {
 	switch (base) {
-		case 0x1f0: return 13;
+		case 0x1f0: return (_prep_type == _PREP_Motorola) ? 14 : 13;
 		case 0x170: return 13;
 		case 0x1e8: return 11;
 		case 0x168: return 10;
@@ -711,6 +730,12 @@
 {
 }
 
+void
+prep_mot_ide_fix_driveid(struct hd_driveid *id)
+{
+	ppc_generic_ide_fix_driveid(id);
+}
+
 __initfunc(void
 prep_ide_init_hwif_ports (ide_ioreg_t *p, ide_ioreg_t base, int *irq))
 {
@@ -850,14 +875,23 @@
 	}
 
 #if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
-        ppc_ide_md.insw = prep_ide_insw;
-        ppc_ide_md.outsw = prep_ide_outsw;
+        if (_prep_type == _PREP_Motorola) {
+                ppc_ide_md.insw = prep_mot_ide_insw;
+                ppc_ide_md.outsw = prep_mot_ide_outsw;
+        } else {
+                ppc_ide_md.insw = prep_ide_insw;
+                ppc_ide_md.outsw = prep_ide_outsw;
+        }
         ppc_ide_md.default_irq = prep_ide_default_irq;
         ppc_ide_md.default_io_base = prep_ide_default_io_base;
         ppc_ide_md.check_region = prep_ide_check_region;
         ppc_ide_md.request_region = prep_ide_request_region;
         ppc_ide_md.release_region = prep_ide_release_region;
-        ppc_ide_md.fix_driveid = prep_ide_fix_driveid;
+        if (_prep_type == _PREP_Motorola) {
+                ppc_ide_md.fix_driveid = prep_mot_ide_fix_driveid;
+        } else {
+                ppc_ide_md.fix_driveid = prep_ide_fix_driveid;
+        }
         ppc_ide_md.ide_init_hwif = prep_ide_init_hwif_ports;
 
         ppc_ide_md.io_base = _IO_BASE;

--------------A51D2D9399B8BADD6DF67399--



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
