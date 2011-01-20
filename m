Return-Path: <Tiejun.Chen@windriver.com>
Message-ID: <4D3799BF.5020001@windriver.com>
Date: Thu, 20 Jan 2011 10:11:11 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: MohanReddy koppula <mohanreddykv@gmail.com>
Subject: Re: Problem with Busybox shell
References: <AANLkTinSfn+TQvzNWc++qP=4B2tbcHo-2iGv6E8tsq+b@mail.gmail.com>	<20110118175533.GB28268@opentech.at>	<AANLkTinDsQYS=dHM2EVbCxv0Yk2zVq5LrYJemL6nSn3D@mail.gmail.com>	<4D3678B6.1040707@windriver.com>
	<AANLkTim0xJr_sr4ZZxngTS7adDKaBpS7=_KeDMwv6mTc@mail.gmail.com>
In-Reply-To: <AANLkTim0xJr_sr4ZZxngTS7adDKaBpS7=_KeDMwv6mTc@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Linuxppc-dev@lists.ozlabs.org, Nicholas Mc Guire <der.herr@hofr.at>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MohanReddy koppula wrote:
> I further debugged and found that flush_to_ldisc() function is not
> called which actually wakes up the readers. This is a worker function
> and is not being scheduled. I suspected whether timer interrupts are
> generated or not. powerpc uses decrementer exceptions as timer
> interrupts. I see that timer_interrupt() function in
> arch/powerpc/kernel/time.c is not called at all. I printed even
> jiffies values and it is not incremented. And I beleivethis makes
> scheduler is not scheduling this worker thread.
> 
>  I think if flush_to_ldisc is not called nothing can be read from the tty.
> 
> Please let me know what could be the reason for timer interrupt being
> not called.

As you know the decrement exception always is invoked by the TB REGs, unless
there is one higher priority exception to block that.

Here I show the jiffies updating path simply as follows (only one simple path,
actually the timer framework should be more complicated.):
-------
DECREMENT Exception
	-> timer_interrupt
		|
		+ evt->event_handler(evt);
			|
			+ tick_handle_periodic()
				|
				+ tick_periodic(cpu);
Then
------
static void tick_periodic(int cpu)
{
        if (tick_do_timer_cpu == cpu) {
                write_seqlock(&xtime_lock);

                /* Keep track of the next tick event */
                tick_next_period = ktime_add(tick_next_period, tick_period);

                do_timer(1);
                write_sequnlock(&xtime_lock);
        }

        update_process_times(user_mode(get_irq_regs()));
        profile_tick(CPU_PROFILING);
}

So if we cannot set/update TB we would have no decrement exception. Or the
kernel is locked/looped somewhere.

Can you track the whole process via print? Maybe you can find out something. And
I'm not familiar with 885, is is SMP?

Tiejun

> 
> Thanks,
> Mohan
> 
> 
> 
> 
> On Wed, Jan 19, 2011 at 12:37 AM, tiejun.chen <tiejun.chen@windriver.com> wrote:
>> MohanReddy koppula wrote:
>>> But, if there is any problem with cable I could not have seen any
>>> character in the interrupt routine of the driver. I turned off both
>> I suppose the bootloader, i.e u-boot, works well so looks this should not be
>> issued by the cable at least.
>>
>>> software and hardware flow control as by board doesn't have hardware
>>> flow control. tty_read is called and it hangs at ldisc->read. And I
>> Any panic information? Or any dead lock? Which line in detail?
>>
>>> see that data is put into the tty buffer by the driver. Will there be
>>> any problem with copy_to_user() if there is some problem in the
>>> memory?
>> Can the serial driver support the poll mode? If so maybe you can take a try to
>> exclude any interrupt reason.
>>
>> And even you can remove all codes to initialize the corresponding PIN & CLK
>> dedicated to the serial port, then try again since the bootloader already did this.
>>
>> Tiejun
>>
>>> Thanks,
>>> Mohan
>>>
>>> On Tue, Jan 18, 2011 at 12:55 PM, Nicholas Mc Guire <der.herr@hofr.at> wrote:
>>>> On Tue, 18 Jan 2011, MohanReddy koppula wrote:
>>>>
>>>>> Hi All,
>>>>>
>>>>> I am working on an MPC885 based custom board. I am able to boot up the
>>>>> linux (linux-2.6.33.7). I could see busybox shell (ash) prompt. But it
>>>>> is not accepting any inputs, I am not able to enter any command, it
>>>>> just hangs there. I am using ttyCPM0 terminal.
>>>>>
>>>>> I suspected if there was any problem in CPM driver interrupts
>>>>> generation and put some printk's in the interrupt handler and could
>>>>> see interrupts are raised and data is read, but shell is not taking
>>>>> the input.
>>>>>
>>>>> I wrote an init.c and opened the ttyCPM0 and tried to read from it,
>>>>> but couldn't. I am able to write to ttyCPM0 and see it on the host
>>>>> minicom.
>>>>>
>>>> if you are using minicom to connect check if you have hardware/software flow
>>>> control turned on - it also could be a cabling problem - had this with the
>>>> beagle board where the tx line was on the wrong pin - so I got output but
>>>> could not get any response to input.
>>>>
>>>> hofrat
