Message-ID: <3DF7AA61.9020205@redswitch.com>
Date: Wed, 11 Dec 2002 13:13:05 -0800
From: "Xiaogeng (Shawn) Jin" <xjin@redswitch.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: usage of disarm_decr[]
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


disarm_decr[] is defined as an unsigned long array but never get
initialized in arch/ppc/kernel/time.c.

What's the purpose of using disarm_decr? I read the timer_interrupt()
code and found the only place where it's referenced.

int timer_interrupt(struct pt_regs * regs)
{
...
	if ( !disarm_decr[smp_processor_id()] )
		set_dec(next_dec);
	last_jiffy_stamp(cpu) = jiffy_stamp;
...
}

So in this case, the value of disarm_decr[] is always zero, right? Then
the decrementer get set each time when the timer interrupt is invoked.

--
Shawn Jin
RedSwitch Inc.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
