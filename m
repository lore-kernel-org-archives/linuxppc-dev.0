To: joakim.tjernlund@lumentis.se
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PWM on the MPC850 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 11 Dec 2002 14:55:42 +0100."
             <IGEFJKJNHJDCBKALBJLLAELKFIAA.joakim.tjernlund@lumentis.se>
Date: Wed, 11 Dec 2002 15:50:54 +0100
Message-Id: <20021211145059.27DECC613A@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <IGEFJKJNHJDCBKALBJLLAELKFIAA.joakim.tjernlund@lumentis.se> you wrote:
>
> > But be warned: do NOT use any of the port B pins for I/O  in  such  a
> > setup. There is a race condition within all MPC8xx CPUs.
>
> hmm, we access a few port B I/O pins from user space. What/where is the
> race in kernel?

It's not in the kernel, it's in the MPC8xxL.

The RISC timers are implemented in softtware (microcode)  running  on
the  CPM.  To  toggle  a PWM output pin, the CPM will read the port B
data register, modify the bit, and rewrite the port B data  register,
This  access is NOT synchronized against any accesses by the CPU. You
can test this by toggeling a port B pin with software running on  the
CPU:  after  each write to the port B data register read the register
back for a couple of times. You will find that,  as  soon  as  a  PWM
timer is running, the value you write will not "stick".

It's a classical race condition: the CPM reads PBDAT to modify a  PWM
pin, then the CPU writes a new value (modifying a different bit), the
the  CPM writes his copy back - and the value written by the CPU gets
lost. You can see this on an oscilloscope: the data  written  by  the
CPU will be actually there onthe outputs for some 15...25 ns (nano!),
and then drop back to the old state.

Moto never officially confirmed the problem, but the  MPC823E  UM  (I
didn't find this anywhere else) contains the traitorous words:

    [16.2.6.4.4 PWM Mode] ... Because the CPM has to read the
    data register, modify it and then write it back, you cannot
    use open drain output with the PWMs if the output can be
    forced to 0 by external devices.

This is IMHO related to the same problem.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Writing a book is like washing an elephant: there's no good place  to
begin  or  end,  and  it's  hard to keep track of what you've already
covered.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
