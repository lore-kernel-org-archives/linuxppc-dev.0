Message-ID: <3E25A6F8.4090709@esd-electronics.com>
Date: Wed, 15 Jan 2003 19:22:48 +0100
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Kernel crash with cardbus bridge
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am trying to get a TI cardbus bridge running in a CompactPCI system
with a CPCI405 CompactPCI CPU. The version of the pcmcia-cs is 3.2.1.

Loading of the modules works fine. When I insert a card or start the cardmgr when
a card is already inserted, the kernel crashes due to an access to address 0x60000000.

Where does this damn address comes from? The PCMCIA card services are hard to debug, esspecially
when you did not write them :-) I think its not a bug in the card services but in some PCI mappings.

Did anybody got a PCI cardbus bridge working with a recent kernel with pcmcia-cs or kernel-builtin PCMCIA?

Any ideas would be fine.

# cardmgr -vf
Oops: machine check, sig: 7
NIP: C00CA720 XER: 20000000 LR: C00CA6F8 SP: C1E57660 REGS: c1e575b0 TRAP: 0200    Not tainted
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c1e56000[53] 'cardmgr' Last syscall: 54
last math 00000000 last altivec 00000000
PLB0: bear= 0x60000000 acr=   0x00000000 besr=  0x0c000000
PLB0 to OPB: bear= 0x00088e0c besr0= 0x00000000 besr1= 0x00000000

GPR00: 00000000 C1E57660 C1E56000 00000000 C300A815 C300C000 00000002 C1E576C8
GPR08: 00000000 C300C000 00000000 00001000 24002022 10022968 00000000 00000000
GPR16: 00000000 00000000 00000000 C00CA94C 00000000 00000000 C00CAB38 C0254000
GPR24: 01000000 C1E576C8 00000002 C0254044 C1E576C8 00000002 C0254000 00000000
Call backtrace:
C00CA6F8 C00CAE08 C00CB34C C00CB124 C00CCCDC C00CA998 C00CD2F0
C00CD488 C00CABEC C00CA5E4 C00CAE08 C00CB34C C00CB124 C00CCCDC
C00CFD64 C004A73C C000477C 0FF7F998 10001C9C 100035EC 10004D8C
0FECAD14 00000000

Matthias


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
