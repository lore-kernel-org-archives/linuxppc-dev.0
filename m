Return-Path: <m_123456_h@hotmail.com>
Received: from bay0-omc2-s29.bay0.hotmail.com (bay0-omc2-s29.bay0.hotmail.com
	[65.54.246.165]) by ozlabs.org (Postfix) with ESMTP id 99C4ADDF52
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Feb 2007 16:11:18 +1100 (EST)
Message-ID: <BAY116-F750CC7583A9FF132FE0E2CD9E0@phx.gbl>
From: "Jack Ger" <m_123456_h@hotmail.com>
To: vbordug@ru.mvista.com
Subject: Re: Problem with linking customer phy with fs_enet drivers
Date: Tue, 06 Feb 2007 21:11:15 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Vitaly,

Thanks for your response.

I dont know how to create the patch which I changed.  I disabled
all the board_init in mpc885ads_setup.c, and disable the scc and fcc
driver init function in the fs_enet-main.c init.

Probably if you look at the booting message, you might have a clue.
Here it is:

loaded at:     00400000 0050818C
board data at: 00506124 0050616C
relocated to:  00405088 004050D0
zimage at:     00405849 00505E76
avail ram:     00509000 02000000

Linux/PPC load: root=/dev/nfs rw ip=on
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.6.10_mvl401-866ads (Acer@Jones) (gcc version 3.4.3 
(MontaVista 3.4.3-25.0.100.0600797 2006-06-06)) #122 Tue Feb 6 16:09:17 PST 
2007
I2C/SPI microcode patch installed.
borad init------
Built 1 zonelists
Kernel command line: root=/dev/nfs rw ip=on
PID hash table entries: 256 (order: 8, 4096 bytes)
Decrementer Frequency = 300000000/60
hr_time_init: arch_to_nsec = 419430400, nsec_to_arch = 21474836
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 30080k available (1740k kernel code, 424k data, 120k init, 0k 
highmem)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
spawn_desched_task(00000000)
desched cpu_callback 3/00000000
ksoftirqd started up.
desched cpu_callback 2/00000000
desched thread 0 started up.
NET: Registered protocol family 16
mympc: Init 0
mympc: Init i2c 1
Registering platform device 'fsl-cpm-fec.1'. Parent at platform
Registering platform device 'fsl-cpm-i2c.1'. Parent at platform
Generic PHY: Registered new driver
Linux Kernel Card Services
  options:  none
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Serial: CPM driver $Revision: 0.01 $
ttyCPM0 at MMIO 0xff000a80 (irq = 20) is a CPM UART
io scheduler noop registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
LXT970: Registered new driver
fs_enet.c:v1.0 (Aug 8, 2005)
i2c /dev entries driver
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
PCMCIA slot A: phys mem 08000000...08210000 (size 00210000)
physmap flash device: 1000000 at 10000000
phys_mapped_flash: Found 1 x16 devices at 0x0 in 16-bit bank
Amd/Fujitsu Extended Query Table at 0x0040
phys_mapped_flash: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
cmdlinepart partition parsing not available
RedBoot partition parsing not available
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
NET: Registered protocol family 1
NET: Registered protocol family 17
fixed@100:1 not found
eth0: Could not attach to PHY
IP-Config: Failed to open eth0
IP-Config: No network devices available.
Looking up port of RPC 100003/2 on 192.168.1.217
RPC: sendmsg returned error 101
portmap: RPC call returned error 101
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 192.168.1.217
RPC: sendmsg returned error 101
portmap: RPC call returned error 101
Root-NFS: Unable to get mountd port number from server, using default
RPC: sendmsg returned error 101
mount: RPC call returned error 101
Root-NFS: Server returned error -101 while mounting /mnt/trgt_root
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "nfs" or unknown-block(2,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(2,0)
<0>Rebooting in 180 seconds..


A Jones

>From: Vitaly Bordug <vbordug@ru.mvista.com>
>To: "Jack Ger" <m_123456_h@hotmail.com>
>CC: linuxppc-embedded@ozlabs.org
>Subject: Re: Problem with linking customer phy with fs_enet drivers
>Date: Tue, 6 Feb 2007 18:57:51 +0300
>
>On Sun, 04 Feb 2007 15:19:41 -0800
>"Jack Ger" <m_123456_h@hotmail.com> wrote:
>
> > Hi all,
> >
> > I am trying to run the customer LXT970 phy with MPC870, porting from
> > MPC885.  I have the lxt phy driver installed and fs_enet driver 
>installed
> > during
> > the kernel bootup.  But during the the fs_enet_open, when trying to link
> > the specific phy, it fails to find the bus_id.   Since we already know 
>that
> > the FEC
> > is working in 2.4 kernel runing the 8xx_io fec,  it must be something I 
>have
> > done
> > wrong with the fs_enet, 2 questions:
> >
>It would be easier not to repeat myself to figure out the reason, and have 
>a look
>at the patch. Mind posting it here?
>
>If that is a problem, send it to me and I'll try to get a few hins out...
>
> > 1) I understood that probably I didn't activate the bus, since I am 
>porting
> > it
> > from MPC885fads_setup.c, there is something I missed.  Currently I am 
>using
> > montavista 4.0.1 which runing on kernel 2.6.10.; I noticed that the
> > mdiobus_register
> > never get called.
> >
> > 2) what is the right way to do the mdiobus_register to register the phy 
>bus?
> >
> > TIA for your help.
> >
> > A Jones
> >
> > _________________________________________________________________
> > Laugh, share and connect with Windows Live Messenger
> > 
>http://clk.atdmt.com/MSN/go/msnnkwme0020000001msn/direct/01/?href=http://imagine-msn.com/messenger/launch80/default.aspx?locale=en-us&source=hmtagline
> >
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
>--
>Sincerely,
>Vitaly

_________________________________________________________________
Valentine’s Day -- Shop for gifts that spell L-O-V-E at MSN Shopping 
http://shopping.msn.com/content/shp/?ctId=8323,ptnrid=37,ptnrdata=24095&tcode=wlmtagline
