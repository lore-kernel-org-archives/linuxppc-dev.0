Message-Id: <200004031503.RAA01458@denx.local.net>
To: Ron Flory <ron.flory@adtran.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Basic questions about PPC embedded developement under Linux 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 03 Apr 2000 09:08:01 CDT."
             <38E8A5C1.349EE908@adtran.com>
Date: Mon, 03 Apr 2000 17:03:26 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <38E8A5C1.349EE908@adtran.com> you wrote:
>
>  My primary concern is how to use GDB (or better yet, DDD) with a PPC
> board via the DBM port.  Is there a Linux tool that permits initial
> program download, register access, and debugging via the Moto standard
> PPC BDM port ?

You have several options, mostly  depending  on  how  much  work/time
and/or money you want to spend.

There are several do-it-yourself BDM kits available with interfaces
to GDB (and thus DDD), see for instance
http://www.vas-gmbh.de/software/mpcbdm/
The main problem with thse solutions is  usually  that  they  require
some soldering work, are not very fast, and don't support programming
FLASH memory.

There are also some vendors offerin full-grown BDM debuggers that run
in a Linux environment, for  instance  VisionICE  by  EST.  The  main
problem  with  these tools is that they don't integrate too well with
the Linux toolchain, i. e. you can't just get the  hardware  and  use
GDB  /  DDD,  but  instead you have to buy their commercial debugger.
This makes these solutions pretty expensive.


Then there is the BDI2000 by Abatron; it is pretty fast, you can  use
a  telnet  interface  for  low  level things, and it talks GDB Remote
Protocol (see http://www.abatron.ch/Manuals/ManGDBCOP-2000B.pdf). For
me this was the optimum solution - YMMV.

Additional goodies: Abatron is really responsive; within a  few  days
they  provided a configuration tool for the BDI2000 for Linux (so far
you had to configure the box using a Windows  box)  and  an  extended
firmware   version   which   understands  the  Linux  "zImage"  resp.
"zImage.initrd" formats.

[Disclaimer: No, I'm not payed  by  Abaron,  but  I  am  a  satisfied
customer.]

>  If so, I'll push very hard to ensure Linux is the developement platform
> for our next project-

Go for it!

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I am a computer. I am dumber than any human and smarter than any  ad-
ministrator.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
