To: "Cordes, Aaron M" <aaron.m.cordes@lmco.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux 2.4.27-pre6-bk hangs on MPC8540 board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 12 Aug 2004 07:47:53 CDT."
             <EE7CAF713952AC4A970DD7CD8B4C12A042DCA7@emss09m06.us.lmco.com>
Date: Thu, 12 Aug 2004 16:07:45 +0200
Message-Id: <20040812140750.DE89DC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <EE7CAF713952AC4A970DD7CD8B4C12A042DCA7@emss09m06.us.lmco.com> you wrote:
>
> We are bringing up an 8540-based board, and are getting hangs at random
> spots when booting Linux.  Sometimes the hangs occur while the kernel is
> initializing, sometimes the boot gets far enough where I can log in and
> run a couple of programs.  Eventually the board locks up with no oopses
> or panics.  If I connect to the board with a debugger, the processor is
> usually stopped in the Data miss exception handler, and there is usually
> memory corruption in the kernel code.

That's it: memory problems.

> I ran memory tests using both Edink and U-boot and they all passed, so
> I'm reluctant to blame hardware for the memory corruption.  Has anyone
> seen similar behavior, or have any suggestions of things I might try?

All those memory tests only can test simple read and write  accesses;
they  all  fail to access burst mode accesses, which will happen when
Linux starts runing, and which are failing.

Your SDRAM initialization is bad, and  the  system  crashes  when  it
tries to fetch instructions from RAM. Note that simple read and write
accesses may still work, it's the burst mode that is failing.

It is NOT sufficient to program the memory controller  of  your  CPU;
each  SDRAM  chip  also  requires  a specific initialization sequence
which you must adhere  to  to  the  letter  -  check  with  the  chip
manufacturer's manual.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If this is a service economy, why is the service so bad?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
