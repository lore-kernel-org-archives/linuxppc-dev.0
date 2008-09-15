Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.234])
	by ozlabs.org (Postfix) with ESMTP id C5DD9DE046
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Sep 2008 15:54:25 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2035478rvb.9
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Sep 2008 22:54:23 -0700 (PDT)
Message-ID: <fa686aa40809142254m68eaf3e8n614564a74667fcdf@mail.gmail.com>
Date: Sun, 14 Sep 2008 23:54:22 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Tim Yamin" <plasm@roo.me.uk>
Subject: Re: [PATCH]: [MPC5200] Add ATA DMA support
In-Reply-To: <792f5f410808130207t6ef3c3ddxeff0ad0debb39242@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <DD39B5C3F4963040ADC9768BE7E430CB03203A7B@is-hdq-exchange.marel.net>
	<792f5f410808120730j7b4be4f2n7a40de880178ccca@mail.gmail.com>
	<DD39B5C3F4963040ADC9768BE7E430CB03203ADC@is-hdq-exchange.marel.net>
	<792f5f410808120830v311e0446kc8fddfb97d0b9ea6@mail.gmail.com>
	<DD39B5C3F4963040ADC9768BE7E430CB03203B75@is-hdq-exchange.marel.net>
	<792f5f410808122257t3711eb2lfc1e02bacade16a3@mail.gmail.com>
	<fa686aa40808122302g197a8e90idc721796aa35ff05@mail.gmail.com>
	<792f5f410808122306u478b3ere8167016ef892323@mail.gmail.com>
	<20080813061135.GH17587@secretlab.ca>
	<792f5f410808130207t6ef3c3ddxeff0ad0debb39242@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, "Bienert, Shawn" <Shawn.Bienert@gdcanada.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 13, 2008 at 3:07 AM, Tim Yamin <plasm@roo.me.uk> wrote:
> On Wed, Aug 13, 2008 at 7:11 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> Sounds good to me.  You will get more testers that way.  I can pick it
>> up for -next if everything else looks good.
>
> Here are the new patches; tested against 2.6.27-rc3.

Hi Tim,

I finally got a chance to try out your patches on my lite5200 board.
Unfortunately, I wasn't able to get it to work easily.  I'm very early
in the debugging this issue, but I thought I'd send you my results in
case you've seen it before.  I've tried this with both an STEC 1GB CF
and a Transcend Ultra industrial 1GB CF card.

When the patch is enabled, Linux boots to the point of probing the ATA
bus.  The first attempt to probe uses UDMA/33 which ends in a timeout.
 Second attempt limits it to UDMA/25 which also times out.  Third
attempt falls back to PIO4 mode which then succeeds and the boot
process continues.  I haven't dug into the details of MPC5200 UDMA
support yet, but I'd like to know if you have any ideas.

Cheers,
g.

Full boot log below:

U-Boot 1.3.4-rc2 (Aug  1 2008 - 14:11:20)

CPU:   MPC5200B v2.2, Core v1.4 at 462 MHz
       Bus 132 MHz, IPB 132 MHz, PCI 33 MHz
Board: Freescale Lite5200B
I2C:   85 kHz, ready
DRAM:  256 MB
FLASH: 32 MB
PCI:   Bus Dev VenId DevId Class Int
        00  1a  1057  5809  0680  00
In:    serial
Out:   serial
Err:   serial
Net:   FEC ETHERNET
IDE:   Bus 0: OK
  Device 0: Model: TRANSCEND Firm: 20070418 Ser#: 0           521143E8
            Type: Hard Disk
            Capacity: 971.5 MB = 0.9 GB (1989792 x 512)
  Device 1: Model:  Firm:  Ser#:
            Type: # 1F #
            Capacity: not available
Hit any key to stop autoboot:  0
=> boot
Using FEC ETHERNET device
TFTP from server 192.168.0.200; our IP address is 192.168.0.70
Filename 'mpc5200/uImage.gcl'.
Load address: 0x400000
Loading: #################################################################
         #############################
done
Bytes transferred = 1376680 (1501a8 hex)
Using FEC ETHERNET device
TFTP from server 192.168.0.200; our IP address is 192.168.0.70
Filename 'mpc5200/lite5200b.dtb'.
Load address: 0x3f0000
Loading: #
done
Bytes transferred = 8192 (2000 hex)
## Booting kernel from Legacy Image at 00400000 ...
   Image Name:   Linux-2.6.27-rc6-00038-gc03fbd9
   Created:      2008-09-14   3:16:24 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1376616 Bytes =  1.3 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Flattened Device Tree blob at 003f0000
   Booting using the fdt blob at 0x3f0000
[    0.000000] Using lite5200 machine description
[    0.000000] Linux version 2.6.27-rc6-00038-gc03fbd9
(grant@trillian) (gcc version 4.0.0 (DENX ELDK 4.1 4.0.0)) #465 Sat
Sep 13 21:15:54 MDT 2008
[    0.000000] PCI host bridge /pci@f0000d00 (primary) ranges:
[    0.000000]  MEM 0x0000000080000000..0x000000009fffffff ->
0x0000000080000000 Prefetch
[    0.000000]  MEM 0x00000000a0000000..0x00000000afffffff ->
0x00000000a0000000
[    0.000000]   IO 0x00000000b0000000..0x00000000b0ffffff -> 0x0000000000000000
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00010000
[    0.000000]   Normal   0x00010000 -> 0x00010000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00010000
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 65024
[    0.000000] Kernel command line: root=/dev/nfs rw
nfsroot=192.168.0.200:/home/srv/nfs/gdc/lite5200-1
ip=192.168.0.70:192.168.0.200:192.168.0.1:255.255.255.0:lite5200-1:eth0:off
console=ttyPSC0,115200
[    0.000000] MPC52xx PIC is up and running!
[    0.000000] PID hash table entries: 1024 (order: 10, 4096 bytes)
[    0.000000] clocksource: timebase mult[79364d9] shift[22] registered
[    0.000194] console [ttyPSC0] enabled
[    0.120005] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.128964] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.166748] Memory: 256572k/262144k available (2740k kernel code,
5272k reserved, 108k data, 108k bss, 168k init)
[    0.177420] SLUB: Genslabs=12, HWalign=32, Order=0-3, MinObjects=0,
CPUs=1, Nodes=1
[    0.185307] Calibrating delay loop... 65.79 BogoMIPS (lpj=131584)
[    0.280159] Mount-cache hash table entries: 512
[    0.288690] net_namespace: 288 bytes
[    0.293054] NET: Registered protocol family 16
[    0.314694] PCI: Probing PCI hardware
[    0.319804] bus: 00 index 0 io port: [ffffff, 100c03f2000]
[    0.325470] bus: 00 index 1 mmio: [800000009fffffff, a0b]
[    0.331081] bus: 00 index 2 mmio: [a0000000afffffff, a4b]
[    0.336808] DMA: MPC52xx BestComm driver
[    0.341125] DMA: MPC52xx BestComm engine @f0001200 ok !
[    0.355586] SCSI subsystem initialized
[    0.376841] NET: Registered protocol family 2
[    0.415732] IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.423336] TCP established hash table entries: 8192 (order: 4, 65536 bytes)
[    0.431208] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[    0.438151] TCP: Hash tables configured (established 8192 bind 8192)
[    0.444701] TCP reno registered
[    0.459823] NET: Registered protocol family 1
[    0.504368] msgmni has been set to 501
[    0.508420] io scheduler noop registered
[    0.512499] io scheduler anticipatory registered (default)
[    0.518146] io scheduler deadline registered
[    0.522741] io scheduler cfq registered
[    0.984815] Generic RTC Driver v1.07
[    0.989504] Serial: MPC52xx PSC UART driver
[    0.994153] f0002000.serial: ttyPSC0 at MMIO 0xf0002000 (irq = 129)
is a MPC52xx PSC
[    1.021517] brd: module loaded
[    1.033964] loop: module loaded
[    1.057979] mpc52xx MII bus: probed
[    1.063689] net eth0: Using PHY at MDIO address 0
[    1.069486] Driver 'sd' needs updating - please use bus_type methods
[    1.076496] ata: MPC52xx IDE/ATA libata driver
[    1.081946] scsi0 : mpc52xx_ata
[    1.086095] ata1: PATA max UDMA/33 ata_regs 0xf0003a00 irq 135
[    1.255960] ata1.00: ATA-4: TRANSCEND, 20070418, max UDMA/66
[    1.261807] ata1.00: 1989792 sectors, multi 0: LBA
[    1.279847] ata1.00: configured for UDMA/33
[    1.284902] scsi 0:0:0:0: Direct-Access     ATA      TRANSCEND
  2007 PQ: 0 ANSI: 5
[    1.294794] sd 0:0:0:0: [sda] 1989792 512-byte hardware sectors (1019 MB)
[    1.302014] sd 0:0:0:0: [sda] Write Protect is off
[    1.307411] sd 0:0:0:0: [sda] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[    1.317467] sd 0:0:0:0: [sda] 1989792 512-byte hardware sectors (1019 MB)
[    1.324683] sd 0:0:0:0: [sda] Write Protect is off
[    1.330081] sd 0:0:0:0: [sda] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[    1.339489]  sda:<3>ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0
action 0x6 frozen
[   31.345893] ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0
dma 4096 in
[   31.345905]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[   31.360881] ata1.00: status: { DRDY }
[   31.364705] ata1: soft resetting link
[   31.547846] ata1.00: configured for UDMA/33
[   31.552225] ata1: EH complete
[   61.551658] ata1.00: limiting speed to UDMA/25:PIO4
[   61.556708] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[   61.563983] ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0
dma 4096 in
[   61.563993]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[   61.578959] ata1.00: status: { DRDY }
[   61.582776] ata1: soft resetting link
[   61.763845] ata1.00: configured for UDMA/25
[   61.768223] ata1: EH complete
[   91.767668] ata1.00: limiting speed to PIO4
[   91.772012] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[   91.779287] ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0
dma 4096 in
[   91.779297]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[   91.794272] ata1.00: status: { DRDY }
[   91.798094] ata1: soft resetting link
[   91.979846] ata1.00: configured for PIO4
[   91.983958] ata1: EH complete
[   91.988286]  sda1 sda2
[   91.992885] sd 0:0:0:0: [sda] Attached SCSI disk
[   91.998678] i2c /dev entries driver
[   92.008333] TCP cubic registered
[   92.011711] NET: Registered protocol family 17
[   92.017539] RPC: Registered udp transport module.
[   92.022418] RPC: Registered tcp transport module.
[   92.536899] net eth0: attached phy 0 to driver LXT971
[   93.543913] IP-Config: Complete:
[   93.547047]      device=eth0, addr=192.168.0.70,
mask=255.255.255.0, gw=192.168.0.1,
[   93.554973]      host=lite5200-1, domain=, nis-domain=(none),
[   93.560881]      bootserver=192.168.0.200,
rootserver=192.168.0.200, rootpath=
[   93.568846] Looking up port of RPC 100003/2 on 192.168.0.200
[   95.535725] PHY: f0003000:00 - Link is Up - 100/Full
[  103.576944] Looking up port of RPC 100005/1 on 192.168.0.200
[  108.628289] VFS: Mounted root (nfs filesystem).
[  108.633152] Freeing unused kernel memory: 168k init
Mount failed for selinuxfs on /selinux:  No such file or directory
modprobe: FATAL: Could not load
/lib/modules/2.6.27-rc6-00038-gc03fbd9/modules.dep: No such file or
directory

modprobe: FATAL: Could not load
/lib/modules/2.6.27-rc6-00038-gc03fbd9/modules.dep: No such file or
directory

INIT: version 2.86 booting
Setting the system clock.
Timed out waiting for time change.
Unable to set System Clock to: Thu Jan 1 00:01:51 UTC 1970 (warning).
Activating swap...done.
Setting the system clock.
Timed out waiting for time change.
Unable to set System Clock to: Thu Jan 1 00:01:53 UTC 1970 (warning).
Cleaning up ifupdown....
Loading kernel modules...FATAL: Could not load
/lib/modules/2.6.27-rc6-00038-gc03fbd9/modules.dep: No such file or
directory
Checking file systems...fsck 1.41.1 (01-Sep-2008)
dosfsck 2.11, 12 Mar 2005, FAT32, LFN
/dev/sda1: 12 files, 5665/15569 clusters
done.
Setting kernel variables (/etc/sysctl.conf)...done.
Mounting local filesystems...done.
Activating swapfile swap...done.
Setting up networking....
Configuring network interfaces...done.
Starting portmap daemon....
Starting NFS common utilities: statd.
INIT: Entering runlevel: 2
Starting system log daemon....
Starting kernel log daemon....
Starting OpenBSD Secure Shell server: sshd.
Starting NFS common utilities: statd.
Starting NTP server: ntpd.
Starting periodic command scheduler: crond.
[  122.655831] warning: `ntpd' uses 32-bit capabilities (legacy support in use)

Debian GNU/Linux lenny/sid lite5200-1 ttyPSC0

lite5200-1 login: Connection closed by foreign host.
grant@gdc-sandbox:~$


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
