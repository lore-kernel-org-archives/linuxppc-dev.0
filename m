Message-Id: <199901091329.OAA26473@denx.muc.de>
To: linuxppc-dev@lists.linuxppc.org
From: Wolfgang Denk <wd@denx.muc.de>
Subject: Re: MBX860: How to boot with initrd ? 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 09 Jan 1999 00:49:17 +0100."
             <199901082349.AAA13864@denx.muc.de>
Date: Sat, 09 Jan 1999 14:29:20 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


F'up to my own message:

In message <199901082349.AAA13864@denx.muc.de> I wrote:
> 
> I'm trying to boot with `initrd' support on a MBX860 system.  I  know
...
> 	Linux/PPC load: console=tty0 console=ttyS0,9600n8
> 	Uncompressing Linux...done.
> 	Now booting the kernel
> 
> Then the system hangs, and I have to reset it.

I guess I should have mentioned that I know that  I  have  to  add  a
"root=/dev/ram"  to  the  command  line  when  booting when using the
generic code. I have modified arch/ppc/boot/misc.c a bit; maybe  this
in of general interest:

--- arch/ppc/boot/misc.c.ORIG	Thu Dec 17 11:39:53 1998
+++ arch/ppc/boot/misc.c	Sat Jan  9 14:05:25 1999
@@ -51,7 +51,15 @@
 char	*cmd_line = cmd_buf;
 
 #if defined(CONFIG_MBX) || defined(CONFIG_FADS)
+#if defined(CONFIG_ROOT_NFS)
 char	*root_string = "root=/dev/nfs";
+#else
+# if defined(CONFIG_BLK_DEV_INITRD)
+char	*root_string = "root=/dev/ram";
+# else
+char	*root_string = "";
+# endif
+#endif
 char	*nfsaddrs_string = "nfsaddrs=";
 char	*nfsroot_string = "nfsroot=";
 char	*defroot_string = "/sys/mbxroot";


And, which makes things even more interesting: there was one kernel
where I was able to boot from the initrd; however, I got some error
messages from the hard disk:

    Linux/PPC load: console=tty0 console=ttyS0,9600n8 root=/dev/ram

    XXX Linux/PPC load: console=tty0 console=ttyS0,9600n8 root=/dev/ram
    Uncompressing Linux...done.
    Now booting the kernel
    Linux version 2.2.0-pre5 (wd@denx.muc.de) (gcc version egcs-2.91.60 19981201 (egcs-1.1.1 release)) #3 Sat Jan 9 11:43:50 MET 1999
    Boot arguments: console=tty0 console=ttyS0,9600n8 root=/dev/ram root=/dev/nfs nfsroot=/sys/mbxroot
    time_init: decrementer frequency = 150000000/60
    Calibrating delay loop... 39.63 BogoMIPS
    Memory: 34996k available (592k kernel code, 744k data, 28k init) [c0000000,c2400000]
    POSIX conformance testing by UNIFIX
    PCI: Probing PCI hardware
    Linux NET4.0 for Linux 2.2
    Based upon Swansea University Computer Society NET3.039
    NET4: Unix domain sockets 1.0 for Linux NET4.0.
    NET4: Linux TCP/IP 1.0 for NET4.0
    IP Protocols: ICMP, UDP, TCP, IGMP
    Starting kswapd v 1.5 
    CPM UART driver version 0.02
    ttyS00 at 0x0280 is a SMC
    ttyS01 at 0x0380 is a SMC
    ttyS02 at 0x0100 is a SCC
    ttyS03 at 0x0200 is a SCC
    pty: 256 Unix98 ptys configured
    RAM disk driver initialized:  16 RAM disks of 4096K size
    hdc: probing with STATUS(0x80) instead of ALTSTATUS(0x08)
    hdc: probing with STATUS(0x80) instead of ALTSTATUS(0x08)
    hdc: no response (status = 0x80), resetting drive
    hdc: probing with STATUS(0x80) instead of ALTSTATUS(0x08)
    hdc: no response (status = 0x80)
    hdg: probing with STATUS(0x24) instead of ALTSTATUS(0x08)
    hdg: probing with STATUS(0x24) instead of ALTSTATUS(0x08)
    hdg: no response (status = 0xa1), resetting drive
    hdg: probing with STATUS(0x24) instead of ALTSTATUS(0x08)
    hdg: no response (status = 0xa1)
    hdh: probing with STATUS(0x24) instead of ALTSTATUS(0x08)
    hdh: probing with STATUS(0x24) instead of ALTSTATUS(0x08)
    hdh: no response (status = 0xa1), resetting drive
    hdh: probing with STATUS(0x24) instead of ALTSTATUS(0x08)
    hdh: no response (status = 0xa1)
    hdc: probing with STATUS(0x80) instead of ALTSTATUS(0x08)
    hdc: probing with STATUS(0x80) instead of ALTSTATUS(0x08)
    hdc: no response (status = 0x80), resetting drive
    hdc: probing with STATUS(0x80) instead of ALTSTATUS(0x08)
    hdc: no response (status = 0x80)
    hdg: probing with STATUS(0x24) instead of ALTSTATUS(0x08)
    hdg: probing with STATUS(0x24) instead of ALTSTATUS(0x08)
    hdg: no response (status = 0xa1), resetting drive
    hdg: probing with STATUS(0x24) instead of ALTSTATUS(0x08)
    hdg: no response (status = 0xa1)
    hdh: probing with STATUS(0x24) instead of ALTSTATUS(0x08)
    hdh: probing with STATUS(0x24) instead of ALTSTATUS(0x08)
    hdh: no response (status = 0xa1), resetting drive
    hdh: probing with STATUS(0x24) instead of ALTSTATUS(0x08)
    hdh: no response (status = 0xa1)
    CPM ENET Version 0.1, 08:00:3e:26:38:4a
    RAMDISK: Compressed image found at block 0
    EXT2-fs warning: checktime reached, running e2fsck is recommended
    VFS: Mounted root (ext2 filesystem).ê

    ### Initial RAM disk starting interactive shell ###
    bash# 

Ok, so I removed the IDE support from  the  configuration  because  I
don't  need  it right now; the kernel did not boot any more. Restored
the old configuration - didn't boot either.

Since then, all kernels hang the same way, and I don't have an idea
what might be wrong..

Wolfgang

-- 
Phone:  (+49)-89-95720-110   Fax: (+49)-89-95720-112   wd@denx.muc.de
Office: (+49)-89-722-27328               Wolfgang.Denk@ICN.Siemens.DE
Harrisberger's Fourth Law of the Lab:
	Experience is directly proportional to the
	amount of equipment ruined.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
