Date: Sun, 5 Sep 1999 23:12:27 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: vger on LongTrail (was: Re: Sym53c8xx in 2.3.now)
In-Reply-To: <Pine.GSO.4.10.9909011709520.5612-100000@oleander.sonytel.be>
Message-ID: <Pine.LNX.4.10.9909052308240.3450-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 1 Sep 1999, Geert Uytterhoeven wrote:
> Anybody who has the sym53c8xx or ncr53c8xx driver working with the latest 2.3.x kernels?
> 
> I get:
> 
> | sym53c8xx: at PCI bus 0, device 6, function 0
> | sym53c8xx: setting PCI_COMMAND_IO PCI_COMMAND_MEMORY...
> | sym53c8xx: setting PCI_COMMAND_MASTER PCI_COMMAND_PARITY...(fix-up)
> | sym53c8xx: 53c875 detected 
> | sym53c875-0: rev=0x04, base=0xc3000000, io_port=0x1400, irq=31
> | sym53c875-0: NCR clock is 40218KHz, 40218KHz
> | sym53c875-0: ID 7, Fast-20, Parity Checking
> | sym53c875-0: on-chip RAM at 0xc3001000
> | sym53c875-0: restart (scsi reset).
> | sym53c875-0: Downloading SCSI SCRIPTS.
> | ncr53c8xx: at PCI bus 0, device 6, function 0
> | ncr53c8xx: IO region 0x1400 to 0x147f is in use
> | mesh: assuming 50MHz clock frequency
> | scsi0 : sym53c8xx - version 1.3c
> | scsi1 : MESH
> | scsi : 2 hosts.
> | scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
> | sym53c8xx_abort: pid=0 serial_number=1 serial_number_at_timeout=1
> 
> And then the system hangs in a wait loop...

I'm starting to think that the problem is related to interrupts. I also get one
or two messages `Keyboard timeout[2]', and the keyboard (PS/2) doesn't seem to
work (Caps Lock doesn't toggle the Caps Lock LED).

Besides, things are getting worse. For the current vger kernel, I needed this
patch to make it compile:

Index: include/asm-ppc/serial.h
===================================================================
RCS file: /vger/u4/cvs/linux/include/asm-ppc/serial.h,v
retrieving revision 1.7
diff -u -r1.7 serial.h
--- serial.h	1999/09/02 21:23:49	1.7
+++ serial.h	1999/09/05 21:11:22
@@ -33,7 +33,6 @@
 #endif
 
 #else
-#define SERIAL_PORT_DFNS
 /*
  * PReP, CHRP, etc.
  */
@@ -52,6 +51,9 @@
 #define ACCENT_FLAGS 0
 #define BOCA_FLAGS 0
 #define HUB6_FLAGS 0
+#define RS_TABLE_SIZE	64
+#else
+#define RS_TABLE_SIZE	4
 #endif
 	
 /*

And now my serial console is scrambled after the serial port init :-(

Greetings,

						Geert

--
Geert Uytterhoeven                   Geert.Uytterhoeven@sonycom.com
Sony Suprastructure Center Europe (SUPC-E) --- Brussels --- Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
