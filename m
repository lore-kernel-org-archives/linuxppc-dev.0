Message-ID: <CF1EBE566046A64291A92D640A2368097AD6C2@postal.viasat.com>
From: "Pagnotta, Chris" <chris.pagnotta@viasat.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: I2C having issues
Date: Tue, 22 Apr 2003 12:48:13 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I tried a couple of things to to get the i2c device up and working and I
am stil having some problems. The I2C registers are mappped to internal
memory at address 0xEF60500. I cannot write to this address and read back
the same values. Here is the output from just the ep405 bootloader.

>du EF600500
EF600500: 00000000 A8000203 00400000 03000100  .........@......
EF600510: 0F0F0000 00000000 00000000 00000000  ................
EF600520: 00000000 00000000 00000000 00000000  ................
EF600530: 00000000 00000000 00000000 00000000  ................
EF600540: 00000000 00000000 00000000 00000000  ................
EF600550: 00000000 00000000 00000000 00000000  ................
EF600560: 00000000 00000000 00000000 00000000  ................
EF600570: 00000000 00000000 00000000 00000000  ................
EF600580: 00000000 00000000 00000000 00000000  ................
EF600590: 00000000 00000000 00000000 00000000  ................
EF6005A0: 00000000 00000000 00000000 00000000  ................
EF6005B0: 00000000 00000000 00000000 00000000  ................
EF6005C0: 00000000 00000000 00000000 00000000  ................
EF6005D0: 00000000 00000000 00000000 00000000  ................
EF6005E0: 00000000 00000000 00000000 00000000  ................
EF6005F0: 00000000 00000000 00000000 00000000  ................

The A8 is the address of eeprom.

When the linux kernel boots up I try to write/read to EF600604
after an ioremap. The read returns with a A8, the write seemed to
never occur.

Here is the code taken from ii2c-ibm.c

module_init(iic_init);

    while (curr_iic != -ENXIO) {
        if (!(iic_drv = ocp_alloc_dev(sizeof (struct i2c_adapter))))
            return -ENOMEM;
        iic_drv->type = IIC;
        if ((curr_iic = ocp_register(iic_drv)) != -ENXIO) {
            adap = (struct i2c_adapter *) iic_drv->ocpdev;
            printk("Physical Address Mapping 0x%08x\n", iic_drv->paddr);
            iic_drv->vaddr = ioremap(iic_drv->paddr, 17);
            printk("Writing to Physical Address 0xEF60504:0x01\n");
            writeb(0x01,iic_drv->vaddr + 4 );
            printk("Reading Physical Address 0xEF60504:0x%08x\n",
readb(iic_drv->vaddr + 4));



Here is the ouput:


Linux version 2.4.21-pre4 (cpagnotta@lb-vdc500-linux) (gcc version 3.2.2) #6
Tu3
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs nfsroot=/tftpboot/powerpc
ip=172.25.4.57:172f
Calibrating delay loop... 199.88 BogoMIPS
Memory: 14640k available (1112k kernel code, 344k data, 76k init, 0k
highmem)
Dentry cache hash table entries: 2048 (order: 2, 16384 bytes)
Inode cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
OCP 4xx power management enabled
OCP uart ver 1.6.2 init complete
Starting kswapd
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ed
ttyS00 at 0xef600300 (irq = 0) is a 16550A
ttyS01 at 0xef600400 (irq = 1) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
eth0: Phy @ 0x0, type LXT971A (0x001378e2)
Reset ethernet interfaces
IBM IIC driver

/* Here is the important info */
Physical Address Mapping 0xef600500
Writing to Physical Address 0xEF60504:0x01
Reading Physical Address 0xEF60504:0x000000a8
/* Here is the important info */

i2c-dev.o: Registered 'IBM IIC adapter' as minor 0
i2c-core.o: adapter IBM IIC adapter registered as adapter 0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 2048)
eth0: IBM EMAC: link up, 10 Mbps Half Duplex, auto-negotiation complete.
eth0: IBM EMAC: MAC 00:10:ec:00:3b:1e.
eth0: IBM EMAC: open completed

IP-Config: Complete:
      device=eth0, addr=172.25.4.57, mask=255.255.0.0, gw=255.255.255.255,
     host=lb-vib-linux, domain=, nis-domain=(none),
     bootserver=172.25.4.56, rootserver=172.25.4.56, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 172.25.4.56
Looking up port of RPC 100005/1 on 172.25.4.56
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 76k init


Any assistance would be greatly appreciated.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
