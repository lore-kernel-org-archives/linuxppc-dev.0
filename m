Message-ID: <001901c211b4$194a4b40$7301a8c0@zhongqx>
From: "zhongqx" <zhongqx@guoguang.com.cn>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Timer interrup can not go forward!
Date: Wed, 12 Jun 2002 09:54:30 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sir,
    How are you!
    I find the problem with my linux-2.4.18 on MPC8xxFADS board ,I find when the Start_kernel function in /init/main.c run to Sti(),
then time_interrupt() start,but it can not be finished,it loop in while loops like following ,can not go out from while loops,Do you have
this probelm? thank you in advance!




int timer_interrupt(struct pt_regs * regs)
{
 int next_dec;
 unsigned long cpu = smp_processor_id();
 unsigned jiffy_stamp = last_jiffy_stamp(cpu);
 extern void do_IRQ(struct pt_regs *);

 if (atomic_read(&ppc_n_lost_interrupts) != 0)
  do_IRQ(regs);

 hardirq_enter(cpu);

 while ((next_dec = tb_ticks_per_jiffy - tb_delta(&jiffy_stamp)) < 0) {
  jiffy_stamp += tb_ticks_per_jiffy;
  if (!user_mode(regs))
   ppc_do_profile(instruction_pointer(regs));
    if (smp_processor_id())
   continue;

  /* We are in an interrupt, no need to save/restore flags */
  write_lock(&xtime_lock);
  tb_last_stamp = jiffy_stamp;
  do_timer(regs);

  /*
   * update the rtc when needed, this should be performed on the
   * right fraction of a second. Half or full second ?
   * Full second works on mk48t59 clocks, others need testing.
   * Note that this update is basically only used through
   * the adjtimex system calls. Setting the HW clock in
   * any other way is a /dev/rtc and userland business.
   * This is still wrong by -0.5/+1.5 jiffies because of the
   * timer interrupt resolution and possible delay, but here we
   * hit a quantization limit which can only be solved by higher
   * resolution timers and decoupling time management from timer
   * interrupts. This is also wrong on the clocks
   * which require being written at the half second boundary.
   * We should have an rtc call that only sets the minutes and
   * seconds like on Intel to avoid problems with non UTC clocks.
   */
  if ( (time_status & STA_UNSYNC) == 0 &&
       xtime.tv_sec - last_rtc_update >= 659 &&
       abs(xtime.tv_usec - (1000000-1000000/HZ)) < 500000/HZ &&
       jiffies - wall_jiffies == 1) {
     if (ppc_md.set_rtc_time(xtime.tv_sec+1 + time_offset) == 0)
    last_rtc_update = xtime.tv_sec+1;
   else
    /* Try again one minute later */
    last_rtc_update += 60;
  }
  write_unlock(&xtime_lock);
 }
 if ( !disarm_decr[smp_processor_id()] )
  set_dec(next_dec);
 last_jiffy_stamp(cpu) = jiffy_stamp;

#ifdef CONFIG_SMP
 smp_local_timer_interrupt(regs);
#endif /* CONFIG_SMP */

 if (ppc_md.heartbeat && !ppc_md.heartbeat_count--)
  ppc_md.heartbeat();

 hardirq_exit(cpu);

 if (softirq_pending(cpu))
  do_softirq();

 return 1; /* lets ret_from_int know we can do checks */
}


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
