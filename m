To: Ibon Gotxi Garcia <igotxi@jazzfree.com>
Cc: Linux PPC embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kgdb and mpc8xx (again) 
In-Reply-To: Message from Ibon Gotxi Garcia <igotxi@jazzfree.com>
   of "10 Mar 2003 17:42:01 -0000." <1047318121.29389.44.camel@muse>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 11 Mar 2003 11:56:05 +1100
Message-ID: <11666.1047344165@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 10 Mar 2003 17:42:01 +0000, Ibon Gotxi Garcia <igotxi@jazzfree.com> writes:
>1.- It's something related with some console output (don't know if
>enabling kgdb disables all the console output in SMC1).

It's a long time since I've done this (I've got a bdi2000 now :-) but enabling
CONFIG_KGDB used to enable a call to breakpoint() in the early setup stuff -
and your output from ppc-linux-gdb seems to confirm this. I am surprised that
the board restarts itself - I suspect you are doing something with gdb e.g.
like quitting it (which will send a command to "kill" the running process -
which I think the kgdb stubs interpret as a restart).

Run your ppc-linux-gdb, and when you get the gdb prompt after the breakpoint()
line (I assume you get this), do a "continue" - the kernel should continue from
where it stopped. This breakpoint() gives you an opportunity to do some things
before the kernel gets into full swing (maybe set a breakpoint somewhere).

>2.- A watchdog timeout happens (Does the kgdb code resets the
>watchdog?).

Nothing can "reset" the watchdog (at least on 8xx and 8260) - it can only be
"set" or not - usually by the boot rom. Don't enable watchdog if you want
to use kgdb, unless you patch your kernel appropriately (you have to poke
the watchdog registers from within the kgdb serial code - I might be able
to dredge up some old patches that do this, if you want - but if you can
afford it, its better to buy a bdi2000).

>3.- Do I have to do a "set endian xxx" in ppc-linux-gdb ??? (to get that
>output i have done a "set endian big")

You shouldn't need to if your cross gdb is built correctly (and it will be
since you are using the denx stuff). Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing & Infra. Tech.      Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@csiro.au

Hymod project: http://www.msa.cmst.csiro.au/projects/Hymod/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
