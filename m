Message-Id: <199911222346.AAA00248@piglet.grunz.lu>
Date: Tue, 23 Nov 1999 00:46:58 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Error accessing PCI config space
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

For some time now, I've had problems with the PlanB video grabber
hardware in my G3-upgraded 7600. I've narrowed the problems down to
errors accessing planb's PCI config space.

In fact, I see the same errors accessing any of the two devices behind
the chaos host bridge, namely control and planb.

The error is that whenever I read from config space, I get the value of
the previous read, however long ago that read occured. See this:

[mlan@piglet ~]$ lspci -vvx
01:0d.0 Ethernet controller: Apple Computer Inc. PlanB Video-In (rev 14)
        Control: I/O+ Mem+ BusMaster- SpecCycle+ MemWINV- VGASnoop+ ParErr+ Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 28
        BIST is running
        Region 0: Memory at <ignored> (32-bit, prefetchable)
        Region 1: Memory at <ignored> (32-bit, non-prefetchable)
00: 00 00 00 f1 6b 10 04 00 14 00 00 02 01 00 00 ff
10: 08 20 00 00 00 00 00 f1 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Vendor & device ID are from the bus scan at bootup; the other values
are read directly from config space by lspci. If you shift this by 4
bytes to the left, all values will make sense.

I can reproduce the same with setpci:

[root@piglet ~]# setpci -v -s 01:0d.0 BASE_ADDRESS_0
01:0d.0:10 = f4000000
[root@piglet ~]# setpci -v -s 01:0d.0 BASE_ADDRESS_0
01:0d.0:10 = f4000000
[root@piglet ~]# setpci -v -s 01:0d.0 DEVICE_ID     
01:0d.0:02 = f400
[root@piglet ~]# setpci -v -s 01:0d.0 BASE_ADDRESS_0
01:0d.0:10 = 0004106b

I've read BASE_ADDRESS_0 a few times; then the read of DEVICE_ID returns
the corresponding 16 bits out of the BASE_ADDRESS_0 register, and a
following read of BASE_ADDRESS_0 returns the value of the long
previously read to determine DEVICE_ID....

This leads me to beleive something is wrong with the
pmac_pcibios_read_xx() calls when used on the chaos bridge.

I've thought about the CPU reordering memory accesses; however, I've
been unable to change this behaviour with either eieio() or sync().

I've also thought about the fact that according to Apples doc, PCI
writes are always posted writes on PowerMac systems. So, the out_le32()
of the config space address might not have completed when reading the
register data.

However, inserting an in_le32(bp->cfg_addr) after the write, to insure
the write completed before reading the resulting data, didn't really
solve the problem: I'm then reading all sorts of garbage from config
space.

An other clue might be that on bootup, when the PCI initialization is
done and the level2 cache is not yet turned on, the config space scan
returns different values:

  Planb: Dumping config space
  00: 14 10 04 00 6b 00 00 02 14 00 00 ff 01 20 00 00
  10: 08 00 00 f1 00 00 00 00 00 00 00 00 00 00 00 00
  20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Here it's less clear what the relationship between read value and real
value is.

Anybody have any clues to what's happening? By the way, I can reproduce
the errors with the original 604 CPU; and as it used to work OK some
time ago, I'll go and compile old kernels now.....

Thanks for any help....

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
