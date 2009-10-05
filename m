Return-Path: <grzegorzj@platan.pl>
Received: from mail.platan.pl (mail.platan.pl [83.12.56.147])
	by ozlabs.org (Postfix) with ESMTP id 10B11B7B8D
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  5 Oct 2009 18:14:48 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.platan.pl (Postfix) with ESMTP id 795276FE6AB
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  5 Oct 2009 09:14:44 +0200 (CEST)
Received: from mail.platan.pl ([127.0.0.1])
	by localhost (grab.platan [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N2YVmYWeGJIr for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  5 Oct 2009 09:14:44 +0200 (CEST)
Received: from [192.168.1.144] (grzegorzj.platan [192.168.1.144])
	by mail.platan.pl (Postfix) with ESMTP id 8EB736FE69E
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  5 Oct 2009 09:14:44 +0200 (CEST)
Message-ID: <4AC99CE4.40600@platan.pl>
Date: Mon, 05 Oct 2009 09:14:44 +0200
From: Grzegorz Jakubowski <grzegorzj@platan.pl>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: problem with PCI network card on MPC8323E but works on MPC8313E
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,
I am newbie in embeded linux on PowerPC,
and in few last weeks i fight with PCI device.

On MPC8323E-RDB lspci -vv return:

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6105 [Rhine-III] 
(rev 86)
         Subsystem: VIA Technologies, Inc. Unknown device 0105
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 128 (750ns min, 2000ns max), Cache Line Size: 32 bytes
         Interrupt: pin A routed to IRQ 20
         Region 0: I/O ports at d0000000 [size=256]
         Region 1: Memory at 90001100 (32-bit, non-prefetchable) [size=256]
         Capabilities: [40] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

but on MPC8313E-RDB lspci -vv return:

00:0f.0 Ethernet controller: VIA Technologies, Inc. VT6105 [Rhine-III] 
(rev 86)
         Subsystem: VIA Technologies, Inc. Unknown device 0105
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 128 (750ns min, 2000ns max), Cache Line Size: 32 bytes
         Interrupt: pin A routed to IRQ 23
         Region 0: I/O ports at <unassigned>
         Region 1: Memory at 90000000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [40] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

on MPC8313E network card works fine, but on MPC8313E I gets kernel Oops 
message:

via-rhine.c:v1.10-LK1.4.2 Sept-11-2006 Written by Donald Becker
Unable to handle kernel paging request for data at address 0xd00
00083
Faulting instruction address: 0xc0011b58
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT
Modules linked in: via_rhine
NIP: C0011B58 LR: C501FE8C CTR: C0011B54
REGS: c31d3c80 TRAP: 0300   Not tainted  (2.6.20.6-rt8)
MSR: 00009032 <EE,ME,IR,DR>  CR: 44004422  XER: 20000000
DAR: D0000083, DSISR: 20000000
TASK = c3f97430[795] 'modprobe' THREAD: c31d2000
GPR00: 00000043 C31D3D30 C3F97430 D0000083 00000100 00000100 C50
22A20 C31D3D08
GPR08: D0000000 00000001 00000000 C0011B54 22004422 1001C7AC 000
00000 00000000
GPR16: 00000000 00000000 000000A5 00000124 C03D3C48 00000001 C50
20000 C5022B7C
GPR24: C07F7AC0 C07F7800 D0000000 00000100 D0000000 D0000083 C07
F7AC0 D0000000
NIP [C0011B58] ioread8+0x4/0x18
LR [C501FE8C] rhine_power_init+0x44/0x17c [via_rhine]
Call Trace:
[C31D3D30] [C0147D5C] pci_request_regions+0x2c/0x9c (unreliable)

[C31D3D50] [C5020384] rhine_init_one+0x220/0x650 [via_rhine]
[C31D3DA0] [C014A434] pci_device_probe+0x80/0xa0
[C31D3DC0] [C0165794] really_probe+0x64/0x134
[C31D3DE0] [C0165BB4] __driver_attach+0x84/0x88
[C31D3E00] [C01647F8] bus_for_each_dev+0x54/0x90
[C31D3E30] [C0165518] driver_attach+0x24/0x34
[C31D3E40] [C0164E68] bus_add_driver+0x88/0x1b4
[C31D3E60] [C0165E8C] driver_register+0x68/0xb0
[C31D3E70] [C0149E6C] __pci_register_driver+0x84/0xe4
[C31D3E90] [C502602C] rhine_init+0x2c/0x90 [via_rhine]
[C31D3EA0] [C004B670] sys_init_module+0xf4/0x1624
[C31D3F40] [C000F4A4] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xff70fe8
     LR = 0x10002ac4
Instruction dump:
83e1001c 38210020 7c0803a6 4e800020 38800000 7c0803a6 4e800021 2
f830000
3860ffea 419eff04 4bffffac 7c0004ac <88630000> 0c030000 4c00012c
  5463063e
  Segmentation fault


maybe problem is with I/O ports (failed instruction was ioread8) because 
    on one board I/O ports are not assigned, but on MPC8323E they are 
invalid assigned.
I have no idea how to solve my problem, thanks for any help. What should 
I try to do?

Best regards, Gregory Jakubowski

ps. sorry for my poor english
