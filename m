Message-ID: <20031103033529.24416.qmail@kunk.qbjnet.com>
Subject: IRQS on 6 Slot Macs
To: linuxppc-dev@lists.linuxppc.org
Date: Sun, 2 Nov 2003 21:35:29 -0600 (CST)
From: Robert E Brose II <bob@kunk.qbjnet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In trying to get OpenGL working on a YDL 3.0 system with kernel 2.4.22-ben2
and XFree86-4.3.0-2.1e,  I get a warning on X initialization:

(II) R128(0): [drm] failure adding irq handler, there is a device already using
that irq

Digging into it more, I'm having a hard time understanding why there is a
problem and how the interrupts are allocated on a S900 (w/G3 card).


With the folowing configuration:
Slot 1:
00:0d.0 VGA compatible controller: ATI Technologies Inc Rage 128 RE/SG (prog-if 00 [VGA])
        Flags: bus master, stepping, medium devsel, latency 32, IRQ 23
Slot 2:
00:0e.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 21)
        Flags: bus master, medium devsel, latency 32, IRQ 24
Slot 3:
01:00.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 04)
        Flags: bus master, medium devsel, latency 32, IRQ 25
Slot 4:
01:01.0 Communication controller: Comtrol Corporation RocketPort 8 Intf (rev 02)
        Flags: medium devsel, IRQ 25
Slot 5:
01:02.0 FireWire (IEEE 1394): Texas Instruments FireWire Controller (rev 01) (pr
og-if 10 [OHCI])
        Flags: bus master, medium devsel, latency 32, IRQ 25
Slot 6:
01:03.0 USB Controller: Lucent Microelectronics USS-312 USB Controller (rev 10)
(prog-if 10 [OHCI])
        Flags: bus master, medium devsel, latency 32, IRQ 25

and /proc/interrupts

  2:          0   PMAC-PIC  Edge      MACE-txdma
  3:      77087   PMAC-PIC  Edge      MACE-rxdma
  8:        345   PMAC-PIC  Edge      Built-in Sound out
  9:          0   PMAC-PIC  Edge      Built-in Sound in
 13:         71   PMAC-PIC  Edge      MESH
 14:      77840   PMAC-PIC  Edge      MACE
 17:          0   PMAC-PIC  Edge      Built-in Sound misc
 18:       4352   PMAC-PIC  Edge      ADB
 19:          0   PMAC-PIC  Edge      SWIM3
 24:      21259   PMAC-PIC  Level     eth0
 25:   72922493   PMAC-PIC  Level     sym53c8xx, usb-ohci, ohci1394



A couple of things right off, the rage128 appears to be the only thing on
irq 23 however 23 doesn't show up in /proc/interrupts meaning, I suppose,
that it's not using the interrupt. So why does the drm complain?

How come everything from slots 3-6 says it's on the same interrupt (25)?

Bob
--
/~\ The ASCII       | Robert E. Brose II    N0QBJ
\ / Ribbon Campaign | http://www.qbjnet.com/
 X  Help cure       | mailto:bob@qbjnet.com
/ \ HTML Email      | public key at http://www.qbjnet.com/key.html

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
