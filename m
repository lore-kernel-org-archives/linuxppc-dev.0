Message-ID: <392C0CFE.8FE51FCF@embeddededge.com>
Date: Wed, 24 May 2000 13:10:22 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Brent <bimhoff@ns1.planetspork.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MBX boot problems
References: <Pine.GSO.4.05.10005211739380.9894-100000@ns1.planetspork.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brent wrote:

> Memory: 67572k available (732k kernel code, 1292k data, 36k init)
> [c0000000,c440 0000]
> PCI: Probing PCI hardware
> NIP: C00085A4 XER: 20000000 LR: C0008314 REGS: c00ce958 TRAP: 0200
> MSR: 00001932 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = c00ccb08[0] 'swapper' mm->pgd c00ca000 Last syscall: 0
> last math 00000000
> GPR00: 0000000C C00CEA48 C00CCB08 00000086 00000000 0000000E C00CEA80
> 00000000
> GPR08: FA210500 0000000D 0000000C FA210500 C00CEA68 00000000 00000000
> 00000000

The kernel is built for a system that has the Tundra QSpan PCI
bridge.  Your system doesn't have one or it is not working.  The
machine check exception occurred when it tried to probe for devices.

Some evidence for this.....First, the message was printed and the
system immediately failed.  Registers 8 and 11, typically used for
indirect references, hold the address of the PCI configuration
registers, and it failed with a machine check exception.....


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
