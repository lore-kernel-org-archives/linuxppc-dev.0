From: Jim Thompson <jim@musenki.com>
To: linuxppc-embedded@lists.linuxppc.org
Cc: Craig Sullender <csullender@earthlink.net>,
	Brad Martin <brad@musenki.com>
Subject: 8245 EPIC problems
Message-Id: <20020227083036.216F8F4058@dinky.musenki.com>
Date: Wed, 27 Feb 2002 02:30:36 -0600 (CST)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Anyone see any obvious problems here?

The situation is that I have a Intel EEPRO/100 in my board's PCI slot
(IDSEL 22, INT A/B/C/D all tied to IRQ0) and a Davicom 9202A on-board
with its interrupt pin tied to IRQ3.

I can send/receive packets on the PCI card fine, but the on-board enet
doesn't work.  It never generates an interrupt.

I have also tried a Davicom 9102A board in the PCI slot, and it works,
so its not like the driver is broken.

The kernel is 2.4.18-pre7.  I had to move phys_eumb_base (3rd arg to
mpc10x_bridge_init() to 0xfc000000.  Otherwise its pretty stock, other
than this little hack in arch/ppc/kernel/openpic.c:openpic_init(),
necessary to get the on-board serial ports working


        if (NumSources == 0)
                openpic_set_sources(0,
#if 0
                                    ((t & OPENPIC_FEATURE_LAST_SOURCE_MASK) >>
                                     OPENPIC_FEATURE_LAST_SOURCE_SHIFT) + 1,
#else
                                        138,
#endif
                                    NULL);


(it works around a bug in the code which prevents me from calling the
commented out lines in musenki_init_IRQ()

    static void __init
    musenki_init_IRQ(void)
    {
	    printk(KERN_INFO "musenki_init_IRQ\n");
	    OpenPIC_InitSenses = musenki_openpic_initsenses;
	    OpenPIC_NumInitSenses = sizeof(musenki_openpic_initsenses);

	    /* openpic_set_sources(0, 26, NULL); /* */
	    /* openpic_set_sources(137, 2, NULL); /* */
	    openpic_init(1, 0, 0, -1);

	    return;
    }

        ppc_md.init_IRQ = musenki_init_IRQ;



arch/ppc/platforms/musenki_pci.c:

    musenki_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
    {
	    static char pci_irq_table[][4] =
	    /*
	     *      PCI IDSEL/INTPIN->INTLINE
	     *         A   B   C   D
	     */
	    {
		    { 19,  0,  0,  0 },     /* IDSEL 22 - PCI slot, IRQ0 */
		    { 16,  0,  0,  0 },     /* IDSEL 23 - on-board DM9102A, IRQ3 */
	    };

	    const long min_idsel = 22, max_idsel = 23, irqs_per_slot = 4;
	    return PCI_IRQ_TABLE_LOOKUP;
    }

    [...]
		    ppc_md.pci_map_irq = musenki_map_irq;

arch/ppc/platforms/musenki_setup.c:

    static u_char musenki_openpic_initsenses[] __initdata = {
	    0,      /* 0-15 are not used on an 8240 EPIC */
	    0,      /* 1 */
	    0,      /* 2 */
	    0,      /* 3 */
	    0,      /* 4 */
	    0,      /* 5 */
	    0,      /* 6 */
	    0,      /* 7 */
	    0,      /* 8 */
	    0,      /* 9 */
	    0,      /* 10 */
	    0,      /* 11 */
	    0,      /* 12 */
	    0,      /* 13 */
	    0,      /* 14 */
	    0,      /* 15 */
	    1,      /* 16: EPIC IRQ 0: Active Low */
	    1,      /* 17: EPIC IRQ 1: Active Low */
	    1,      /* 18: EPIC IRQ 2: Active Low */
	    1,      /* 19: EPIC IRQ 3: Active Low */
	    1,      /* 20: EPIC IRQ 4: Active Low */
    };


    Memory BAT mapping: BAT2=32Mb, BAT3=32Mb
    Linux version 2.4.18-pre7 (jim@zaphod) (gcc version 3.0.3) #44 Wed Feb 27 02:08:51 CST 2002
    Musenki M3/M1: See www.musenki.com for details
    On node 0 totalpages: 8192
    zone(0): 8192 pages.
    zone(1): 0 pages.
    zone(2): 0 pages.
    Kernel command line:
    musenki_init_IRQ
    OpenPIC Version 1.2 (1 CPUs and 138 IRQ sources) at fc040000
    time_init: decrementer frequency = 25.000000 MHz
    Calibrating delay loop... 166.29 BogoMIPS
    Memory: 27508k available (1120k kernel code, 424k data, 204k init, 0k highmem)
    Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
    Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
    Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
    Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
    Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
    POSIX conformance testing by UNIFIX
    PCI: Probing PCI hardware
    Linux NET4.0 for Linux 2.4
    Based upon Swansea University Computer Society NET3.039
    Initializing RT netlink socket
    Starting kswapd
    pty: 256 Unix98 ptys configured
    Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
    ttyS00 at 0xfc004500x (irq = 137) is a ST16650
    ttyS01 at 0xfc004600x (irq = 138) is a ST16650
    block: 64 slots per queue, batch=16
    RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
    loop: loaded (max 8 devices)
    Linux Tulip driver version 0.9.15-pre9 (Nov 6, 2001)
    tulip0:  EEPROM default media type Autosense.
    tulip0:  MII interface PHY 1, setup/reset sequences 0/2 long, capabilities 00 01.
    tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
    tulip0:  Index #1 - Media 10baseT (#0) described by a 21140 non-MII (0) block.
    tulip0:  Index #2 - Media 100baseTx (#3) described by a 21140 non-MII (0) block.
    tulip0:  Index #3 - Media 10baseT-FDX (#4) described by a 21140 non-MII (0) block.
    tulip0:  Index #4 - Media 100baseTx-FDX (#5) described by a 21140 non-MII (0) block.
    tulip0:  MII transceiver #1 config 3100 status 7809 advertising 01e1.
    eth0: Davicom DM9102/DM9102A rev 49 at 0xc300df00, 00:80:AD:8F:35:37, IRQ 16.
    eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
    eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
    eth1: Intel Corp. 82559 InBusiness 10/100, 00:03:47:AF:33:40, IRQ 19.
      Board assembly 742252-003, Physical connectors present: RJ45
      Primary interface chip i82555 PHY #1.
      General self-test: passed.
      Serial sub-system self-test: passed.
      Internal registers self-test: passed.
      ROM checksum self-test: passed (0x8b51f404).
    NET4: Linux TCP/IP 1.0 for NET4.0
    IP Protocols: ICMP, UDP, TCP, IGMP
    IP: routing cache hash table of 512 buckets, 4Kbytes
    TCP: Hash tables configured (established 2048 bind 4096)
    IPv4 over IPv4 tunneling driver
    GRE over IPv4 tunneling driver
    NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
    802.1Q VLAN Support v1.6  Ben Greear <greearb@candelatech.com>
    vlan Initialization complete.
    RAMDISK: Compressed image found at block 0
    Freeing initrd memory: 2992k freed
    EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
    VFS: Mounted root (ext2 filesystem).
    Freeing unused kernel memory: 204k init
    serial console detected.  Disabling virtual terminals.
    init started:  BusyBox v0.61.pre (2002.02.20-15:46+0000) multi-call binary


    BusyBox v0.61.pre (2002.02.20-16:05+0000) Built-in shell (ash)
    Enter 'help' for a list of built-in commands.

    # ifconfig eth0 192.168.0.4 up
    # ifconfig eth1 10.10.10.1 up
    # ifconfig
    eth0      Link encap:Ethernet  HWaddr 00:80:AD:8F:35:37
	      inet addr:192.168.0.4  Bcast:192.168.0.255  Mask:255.255.255.0
	      UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
	      RX packets:0 errors:0 dropped:0 overruns:0 frame:0
	      TX packets:0 errors:1 dropped:0 overruns:0 carrier:0
	      collisions:0 txqueuelen:100
	      RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
	      Interrupt:16 Base address:0xdf00

    eth1      Link encap:Ethernet  HWaddr 00:03:47:AF:33:40
	      inet addr:10.10.10.1  Bcast:10.255.255.255  Mask:255.0.0.0
	      UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
	      RX packets:10 errors:0 dropped:0 overruns:0 frame:0
	      TX packets:6 errors:0 dropped:0 overruns:0 carrier:0
	      collisions:0 txqueuelen:100
	      RX bytes:972 (972.0 b)  TX bytes:420 (420.0 b)
	      Interrupt:19 Base address:0xf000
    # ping -c 2 192.168.0.1
    PING 192.168.0.1 (192.168.0.1): 56 data bytes
    NETDEV WATCHDOG: eth0: transmit timed out
    eth0: 21140 transmit timed out, status fc120000, SIA ffffff5e 00000000 00000000 00000000, resetting...
    eth0: transmit timed out, switching to MII media.

    --- 192.168.0.1 ping statistics ---
    2 packets transmitteeth0: MII status 782d, Link partner report 45e1.
    d, 0 packets received, 100% packet loss
    # ping -c 2 10.10.10.2
    PING 10.10.10.2 (10.10.10.2): 56 data bytes
    64 bytes from 10.10.10.2: icmp_seq=0 ttl=255 time=0.3 ms
    64 bytes from 10.10.10.2: icmp_seq=1 ttl=255 time=0.2 ms

    --- 10.10.10.2 ping statistics ---
    2 packets transmitted, 2 packets received, 0% packet loss
    round-trip min/avg/max = 0.2/0.2/0.3 ms
    # cat /proc/pci
    PCI devices found:
      Bus  0, device   0, function  0:
	Host bridge: PCI device 1057:0006 (Motorola) (rev 18).
	  Prefetchable 32 bit memory at 0x0 [0xffffffff].
	  Non-prefetchable 32 bit memory at 0x0 [0xfff].
	  Prefetchable 32 bit memory at 0x0 [0xffffffff].
      Bus  0, device  22, function  0:
	Ethernet controller: Intel Corp. 82559 InBusiness 10/100 (rev 8).
	  IRQ 19.
	  Master Capable.  Latency=128.  Min Gnt=8.Max Lat=56.
	  Non-prefetchable 32 bit memory at 0xbffff000 [0xbfffffff].
	  I/O at 0xfebfffc0 [0xfebfffff].
	  Non-prefetchable 32 bit memory at 0xbfe00000 [0xbfefffff].
      Bus  0, device  23, function  0:
	Ethernet controller: Davicom Semiconductor, Inc. Ethernet 100/10 MBit (rev 49).
	  IRQ 16.
	  Master Capable.  Latency=128.  Min Gnt=20.Max Lat=40.
	  I/O at 0xfebffe00 [0xfebffeff].
	  Non-prefetchable 32 bit memory at 0xbfdfff00 [0xbfdfffff].
    # cat /proc/interrupts
	       CPU0
     16:          0   OpenPIC   Level     eth0
     19:         22   OpenPIC   Level     eth1
    137:       4516   OpenPIC   Level     serial
    BAD:          0


Now, I would have expected the musenki_map_irq() above to look more like:

    musenki_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
    {
	    static char pci_irq_table[][4] =
	    /*
	     *      PCI IDSEL/INTPIN->INTLINE
	     *         A   B   C   D
	     */
	    {
		    { 16, 17, 18, 19 },     /* IDSEL 22 - PCI slot, IRQ0 */
		    { 19,  0,  0,  0 },     /* IDSEL 23 - on-board DM9102A, IRQ3 */
	    };

	    const long min_idsel = 22, max_idsel = 23, irqs_per_slot = 4;
	    return PCI_IRQ_TABLE_LOOKUP;
    }

But the PCI slot only seems to work on IRQ 19.  The On-board Davicom
doesn't work on any IRQ between 16 and 20.

Clues sought for the clue-impaired.

I am working to get the changes into 2.4.18-rc4.

Jim


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
