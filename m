Message-Id: <v03110701b7e62baebe04@[64.230.151.19]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 7 Oct 2001 12:07:12 -0400
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: no luck with Adaptec SCSI controller in 2.4.X
Cc: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.yellowdoglinux.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Sorry to bother you, I am trying to move from the 2.2.19 kernel to
Ben Herrenschmidt's latest 2.4.11 kernel on a ppc linux B+W G3 machine
(same error occurs on 2.4.6, and 2.4.8 kernels too).

I have an Apple supplied Adaptec SCSI PCI 2930CU card.

After using scsi for a few minutes, I receive a flood of the following
error messages:

aic7xxx_abort returns 8194

and basically my machine becomes unusable.

If I return to the 2.2.29 kernel, everything works fine.

Here is what dmesg says about my card:
>
>SCSI subsystem driver Revision: 1.00
>scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
>        <Adaptec 2902/04/10/15/20/30C SCSI adapter>
>        aic7850: Ultra Single Channel A, SCSI Id=7, 3/255 SCBs
>
>  Vendor: QUANTUM   Model: FIREBALL_TM3200S  Rev: 300N
>  Type:   Direct-Access                      ANSI SCSI revision: 02
>  Vendor: SEAGATE   Model: ST39140N          Rev: 1498
>  Type:   Direct-Access                      ANSI SCSI revision: 02
>  Vendor: IOMEGA    Model: ZIP 100           Rev: L.27
>  Type:   Direct-Access                      ANSI SCSI revision: 02
>scsi0:0:1:0: Tagged Queuing enabled.  Depth 253
>scsi0:0:2:0: Tagged Queuing enabled.  Depth 253
>scsi1 : SCSI host adapter emulation for IDE ATAPI devices
>scsi2 : MESH
>Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
>Attached scsi disk sdb at scsi0, channel 0, id 2, lun 0
>Attached scsi removable disk sdc at scsi0, channel 0, id 5, lun 0
>(scsi0:A:1): 20.000MB/s transfers (20.000MHz, offset 15)
>SCSI device sda: 6281856 512-byte hdwr sectors (3216 MB)
> /dev/scsi/host0/bus0/target1/lun0: [mac] p1 p2 p3 p4 p5 p6 p7 p8
>(scsi0:A:2): 20.000MB/s transfers (20.000MHz, offset 15)
>SCSI device sdb: 17783240 512-byte hdwr sectors (9105 MB)
> /dev/scsi/host0/bus0/target2/lun0: [mac] p1 p2 p3 p4 p5 p6 p7
>sdc : READ CAPACITY failed.
>sdc : status = 1, message = 00, host = 0, driver = 08
>Current sd00:00: sense key Not Ready
>Additional sense indicates Medium not present
>sdc : block size assumed to be 512 bytes, disk size 1GB.
> /dev/scsi/host0/bus0/target5/lun0: I/O error: dev 08:20, sector 0
> I/O error: dev 08:20, sector 0
> unable to read partition table


Here is what lspci says:
>
>01:02.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
>	Subsystem: Adaptec AHA-2904/Integrated AIC-7850
>	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
>Stepping- SERR- FastB2B-
>	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
><TAbort- <MAbort- >SERR- <PERR-
>	Latency: 16 (1000ns min, 1000ns max), cache line size 08
>	Interrupt: pin A routed to IRQ 23
>	Region 0: I/O ports at 1000 [disabled] [size=256]
>	Region 1: Memory at 80882000 (32-bit, non-prefetchable) [size=4K]
>	Expansion ROM at 80890000 [disabled] [size=64K]
>	Capabilities: [dc] Power Management version 1
>		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
>PME(D0-,D1-,D2-,D3hot-,D3cold-)
>		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>

I tried to load the OLD AIC7XXX driver but could not find the proper line
for the .config file.

It seems CONFIG_SCSI_AIC7XXX_OLD is no longer present in the .config.

Has this been removed?  If so, is there a patch that can add it back.

Here are the kernel error messages:

Oct  6 21:06:25 localhost kernel: scsi0:0:1:0: Attempting to queue an ABORT
message
Oct  6 21:06:25 localhost kernel: scsi0:0:1:0: Command found on device queue
Oct  6 21:06:25 localhost kernel: aic7xxx_abort returns 8194
Oct  6 21:06:25 localhost kernel: scsi0:0:1:0: Attempting to queue an ABORT
message
Oct  6 21:06:25 localhost kernel: scsi0:0:1:0: Command found on device queue


As I aid, my complete system works fine under 2.2.19.

Any idea on how I can debug this or what information you might need to
debug this
further would be greatly appreciated.

Just to be safe, I have tried this with 2.4.6, 2.4.8, and 2.4.11 and
all error out in exactly the same way.

Any help would be greatly appreciated.

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
