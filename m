Message-ID: <3BD9238D.6080009@humboldt.co.uk>
Date: Fri, 26 Oct 2001 09:49:17 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: Steven Scholz <steven.scholz@imc-berlin.de>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: CAN and MPC855T/860T
References: <20011026080628.D625310CDA@denx.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:


> IMHO there are two Open Source projects that look interesting:
>
>    1. http://home.wanadoo.nl/arnaud/


Two days ago I got this code working using a SJA1000 chip on a PowerPC
system. It's very "interesting" code, for the following reasons:

1) Its initialisation is back to front. Most Linux subsystems you load a
hardware driver which calls a function to register itself. With this you
load the CAN subsystem which takes module arguments telling it which
hardware drivers to use.


2) When the interrupt handlers call worker functions, they pass the
parameters through global variables rather than as function parameters.

3) It has two different ways of keeping track of its circular buffers,
by an index or by pointers. Different routines use different methods,
with hilarious consequences. (This may particularly cause problems for
users of Pelican mode.)

4) It has several loops with udelays() in them. One of these gets called
by an interrupt handler.

I'm not entirely sure what to do with my changes, as I also integrated
it into the kernel tree (the target system doesn't use modules).

--
Adrian Cox   http://www.humboldt.co.uk/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
