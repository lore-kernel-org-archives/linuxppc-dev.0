Message-ID: <3DF7BCD6.6080605@redswitch.com>
Date: Wed, 11 Dec 2002 14:31:50 -0800
From: "Xiaogeng (Shawn) Jin" <xjin@redswitch.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: usage of disarm_decr[]
References: <3DF7AA61.9020205@redswitch.com> <15863.44615.245438.78166@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you. I have some further questions regarding to timer_interrupt().

How often is timer_interrupt() invoked? Every 1/HZ seconds? This is
controlled by the decrementer, right? Initially the value of the
decrementer is 'tb_ticks_per_jiffy'. Then it's updated in
timer_interrupt(). Why isn't 'next_dec' the initial value
'tb_ticks_per_jiffy'? It's due to the time drift caused by the accuracy
of external clock (oscillator) or by the precision of software?

	next_dec = tb_ticks_per_jiffy - tb_delta(&jiffy_stamp)

The timebase register is initialized to zero and then increments
periodically. How does it increment? Each clock (TMBCLK) the increment
is 1? by itself, I mean, hardware itself, or by software?

>>What's the purpose of using disarm_decr? I read the timer_interrupt()
>>code and found the only place where it's referenced.
>
> RT-Linux (www.fsmlabs.com) uses it.  RT-Linux takes over all interrupt
> handling, including decrementer interrupts, and the disarm_decr thing
> is there to give RT-Linux a way to take control of the decrementer
> register.

Thanks.

- Shawn.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
