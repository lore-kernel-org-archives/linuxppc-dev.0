Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3F694DDE0F
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 22:34:43 +1000 (EST)
Subject: Re: 22.1-rt8 : BUG: scheduling while atomic:
	stress/0x00000002/739, CPU#0
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pradyumna Sampath <pradyumna.sampath@gmail.com>
In-Reply-To: <f87351060708030450u7fbd38e1o8ee491e523b30e3f@mail.gmail.com>
References: <f87351060708030450u7fbd38e1o8ee491e523b30e3f@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 03 Aug 2007 22:34:25 +1000
Message-Id: <1186144465.5981.3.camel@gruick>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-08-03 at 17:20 +0530, Pradyumna Sampath wrote:
> Hi,
> I am running linux-2.6.22.1-rt8 on mpc5200 and on running stress
> 
> #./stress --cpu 8 --io 4 --vm 2 --vm-bytes 2M --timeout 300s
> 
> I get the following stack.But this does not happen with non -rt kernel.
> 
>    LR = 0xff51fcc
> BUG: scheduling while atomic: stress/0x00000002/739, CPU#0
> Call Trace:
> [c04fbb80] [c0008650] show_stack+0x50/0x190 (unreliable)
> [c04fbbb0] [c0016fc0] __schedule_bug+0x38/0x48
> [c04fbbc0] [c01d4f7c] __schedule+0x3dc/0x450
> [c04fbbf0] [c01d56c8] schedule+0x54/0xf0
> [c04fbc00] [c01d6390] rt_spin_lock_slowlock+0x100/0x224
> [c04fbc60] [c0052198] get_zone_pcp+0x30/0x58
> [c04fbc80] [c0053078] free_hot_cold_page+0x114/0x1fc
> [c04fbcb0] [c0056424] put_page+0x50/0x15c
> [c04fbcd0] [c0069854] free_page_and_swap_cache+0x44/0x80
> [c04fbce0] [c005d760] unmap_vmas+0x2e0/0x788
> [c04fbd70] [c006292c] exit_mmap+0x74/0x108
> [c04fbda0] [c001adc0] mmput+0x54/0xf0
> [c04fbdc0] [c001ecfc] exit_mm+0xc0/0x124
> [c04fbde0] [c001ffd0] do_exit+0x164/0x8bc
> [c04fbe20] [c0020760] do_group_exit+0x38/0x90
> [c04fbe40] [c002ba48] get_signal_to_deliver+0x2ac/0x3c0
> [c04fbe70] [c000739c] do_signal+0x50/0x60c
> [c04fbf40] [c000fec0] do_user_signal+0x74/0xc4
> --- Exception: c00 at 0xfeab1dc
>    LR = 0xff51fcc
> 
> I have also tested the same case on x86 and that does not throw up
> anything. Another observation is the fact is that this happens when
> --vm is > 1. So I am guessing its a very PowerPC specific problem.
> Maybe some part of the vm code for powerpc. This happens for all
> powerpc -rt kernels I have used.

Weird. unmap_vmas calls to free_page_and_swap_cache() should be
happening within a get/put_cpu section, thus with preempt disabled, thus
I fail to see how rt_spin_lock would be allowed to preempt. 
