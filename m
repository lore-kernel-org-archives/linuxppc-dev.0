Message-Id: <4.2.0.37.19990521183415.04a02b30@mail.lauterbach.com>
Date: Fri, 21 May 1999 18:36:16 +0200
To: Jim Chapman <jim.chapman@iname.com>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: Q: Register usage in mpc860 ports
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <37457D27.DA34E026@iname.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 17:35 21.05.99 , Jim Chapman wrote:

>I am porting LinuxPPC to a custom embedded mpc860 board. I am starting
>with the mbx port and using home-built egcs-1.1.2 tools on  a Linux
>host, using the instructions in
>http://members.home.com/mmporter/cross.html
>
>There seem to be register usage conflicts in the MMU TLB handlers. The
>code tries to use location 0 (according to the comment) to store a
>couple of register values, e.g. in arch/ppc/kernel/head.S
>
>InstructionTLBMiss:
>  mtspr M_TW, r20 /* Save a couple of working registers */
>  mfcr r20
>  stw r20, 0(r0)
>  stw r21, 4(r0)
>
>However, I am finding that r0 isn't zero when the MMU exceptions are
>taken. Instead, it points to somewhere in the text or data segment. I
>hacked the code to save r20 & r21 to a specific memory location and that
>fixed that particular problem.

r0 represents 0 in a number of PPC instructions, lookup stw in your PPC 
assembler book.

Franz.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
