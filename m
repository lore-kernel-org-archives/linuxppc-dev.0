Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 2E05C679E1
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Feb 2006 06:13:51 +1100 (EST)
Date: Tue, 21 Feb 2006 20:07:10 +0100 (MET)
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: linuxppc-dev@ozlabs.org,debian-powerpc@lists.debian.org
MIME-Version: 1.0
Subject: AmigaOne PPC Linux: Problems with Interrupts
Message-ID: <11408.1140548830@www018.gmx.net>
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I encountered some problems with Linux PPC on the AmigaOne. As you can see
in the /proc/interrupts output below, the AmigaOne has a i8259 PIC (no
OpenPIC). The first problem is, that the interrupts 7 and 10 are shown as
"Edge" triggered, but they're set to "Level" in the u-boot (firmware)
preferences. I'm not sure, if u-boot setups the interrupts, therefore I
added this code to the platform PCI initialisation code (copied from
prep_pci.c):

void __init
amigaone_pcibios_fixup(void)
{
	/* IRQ 7 is level triggered. */
	unsigned char irq_edge_mask_lo = 0x80;
	/* IRQ, 9, 10, 11 is level triggered. */
	unsigned char irq_edge_mask_hi = 0x07;

	outb(inb(0x04d0)|irq_edge_mask_lo, 0x4d0);	/* primary 8259 */
	outb(inb(0x04d1)|irq_edge_mask_hi, 0x4d1);	/* cascaded 8259 */
}

Unortunately this didn't help and the interrupts seem to be still "edge"
triggered.

/proc/interrupts:
           CPU0
  1:        189   i8259     Edge      i8042
  2:          0   i8259     Edge      82c59 secondary cascade
  5:          0   i8259     Edge      uhci_hcd, uhci_hcd
  7:        546   i8259     Edge      eth0
 10:          0   i8259     Edge      EMU10K1
 12:       8217   i8259     Edge      i8042
 14:      19597   i8259     Edge      ide0
 15:      18951   i8259     Edge      ide1
BAD:          2

The other issue are the 2 BAD interrupts shown above. Does this have to do
something with the "edge" or "level" triggered mode or is it a interrupt
routing problem?

Thanks!

Gerhard

Other infos:

/proc/ioports
00000000-00bfffff : PCI host bridge
  00000000-0000001f : dma1
  00000020-00000021 : 8259 (master)
  00000040-0000005f : timer
  00000060-0000006f : i8042
  00000080-0000008f : dma page reg
  000000a0-000000a1 : 8259 (slave)
  000000c0-000000df : dma2
  00000170-00000177 : ide1
  000001f0-000001f7 : ide0
  00000278-0000027a : parport2
  000002f8-000002ff : serial
  00000376-00000376 : ide1
  00000378-0000037a : parport0
  000003bc-000003be : parport1
  000003c0-000003df : vga+
  000003e8-000003ef : serial
  000003f6-000003f6 : ide0
  000003f8-000003ff : serial
  000004d0-000004d1 : 8259 edge control
  00002000-00002fff : PCI Bus #01
    00002000-000020ff : 0000:01:00.0
  0000cc00-0000cc0f : 0000:00:07.1
    0000cc00-0000cc07 : ide0
    0000cc08-0000cc0f : ide1
  00802000-0080207f : 0000:00:06.0
    00802000-0080207f : 0000:00:06.0
  00802080-0080209f : 0000:00:07.2
    00802080-0080209f : uhci_hcd
  008020a0-008020bf : 0000:00:07.3
    008020a0-008020bf : uhci_hcd
  00802100-008021ff : 0000:00:07.5
  00802200-00802203 : 0000:00:07.5
  00802204-00802207 : 0000:00:07.5
  00802300-008023ff : 0000:00:07.6
  00802400-0080241f : 0000:00:09.0
    00802400-0080241f : EMU10K1
  00802420-00802427 : 0000:00:09.1
    00802420-00802427 : emu10k1-gp

-- 
10 GB Mailbox, 100 FreeSMS/Monat http://www.gmx.net/de/go/topmail
+++ GMX - die erste Adresse für Mail, Message, More +++
