Mime-Version: 1.0
Message-Id: <p05100302b9d2ade72041@[192.168.0.8]>
In-Reply-To: <20021011124143.A16886@suse.de>
References: <20021011092019.A1374@suse.de>
 <20021011100935.10178@192.168.4.1> <20021011124143.A16886@suse.de>
Date: Wed, 16 Oct 2002 02:04:31 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: part deux Re: Radeon 7000 in 9500 - which slot?
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Have moved the 7000 to the top slot on the 9500, 2 monitors attached.

When using 2.4.20-pre9-ben0, booting into RL3 (not troubleshooting X
at this point) and kernel arg video=radeon:1024x768-16@75, the
console boot briefly appears to start in accelerated mode, then the
monitor goes black and stays that way. However, I can tell from
listening to the disks that the boot proceeds normally.

Typing blindly to get the dmesg, we have:

	PCI: Enabling device 00:0d.0 (0086 -> 0087)
	radeonfb: ref_clk=2700, ref_div=12, xclk=18277 from OF
	radeon_get_moninfo: bios 4 scratch = 0
	Console: switching to colour frame buffer device 128x48
	radeonfb: ATI Radeon VE QY DDR SGRAM 32 MB
	radeonfb: DVI port no monitor connected
	radeonfb: CRT port no monitor connected

Am I wrong, or does it appear to think I have no monitors connected?
The main monitor's power LED indicates it has sync (green), while the
second monitor's power LED indicates not (yellow).

FWIW, lspci -vv yields

00:0d.0 VGA compatible controller: ATI Technologies Inc: Unknown
device 5159 (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0908
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at 88000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 0400 [size=256]
	Region 2: Memory at 80910000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at 80920000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


Stefan Jeglinski


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
