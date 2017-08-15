Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWdTy0zykzDr2S
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 13:37:58 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Breno Leitao <leitao@debian.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 1/2] powerpc/xmon: Dump ftrace buffers for the current
 CPU only
In-Reply-To: <20170814201007.2ovddznqow6qno56@gmail.com>
References: <1501704846-22625-1-git-send-email-leitao@debian.org>
 <87efseqp7s.fsf@concordia.ellerman.id.au>
 <20170814201007.2ovddznqow6qno56@gmail.com>
Date: Tue, 15 Aug 2017 13:37:55 +1000
Message-ID: <87a831v6uk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Breno Leitao <leitao@debian.org> writes:

> Hello Michael,
>
> On Mon, Aug 14, 2017 at 11:00:07PM +1000, Michael Ellerman wrote:
>> Breno Leitao <leitao@debian.org> writes:
>> > @@ -2231,6 +2232,19 @@ static void xmon_rawdump (unsigned long adrs, long ndump)
>> >  	printf("\n");
>> >  }
>> >  
>> > +static void dump_tracing(void)
>> > +{
>> > +	int c;
>> > +
>> > +	c = inchar();
>> > +	if (c == 'c')
>> > +		ftrace_dump(DUMP_ORIG);
>> > +	else
>> > +		ftrace_dump(DUMP_ALL);
>> > +
>> > +	tracing_on();
>> > +}
>> 
>> Thinking about this some more, two things that would make this *really*
>> useful.
>> 
>> Firstly, it would be great if we could dump the buffer for *another*
>> CPU. 
>
> Well, you can do it with this new 'dtc' option on xmon. You just need to
> change to that CPU prior to call 'dtc'.

But that's the problem. If the other CPU is stuck then you can't change
to it in xmon.

If it *isn't* stuck, then you can just change to it and backtrace like
normal.

eg, if you use the HARDLOCKUP lkdtm test:

  # cd /sys/kernel/debug/provoke-crash
  # echo HARDLOCKUP > DIRECT
  sysrq: SysRq : Entering xmon
  cpu 0x1: Vector: 501 (Hardware Interrupt) at [c0000000fe9af9a0]
      pc: c0000000000f15d0: plpar_hcall_norets+0x1c/0x28
      lr: c000000000daaf04: check_and_cede_processor+0x34/0x50
      sp: c0000000fe9afc20
     msr: 8000000000009033
    current = 0xc0000000fe95a200
    paca    = 0xc00000000fd40580	 softe: 0	 irq_happened: 0x09
      pid   = 0, comm = swapper/1
  Linux version 4.13.0-rc2-gcc-6.3.1-00101-ged49f7fd6438 (michael@ka3.ozlabs.ibm.com) (gcc version 6.3.1 20170214 (Custom e9096cb27f4bd642)) #455 SMP Mon Aug 14 22:19:37 AEST 2017
  enter ? for help
  [link register   ] c000000000daaf04 check_and_cede_processor+0x34/0x50
  [c0000000fe9afc20] c000000000daaef0 check_and_cede_processor+0x20/0x50 (unreliable)
  [c0000000fe9afc80] c000000000daaf94 shared_cede_loop+0x74/0x2b0
  [c0000000fe9afcd0] c000000000da6fa0 cpuidle_enter_state+0xe0/0x6b0
  [c0000000fe9afd50] c0000000001ff17c call_cpuidle+0x7c/0x110
  [c0000000fe9afd90] c0000000001ff800 do_idle+0x350/0x460
  [c0000000fe9afe20] c0000000001ffbe8 cpu_startup_entry+0x38/0x40
  [c0000000fe9afe50] c000000000060108 start_secondary+0x528/0xb90
  [c0000000fe9aff90] c00000000000af6c start_secondary_prolog+0x10/0x14
  1:mon> c
  cpus stopped: 0x0-0x5 0x7-0xf
  1:mon> 
  1:mon> c 6
  cpu 0x6 isn't in xmon


Notice that CPU 6 hasn't called in, so we can't switch to it, and we
have no (easy) way of working out where it is.

If we could dump the ftrace buffer for CPU 6 from another CPU, we'd be
able to see eg:

  6)               |  SyS_write() {
  6)               |    __fdget_pos() {
  6)   0.088 us    |      __fget_light();
  6)   1.168 us    |    }
  6)               |    vfs_write() {
  6)   0.092 us    |      rw_verify_area();
  6)   0.062 us    |      __sb_start_write();
  6)               |      __vfs_write() {
			  ...
  6)               |            lkdtm_do_action() {
  6)               |              lkdtm_HARDLOCKUP() {
---------------------------------


Which would be helpful.

cheers
