Date: Wed, 27 Feb 2002 09:42:00 +0100 (MET)
From: Gerard Basler <gbasler@ee.ethz.ch>
To: linuxppc-embedded@lists.linuxppc.org
Subject: I2C RTC
Message-ID: <Pine.GSO.4.43.0202270920180.6136-100000@tardis-a01.ee.ethz.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I should write a driver for the M41T00 real time clock which is
connected over the I2C bus to the PPC405GP processor.
To write a replacement for the /dev/rtc driver is not so difficult, but
I've found out that the kernel reads/writes time directly to the CMOS
bypassing such a driver.
I received a similar driver for an ARM platform. It's based on the
driver acorn/char/pcf8583.c.
My problem is that I don't know what the ppc_md.set_rtc_time /
ppc_md.get_rtc_time calls are good for and when they are called (from
interrupt?). The ARM driver changes a similar pointer
"set_rtc" defined in arch/arm/kernel/time.c, to it's own routine as soon
as the driver is ready. (This looks like a bad hack...)
Must I do a the same with the pointers in ppc_md?
What's the meaning of the variable xtime?
(Why is the time not stored in cpu internal counters?)

Thanks for any hint that could help

Gerard

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
