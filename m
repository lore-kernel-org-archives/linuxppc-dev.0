Date: Wed, 18 Apr 2001 15:20:22 -0500 (CDT)
From: Grant Erickson <erick205@umn.edu>
To: Gabriel Paubert <paubert@iram.es>
Cc: Linux/PPC Embedded Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Kernel Real Time Clock (RTC) Support for I2C Devices
In-Reply-To: <Pine.HPX.4.10.10104182129390.11443-100000@gra-ux1.iram.es>
Message-Id: <Pine.SOL.4.20.0104181513250.10793-100000@garnet.tc.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 18 Apr 2001, Gabriel Paubert wrote:
> On Wed, 18 Apr 2001, Grant Erickson wrote:
> > >From the looks of drivers/char/rtc.c it would appear that this kernel
> > driver only supports bus-attached RTCs such as the mentioned MC146818. Is
> > this correct?
>
> I think so.
>
> > What is the correct access method / kernel tie-in for supporting such an
> > I2C-based RTC device using the "standard" interfaces?
>
> Adding a new kind of clock to the kernel and setting the correct pointers
> in ppc_md seems the right (if not necessarily simple) solution to your
> problem.

As per Wolfgang's follow-on comments, it looks like there are actually two
places I need to connect things. First, /dev/rtc such that 'hwclock' can
get into the game. Second, the ppc_md interfaces, presumably so when
either ntpd is running or the user does 'date MMDD...' both the Linux
notion of time and the RTC get updated.

> I wonder how you calibrate the decrementer frequency on this machine...

As far as I can see, the decrementer frequency is set based on the 405GPs
64-bit decrementer.

> ...I2C is too slow to get any precision, unless you accept to wait for
> one minute or so at boot. I still have problems of reproducibility of
> clock frequency measurements with bus attached RTC (on machines on
> which the RTC is the only moderately precise timing source and its
> interrupt line is unfortunately not connected).

In light of this, after looking at the PPC kernel code again, it looks
like I might NOT want to set get_rtc_time but just set_rtc_time to get the
ntpd/date functionality.

Thanks for the feedback.

Regards,

Grant Erickson


--
 Grant Erickson                       University of Minnesota Alumni
  o mail:erick205@umn.edu                                 1996 BSEE
  o http://www.umn.edu/~erick205                          1998 MSEE


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
