Message-ID: <37457D27.DA34E026@iname.com>
Date: Fri, 21 May 1999 16:35:03 +0100
From: Jim Chapman <jim.chapman@iname.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Q: Register usage in mpc860 ports
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am porting LinuxPPC to a custom embedded mpc860 board. I am starting
with the mbx port and using home-built egcs-1.1.2 tools on  a Linux
host, using the instructions in
http://members.home.com/mmporter/cross.html

There seem to be register usage conflicts in the MMU TLB handlers. The
code tries to use location 0 (according to the comment) to store a
couple of register values, e.g. in arch/ppc/kernel/head.S

InstructionTLBMiss:
 mtspr M_TW, r20 /* Save a couple of working registers */
 mfcr r20
 stw r20, 0(r0)
 stw r21, 4(r0)

However, I am finding that r0 isn't zero when the MMU exceptions are
taken. Instead, it points to somewhere in the text or data segment. I
hacked the code to save r20 & r21 to a specific memory location and that
fixed that particular problem.

Has anyone else seen this sort of thing when doing a custom port?
Perhaps this is being caused by an init problem since the MBX comments
suggest that E-PPCbug is used to download and init that card but I don't
use EPPCbug? What registers are reserved by the kernel in the MBX port,
apart from r2? What mpc860 register setup should be done in head.S
before going to C?

Thanks

Jim





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
