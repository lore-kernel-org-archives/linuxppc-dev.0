Message-Id: <5.1.0.14.0.20010925083406.00a6fec0@pop.gmx.de>
Date: Tue, 25 Sep 2001 09:01:42 +0800
To: g.ramakrishna@exgate.tek.com, wd@denx.de
From: Michael Habermann <MHabermann@gmx.de>
Subject: RE: Can not boot linux-2.4.4 using ppcboot-1.0.4 
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <301A812E6528D511A8F70008C71E578616C939@AP-BANG-M02>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 06:14 AM 9/24/2001 -0700, g.ramakrishna@exgate.tek.com wrote:


>I had already changed the board info in the kernel according to
>include/ppcboot.h
>of ppcboot-1.0.4. It still fails to start the kernel. It stops at "rfi"
>instruction in "turn_on_mmu" in the file "arch/ppc/kernel/head_8xx.S"
>
>         turn_on_mmu:
>           mfmsr   r0
>                 ori     r0,r0,MSR_DR|MSR_IR
>           mtspr   SRR1,r0
>                 lis     r0,start_here@h
>           ori     r0,r0,start_here@l
>                 mtspr   SRR0,r0
>           SYNC
>                 rfi                             /* enables MMU */

After the instruction, the MMU is enabled and the code should continue at
the function 'start_here'. Probably you are single-stepping using MPC8BUG,
which cannot handle the MMU. So the next breakpoint, which is set by
MPC8BUG, will never be reached, because it is set to a physical address.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
