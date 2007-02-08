Return-Path: <Sylvain.Joyeau@thomson.net>
Received: from dmzraw4.extranet.thmulti.com (dmzraw4.extranet.thmulti.com
	[141.11.234.72]) by ozlabs.org (Postfix) with ESMTP id 21E78DDF48
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Feb 2007 00:41:59 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: PCI2 issue on MPC8541
Date: Thu, 8 Feb 2007 14:02:27 +0100
Message-ID: <B00307ADBC68954AA8D6FB3AC8FD66F38DCDE3@rennsmail05.eu.thmulti.com>
From: "Joyeau Sylvain" <Sylvain.Joyeau@thomson.net>
To: "Shriram Janardhan" <shriramjanardhan@yahoo.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Shriram,

We faced a similar issue on PCI2/MPC8541 with linux 2.6.13. This version =
(and probably older ones) have a bug related to PCI2 ressource =
allocation inside the kernel (in particular due to wrong =
'mpc85xx_pci1_last_busno' variable initialisation).
Upgrading to the last stable kernel release (2.6.19 for sure) may help.

--
Sylvain.


> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+sylvain.joyeau=3Dthomson.net@ozlabs.or
g [mailto:linuxppc-embedded-> =
bounces+sylvain.joyeau=3Dthomson.net@ozlabs.org] On Behalf Of=20
> Shriram Janardhan
> Sent: mercredi 7 f=E9vrier 2007 20:23
> To: linuxppc-embedded@ozlabs.org
> Subject: PCI2 issue on MPC8541
>=20
> Hello everybody,
> =20
> I'm having an issue w.r.t PCI2 on MPC8541 and would=20
> appreciate if anybody could share their thoughts on what=20
> could be wrong.
> =20
> We're running the 2.6.11 version of the linux kernel on=20
> MPC8541 and having trouble getting the cardmgr to initialize=20
> a compact flash connected to PCI2 through a TI1510 bridge.
> =20
> We have two CFs connected through two TI1510 bridges to the=20
> two PCI controllers.  When cardmgr is invoked to intialize=20
> the two sockets, the PCI1/ide0 initialization goes on fine=20
> but the PCI2/ide-cs initialization fails. =20
> =20
> The bridges are on slot 11 of the respective controllers and=20
> the interrupts from the two bridges are multiplexed onto the=20
> same external interrupt pin(EXT2) of the 8541.
> =20
> For the second CF, we are able to read the CIS and correctly=20
> identify the CF, but the cardmgr fails while trying to=20
> execute the IOCTL DS_GET_DEVICE_INFO.
> =20
> ------------------------------------------------------------
> (none)#
> (none)# lspci -vv
> 00:00.0 Class 0b20: 1057:000c (rev 11)
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-=20
> VGASnoop- ParErr- Step
> ping- SERR+ FastB2B-
>         Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast=20
> >TAbort- <TAbort-
> <MAbort+ >SERR- <PERR-
>         Latency: 128
>         Interrupt: pin A routed to IRQ 0
>         Region 0: Memory at 9ff00000 (32-bit,=20
> non-prefetchable) [size=3D1M]
>         Region 1: Memory at <unassigned> (32-bit,=20
> prefetchable) [size=3D80000000]
>         Region 2: Memory at <unassigned> (64-bit, non-prefetchable)
>         Region 4: Memory at <unassigned> (64-bit, non-prefetchable)
> =20
> 00:0b.0 Class 0607: 104c:ac56
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-=20
> VGASnoop- ParErr- Step
> ping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-=20
> DEVSEL=3Dmedium >TAbort- <TAbort
> - <MAbort- >SERR- <PERR-
>         Latency: 168, cache line size 08
>         Interrupt: pin A routed to IRQ 98
>         Region 0: Memory at 80000000 (32-bit,=20
> non-prefetchable) [size=3D4K]
>         Bus: primary=3D00, secondary=3D01, subordinate=3D04, =
sec-latency=3D176
>         Memory window 0: 80400000-807ff000 (prefetchable)
>         Memory window 1: 80800000-80bff000
>         I/O window 0: 00001000-000010ff
>         I/O window 1: 00001400-000014ff
>         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+=20
> 16bInt+ PostWrite+
>         16-bit legacy interface ports at 0001
> =20
> 02:00.0 Class 0b20: 1057:000c (rev 11)
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-=20
> VGASnoop- ParErr- Step
> ping- SERR+ FastB2B-
>         Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast=20
> >TAbort- <TAbort-
> <MAbort+ >SERR- <PERR-
>         Latency: 128
>         Interrupt: pin A routed to IRQ 0
>         Region 0: Memory at bff00000 (32-bit,=20
> non-prefetchable) [size=3D1M]
>         Region 1: Memory at <unassigned> (32-bit,=20
> prefetchable) [size=3D80000000]
>         Region 2: Memory at <unassigned> (64-bit, non-prefetchable)
>         Region 4: Memory at <unassigned> (64-bit, non-prefetchable)
> =20
> 02:0b.0 Class 0607: 104c:ac56
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-=20
> VGASnoop- ParErr- Step
> ping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-=20
> DEVSEL=3Dmedium >TAbort- <TAbort
> - <MAbort- >SERR- <PERR-
>         Latency: 168, cache line size 08
>         Interrupt: pin A routed to IRQ 98
>         Region 0: Memory at a0000000 (32-bit,=20
> non-prefetchable) [size=3D4K]
>         Bus: primary=3D02, secondary=3D03, subordinate=3D06, =
sec-latency=3D176
>         Memory window 0: a0400000-a07ff000 (prefetchable)
>         Memory window 1: a0800000-a0bff000
>         I/O window 0: 00000000-000000ff
>         I/O window 1: 00000400-000004ff
>         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+=20
> 16bInt+ PostWrite+
>         16-bit legacy interface ports at 0001
> =20
> (none)#
> --------------------------------------------------------------------
> (none)# cardmgr -v -o
> cardmgr[865]: watching 2 sockets
> cardmgr[865]: starting, version is 3.2.8
> cardmgr[865]: initializing socket 0
> cardmgr[86Probing IDE interface ide0...
> 5]: socket 0: ATA/IDE Fixed Disk
> cardmgr[865]:   product info: "Wintec Industries", "CF 256MB"
> cardmgr[865]:   function: 4 (fixed disk)
> hda: CF 256MB, CFA DISK drive
> ide0 at 0x000-0x007,0x00e on irq 98
> hda: max request size: 128KiB
> hda: 513536 sectors (262 MB) w/0KiB Cache, CHS=3D1003/16/32
> hda: cache flushes not supported
>  hda: hda1
> ide-cs: hda: Vcc =3D 3.3, Vpp =3D 0.0
> cardmgr[865]: executing: './ide start hda'
> cardmgr[865]: + mknod /dev/hda b 3 0
> cardmgr[865]: + mknod /dev/hda1 b 3 1
> cardmgr[865]: + mknocs: memory probe 0x80000000-0x9fffffff:d=20
> /dev/hda2 b 3  excl
> uding2
> cardmgr[865] 0x80000000-0x9fffffff: + mknod /dev/h
> da3 b 3 3
> cardcs: memory probe 0xa0000000-0xbfffffff:mgr[865]: + mkno=20
> excludingd /dev/hda4
>  b 3  0xa0000000-0xa1ffffff4
> cardmgr[865] 0xbe000000-0xbfffffff: + mknod /dev/h
> da5 b 3 5
> card1.0: mgr[865]: + mknoGetNextTuple: No more items
> d /dev/hda6 b 3 6
> cardmgr[865]: + mknod /dev/hda7 b 3 7
> cardmgr[865]: + mknod /dev/hda8 b 3 8
> cardmgr[865]: + mknod /dev/hda9 b 3 9
> cardmgr[865]: + mknod /dev/hda10 b 3 10
> cardmgr[865]: + mknod /dev/hda11 b 3 11
> cardmgr[865]: + mknod /dev/hda12 b 3 12
> cardmgr[865]: + mknod /dev/hda13 b 3 13
> cardmgr[865]: + mknod /dev/hda14 b 3 14
> cardmgr[865]: + mknod /dev/hda15 b 3 15
> cardmgr[865]: + mknod /dev/hda16 b 3 16
> cardmgr[865]: initializing socket 1
> cardmgr[865]: socket 1: ATA/IDE Fixed Disk
> cardmgr[865]:   product info: "SILICONSYSTEMS", "VER2.00"
> cardmgr[865]:   function: 4 (fixed disk)
> cardmgr[865]: get dev info on socket 1 failed: No such device
> cardmgr[865]: exiting
> (none)#
> --------------------------------------------------------------
> -------------------------
> (none)# cat /proc/ioports
> 00000000-00ffffff : PCI1 host bridge
>   00000000-0000000f : pcmcia_socket0
>     00000000-00000007 : ide0
>     0000000e-0000000e : ide0
>   00001000-000010ff : PCI CardBus #01
>   00001400-000014ff : PCI CardBus #01
> 01000000-01ffffff : PCI2 host bridge
>   01000000-010000ff : PCI CardBus #03
>   01000400-010004ff : PCI CardBus #03
> --------------------------------------------------------------
> ----------------------------
> (none)# cat /etc/pcmcia/config.opts
> # Local PCMCIA Configuration File
> #
> # System resources available for PCMCIA cards
> #
> include port 0x1000-0x1fff
> include port 0x0000-0x0fff
> include memory 0x80000000-0x9fffffff
> include memory 0xa0000000-0xbfffffff
> (none)#
> --------------------------------------------------------------
> -------------------------
> =20
> We use the following definitions - same as that of MPC8555CDS.
> /* PCI 1 memory map */
> #define MPC85XX_PCI1_LOWER_IO 0x00000000
> #define MPC85XX_PCI1_UPPER_IO 0x00ffffff
> #define MPC85XX_PCI1_LOWER_MEM 0x80000000
> #define MPC85XX_PCI1_UPPER_MEM 0x9fffffff
> #define MPC85XX_PCI1_IO_BASE 0xe2000000
> #define MPC85XX_PCI1_MEM_OFFSET 0x00000000
> #define MPC85XX_PCI1_IO_SIZE 0x01000000
> /* PCI 2 memory map */
> /* Note: the standard PPC fixups will cause IO space to get bumped by
> * hose->io_base_virt - isa_io_base =3D> MPC85XX_PCI1_IO_SIZE */
> #define MPC85XX_PCI2_LOWER_IO 0x00000000
> #define MPC85XX_PCI2_UPPER_IO 0x00ffffff
> #define MPC85XX_PCI2_LOWER_MEM 0xa0000000
> #define MPC85XX_PCI2_UPPER_MEM 0xbfffffff
> #define MPC85XX_PCI2_IO_BASE 0xe3000000
> #define MPC85XX_PCI2_MEM_OFFSET 0x00000000
> #define MPC85XX_PCI2_IO_SIZE 0x01000000
> --------------------------------------------------------------
> ----------
> =20
> I am wondering if it is a PCMCIA addressing issue.  I am not=20
> sure how to setup pcmcia/config.opts.
> =20
> Any thoughts??
> =20
> Thanks,
> Shriram.
>=20
> ________________________________
>=20
> We won't tell. Get more on shows you hate to love=20
> <http://us.rd.yahoo.com/evt=3D49980/*http://tv.yahoo.com/collect
ions/265>=20
> (and love to hate): Yahoo! TV's Guilty Pleasures list.=20
> <http://us.rd.yahoo.com/evt=3D49980/*http://tv.yahoo.com/collect
ions/265>=20
>=20
