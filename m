To: linuxppc-dev@lists.linuxppc.org
Subject: set_rtc_time() cleanup / normalization
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Date: Mon, 12 May 2003 23:17:28 +0200
Message-Id: <20030512211733.B489EC6092@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi everybody,

I would like to find out if there is some consensus about the use  of
set_rtc_time() in the timer interrupt handler.

    Note: this question relates to a thread that was started by
    Stephen Johnson on Tue, 22 Apr 2003; see message:
    http://lists.linuxppc.org/linuxppc-embedded/200304/msg00233.html

The problem: some systems use RTC chips which  are  attached  to  the
system  using an I2C bus (or similar). To control the device you will
have to setup one or more I2C transactions, which usually  result  in
one or more interrupts which must be processed.

Depending on which architecture and/or board you are using, there may
or may not be a call to set_rtc_time()  be  performed  in  the  timer
interrupt  handler.  This  call  will  happen  every  11 minutes (659
seconds, to be precise) - see "arch/ppc/kernel/time.c".


I would like to know if there is a rationale  in  putting  this  call
into a general part of the source code.

Other architectures handle this differently. For example, in the  ARM
kernel   tree  the  timer  interrupt  implementation  is  essentially
board-specific (located in a include/asm/arch-.../time.h file).  Some
ARM  boards'  timer interrupt handlers do call set_rtc_time(), others
don't.

Shouldn't we do the same on PPC?

Or maybe we should delete this code completely? If somebody wants  to
sync the RTC against the system time a simple daemon or cron job (for
example calling "hwclock --systohc" every 11 minutes) would result in
more or less identical results.



More information:

Calling set_rtc_time() is useful only in a situation where  there  is
an  external reference time against which the system time is synchro-
nized. In such a configuration this call would make sure that the RTC
is kept in sync with the reference time. This allows  to  start  with
minimal  deviation  in case of a crash, where no orderly shutdown was
performed. In case of a normal shutcown / reboot the shutdown scripts
would take care of saving the system time to RTC anyway...

In all other cases such a call to set_rtc_time() is  not  needed,  or
even harmful.

Many embedded systems run in a configuration where they  use  a  high
precision RTC chip and want to have the system time kept in sync with
it.  In  such  a configuration, the call to set_rtc_time() is plainly
wrong and must be avoided.


Oliver Amft posted a solution which includes spawning a kernel thread
to perform the set_rtc_time() call outside the timer  inteerupt;  see
http://lists.linuxppc.org/linuxppc-embedded/200304/msg00272.html;  in
my opinion this is only a workaround, but  not  a  solution.  Limited
accuracy (scheduling delay for the thread) and code size overhead are
just two of the problems of such a solution.


All feedback welcome.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
PROGRAM - n.  A magic spell cast over a computer  allowing it to turn
one's input into error messages.
v. tr. - To engage in a pastime similar to banging one's head against
a wall, but with fewer opportunities for reward.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
