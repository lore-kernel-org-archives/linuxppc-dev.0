Message-Id: <200103161815.NAA49161@p2.parker.boston.ma.us>
To: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <karid@flaga.is>
Cc: "Linux Embedded ppc (E-mail)" <linuxppc-embedded@lists.linuxppc.org>,
	linux-usb-devel@lists.sourceforge.net
Subject: Re: USB questions (for the MPC8xx) 
In-reply-to: Your message of "Fri, 16 Mar 2001 12:52:10 GMT."
             <EADB10BAC266A14A85ECBF8686A73E310A9116@kolkrabbi.flaga.is>
Date: Fri, 16 Mar 2001 13:15:18 -0500
From: Brad Parker <brad@parker.boston.ma.us>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


=?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= wrote:
>
>Hi,
>
>In the m8xxhci.c hci driver for the mpc one can select to use TIMER1 for
>the SOF generator.
>A interruopt handler, m8xxhci_timer_interrupt() is registered to handle
>this interrupt and generate the SOF.

so many questions! :-)

>Why is it then that the timer is also exported to PA6?


>Why is it the the USE_TIMER1_FOR_SOF is defined within the
>USE_UCODE_PATCH which is for external generated SOF-interrupt?
>Isn't the timer option exactly for the case where you do not have
>externally generated SOF-interrupt?
>If we can use a timer for generating the SOF why can't we just use a
>regular kernel timer instead, and therfore free one timer or baud rate
>generator?

I'm not aware of the driver using PA6.  (if you're talking about Roman's
patch, it's probably because he's connected PA6/TOUT1 to PC15/DREQ0
to make the microcode patch work - see below)

The code uses a microcode patch which requires a 1Khz signal be fed to
DREQ0.

The DW rev of the RPXLite board has circuitry which will connect DREQ0
(a.k.a. PC15) to BRG1O (a.k.a. PA7).

So, the code outputs BRG1 on PA7 and makes PC15 an input.

Because the Sipex 5310 USB transceiver does not echo tranmitted data
the way the Philips transceiver does (and the Philips is used on the
FADS board so the MOT people assume thats what you have), you will NOT
get SOF interrupts if you use Sipex part (which some RPXLite board do,
since it claims to be pin compat).

So, if you have a Sipex USB transceiver you need a way to figure out
when the SOF interrupts occur.  One way is to connect DREC0 to an
interrupt line, but this requires a h/w change.

A s/w only fix is to run a h/w timer and to 'sync' it to the BRG1
output.  This is what timer4 is used for.  A linux timer can't be used
becuase it won't stay in sync.  The timer can not drift - it must be
exactly in sync with the BRG1' timer'.

If you are designing hardware or can change it I would use timer1 (or
any timer which has an output pin) and connect the timer output to
DREC0.  This frees up BRG1 and is the simplest way to make the microcode
patch work.

On the BSE ipengine I generate the 1khz in the fpga and since it used
the philips part I don't need to use any timers at all.

The timer code in the driver is confusing and there is lots of old
unused code.  I'm about to remove 50% of it.

Hope this helps.  If not, ask again...

-brad

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
