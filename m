To: lapinski@ece.utexas.edu
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kernel debugging in MontaVista Journeyman 2.0 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 07 Feb 2002 19:24:02 CST."
             <Pine.A41.4.44.0202071800550.13790-100000@pacific.ece.utexas.edu>
Date: Fri, 08 Feb 2002 09:11:30 +0100
Message-Id: <20020208081135.84C39109D5@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Viktor,

in message <Pine.A41.4.44.0202071800550.13790-100000@pacific.ece.utexas.edu> you wrote:
>
>
> We have Motorola Sandpoint with PPMC8240 and MontaVista Journeyman 2.0.
> Budget constraints do not allow us to have a full version of MontaVista
> Linux and I am trying to find some ways to do kernel debugging with the
> Journeyman version of linux-2.4.2_hhl20.

IMHO it does not matter much  if  you're  running  MV  Journeyman  or
professional or _any_ other version of the Linux kernel.

The most efficient way (IMHO) for kernel debugging is  using  a  JTAG
debugger  like  the  Abatron  BDI2000.  Note  that  I'm talking about
debugging here...

> We need to perform some measurements on a network card driver.  Ideally,
> it would be great to obtain executuion traces (on the machine instruction

Performance analysis and execution traces is a different story.

> level) of different components of that driver (eventaully with timestamps)
> and also (probably indirectly) measure DMA exchanges between the network
> card and RAM.  Setting breakpoints is also desirable.

You have several  options  for  traces  /  timing  analysis.  A  pure
software  approach  is  the  Linux  Trace  Toolkit, which can provide
extremely interesting information, and it's _free_.

A mixed approach (software instrumentation and hardware  support  for
data  accquisition)  is  CodeTEST  by  Applied Microsystems; it's not
exactly cheap but can be used for a lot in interesting things, up  to
and  including  MC/DC code coverage; execution traces with timestamps
are included, too.

There are probably a couple of other tools that allow oa  combination
of  debugging  and  tracing.  You  may  want  to check out tools like
Lauterbach's TRACE32 for instance - but be careful to ask  for  Linux
MMU  support;  I  know that they have it for MPC8xx CPUs, but I'm not
sure about the 82xx.

> Journeyman apparently does not have KGDB support and I would highly

You don't need kgdb when you have a BDM / JTAG debugger :-)

> be done (besides using occiloscope or printouts and pencil).  It's the
> first time I am trying to get deep into the kernel so any of your
> suggestions/references would be very helpful.

My recommendation is to start with LTT; probably  this  provides  all
information you need, and maybe more.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Perfection is reached, not when there is no longer anything  to  add,
but when there is no longer anything to take away.
- Antoine de Saint-Exupery

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
