Date: Wed, 5 Jan 2000 17:04:09 -0500 (EST)
From: Naoki Takebayashi <ntakebay@bio.indiana.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: enhanced RTC and SMP on PowerMac
Message-ID: <Pine.SOL.4.10.10001051648140.262-100000@sunflower.bio.indiana.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Is enhanced RTC supposed to work on PowerMac?  When I compile with
CONFIG_RTC, the kernel doesn't boot up and dies when it hits the following
line:

   /* Initialize periodic freq. to CMOS reset default, which is 1024Hz */
   CMOS_WRITE(((CMOS_READ(RTC_FREQ_SELECT) & 0xF0) | 0x06), RTC_FREQ_SELECT);

in the function, __initfunc(int rtc_init(void)), in
linux/drivers/char/rtc.c.

I'm using 2.2.14 on PowerSurge board (UMAX S900).

I was looking at the linux/arch/ppc/kernel/pmac_time.c and prep_time.c.
And I noticed, that PReP machine uses CMOS_WRITE to access RTC, but
PowerMac uses cuda to access RTC instead of CMOS_WRITE.  So I'm guessing
that enhanced RTC doesn't work on the PowerMacs, right now.


Naoki Takebayashi     <ntakebay@bio.indiana.edu>
--- Dept. of Biology, Indiana University, Jordan Hall 142
--- 1001 E. Third St. Bloomington, IN 47405-3700 USA


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
