Date: Wed, 18 Apr 2001 22:44:59 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Grant Erickson <erick205@umn.edu>
Cc: Linux/PPC Embedded Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Kernel Real Time Clock (RTC) Support for I2C Devices
In-Reply-To: <Pine.SOL.4.20.0104181513250.10793-100000@garnet.tc.umn.edu>
Message-ID: <Pine.HPX.4.10.10104182238350.11443-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 18 Apr 2001, Grant Erickson wrote:

> > Adding a new kind of clock to the kernel and setting the correct pointers
> > in ppc_md seems the right (if not necessarily simple) solution to your
> > problem.
>
> As per Wolfgang's follow-on comments, it looks like there are actually two
> places I need to connect things. First, /dev/rtc such that 'hwclock' can
> get into the game. Second, the ppc_md interfaces, presumably so when
> either ntpd is running or the user does 'date MMDD...' both the Linux
> notion of time and the RTC get updated.

Hmmm, the RTC only gets updated automatically if you have the PLL locked
(from NTP) AFAIR.

> > I wonder how you calibrate the decrementer frequency on this machine...
>
> As far as I can see, the decrementer frequency is set based on the 405GPs
> 64-bit decrementer.

Can't comment, don't know the 405.

> In light of this, after looking at the PPC kernel code again, it looks
> like I might NOT want to set get_rtc_time but just set_rtc_time to get the
> ntpd/date functionality.

get_rtc_time once at boot to have an approximate idea of the time at boot
is a good idea in any case.  Having set_rtc_time if you never read the RTC
again looks like write-only memory :-)

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
