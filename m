Message-ID: <3AAFAF8C.4050206@galileo.co.il>
Date: Wed, 14 Mar 2001 19:51:08 +0200
From: Rabeeh Khoury <rabeeh@galileo.co.il>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Max bus issue
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

I am having a problem running Linux with Max bus on Galileo Technology
bridge with 7400 CPU.

The following gives the symptoms of the problem (as I can see them from
a logic anlyzer on the bus between the CPU and the bridge) -

1.. The system mounts NFS then starts running /sbin/init and the other
stuff. The system fails in random places at different times (can reach
upto 7 seconds from the point mounting the NFS but NEVER failed before
this point).

2.. The failures are usually that the CPU branches to a an adress of
about 0xc1...... (32 bit address at the external bus !!! not a virtual
address at all) which is not available at all (I have 32 MByte SDRAM
starting from address 0-0x02000000 which is 0xc0000000 to 0xc2000000).

3.. When the CPU branches to this weird address, the bridge returns
0xffffffff which the CPU thinks this is a trap and executes a trap/debug
breakpoint code.

4.. The weird address that the CPU branches to is an address that
branches to after interrupt handler routines or decrementer exception
handler which makes me think that the problem might be in the common
function 'transfer_to_handler' in arch/ppc/kernel/head.S ; this function
moves r23 (which holds the virtual address of where to continue to) to
the link register, which when finished handling the exception, the CPU
branches to this address to continue processing the task where it was
stopped from.

5.. I run kernel 2.4.0-test11 and runs stable on 60x bus (usually it
shouldn't matter to the software if the bus is 60x or Max but a fact
that here it really matters).
6.. The bridge and the CPU runs stable on other operating systems (such
as VxWorks) with Max Bus feature.

Was there any fixes for arch/ppc/kernel/head.S regarding Max bus issues ?
Is there any one running Linux on Max bus based platform ?
Did any one encounter such a problem ?


Regards,
Rabeeh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
