Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id DAC6BDE149
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 02:29:44 +1000 (EST)
Message-ID: <4808CC4E.5000705@ru.mvista.com>
Date: Fri, 18 Apr 2008 20:29:02 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
Subject: Re: pci issue - wrong detection of pci ressources
References: <48088F02.2060806@linux.vnet.ibm.com>
In-Reply-To: <48088F02.2060806@linux.vnet.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Detlev Zundel <dzu@denx.de>,
	Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christian Ehrhardt wrote:

> I tried to use a radeon r200 based graphic card on a sequoia ppc 
> (440epx) board. I wondered about the initialization of radeonfb that 
> failed with
>     __ioremap(): phys addr 0x0 is RAM lr c029cf80
>     radeonfb (0000:00:0a.0): cannot map MMIO
>     radeonfb: probe of 0000:00:0a.0 failed with error -5

> I trigger a check in ioremap, because the address it wants to remap is 
> 0x0 which can never work. The reason of that is that the pci ressource 
> of that graphic card is not properly detected.

    There might be another reason.  This driver seems to be another subject to 
the 440-specific PCI memory space issue beacuse it uses 'unsigned long' to 
store the PCI memory physical addresses and those are 64-bit in the 440 
arch/powerpc/ kernels.

> With some help I found two kernels - one that work and one that has this 
> issue.
> Unfortunately they are very different:
>   good => 2.6.24.2 from the linux-2.6-denx - built for arch=ppc
>   bad => we have 2.6.25-rc9 (used in our kvm ppc project atm) - build 
> for arch=powerpc
> I tried building the 2.6.25-rc9 with arch=ppc, but that one does not 
> boot so far. Because of that I can't surely tell you if it is only that 
> difference that breaks the pci detection.
> We need arch=powerpc for our kvm code anyway, so I hope there is another 
> solution than to switch to arch=ppc ;-)

    Yes, the driver needs fixing -- at least that.

> I just started to debug into that, but I wanted to ask here if there 
> might be some known issues causing that and/or to get some hints where 
> to look at.

    Now you know of at least one.

> The issue is much better visible when I boot with these two kernels and 
> use "lspci -vvv"

> Good kernel:
> 00:0a.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 
> 9200 PRO] (rev 01) (prog-if 00 [VGA])
>        Subsystem: PC Partner Limited Unknown device 0250
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 128 (2000ns min)
>        Interrupt: pin A routed to IRQ 67
>        Region 0: Memory at 88000000 (32-bit, prefetchable) [size=128M]
>        Region 1: I/O ports at ff00 [size=256]
>        Region 2: Memory at 87ff0000 (32-bit, non-prefetchable) [size=64K]
>        Expansion ROM at 80020000 [disabled] [size=128K]

    Here, the PCI resources have been re-assigned by arch/ppc/ kernel, and are 
confined to 4 GB due to fixup_bigphys_addr() trick used for 440...

>        Capabilities: [50] Power Management version 2
>                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

> Bad kernel:
> 00:0a.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 
> 9200 PRO] (rev 01) (prog-if 00 [VGA])
>        Subsystem: PC Partner Limited Unknown device 0250
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 128 (2000ns min)
>        Interrupt: pin A routed to IRQ 16
>        Region 0: Memory at 180000000 (32-bit, prefetchable) [size=128M]

    That's beyond 4 GB, seems correct. That should be the address assigned by 
bootloader? BTW, what's your bootloader, U-Boot?

>        Region 1: I/O ports at 1000 [size=256]
>        Region 2: Memory at <ignored> (32-bit, non-prefetchable)

    Hm... what could this mean? Could you post the result of 'lspci -x'?

>        Capabilities: [50] Power Management version 2
>                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

> => Region 2 is not detected with our kernel, this later break things 
> like radeonfb initialization.

    Well, not only this...

WBR, Sergei
