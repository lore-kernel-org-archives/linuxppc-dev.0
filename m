Date: Sat, 11 May 2002 04:08:47 +0200 (CEST)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jean-Denis Boyer <jdboyer@mediatrix.com>,
	"'Troy Benjegerdes'" <hozer@drgw.net>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>,
	"'Paul Mackerras'" <paulus@samba.org>
Subject: RE: Bogomips and loops_per_jiffy
In-Reply-To: <20020510211649.18120@smtp.wanadoo.fr>
Message-ID: <Pine.LNX.4.33.0205110141410.23021-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 10 May 2002, Benjamin Herrenschmidt wrote:

> >I don't have the time to study whether the patches proposed would work
> >well in all these weird cases.
> >
> >BTW, how do you initially set the system time in your RTC less machines ?
>
> I spent some time studying the latest of the patches and it seems ok.

Yes, however if it can be fixed by just adding an initialization of the
timebase or of the timekeeping values even on the machines on which you
can't initialize the system time, I'd prefer to do it that way.

The decrementer interrupt code is not executed frequently enough to stay
in the cache, so making it bigger means perhaps one more cache miss (to
memory, not to L2 or L3) HZ times per second. Not a big deal I know, but
you know that I'm a fanatic of minimal code size (as everybody should be
for non looping code at least) and the loop exit expression I wrote maps
exactly to:

	sub. next_dec,tb_ticks_per_jiffy,tb_delta()


Besides that, the proposed patch which only exits the loop when the
decrememter count falls between 0 and tb_ticks_per_jiffy means that in the
missing initialization case you are going to execute do_timer() a few
thousand times. Although it should not cause any problem since I don't
expect any timer to be running at this early boot stage, I find this
possibility extremely ugly.

In short, I still prefer fixing the initialization of tb_last_stamp, which
could be done with the following simple (but untested and not even
compiled) patch, which essentially shrinks what we skip when
ppc_md.get_rtc_time is not defined.

That's from my 2.4 BK repository but it should apply almost trivially to
any 2.4/2.5 kernel.

===== time.c 1.32 vs edited =====
--- 1.32/arch/ppc/kernel/time.c	Fri Apr  5 19:17:22 2002
+++ edited/time.c	Sat May 11 03:46:08 2002
@@ -316,8 +316,9 @@
 	 * makes things more complex. Repeatedly read the RTC until the
 	 * next second boundary to try to achieve some precision...
 	 */
+	sec = 0;
+	stamp = get_native_tbl();
 	if (ppc_md.get_rtc_time) {
-		stamp = get_native_tbl();
 		sec = ppc_md.get_rtc_time();
 		elapsed = 0;
 		do {
@@ -331,14 +332,14 @@
 		if (sec==old_sec) {
 			printk("Warning: real time clock seems stuck!\n");
 		}
-		write_lock_irqsave(&xtime_lock, flags);
-		xtime.tv_sec = sec;
-		last_jiffy_stamp(0) = tb_last_stamp = stamp;
-		xtime.tv_usec = 0;
-		/* No update now, we just read the time from the RTC ! */
-		last_rtc_update = xtime.tv_sec;
-		write_unlock_irqrestore(&xtime_lock, flags);
 	}
+	write_lock_irqsave(&xtime_lock, flags);
+	xtime.tv_sec = sec;
+	last_jiffy_stamp(0) = tb_last_stamp = stamp;
+	xtime.tv_usec = 0;
+	/* No update now, we just read the time from the RTC ! */
+	last_rtc_update = xtime.tv_sec;
+	write_unlock_irqrestore(&xtime_lock, flags);

 	/* Not exact, but the timer interrupt takes care of this */
 	set_dec(tb_ticks_per_jiffy);


Oh, BTW I just had to reboot 6 machines (correlation spectrometers) after
some hardware modifications I had to perform today, that's what I have in
the logs showing the absolute time error on boot of these machines:

May 10 21:25:02 vcorr1 ntpdate[203]: step time server 150.214.224.210
offset -0.010231 sec
May 10 21:25:03 vcorr2 ntpdate[203]: step time server 150.214.224.210
offset 0.014724 sec
May 10 21:25:06 vcorr3 ntpdate[203]: step time server 150.214.224.210
offset 0.035770 sec
May 10 21:25:09 vcorr4 ntpdate[203]: step time server 150.214.224.210
offset 0.045062 sec
May 10 21:25:09 vcorr5 ntpdate[203]: step time server 150.214.224.210
offset 0.034193 sec
May 10 21:25:21 vcorr6 ntpdate[203]: step time server 150.214.224.210
offset 0.034062 sec

I believe we can do better but since what I have some doubts on the
absolute precision of the RTC chips when you store a new value. But the
documentation of the chips on this kind of details sucks. The only
conclusion is that I have to write to the clock as close as possible from
the second boudnary and not on the half second like PC clocks.

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
