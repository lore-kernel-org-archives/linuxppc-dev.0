From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E42992644595405B2364D@penguin.adic.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: FW: Kernel boot: 'Kernel command line' not getting bootargs?????
Date: Tue, 4 Feb 2003 16:20:45 -0800 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Problem solved thanks to the following.

-- Brian

p.s. I can smell, taste, feel, see and hear it. Gentlemen, we have bash
prompt!!!!

-----Original Message-----
From: David C. Chiu [mailto:dchiu@ariodata.com]
Sent: Tuesday, February 04, 2003 3:12 PM
To: brian.auld@adic.com
Subject: RE: Kernel boot: 'Kernel command line' not getting bootargs?????

I have not followed u-boot (we're still using modified ppc-boot v1.1.5)
but if it is anything like ppc-boot, and that the kernel is anything
like what we have (MV kernel 2.4.19 pre-7) then the board info structure
and cmd line isn't being passed to the kernel (or more precisely, kernel
isn't paying attention to it.) We made some patches to pull in the whole
board info and cmd line. Be careful as the MV kernel hard coded a memory
location in flash where it fetches Ethernet MAC address.

The following assumes you are using ppc-boot. Since u-boot is more or
less a descendent of ppc-boot, it is PROBABLY not too different.

Search for ebony_setup_arch in arch/ppc directory and its
subdirectories. you'll see a reference to ioremap64 EBONY_VPD_BASE where
it memcpy the hardwired Ethernet address from some location in flash.

Search for platform_init in the same general area. you will see a
reference to parse_bootinfo which really does nothing for ppc-boot. You
will need to replace it with something friendlier to ppc-boot.

#ifdef __ARIODATA__
void __init parse_ppcboot_boardinfo(unsigned long r3, unsigned long r4,
                unsigned long r5, unsigned long r6, unsigned long r7)
{
        if (r3) {
                memcpy((void *) __res, (void *) (r3 + KERNELBASE),
                       sizeof (bd_t));
        }
#if defined(CONFIG_BLK_DEV_INITRD)
        /*
         * If the init RAM disk has been configured in, and there's a
valid
         * starting address for it, set it up.
         */
        if (r4) {
                initrd_start = r4 + KERNELBASE;
                initrd_end = r5 + KERNELBASE;
        }
#endif                          /* CONFIG_BLK_DEV_INITRD */

        /* Copy the kernel command line arguments to a safe place. */

        if (r6) {
                *(char *) (r7 + KERNELBASE) = 0;
                strcpy(cmd_line, (char *) (r6 + KERNELBASE));
        }
}
#endif

void __init platform_init(unsigned long r3, unsigned long r4,
                unsigned long r5, unsigned long r6, unsigned long r7)
{
#ifdef __ARIODATA__
        parse_ppcboot_boardinfo( r3, r4, r5, r6, r7 );
#else
        parse_bootinfo((struct bi_record *) (r3 + KERNELBASE));
#endif
        ppc_md.setup_arch = ebony_setup_arch;
        ppc_md.show_cpuinfo = ebony_show_cpuinfo;
        ppc_md.init_IRQ = ebony_init_irq;
        ppc_md.get_irq = NULL;          /* Set in ppc4xx_pic_init() */

		.
		.
		.


You will also need to lift the board info structure from ppc-boot into
the kernel; the board info structure is in ppcboot.h and needs to be
copy into include/asm/ibm440.h.

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of
brian.auld@adic.com
Sent: Tuesday, February 04, 2003 11:40 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Kernel boot: 'Kernel command line' not getting bootargs?????



Ebony/440GP progress update.

I'm almost there ... I can smell it, I can taste it, I can hear it ....
but
I just can't see or feel it yet.

Wolfgang mentioned this in a previous post. As everyone knows,
appropriate
bootargs need to be passed for the kernel to boot with an nfs-mounted
root
filesystem. I've triple checked everything and am 99.9999% sure I'm
setting
the bootargs appropriately. For some reason, whenever I try booting, the
'Kernel command line:' always says 'ip=on'. I searched the archives and
couldn't anyone that had a similar problem.

I 'll attach my boot log with a printout of my u-boot env vars along the
way:

************************************************************************
*
************************************************************************
*
***************************   BOOT LOG
*********************************
************************************************************************
*
************************************************************************
*
U-Boot 0.2.0 (Jan 31 2003 - 05:12:55)

IBM PowerPC 440 Rev. C
Board: IBM 440GP Evaluation Board (Ebony)
        VCO: 800 MHz
        CPU: 400 MHz
        PLB: 133 MHz
        OPB: 66 MHz
        EPB: 66 MHz
I2C:   ready
DRAM:  I2c read: failed 4
I2c read: failed 4
128 MB
FLASH:  4.5 MB
PCI:   Bus Dev VenId DevId Class Int
In:    serial
Out:   serial
Err:   serial
KGDB:  kgdb ready
ready
BEDBUG:ready
=> printenv
baudrate=9600
ethaddr=00:04:AC:E3:1B:54
serial#=ADIC-Ebony1-iSCSI
bootcmd=bootp; setenv bootargs root=/dev/nfs rw
nfsroot=$(serverip):$(rootpath)
ip=$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname)::off; bootm
bootdelay=5
stdin=serial
stdout=serial
stderr=serial

Environment size: 272/4092 bytes
=> bootp
ENET Speed is 100 Mbps - HALF duplex connection
BOOTP broadcast 1
DHCP client bound to address 172.16.77.152
ARP broadcast 1
TFTP from server 172.16.77.151; our IP address is 172.16.77.152
Filename '/tftpboot/vmlinux.PPCBoot'.
Load address: 0x100000
Loading:
#################################################################
         ####################################################
done
Bytes transferred = 594015 (9105f hex)
=> printenv
baudrate=9600
ethaddr=00:04:AC:E3:1B:54
serial#=ADIC-Ebony1-iSCSI
bootcmd=bootp; setenv bootargs root=/dev/nfs rw
nfsroot=$(serverip):$(rootpath)
ip=$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname)::off; bootm
bootdelay=5
stdin=serial
stdout=serial
stderr=serial
bootfile=/tftpboot/vmlinux.PPCBoot
filesize=9105f
gatewayip=172.16.77.1
netmask=255.255.255.0
hostname=ebony1-linux-iSCSI
rootpath=/opt/eldk/ppc_4xx
ipaddr=172.16.77.152
serverip=172.16.77.151

Environment size: 465/4092 bytes
=> bootm
## Booting image at 00100000 ...
   Image Name:   Linux-2.4.20
   Created:      2003-02-03  18:02:31 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    593951 Bytes = 580 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.4.20 (root@ppc-dev) (gcc version 2.95.4 20010319
(prerelease/franzo/20011204)) #1 Mon Feb 3 12:59:58 EST 2003
IBM Ebony port (C) 2002 MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
>>>>>>>>>>>>>>>>>>>>>>>>>>>>
****************************
Kernel command line: ip=on * Why does this not reflect my bootarg??
****************************
<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Calibrating delay loop... 599.65 BogoMIPS
Memory: 127720k available (968k kernel code, 356k data, 212k init, 0k
highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0xfdfe9200 (irq = 0) is a 16550A
ttyS01 at 0xfdfe8300 (irq = 1) is a 16550A
Zmii bridge in RMII mode
eth0: Phy @ 0x8, type Am79c875A (0x00225541)
Reset ethernet interfaces
Zmii bridge in RMII mode
eth1: Phy @ 0x9, type Am79c875A (0x00225541)
Reset ethernet interfaces
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
eth0: IBM EMAC: link up, 100 Mbps Half Duplex, auto-negotiation
complete.
eth0: IBM EMAC: MAC 00:04:ac:e3:1b:54.
eth0: IBM EMAC: open completed

eth1: IBM EMAC: link up, 10 Mbps Half Duplex.
eth1: IBM EMAC: MAC 00:04:ac:e3:1b:55.
eth1: IBM EMAC: open completed

Sending BOOTP requests . OK
IP-Config: Got BOOTP answer from 172.16.77.151, my address is
172.16.77.152
IP-Config: Complete:
      device=eth0, addr=172.16.77.152, mask=255.255.255.0,
gw=172.16.77.1,
     host=ebony1-linux-iSCSI, domain=adic.com, nis-domain=(none),
     bootserver=172.16.77.151, rootserver=172.16.77.151,
rootpath=/opt/eldk/ppc_4xx
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 172.16.77.151
Looking up port of RPC 100005/1 on 172.16.77.151
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 212k init
modprobe: modprobe: Can't open dependencies file
/lib/modules/2.4.20/modules.dep (No such file or directory)
INIT: version 2.78 booting
INIT: /etc/inittab[2]: missing action field
INIT: /etc/inittab[13]: missing action field
INIT: /etc/inittab[16]: missing action field
INIT: /etc/inittab[20]: process field too long
INIT: /etc/inittab[21]: missing action field
INIT: /etc/inittab[22]: missing action field
INIT: Entering runlevel: 3
INIT: no more processes left in this runlevel

************************************************************************
*
************************************************************************
*
*********************** BOOT LOG END
********************************
************************************************************************
*
************************************************************************
*


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
