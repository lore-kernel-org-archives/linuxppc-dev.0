Message-Id: <v03110700b7e6165a1f85@[64.230.145.122]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 7 Oct 2001 10:38:19 -0400
To: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.yellowdoglinux.com
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: still no luck with Radeon or Adaptec SCSI controller in 2.4.X
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I just built and tried the latest 2.4.11 kernel of Ben's and still can't
get the Radeon or the AIC-7XXX Adaptec SCSI PCI card (from Apple) to work.

Here are the relevant pieces from lspci and the mdesg log:

PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Cannot allocate resource region 1 of device 01:04.0

...

PCI: Enabling device 01:04.0 (0084 -> 0087)
radeonfb: ref_clk=2700, ref_div=67, xclk=16600
radeonfb: ATI Radeon DDR SGRAM 32 MB

...

SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec 2902/04/10/15/20/30C SCSI adapter>
        aic7850: Ultra Single Channel A, SCSI Id=7, 3/255 SCBs

  Vendor: QUANTUM   Model: FIREBALL_TM3200S  Rev: 300N
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST39140N          Rev: 1498
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: IOMEGA    Model: ZIP 100           Rev: L.27
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:0:1:0: Tagged Queuing enabled.  Depth 253
scsi0:0:2:0: Tagged Queuing enabled.  Depth 253
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
scsi2 : MESH
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 2, lun 0
Attached scsi removable disk sdc at scsi0, channel 0, id 5, lun 0
(scsi0:A:1): 20.000MB/s transfers (20.000MHz, offset 15)
SCSI device sda: 6281856 512-byte hdwr sectors (3216 MB)
 /dev/scsi/host0/bus0/target1/lun0: [mac] p1 p2 p3 p4 p5 p6 p7 p8
(scsi0:A:2): 20.000MB/s transfers (20.000MHz, offset 15)
SCSI device sdb: 17783240 512-byte hdwr sectors (9105 MB)
 /dev/scsi/host0/bus0/target2/lun0: [mac] p1 p2 p3 p4 p5 p6 p7
sdc : READ CAPACITY failed.
sdc : status = 1, message = 00, host = 0, driver = 08
Current sd00:00: sense key Not Ready
Additional sense indicates Medium not present
sdc : block size assumed to be 512 bytes, disk size 1GB.
 /dev/scsi/host0/bus0/target5/lun0: I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
 unable to read partition table
...

Here is what lspci says:

01:02.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
	Subsystem: Adaptec AHA-2904/Integrated AIC-7850
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (1000ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 23
	Region 0: I/O ports at 1000 [disabled] [size=256]
	Region 1: Memory at 80882000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 80890000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

...

01:04.0 VGA compatible controller: ATI Technologies Inc: Unknown device
5144 (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0908
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 25
	Region 0: Memory at 88000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 1c00 [size=256]
	Region 2: Memory at 80980000 (32-bit, non-prefetchable) [size=512K]
	Expansion ROM at 808e0000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


So why does lspci not know the Radeom device id.  The device id is 5144
which is in the radeon.h list and is identified as a RADEON_QD?

Why did the pci probe not able to allocate the resources for it?

> PCI: Cannot allocate resource region 1 of device 01:04.0


Then after using scsi awhile, I started to get the dreaded "aix7xxx_abort
returns 8194" and all was basically lost.

I tried to load the OLD AIC7XXX driver but could not find the proper line
for the .config file:
CONFIG_SCSI_AIC7XXX_OLD is no longer present in the .config

Has that older driver been removed?  Does anyone know the e-mail address of
the maintainer that I could contact directly (Justin T. Gibbs)?

Any ideas welcome!

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
