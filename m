Message-Id: <4.2.2.20040518092928.05070d90@bhawley.mailhost.luminex.com>
Date: Tue, 18 May 2004 09:32:07 -0700
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
From: Brian Hawley <bhawley@luminex.com>
Subject: Ebony Board, PPC440GP and NFS panics
In-Reply-To: <200405180149.i4I1niRV001354@ms.usish.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 > We've been trying to get linux-2.5-ocp up and running on the ebony
 > board. Thanks to those who have helped, but we are still stuck, and have
 > figured out a
 > few things, but need some advice on others.
 >
 > Using the default ebony config (ebony_defconfig) we found that the default
 > bootargs (ip=on) always overrode whatever we passed from the bootargs in
 > u-boot. This always ended up with retries and NFS timeouts...
 >
 > When we recompiled linux with the default boot args off, we were able to
 > use the bootargs as laid out in the DULG for booting with an NFS root, but
 > the kernel panics...
 >
 > One thing that looks very odd is the Mac Address. The u-boot printenv
 > shows the mac address as we've listed it in the dhcp information. But, it
 > isn't clear that
 > the linux kernel can get access to the Mac Address....
 >
 >
 > Clearly, we are missing something obvious??
 >
 > Any help would be appreciated.
 >
 > Here's our dhcpd.conf.
 >
 > /* generic network stuff and router and other information deleted ... */
 > host ebony {
 > hardware ethernet 00:04:ac:e3:23:b2;
 > fixed-address 162.10.98.190;
 > option root-path "/eldk/ppc_4xx";
 > option host-name "ebony";
 > filename "/uImage-rd";
 > }
 >
 > showmount -e indicates that it is exported:
 >
 > 2 > showmount -e
 > export list for orion:
 > /eldk/ppc_4xx (everyone)
 >
 >
 > We can tftp just fine from it, but when we attempt to boot with an NFS
root...
 >
 > When booting using the version without the default bootargs (ip=on) and the
 > arguments laid out in the DULG, we get the following:
 >
 > Linux version 2.6.5 (root@feimer) (gcc version 3.3.3) #1 Fri May 14
 > 12:13:24 PDT 2004
 > IBM Ebony port (MontaVista Software, Inc. (source@mvista.com))
 > On node 0 totalpages: 32768
 > DMA zone: 32768 pages, LIFO batch:8
 > Normal zone: 0 pages, LIFO batch:1
 > HighMem zone: 0 pages, LIFO batch:1
 > Built 1 zonelists
 > Kernel command line:
 > PID hash table entries: 1024 (order 10: 8192 bytes)
 > Memory: 127584k available (1212k kernel code, 428k data, 84k init, 0k
highmem)
 > Calibrating delay loop... 598.01 BogoMIPS
 > Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
 > Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
 > Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
 > POSIX conformance testing by UNIFIX
 > NET: Registered protocol family 16
 > PCI: Probing PCI hardware
 > Serial: 8250/16550 driver $Revision: 1.90 $ 6 ports, IRQ sharing enabled
 > ttyS0 at MMIO 0x0 (irq = 0) is a 16550A
 > ttyS1 at MMIO 0x0 (irq = 1) is a 16550A
 > mal0: Initialized, 4 tx channels, 2 rx channels
 > emac: IBM EMAC Ethernet driver, version 2.0
 > Maintained by Benjamin Herrenschmidt <benh@kernel.crashing.org>
 > zmii0: input 0 in SMII mode
 > eth0: IBM emac, MAC ff:ff:ff:ff:ff:ff
 > eth0: Found Generic MII PHY (0x08)
 > zmii0: input 1 in RMII mode
 > eth1: IBM emac, MAC ff:ff:ff:ff:ff:ff
 > eth1: Found Generic MII PHY (0x09)
 > mice: PS/2 mouse device common for all mice
 > NET: Registered protocol family 2
 > IP: routing cache hash table of 1024 buckets, 8Kbytes
 > TCP: Hash tables configured (established 8192 bind 16384)
 > NET: Registered protocol family 1
 > NET: Registered protocol family 17
 > Root-NFS: No NFS server available, giving up.
 > VFS: Unable to mount root fs via NFS, trying floppy.
 > Kernel panic: VFS: Unable to mount root fs on unknown-block(2,0)
 > <0>Rebooting in 180 seconds..<6>eth0: Link is Up
 > eth0: Speed: 100, Full duplex.
 >
 >


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
