Date: Mon, 20 Mar 2000 21:45:05 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: David Edelsohn <dje@watson.ibm.com>
cc: Florian Lohoff <flo@rfc822.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: PPC/MCA RS/6000 port ? 
In-Reply-To: <200003200257.VAA26624@mal-ach.watson.ibm.com>
Message-ID: <Pine.HPX.4.10.10003202103070.28648-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 19 Mar 2000, David Edelsohn wrote:

> 	The PPC601 was a POWER architecture chip with additional user-mode
> PowerPC instructions.  It was based on the existing RSC (RIOS Single Chip)
> processor that IBM already was using and allowed the first PowerPC chip
> implementation to be developed and deployed very rapidly.  The supervisor
> state of the chip was all POWER architecture, not PowerPC Books II and
> III.  The direct store segments were a way to access special devices on
> the I/O bus.

Actually I thought that the supervisor mode of the 601 was a mixture of
POWER and PPC. I read somewhere that the hash table implementation of the
POWER was very different for example (and POWER had only SPR 0 to 31
while PPCs, including 601, have many more).

Have a look at the code, there are quite a lot of tests for 601 specific
differences (for cache control operations, to avoid touching HID0,
different BATs). And a few ugly things like using the decrementer even in
cases where the tb/rtc would be more appropriate IMHO but the wraparound
at 1e9 of 601's RTCL would be awkward to handle.

However, if the use direct store segments is _unavoidable_, significant
kernel modifications are required.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
