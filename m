Date: Tue, 7 May 2002 19:48:24 -0500
From: Troy Benjegerdes <hozer@drgw.net>
To: Jean-Denis Boyer <jdboyer@mediatrix.com>
Cc: trini@mvista.com, mgreer@mvista.com,
	"'Jim Thompson'" <jim@musenki.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Bogomips and loops_per_jiffy
Message-ID: <20020507194824.X6606@altus.drgw.net>
References: <F1BED55F35F4D3118C0F00E0295CFF4DFF9FEF@mail.mediatrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F1BED55F35F4D3118C0F00E0295CFF4DFF9FEF@mail.mediatrix.com>; from jdboyer@mediatrix.com on Mon, May 06, 2002 at 05:17:40PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, May 06, 2002 at 05:17:40PM -0400, Jean-Denis Boyer wrote:
>
> Jim,
>
> I have found a fix for the hanging "Calibrating delay loop...".
>
> I added the following line at the beginning of
> the function "time_init" in arch/ppc/kernel/time.c
>
>   set_tb(0, 0);
>
> This resets the time base register and avoids the timer interrupt
> to set the second decrementer value to a very large one.
> It happens only when the TBL is large.
>
> This is a quick fix. Because I think it should work
> for any value of TB. It looks like that part of the code
> does not correctly support the overflow.
>
> Looking through the code, I wonder why the return value of
> the function "tb_delta" is signed.

Hrrm... that definitely seems wrong.

I think this is a signed vs unsigned overflow.

Can you try the following and see if it fixes the problem without the
'set_tb()' quick fix? This should be a more 'correct' fix.


===== time.c 1.42 vs edited =====
--- 1.42/arch/ppc/kernel/time.c	Fri Apr  5 12:39:36 2002
+++ edited/time.c	Tue May  7 19:40:39 2002
@@ -99,8 +99,8 @@
 EXPORT_SYMBOL(rtc_lock);

 /* Timer interrupt helper function */
-static inline int tb_delta(unsigned *jiffy_stamp) {
-	int delta;
+static inline unsigned tb_delta(unsigned *jiffy_stamp) {
+	unsigned delta;
 	if (__USE_RTC()) {
 		delta = get_rtcl();
 		if (delta < *jiffy_stamp) *jiffy_stamp -= 1000000000;
@@ -150,7 +150,7 @@
  */
 int timer_interrupt(struct pt_regs * regs)
 {
-	int next_dec;
+	unsigned next_dec;
 	unsigned long cpu = smp_processor_id();
 	unsigned jiffy_stamp = last_jiffy_stamp(cpu);
 	extern void do_IRQ(struct pt_regs *);
@@ -258,7 +258,7 @@
 void do_settimeofday(struct timeval *tv)
 {
 	unsigned long flags;
-	int tb_delta, new_usec, new_sec;
+	unsigned tb_delta, new_usec, new_sec;

 	write_lock_irqsave(&xtime_lock, flags);
 	/* Updating the RTC is not the job of this code. If the time is

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
