Date: Fri, 19 Dec 2003 13:01:39 -0400
From: Gavin Hemphill <hemphill@cdr1-12.accesscable.net>
Subject: Re: aic7xxx revisited...
In-reply-to: <20031219092217.GA20303@uchicago.edu>
To: Alec Wood <alecwood@cs.uchicago.edu>,
	linuxppc-dev@lists.linuxppc.org
Message-id: <3FE32EF3.9020704@cdr1-12.accesscable.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
References: <20031219092217.GA20303@uchicago.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I also have a similar machine, and can confirm that the YDL 2.4.22
series kernels machine check if either/or both cards are installed.
The old adaptec driver works on 22-2a, 22-2f, and 22-2g (built as a
module, as long as you don't build the new driver at all and of course
rename the object file), and Ben's latest kernel 2.4.22-ben1 from bk
does not exhibit the problem with the new adaptec driver built as a
module (It however blanks my screen (22" cinema on an ATI 7500) as soon
as I try and start x - can't even switch consoles).  All of the kernels
except the benh one were built using the config file in the configs
directory changing only the adaptec driver with menuconfig.  The benh
kernel was built with the config from 22-2f and an oldconfig done.

cpuinfo is as follows:
cpu             : 7450, altivec supported
clock           : 733MHz
revision        : 2.0 (pvr 8000 0200)
bogomips        : 730.72
machine         : PowerMac3,4
motherboard     : PowerMac3,4 MacRISC2 MacRISC Power Macintosh
board revision  : 00000000
detected as     : 69 (PowerMac G4 Silver)
pmac flags      : 00000000
L2 cache        : 256K unified
memory          : 1536MB
pmac-generation : NewWorld

Card Spec's are:

10:12.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
         Subsystem: Adaptec AHA-2904/Integrated AIC-7850
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 16 (1000ns min, 1000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 52
         Region 0: I/O ports at 1000 [size=256]
         Region 1: Memory at 80083000 (32-bit, non-prefetchable) [size=4K]
         Expansion ROM at 80090000 [disabled] [size=64K]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

10:15.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
         Subsystem: Adaptec 29160 Ultra160 SCSI Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 16 (10000ns min, 6250ns max), cache line size 08
         Interrupt: pin A routed to IRQ 58
         BIST result: 00
         Region 0: I/O ports at 1400 [size=256]
         Region 1: Memory at 80082000 (64-bit, non-prefetchable) [size=4K]
         Expansion ROM at 800a0000 [disabled] [size=128K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-


Alec Wood wrote:
> I'm attempting to compile a stock 2.4.23 on my PowerMac G4/667, and
> appear to be hitting the same bug that Ethan Weinstein reported a while
> back.  Have there been any insights into the source of the problem?
>
> I haven't been able to get any good diagnostic information yet (other
> than the SRR1=149030 bit), and Ben's advice on getting xmon to print to
> the screen doesn't appear to be germaine to the newer kernel.
>
> I actually first hit the problem whilst installing YDL 3.0.1 -- the
> installer crashed at every boot until I pulled the SCSI card out
> (Adaptec AHA-7850 (rev 3)).
>
> I've also found that the same crash occurs with both the new and old
> aic7xxx drivers, and also as a compiled-in driver or at insmod time. My
> old 2.4.18 works great (new aic7xxx), but I'd like to get up-to-date...
>
> Any thoughts?
> -Alec
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
