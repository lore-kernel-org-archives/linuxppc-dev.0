To: "Donald MacArthur" <dmacarth@ufl.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PWM on the MPC850 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 11 Dec 2002 08:31:21 EST."
             <NDBBIHDFKLJKGJJGMFJOOEILCGAA.dmacarth@ufl.edu>
Date: Wed, 11 Dec 2002 14:43:15 +0100
Message-Id: <20021211134320.0EC51C613A@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <NDBBIHDFKLJKGJJGMFJOOEILCGAA.dmacarth@ufl.edu> you wrote:
>
> Does have any information regarding generating RC spec PWM signals using the
> MPC850
> that does not bog down the processor?  Also does anyone know how to expand

You can, to a certain degree, use the RISC timers to set up a  couple
of  PWM  channels  that run with zero CPU load (just some load on the
CPM). See the PWM driver (arch/ppc/8xx_io/pwm_8xx.c)  in  our  kernel
source tree.

But be warned: do NOT use any of the port B pins for I/O  in  such  a
setup. There is a race condition within all MPC8xx CPUs.

> the number
> of RS232 ports for the MPS850 from two to 2+.

Add one or more external  UARTs?  This  has  been  done  before  (for
example, we have a design with 2 x octal UARTs on a MPC8xx system).

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
An age is called Dark not because  the  light  fails  to  shine,  but
because people refuse to see it.           -- James Michener, "Space"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
