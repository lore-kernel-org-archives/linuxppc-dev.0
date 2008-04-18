Return-Path: <ehrhardt@linux.vnet.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B4ABADE602
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 22:06:55 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id m3IC6nkD201448
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 12:06:49 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m3IC6ne33404006
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 14:06:49 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m3IC6mp7019014
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 14:06:48 +0200
Message-ID: <48088F02.2060806@linux.vnet.ibm.com>
Date: Fri, 18 Apr 2008 14:07:30 +0200
From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, Hollis Blanchard <hollisb@us.ibm.com>,
	Detlev Zundel <dzu@denx.de>, Wolfgang Denk <wd@denx.de>
Subject: pci issue - wrong detection of pci ressources
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
I tried to use a radeon r200 based graphic card on a sequoia ppc (440epx) board. I wondered about the initialization of radeonfb that failed with
	__ioremap(): phys addr 0x0 is RAM lr c029cf80
	radeonfb (0000:00:0a.0): cannot map MMIO
	radeonfb: probe of 0000:00:0a.0 failed with error -5

I trigger a check in ioremap, because the address it wants to remap is 0x0 which can never work. The reason of that is that the pci ressource of that graphic card is not properly detected.

With some help I found two kernels - one that work and one that has this issue.
Unfortunately they are very different:
   good => 2.6.24.2 from the linux-2.6-denx - built for arch=ppc
   bad => we have 2.6.25-rc9 (used in our kvm ppc project atm) - build for arch=powerpc
I tried building the 2.6.25-rc9 with arch=ppc, but that one does not boot so far. Because of that I can't surely tell you if it is only that difference that breaks the pci detection.
We need arch=powerpc for our kvm code anyway, so I hope there is another solution than to switch to arch=ppc ;-)

I just started to debug into that, but I wanted to ask here if there might be some known issues causing that and/or to get some hints where to look at.

The issue is much better visible when I boot with these two kernels and use "lspci -vvv"

Good kernel:
00:0a.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 PRO] (rev 01) (prog-if 00 [VGA])
        Subsystem: PC Partner Limited Unknown device 0250
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (2000ns min)
        Interrupt: pin A routed to IRQ 67
        Region 0: Memory at 88000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at ff00 [size=256]
        Region 2: Memory at 87ff0000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at 80020000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Bad kernel:
00:0a.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 PRO] (rev 01) (prog-if 00 [VGA])
        Subsystem: PC Partner Limited Unknown device 0250
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (2000ns min)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at 180000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 1000 [size=256]
        Region 2: Memory at <ignored> (32-bit, non-prefetchable)
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


=> Region 2 is not detected with our kernel, this later break things like radeonfb initialization.

-- 

Grüsse / regards, 
Christian Ehrhardt
IBM Linux Technology Center, Open Virtualization

P.S. I tested both pci slots of my board and both behave the same
