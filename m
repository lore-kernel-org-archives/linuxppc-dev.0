Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5E9C7B7D97
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jun 2010 17:03:58 +1000 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp06.in.ibm.com (8.14.4/8.13.1) with ESMTP id o5773rnw021813
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jun 2010 12:33:53 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5773rlM2728084
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jun 2010 12:33:54 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5773qei015616
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jun 2010 12:33:53 +0530
Date: Mon, 7 Jun 2010 12:33:51 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [Patch 0/5] PPC64-HWBKPT: Hardware Breakpoint interfaces - ver
	XXII
Message-ID: <20100607070351.GA3853@in.ibm.com>
References: <20100528063924.GA8679@in.ibm.com>
	<20100602113316.GA17061@brick.ozlabs.ibm.com>
	<20100604065145.GA2408@in.ibm.com>
	<20100604090648.GC26154@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100604090648.GC26154@brick.ozlabs.ibm.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 04, 2010 at 07:06:48PM +1000, Paul Mackerras wrote:
> On Fri, Jun 04, 2010 at 12:21:45PM +0530, K.Prasad wrote:
> 
> > Meanwhile I tested the per-cpu breakpoints with the new emulate_step
> > patch (refer linuxppc-dev message-id:
> > 20100602112903.GB30149@brick.ozlabs.ibm.com) and they continue to fail
> > due to emulate_step() failure, in my case, on a "lwz r0,0(r28)"
> > instruction.
> 
> Strange, what was in r28?  The emulator should handle that instruction.
> 

It must be containing one of the offsets of "struct tracer" which is a
parameter to the function trace_selftest_startup_ksym(). Basically this
function does a selftest over hw-breakpoints by placing read-write
breakpoint on a dummy global-variable and performs read-write access
thereupon. The lwz instruction which fails here corresponds to the
instruction that does read-write. A complete disassemble of the function
upto the failing instruction (at address) is pasted at the end of this
mail.

> > About the latest patchset, given that we chose to ignore extraneous
> > interrupts for non-ptrace breakpoints, I thought that re-using
> > current->thread.ptrace_bps as a flag would be efficient than
> > introducing
> > a new member in 'struct thread_struct' to do the same. I'm not sure
> > if
> > you foresee any issues with that.
> 
> I just wonder what provides exclusion between its use as a flag and
> its use to hold a real ptrace breakpoint.  As far as I can see nothing
> does.  If there is something, it's off in some other source file,
> unless I'm missing something.  And in that case there should be a bit
> fat comment explaining why it's safe.
> 

The hw_breakpoint_handler() goes like this:

int __kprobes hw_breakpoint_handler(struct die_args *args)
{
...
....
	/*
	 * Return early after invoking user-callback function without restoring
	 * DABR if the breakpoint is from ptrace which always operates in
	 * one-shot mode. The ptrace-ed process will receive the SIGTRAP signal
	 * generated in do_dabr().
	 */
	if (is_ptrace_bp) {
		perf_bp_event(bp, regs);
		rc = NOTIFY_DONE;
		goto out;
	}

	/*
	 * Verify if dar lies within the address range occupied by the symbol
	 * being watched to filter extraneous exceptions.
	 */
	if (!((bp->attr.bp_addr <= dar) &&
	     (dar <= (bp->attr.bp_addr + bp->attr.bp_len)))) {
		/*
		 * This exception is triggered not because of a memory access
		 * on the monitored variable but in the double-word address
		 * range in which it is contained. We will consume this
		 * exception, considering it as 'noise'.
		 */
		is_extraneous_interrupt = true;
	}
....
...
}

Given that 'ptrace_bps' is used only for ptrace originated breakpoints
and that we return early i.e. before detecting extraneous interrupts
in hw_breakpoint_handler() (as shown above) they shouldn't overlap each
other. The following comment in hw_breakpoint_handler() explains the
same.
		/*
		 * To prevent invocation of perf_event_bp(), we shall overload
		 * thread.ptrace_bps[] pointer (unused for non-ptrace
		 * exceptions) to flag an extraneous interrupt which must be
		 * skipped.
		 */
Thanks,
K.Prasad

(gdb) disass trace_selftest_startup_ksym
Dump of assembler code for function trace_selftest_startup_ksym:
0xc000000000125580 <trace_selftest_startup_ksym+0>:	mflr    r0
0xc000000000125584 <trace_selftest_startup_ksym+4>:	std     r26,-48(r1)
0xc000000000125588 <trace_selftest_startup_ksym+8>:	std     r27,-40(r1)
0xc00000000012558c <trace_selftest_startup_ksym+12>:	std     r28,-32(r1)
0xc000000000125590 <trace_selftest_startup_ksym+16>:	std     r29,-24(r1)
0xc000000000125594 <trace_selftest_startup_ksym+20>:	std     r30,-16(r1)
0xc000000000125598 <trace_selftest_startup_ksym+24>:	std     r31,-8(r1)
0xc00000000012559c <trace_selftest_startup_ksym+28>:	std     r0,16(r1)
0xc0000000001255a0 <trace_selftest_startup_ksym+32>:	stdu    r1,-176(r1)
0xc0000000001255a4 <trace_selftest_startup_ksym+36>:	mr      r31,r1
0xc0000000001255a8 <trace_selftest_startup_ksym+40>:	ld      r30,-17784(r2)
0xc0000000001255ac <trace_selftest_startup_ksym+44>:	mr      r26,r4
0xc0000000001255b0 <trace_selftest_startup_ksym+48>:	mr      r27,r3
0xc0000000001255b4 <trace_selftest_startup_ksym+52>:	bl      0xc000000000125510 <tracer_init>
0xc0000000001255b8 <trace_selftest_startup_ksym+56>:	li      r4,3
0xc0000000001255bc <trace_selftest_startup_ksym+60>:	mr.     r29,r3
0xc0000000001255c0 <trace_selftest_startup_ksym+64>:	mr      r5,r29
0xc0000000001255c4 <trace_selftest_startup_ksym+68>:	beq     0xc0000000001255e0 <trace_selftest_startup_ksym+96>
0xc0000000001255c8 <trace_selftest_startup_ksym+72>:	ld      r3,-31520(r30)
0xc0000000001255cc <trace_selftest_startup_ksym+76>:	ld      r4,0(r27)
0xc0000000001255d0 <trace_selftest_startup_ksym+80>:	bl      0xc00000000009c560 <printk>
0xc0000000001255d4 <trace_selftest_startup_ksym+84>:	nop
0xc0000000001255d8 <trace_selftest_startup_ksym+88>:	b       0xc000000000125690 <trace_selftest_startup_ksym+272>
0xc0000000001255dc <trace_selftest_startup_ksym+92>:	nop
0xc0000000001255e0 <trace_selftest_startup_ksym+96>:	ld      r28,-31512(r30)
0xc0000000001255e4 <trace_selftest_startup_ksym+100>:	ld      r3,-31504(r30)
0xc0000000001255e8 <trace_selftest_startup_ksym+104>:	stw     r29,0(r28)
0xc0000000001255ec <trace_selftest_startup_ksym+108>:	mr      r5,r28
0xc0000000001255f0 <trace_selftest_startup_ksym+112>:	bl      0xc000000000140760 <process_new_ksym_entry>
0xc0000000001255f4 <trace_selftest_startup_ksym+116>:	nop
0xc0000000001255f8 <trace_selftest_startup_ksym+120>:	cmpwi   cr7,r3,0
0xc0000000001255fc <trace_selftest_startup_ksym+124>:	mr      r29,r3
0xc000000000125600 <trace_selftest_startup_ksym+128>:	blt     cr7,0xc00000000012567c <trace_selftest_startup_ksym+252>
0xc000000000125604 <trace_selftest_startup_ksym+132>:	lwz     r0,0(r28)
0xc000000000125608 <trace_selftest_startup_ksym+136>:	cmpwi   cr7,r0,0
0xc00000000012560c <trace_selftest_startup_ksym+140>:	bne     cr7,0xc000000000125618 <trace_selftest_startup_ksym+152>
0xc000000000125610 <trace_selftest_startup_ksym+144>:	li      r0,1
