Message-ID: <B1243F436404D511A5CF009027E705DA04EC4B37@uswaumsx09medge.med.ge.com>
From: "Petersen, David (MED, GEMS-IT)" <David.Petersen@med.ge.com>
To: "'Jean-Denis Boyer'" <jdboyer@mediatrix.com>,
	"'Gabriel Paubert'" <paubert@iram.es>
Cc: Troy Benjegerdes <hozer@drgw.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: RE: Bogomips and loops_per_jiffy
Date: Fri, 10 May 2002 09:15:17 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	On the 8xx processors that I use the tb is not reset by Hard or
Soft reset (per Motorla manual), therefore it is required to set the tb
to achieve consistant operation. My system will hang periodically and
whenever it does the initial decrementer value has been set to a huge
value eg 0xFD842356.



-----Original Message-----
From: Jean-Denis Boyer [mailto:jdboyer@mediatrix.com]
Sent: Friday, May 10, 2002 9:11 AM
To: 'Gabriel Paubert'
Cc: Troy Benjegerdes; Benjamin Herrenschmidt;
linuxppc-embedded@lists.linuxppc.org; Paul Mackerras
Subject: RE: Bogomips and loops_per_jiffy



Grabiel,

> I'm afraid that this is a symptom of lost timekeeping
> after reading the RTC and that you simply cure the symptom.

My platform uses an 8260 processor, and AFAIK there is no RTC. The
function
__USE_RTC() returns 0.

> Better set the TB to a large value to force the problem and
> see if you can reproduce it.

That's exactly the way I reproduced it!... and why I initially proposed
the
fix set_tb(0,0).

If you add a set_tb(0, 0x90000000) at the beginning of time_init, you
will
fall right into it.

The problem occurs only when the TBL is initially over 0x80000000. Then,
when compared against jiffy_stamp (unsigned, initially 0), and
transformed
into a signed integer, it returns a negative delta, causing the while
loop
in the time_interrupt to be left, and the decrementer set to a very high
value.

Yes, pratically, it will never happen at run time. Anyway, the
decrementer
and the time base count at the same rate, so they share the same
constraints.

At boot time, however, it is platform specific... usually, after a cold
boot, the TB is reset to 0. But after a warm reset, this is not
necessarily
true. Does the boot load resets the time base? The boot loader can also
take
a long time to get the kernel in place and jump to it, for example after
a
heavy hardware testing (RAM and peripherals), or an inefficient TFTP
download... Well, any weird reason you can imagine that slows down the
boot
time only by a few minutes. ;-)

Regards,

--------------------------------------------
 Jean-Denis Boyer, B.Eng., System Architect
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
