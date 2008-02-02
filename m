Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id A8063DDE9C
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 23:05:16 +1100 (EST)
Message-ID: <47A45C72.9030004@anagramm.de>
Date: Sat, 02 Feb 2008 13:05:06 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Kernel oops while duming user core.
References: <DCEAAC0833DD314AB0B58112AD99B93B03EE44A5@ismail.innsys.innovsys.com>	<20080131161527.GT14201@localdomain>
	<20080201173834.GD671@ld0162-tx32.am.freescale.net>
In-Reply-To: <20080201173834.GD671@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood schrieb:
> On Thu, Jan 31, 2008 at 10:15:27AM -0600, Nathan Lynch wrote:
>> Rune Torgersen wrote:
>>> I get the following kernel core while a user program I have is dumping
>>> core.
>>> Any DIeas at what to look for? (this is runnign 2.6.24, arch/powerpc on
>>> a 8280)
>>> When runnign the program on 2.6.18 arch/ppc, the program gets a sig 11
>>> and dumps core.
>>> On 2.6.24, I ghet the kernel oops, and then the program hangs sround
>>> forever and is unkillable.
>> Hmm, this is the second report of 2.6.24 crashing in
>> __flush_dcache_icache during a core dump; see:
>> http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048662.html
>>
>> Is this easily recreatable?
> 
> Yes, this program does it reliably:
> 
> #include <pthread.h>
> #include <stdio.h>
> #include <unistd.h>
> #include <signal.h>
> 
> void *threadfn(void *arg)
> {
> 	fprintf(stderr, "threadfn\n");
> 	fflush(stderr);
> 	sleep(1);
> 	*(char *)0=0;
> 	return NULL;
> }
> 
> int main(void)
> {
> 	pthread_t thread[4];
> 	int i;
> 
> 	for (i = 0; i < 4; i++)
> 		pthread_create(&thread[0], NULL, threadfn, NULL);
> 
> 	for (;;);
> }

Ack!

This is a MPC8540ADS arch/powerpc compatible environment here:

Feb  2 12:59:17 fox_1 kernel: Unable to handle kernel paging request for data at address 0x4802f000
Feb  2 12:59:17 fox_1 kernel: Faulting instruction address: 0xc000d5b8
Feb  2 12:59:17 fox_1 kernel: Oops: Kernel access of bad area, sig: 11 [#1]
Feb  2 12:59:17 fox_1 kernel: MPC85xx ADS
Feb  2 12:59:17 fox_1 kernel: Modules linked in:
Feb  2 12:59:17 fox_1 kernel: NIP: c000d5b8 LR: c0010fb8 CTR: 00000080
Feb  2 12:59:17 fox_1 kernel: REGS: c24abb20 TRAP: 0300   Not tainted  (2.6.24)
Feb  2 12:59:17 fox_1 kernel: MSR: 00029000 <EE,ME>  CR: 22882222  XER: 00000000
Feb  2 12:59:17 fox_1 kernel: DEAR: 4802f000, ESR: 00000000
Feb  2 12:59:17 fox_1 kernel: TASK = cf894d20[942] 'oops' THREAD: c24aa000
Feb  2 12:59:17 fox_1 kernel: GPR00: c22c7680 c24abbd0 cf894d20 4802f000 00000080 000f8b60 4802f000 ffffffff
Feb  2 12:59:17 fox_1 kernel: GPR08: 00000000 c22c7680 000008d1 00000000 22882222 10018a64 00000006 c035a300
Feb  2 12:59:17 fox_1 kernel: GPR16: 00024000 c0380000 c24aa000 c24abc9c c24abc98 c2570480 c22c7680 c0380000
Feb  2 12:59:17 fox_1 kernel: GPR24: c0390420 cf09d000 c0497b60 c5b63948 4802f000 c24aa000 000000bc c0497b60
Feb  2 12:59:17 fox_1 kernel: NIP [c000d5b8] __flush_dcache_icache+0x14/0x40
Feb  2 12:59:17 fox_1 kernel: LR [c0010fb8] update_mmu_cache+0x94/0x98
Feb  2 12:59:17 fox_1 kernel: Call Trace:
Feb  2 12:59:17 fox_1 kernel: [c24abbd0] [c24aa000] 0xc24aa000 (unreliable)
Feb  2 12:59:17 fox_1 kernel: [c24abbe0] [c005d978] handle_mm_fault+0x374/0x6a4
Feb  2 12:59:17 fox_1 kernel: [c24abc30] [c005ddd0] get_user_pages+0x128/0x384
Feb  2 12:59:17 fox_1 kernel: [c24abc90] [c00a80d8] elf_core_dump+0xab8/0xb74
Feb  2 12:59:17 fox_1 kernel: [c24abd30] [c007718c] do_coredump+0x730/0x758
Feb  2 12:59:17 fox_1 kernel: [c24abe30] [c002eeb0] get_signal_to_deliver+0x244/0x3c4
Feb  2 12:59:17 fox_1 kernel: [c24abe80] [c000782c] do_signal+0x48/0x264
Feb  2 12:59:17 fox_1 kernel: [c24abf40] [c000e4ac] do_user_signal+0x74/0xc4
Feb  2 12:59:17 fox_1 kernel: Instruction dump:
Feb  2 12:59:17 fox_1 kernel: 4d820020 7c8903a6 7c001bac 38630020 4200fff8 7c0004ac 4e800020 60000000
Feb  2 12:59:17 fox_1 kernel: 54630026 38800080 7c8903a6 7c661b78 <7c00186c> 38630020 4200fff8 7c0004ac
Feb  2 12:59:17 fox_1 kernel: ---[ end trace a1d91e665173315a ]---
Feb  2 12:59:17 fox_1 kernel: note: oops[942] exited with preempt_count 1

It does not oops when the core dump is disabled.

Regards,

Clemens
