Message-Id: <200101032105.f03L5DY24101@denx.local.net>
To: Subodh Nijsure <subodh@best.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Booting linux kernel. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 03 Jan 2001 12:42:19 PST."
             <200101032042.MAA17739@shell9.ba.best.com>
Date: Wed, 03 Jan 2001 22:05:13 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200101032042.MAA17739@shell9.ba.best.com> you wrote:
>
> I have a custom 860T based board for which I have ppcboot 0.7,  register
...
> When I boot the kernel don't see anything on the console, I have the
> boardinfo structure below.

Which board configuration did  you  chose  when  building  the  Linux
kernel,  and  did  you  really make sure that machine specific header
file (include/asm-ppc/????) includes the same definition of the Board
Information structure as we use in PPCBoot, and that  IMAP_ADDR  uses
the same value as your PPCBoot configuration in CFG_IMMR?


> I guess simple question is how do I go about debugging this problem?
...
> Only tools I have is ppc_8xx-gdb and the Macraigor wiggler to which I
> can connect using rproxy. Is there a better tool that I should acquire
> that will help me in debugging this?

If you don't get any communication working at  all  you  need  a  BDM
debugger,  and  one  that  supports  the MMU. AFAIK the software that
comes with the wiggler does not.

I know of two working solutions for MMU-capable BDM/JTAG debuggers:

- The BDI2000 by Abatron is the commercial solution; it supports fast
  flash programming, provides a telnet interface and talks remote GDB
  protocol over the network, so it fits  ideally  in  a  Linux  based
  development environment. For details see www.abatron.ch

- The BDM4GDB project at SourceForge is the Open Source  approach  to
  the  same  problem.  You can build a small adapter that attaches to
  the parallel port, and the rest  is  done  in  software  as  a  GDB
  extension.  You  have  the  same  debugging  capabilities,  but are
  restricted as you have to use a parallel port on a PC.  Also,  only
  few  flash types are supported (but it's easy to add new ones). See
  the mailng  list  at  bdm4gdb-users@lists.sourceforge.net.  If  you
  cannot  build  the  (simple)  PCB for the adapter yourself, we sell
  limited quantities at production cost (< $ 50).

Feel free to contact me for a quote for the  BDM4GDB  adapter  and/or
the BDI2000.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Above all else -- sky.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
