Return-Path: <jxnuxdy@163.com>
Received: from m13-193.163.com (m13-193.163.com [220.181.13.193])
	by ozlabs.org (Postfix) with ESMTP id 91929B7D16
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jun 2010 11:46:20 +1000 (EST)
Date: Fri, 11 Jun 2010 09:30:19 +0800 (CST)
From: jxnuxdy <jxnuxdy@163.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <c3ef46.1e4c.12924a10776.Coremail.jxnuxdy@163.com>
In-Reply-To: <1276219072.1962.82.camel@pasglop>
References: <1276219072.1962.82.camel@pasglop>
	<20100604212134.10552.70717.stgit@angua>
	<20100604212155.10552.19260.stgit@angua>
	<1276152002.1962.55.camel@pasglop>
	<AANLkTinmDFBvAjcjrgf3RHuiXgNxVV20yLzBaqhE5lrk@mail.gmail.com>
Subject: PCIe bus seems work while 'dma' can't under linux
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Michal Simek <monstr@monstr.eu>,
	devicetree-discuss@lists.ozlabs.org, microblaze-uclinux@itee.uq.edu.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi guys,

I encountered a PCIe problem under linux, the two PCIe bus on my board seems work, at least I can access the registers through the PCIe bus, however the dma for the PCIe bus can't work, so I just dumped the pci device, but I am curiously to find there is no regions displayed on PCIe controlers, why? is it relate with my 'dma' issue then?


bash-2.04# cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Class 0b20  Header Type 01: PCI device 1957:0032 (rev 17).
  Bus  1, device   0, function  0:
    Class 0580  Header Type 00: PCI device 11ab:db90 (rev 1).
      Prefetchable 64 bit memory at 0x80000000 [0x800fffff].
      Prefetchable 64 bit memory at 0x84000000 [0x87ffffff].
  Bus  9, device   0, function  0:
    Class 0b20  Header Type 01: PCI device 1957:0032 (rev 17).
  Bus 10, device   0, function  0:
    Class 0580  Header Type 00: PCI device 11ab:db90 (rev 1).
      Prefetchable 64 bit memory at 0xa0000000 [0xa00fffff].
      Prefetchable 64 bit memory at 0xa4000000 [0xa7ffffff].
bash-2.04# lspci -vv
00:00.0 Power PC: Unknown device 1957:0032 (rev 11)
        !!! Invalid class 0b20 for header type 01
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, cache line size 08
        Bus: primary=00, secondary=01, subordinate=06, sec-latency=0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: 80000000-9fffffff
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [4c] #10 [0041]

01:00.0 Memory controller: Galileo Technology Ltd.: Unknown device db90 (rev 01)
        Subsystem: Galileo Technology Ltd.: Unknown device 11ab
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, cache line size 08
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at 80000000 (64-bit, prefetchable) [size=1M]
        Region 2: Memory at 84000000 (64-bit, prefetchable) [size=64M]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [60] #10 [0011]

09:00.0 Power PC: Unknown device 1957:0032 (rev 11)
        !!! Invalid class 0b20 for header type 01
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, cache line size 08
        Bus: primary=00, secondary=0a, subordinate=0f, sec-latency=0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: a0000000-bfffffff
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [4c] #10 [0041]

0a:00.0 Memory controller: Galileo Technology Ltd.: Unknown device db90 (rev 01)
        Subsystem: Galileo Technology Ltd.: Unknown device 11ab
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, cache line size 08
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at a0000000 (64-bit, prefetchable) [size=1M]
        Region 2: Memory at a4000000 (64-bit, prefetchable) [size=64M]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [60] #10 [0011]

bash-2.04# 

Thanks
Denny
