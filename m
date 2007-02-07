Return-Path: <shriramjanardhan@yahoo.com>
Received: from web58503.mail.re3.yahoo.com (web58503.mail.re3.yahoo.com
	[68.142.236.186]) by ozlabs.org (Postfix) with SMTP id AAF25DDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Feb 2007 06:29:14 +1100 (EST)
Date: Wed, 7 Feb 2007 11:22:32 -0800 (PST)
From: Shriram Janardhan <shriramjanardhan@yahoo.com>
Subject: PCI2 issue on MPC8541
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1419720783-1170876152=:9921"
Message-ID: <598544.9921.qm@web58503.mail.re3.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1419720783-1170876152=:9921
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello everybody,
   
  I'm having an issue w.r.t PCI2 on MPC8541 and would appreciate if anybody could share their thoughts on what could be wrong.
   
  We're running the 2.6.11 version of the linux kernel on MPC8541 and having trouble getting the cardmgr to initialize a compact flash connected to PCI2 through a TI1510 bridge.
   
  We have two CFs connected through two TI1510 bridges to the two PCI controllers.  When cardmgr is invoked to intialize the two sockets, the PCI1/ide0 initialization goes on fine but the PCI2/ide-cs initialization fails.  
   
  The bridges are on slot 11 of the respective controllers and the interrupts from the two bridges are multiplexed onto the same external interrupt pin(EXT2) of the 8541.
   
  For the second CF, we are able to read the CIS and correctly identify the CF, but the cardmgr fails while trying to execute the IOCTL DS_GET_DEVICE_INFO.
   
    ------------------------------------------------------------
  (none)#
(none)# lspci -vv
00:00.0 Class 0b20: 1057:000c (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
        Latency: 128
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at 9ff00000 (32-bit, non-prefetchable) [size=1M]
        Region 1: Memory at <unassigned> (32-bit, prefetchable) [size=80000000]
        Region 2: Memory at <unassigned> (64-bit, non-prefetchable)
        Region 4: Memory at <unassigned> (64-bit, non-prefetchable)
   
  00:0b.0 Class 0607: 104c:ac56
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 08
        Interrupt: pin A routed to IRQ 98
        Region 0: Memory at 80000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
        Memory window 0: 80400000-807ff000 (prefetchable)
        Memory window 1: 80800000-80bff000
        I/O window 0: 00001000-000010ff
        I/O window 1: 00001400-000014ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001
   
  02:00.0 Class 0b20: 1057:000c (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
        Latency: 128
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at bff00000 (32-bit, non-prefetchable) [size=1M]
        Region 1: Memory at <unassigned> (32-bit, prefetchable) [size=80000000]
        Region 2: Memory at <unassigned> (64-bit, non-prefetchable)
        Region 4: Memory at <unassigned> (64-bit, non-prefetchable)
   
  02:0b.0 Class 0607: 104c:ac56
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 08
        Interrupt: pin A routed to IRQ 98
        Region 0: Memory at a0000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: a0400000-a07ff000 (prefetchable)
        Memory window 1: a0800000-a0bff000
        I/O window 0: 00000000-000000ff
        I/O window 1: 00000400-000004ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001
   
  (none)#
  --------------------------------------------------------------------
(none)# cardmgr -v -o
cardmgr[865]: watching 2 sockets
cardmgr[865]: starting, version is 3.2.8
cardmgr[865]: initializing socket 0
cardmgr[86Probing IDE interface ide0...
5]: socket 0: ATA/IDE Fixed Disk
cardmgr[865]:   product info: "Wintec Industries", "CF 256MB"
cardmgr[865]:   function: 4 (fixed disk)
hda: CF 256MB, CFA DISK drive
ide0 at 0x000-0x007,0x00e on irq 98
hda: max request size: 128KiB
hda: 513536 sectors (262 MB) w/0KiB Cache, CHS=1003/16/32
hda: cache flushes not supported
 hda: hda1
ide-cs: hda: Vcc = 3.3, Vpp = 0.0
cardmgr[865]: executing: './ide start hda'
cardmgr[865]: + mknod /dev/hda b 3 0
cardmgr[865]: + mknod /dev/hda1 b 3 1
cardmgr[865]: + mknocs: memory probe 0x80000000-0x9fffffff:d /dev/hda2 b 3  excl
uding2
cardmgr[865] 0x80000000-0x9fffffff: + mknod /dev/h
da3 b 3 3
cardcs: memory probe 0xa0000000-0xbfffffff:mgr[865]: + mkno excludingd /dev/hda4
 b 3  0xa0000000-0xa1ffffff4
cardmgr[865] 0xbe000000-0xbfffffff: + mknod /dev/h
da5 b 3 5
card1.0: mgr[865]: + mknoGetNextTuple: No more items
d /dev/hda6 b 3 6
cardmgr[865]: + mknod /dev/hda7 b 3 7
cardmgr[865]: + mknod /dev/hda8 b 3 8
cardmgr[865]: + mknod /dev/hda9 b 3 9
cardmgr[865]: + mknod /dev/hda10 b 3 10
cardmgr[865]: + mknod /dev/hda11 b 3 11
cardmgr[865]: + mknod /dev/hda12 b 3 12
cardmgr[865]: + mknod /dev/hda13 b 3 13
cardmgr[865]: + mknod /dev/hda14 b 3 14
cardmgr[865]: + mknod /dev/hda15 b 3 15
cardmgr[865]: + mknod /dev/hda16 b 3 16
cardmgr[865]: initializing socket 1
cardmgr[865]: socket 1: ATA/IDE Fixed Disk
cardmgr[865]:   product info: "SILICONSYSTEMS", "VER2.00"
cardmgr[865]:   function: 4 (fixed disk)
cardmgr[865]: get dev info on socket 1 failed: No such device
cardmgr[865]: exiting
(none)#
  ---------------------------------------------------------------------------------------
  (none)# cat /proc/ioports
00000000-00ffffff : PCI1 host bridge
  00000000-0000000f : pcmcia_socket0
    00000000-00000007 : ide0
    0000000e-0000000e : ide0
  00001000-000010ff : PCI CardBus #01
  00001400-000014ff : PCI CardBus #01
01000000-01ffffff : PCI2 host bridge
  01000000-010000ff : PCI CardBus #03
  01000400-010004ff : PCI CardBus #03
------------------------------------------------------------------------------------------
(none)# cat /etc/pcmcia/config.opts
# Local PCMCIA Configuration File
#
# System resources available for PCMCIA cards
#
include port 0x1000-0x1fff
include port 0x0000-0x0fff
include memory 0x80000000-0x9fffffff
include memory 0xa0000000-0xbfffffff
(none)#
---------------------------------------------------------------------------------------
   
  We use the following definitions - same as that of MPC8555CDS.
    /* PCI 1 memory map */
  #define MPC85XX_PCI1_LOWER_IO 0x00000000
  #define MPC85XX_PCI1_UPPER_IO 0x00ffffff
  #define MPC85XX_PCI1_LOWER_MEM 0x80000000
  #define MPC85XX_PCI1_UPPER_MEM 0x9fffffff
  #define MPC85XX_PCI1_IO_BASE 0xe2000000
  #define MPC85XX_PCI1_MEM_OFFSET 0x00000000
  #define MPC85XX_PCI1_IO_SIZE 0x01000000
  /* PCI 2 memory map */
  /* Note: the standard PPC fixups will cause IO space to get bumped by
  * hose->io_base_virt - isa_io_base => MPC85XX_PCI1_IO_SIZE */
  #define MPC85XX_PCI2_LOWER_IO 0x00000000
  #define MPC85XX_PCI2_UPPER_IO 0x00ffffff
  #define MPC85XX_PCI2_LOWER_MEM 0xa0000000
  #define MPC85XX_PCI2_UPPER_MEM 0xbfffffff
  #define MPC85XX_PCI2_IO_BASE 0xe3000000
  #define MPC85XX_PCI2_MEM_OFFSET 0x00000000
  #define MPC85XX_PCI2_IO_SIZE 0x01000000

  ------------------------------------------------------------------------
   
  I am wondering if it is a PCMCIA addressing issue.  I am not sure how to setup pcmcia/config.opts.
   
  Any thoughts??
   
  Thanks,
  Shriram.


 
---------------------------------
We won't tell. Get more on shows you hate to love
(and love to hate): Yahoo! TV's Guilty Pleasures list.
--0-1419720783-1170876152=:9921
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV><FONT face=Arial size=2><SPAN class=057401818-07022007>Hello everybody,</SPAN></FONT></DIV>  <DIV><FONT face=Arial size=2><SPAN class=057401818-07022007></SPAN></FONT>&nbsp;</DIV>  <DIV><FONT face=Arial size=2><SPAN class=057401818-07022007>I'm having an issue w.r.t PCI2 on MPC8541 and would appreciate if anybody could share their thoughts&nbsp;on what could be wrong.</SPAN></FONT></DIV>  <DIV><FONT face=Arial size=2><SPAN class=057401818-07022007></SPAN></FONT>&nbsp;</DIV>  <DIV><FONT face=Arial size=2><SPAN class=057401818-07022007>We're running the 2.6.11 version of the linux kernel on MPC8541 and&nbsp;</SPAN></FONT><FONT face=Arial size=2><SPAN class=057401818-07022007>having trouble getting the cardmgr to initialize a compact flash connected to PCI2 through a TI1510 bridge.</SPAN></FONT></DIV>  <DIV><FONT face=Arial size=2><SPAN class=057401818-07022007></SPAN></FONT>&nbsp;</DIV>  <DIV><FONT face=Arial size=2><SPAN class=057401818-07022007>We have two CFs
 connected through two TI1510 bridges to the two PCI controllers.&nbsp; When cardmgr is invoked to intialize the two sockets, the PCI1/ide0 initialization goes on fine but the PCI2/ide-cs initialization fails.&nbsp; </SPAN></FONT></DIV>  <DIV><FONT face=Arial size=2><SPAN class=057401818-07022007></SPAN></FONT>&nbsp;</DIV>  <DIV><FONT face=Arial size=2><SPAN class=057401818-07022007>The bridges are on slot 11 of the respective controllers and the interrupts from the two bridges are multiplexed onto the same external interrupt pin(EXT2) of the 8541.</SPAN></FONT></DIV>  <DIV><FONT face=Arial size=2><SPAN class=057401818-07022007></SPAN></FONT>&nbsp;</DIV>  <DIV><FONT face=Arial size=2><SPAN class=057401818-07022007>For the second CF, we are able to read the CIS and correctly identify the CF, but the cardmgr fails while trying to execute the IOCTL DS_GET_DEVICE_INFO.</SPAN></FONT></DIV>  <DIV><FONT face=Arial size=2><SPAN class=057401818-07022007></SPAN></FONT>&nbsp;</DIV> 
 <DIV><FONT size=+0><SPAN class=057401818-07022007>  <DIV dir=ltr align=left><FONT face=Arial color=#0000ff size=2><SPAN class=014463716-06022007>------------------------------------------------------------</SPAN></FONT></DIV>  <DIV dir=ltr align=left><FONT face=Arial color=#0000ff size=2><SPAN class=014463716-06022007>(none)#<BR>(none)# lspci -vv<BR>00:00.0 Class 0b20: 1057:000c (rev 11)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step<BR>ping- SERR+ FastB2B-<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast &gt;TAbort- &lt;TAbort-<BR>&lt;MAbort+ &gt;SERR- &lt;PERR-<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Latency: 128<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Interrupt: pin A routed to IRQ 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Region 0: Memory at 9ff00000 (32-bit, non-prefetchable)
 [size=1M]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Region 1: Memory at &lt;unassigned&gt; (32-bit, prefetchable) [size=80000000]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Region 2: Memory at &lt;unassigned&gt; (64-bit, non-prefetchable)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Region 4: Memory at &lt;unassigned&gt; (64-bit, non-prefetchable)</SPAN></FONT></DIV>  <DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>  <DIV dir=ltr align=left><FONT face=Arial color=#0000ff size=2><SPAN class=014463716-06022007>00:0b.0 Class 0607: 104c:ac56<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step<BR>ping- SERR- FastB2B-<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium &gt;TAbort- &lt;TAbort<BR>- &lt;MAbort- &gt;SERR- &lt;PERR-<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Latency: 168, cache line size 08<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 Interrupt: pin A routed to IRQ 98<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Region 0: Memory at 80000000 (32-bit, non-prefetchable) [size=4K]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bus: primary=00, secondary=01, subordinate=04, sec-latency=176<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory window 0: 80400000-807ff000 (prefetchable)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory window 1: 80800000-80bff000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O window 0: 00001000-000010ff<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O window 1: 00001400-000014ff<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BridgeCtl: Parity- SERR- ISA- VGA- MAbort- &gt;Reset+ 16bInt+ PostWrite+<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16-bit legacy interface ports at 0001</SPAN></FONT></DIV>  <DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>  <DIV dir=ltr align=left><FONT face=Arial color=#0000ff size=2><SPAN class=014463716-06022007>02:00.0 Class 0b20: 1057:000c
 (rev 11)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step<BR>ping- SERR+ FastB2B-<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast &gt;TAbort- &lt;TAbort-<BR>&lt;MAbort+ &gt;SERR- &lt;PERR-<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Latency: 128<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Interrupt: pin A routed to IRQ 0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Region 0: Memory at bff00000 (32-bit, non-prefetchable) [size=1M]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Region 1: Memory at &lt;unassigned&gt; (32-bit, prefetchable) [size=80000000]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Region 2: Memory at &lt;unassigned&gt; (64-bit, non-prefetchable)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Region 4: Memory at &lt;unassigned&gt; (64-bit, non-prefetchable)</SPAN></FONT></DIV>  <DIV><FONT face=Arial color=#0000ff
 size=2></FONT>&nbsp;</DIV>  <DIV dir=ltr align=left><FONT face=Arial color=#0000ff size=2><SPAN class=014463716-06022007>02:0b.0 Class 0607: 104c:ac56<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step<BR>ping- SERR- FastB2B-<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium &gt;TAbort- &lt;TAbort<BR>- &lt;MAbort- &gt;SERR- &lt;PERR-<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Latency: 168, cache line size 08<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Interrupt: pin A routed to IRQ 98<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Region 0: Memory at a0000000 (32-bit, non-prefetchable) [size=4K]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bus: primary=02, secondary=03, subordinate=06, sec-latency=176<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory window 0: a0400000-a07ff000 (prefetchable)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory
 window 1: a0800000-a0bff000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O window 0: 00000000-000000ff<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O window 1: 00000400-000004ff<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BridgeCtl: Parity- SERR- ISA- VGA- MAbort- &gt;Reset+ 16bInt+ PostWrite+<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16-bit legacy interface ports at 0001</SPAN></FONT></DIV>  <DIV><FONT face=Arial color=#0000ff size=2></FONT>&nbsp;</DIV>  <DIV dir=ltr align=left><FONT face=Arial color=#0000ff size=2><SPAN class=014463716-06022007>(none)#</SPAN></FONT></DIV>  <DIV dir=ltr align=left><FONT color=#0000ff><SPAN class=014463716-06022007><FONT face=Arial size=2>--------------------------------------------------------------------<BR>(none)# cardmgr -v -o<BR>cardmgr[865]: watching 2 sockets<BR>cardmgr[865]: starting, version is 3.2.8<BR>cardmgr[865]: initializing socket 0<BR>cardmgr[86Probing IDE interface ide0...<BR>5]: socket 0: ATA/IDE Fixed
 Disk<BR>cardmgr[865]:&nbsp;&nbsp; product info: "Wintec Industries", "CF 256MB"<BR>cardmgr[865]:&nbsp;&nbsp; function: 4 (fixed disk)<BR>hda: CF 256MB, CFA DISK drive<BR>ide0 at 0x000-0x007,0x00e on irq 98<BR>hda: max request size: 128KiB<BR>hda: 513536 sectors (262 MB) w/0KiB Cache, CHS=1003/16/32<BR>hda: cache flushes not supported<BR>&nbsp;hda: hda1<BR>ide-cs: hda: Vcc = 3.3, Vpp = 0.0<BR>cardmgr[865]: executing: './ide start hda'<BR>cardmgr[865]: + mknod /dev/hda b 3 0<BR>cardmgr[865]: + mknod /dev/hda1 b 3 1<BR>cardmgr[865]: + mknocs: memory probe 0x80000000-0x9fffffff:d /dev/hda2 b 3&nbsp; excl<BR>uding2<BR>cardmgr[865] 0x80000000-0x9fffffff: + mknod /dev/h<BR>da3 b 3 3<BR>cardcs: memory probe 0xa0000000-0xbfffffff:mgr[865]: + mkno excludingd /dev/hda4<BR>&nbsp;b 3&nbsp; 0xa0000000-0xa1ffffff4<BR>cardmgr[865] 0xbe000000-0xbfffffff: + mknod /dev/h<BR>da5 b 3 5<BR>card1.0: mgr[865]: + mknoGetNextTuple: No more items<BR>d /dev/hda6 b 3 6<BR>cardmgr[865]: + mknod
 /dev/hda7 b 3 7<BR>cardmgr[865]: + mknod /dev/hda8 b 3 8<BR>cardmgr[865]: + mknod /dev/hda9 b 3 9<BR>cardmgr[865]: + mknod /dev/hda10 b 3 10<BR>cardmgr[865]: + mknod /dev/hda11 b 3 11<BR>cardmgr[865]: + mknod /dev/hda12 b 3 12<BR>cardmgr[865]: + mknod /dev/hda13 b 3 13<BR>cardmgr[865]: + mknod /dev/hda14 b 3 14<BR>cardmgr[865]: + mknod /dev/hda15 b 3 15<BR>cardmgr[865]: + mknod /dev/hda16 b 3 16<BR></FONT><FONT face=Arial><FONT size=2><FONT color=#ff0000>cardmgr[865]: initializing socket 1<BR>cardmgr[865]: socket 1: ATA/IDE Fixed Disk<BR>cardmgr[865]:&nbsp;&nbsp; product info: "SILICONSYSTEMS", "VER2.00"<BR>cardmgr[865]:&nbsp;&nbsp; function: 4 (fixed disk)<BR>cardmgr[865]: get dev info on socket 1 failed: No such device<BR>cardmgr[865]: exiting<BR></FONT>(none)#</FONT></FONT></SPAN></FONT></DIV>  <DIV dir=ltr align=left><FONT face=Arial color=#0000ff size=2><SPAN
 class=014463716-06022007>---------------------------------------------------------------------------------------</SPAN></FONT></DIV>  <DIV dir=ltr align=left><FONT color=#0000ff><SPAN class=014463716-06022007><FONT face=Arial><FONT size=2>(none)# cat /proc/ioports<BR>00000000-00ffffff : PCI1 host bridge<BR>&nbsp; 00000000-0000000f : pcmcia_socket0<BR>&nbsp;&nbsp;&nbsp; 00000000-00000007 : ide0<BR>&nbsp;&nbsp;&nbsp; 0000000e-0000000e : ide0<BR>&nbsp; 00001000-000010ff : PCI CardBus #01<BR>&nbsp; 00001400-000014ff : PCI CardBus #01<BR>01000000-01ffffff : PCI2 host bridge<BR>&nbsp; 01000000-010000ff : PCI CardBus #03<BR>&nbsp; 01000400-010004ff : PCI CardBus #03<BR>------------------------------------------------------------------------------------------<BR>(none)# cat /etc/pcmcia/config.opts<BR># Local PCMCIA Configuration File<BR>#<BR># System resources available for PCMCIA cards<BR>#<BR>include port 0x1000-0x1fff<BR>include port 0x0000-0x0fff<BR>include memory
 0x80000000-0x9fffffff<BR>include memory 0xa0000000-0xbfffffff<BR>(none)#<BR><SPAN class=014463716-06022007>---------------------------------------------------------------------------------------</SPAN></FONT></FONT></SPAN></FONT></DIV>  <DIV dir=ltr align=left><FONT face=Arial color=#0000ff size=2><SPAN class=014463716-06022007><SPAN class=014463716-06022007></SPAN></SPAN></FONT>&nbsp;</DIV>  <DIV dir=ltr align=left><FONT face=Arial color=#0000ff size=2><SPAN class=014463716-06022007><SPAN class=014463716-06022007><SPAN class=057401818-07022007>We use the following definitions - same as that of MPC8555CDS.</SPAN></SPAN></SPAN></FONT></DIV>  <DIV dir=ltr align=left><FONT size=+0><SPAN class=014463716-06022007><SPAN class=014463716-06022007><SPAN class=057401818-07022007>  <div><FONT face=Arial color=#0000ff size=2>/* PCI 1 memory map */</FONT></div>  <div><FONT face=Arial color=#0000ff size=2>#define MPC85XX_PCI<SPAN class=057401818-07022007>1</SPAN>_LOWER_IO
 0x00000000</FONT></div>  <div><FONT face=Arial color=#0000ff size=2>#define MPC85XX_PCI<SPAN class=057401818-07022007>1</SPAN>_UPPER_IO 0x00ffffff</FONT></div>  <div><FONT face=Arial color=#0000ff size=2>#define MPC85XX_PCI<SPAN class=057401818-07022007>1</SPAN>_LOWER_MEM 0x80000000</FONT></div>  <div><FONT face=Arial color=#0000ff size=2>#define MPC85XX_PCI<SPAN class=057401818-07022007>1</SPAN>_UPPER_MEM 0x9fffffff</FONT></div>  <div><FONT face=Arial color=#0000ff size=2>#define MPC85XX_PCI<SPAN class=057401818-07022007>1</SPAN>_IO_BASE 0xe2000000</FONT></div>  <div><FONT face=Arial color=#0000ff size=2>#define MPC85XX_PCI<SPAN class=057401818-07022007>1</SPAN>_MEM_OFFSET 0x00000000</FONT></div>  <div><FONT face=Arial color=#0000ff size=2>#define MPC85XX_PCI<SPAN class=057401818-07022007>1</SPAN>_IO_SIZE 0x01000000</FONT></div>  <div><FONT face=Arial color=#0000ff size=2>/* PCI 2 memory map */</FONT></div>  <div><FONT face=Arial color=#0000ff size=2>/* Note: the standard
 PPC fixups will cause IO space to get bumped by</FONT></div>  <div><FONT face=Arial color=#0000ff size=2>* hose-&gt;io_base_virt - isa_io_base =&gt; MPC85XX_PCI1_IO_SIZE */</FONT></div>  <div><FONT face=Arial color=#0000ff size=2>#define MPC85XX_PCI<SPAN class=057401818-07022007>2</SPAN>_LOWER_IO 0x00000000</FONT></div>  <div><FONT face=Arial color=#0000ff size=2>#define MPC85XX_PCI<SPAN class=057401818-07022007>2</SPAN>_UPPER_IO 0x00ffffff</FONT></div>  <div><FONT face=Arial color=#0000ff size=2>#define MPC85XX_PCI<SPAN class=057401818-07022007>2</SPAN>_LOWER_MEM 0xa0000000</FONT></div>  <div><FONT face=Arial color=#0000ff size=2>#define MPC85XX_PCI<SPAN class=057401818-07022007>2</SPAN>_UPPER_MEM 0xbfffffff</FONT></div>  <div><FONT face=Arial color=#0000ff size=2>#define MPC85XX_PCI<SPAN class=057401818-07022007>2</SPAN>_IO_BASE 0xe3000000</FONT></div>  <div><FONT face=Arial color=#0000ff size=2>#define MPC85XX_PCI<SPAN class=057401818-07022007>2</SPAN>_MEM_OFFSET
 0x00000000</FONT></div>  <div><FONT face=Arial color=#0000ff size=2>#define MPC85XX_PCI<SPAN class=057401818-07022007>2</SPAN>_IO_SIZE 0x01000000</FONT></div></SPAN></SPAN></SPAN></FONT></DIV>  <DIV dir=ltr align=left><FONT face=Arial color=#0000ff size=2><SPAN class=014463716-06022007><SPAN class=014463716-06022007><SPAN class=057401818-07022007>------------------------------------------------------------------------</SPAN></SPAN></SPAN></FONT></DIV>  <DIV dir=ltr align=left><FONT face=Arial color=#0000ff size=2><SPAN class=014463716-06022007><SPAN class=014463716-06022007><SPAN class=057401818-07022007></SPAN></SPAN></SPAN></FONT>&nbsp;</DIV>  <DIV dir=ltr align=left><FONT face=Arial size=2><SPAN class=014463716-06022007><SPAN class=014463716-06022007><SPAN class=057401818-07022007>I am wondering if it is a PCMCIA addressing issue.&nbsp; I am not sure how to setup pcmcia/config.opts.</SPAN></SPAN></SPAN></FONT></DIV>  <DIV dir=ltr align=left><FONT face=Arial size=2><SPAN
 class=014463716-06022007><SPAN class=014463716-06022007><SPAN class=057401818-07022007></SPAN></SPAN></SPAN></FONT>&nbsp;</DIV>  <DIV dir=ltr align=left><FONT face=Arial size=2><SPAN class=014463716-06022007><SPAN class=014463716-06022007><SPAN class=057401818-07022007>Any thoughts??</SPAN></SPAN></SPAN></FONT></DIV>  <DIV dir=ltr align=left><FONT face=Arial size=2><SPAN class=014463716-06022007><SPAN class=014463716-06022007><SPAN class=057401818-07022007></SPAN></SPAN></SPAN></FONT>&nbsp;</DIV>  <DIV dir=ltr align=left><FONT face=Arial size=2><SPAN class=014463716-06022007><SPAN class=014463716-06022007><SPAN class=057401818-07022007>Thanks,</SPAN></SPAN></SPAN></FONT></DIV>  <DIV dir=ltr align=left><FONT face=Arial size=2><SPAN class=014463716-06022007><SPAN class=014463716-06022007><SPAN class=057401818-07022007>Shriram.</SPAN></SPAN></SPAN></FONT></DIV></SPAN></FONT></DIV><p>&#32;

<hr size=1>We won't tell. Get more on <a href="http://us.rd.yahoo.com/evt=49980/*http://tv.yahoo.com/collections/265
">shows you hate to love</a><br>(and love to hate): <a href="http://us.rd.yahoo.com/evt=49980/*http://tv.yahoo.com/collections/265
">Yahoo! TV's Guilty Pleasures list.</a>
--0-1419720783-1170876152=:9921--
