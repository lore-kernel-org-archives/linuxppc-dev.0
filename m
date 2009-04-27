Return-Path: <martyn.welch@gefanuc.com>
Received: from exprod5og114.obsmtp.com (exprod5og114.obsmtp.com [64.18.0.28])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 58217DDE1F
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 01:13:59 +1000 (EST)
Message-ID: <49F5CA09.7090607@gefanuc.com>
Date: Mon, 27 Apr 2009 16:06:49 +0100
From: Martyn Welch <martyn.welch@gefanuc.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/86xx: clean up smp init code
References: <1240421691-10193-1-git-send-email-galak@kernel.crashing.org>
	<49F064EB.5030109@gefanuc.com>
	<8AE021A6-CA3A-462E-B3AF-61A7F7D0CBA8@kernel.crashing.org>
In-Reply-To: <8AE021A6-CA3A-462E-B3AF-61A7F7D0CBA8@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>
> On Apr 23, 2009, at 7:54 AM, Martyn Welch wrote:
>
>> Kumar Gala wrote:
>>> Removed the need for asm/mpc86xx.h as it was only used in mpc86xx_smp.c
>>> and just moved the defines it cared about into there.  Also fixed up
>>> the ioremap to only map the one 4k page we need access to and to 
>>> iounmap
>>> when we are done.
>>>
>>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>>> ---
>>> arch/powerpc/include/asm/mpc86xx.h         |   33 
>>> ----------------------------
>>> arch/powerpc/platforms/86xx/gef_ppc9a.c    |    1 -
>>> arch/powerpc/platforms/86xx/gef_sbc310.c   |    1 -
>>> arch/powerpc/platforms/86xx/gef_sbc610.c   |    1 -
>>> arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    1 -
>>> arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    1 -
>>> arch/powerpc/platforms/86xx/mpc86xx_smp.c  |    8 ++++++-
>>> arch/powerpc/platforms/86xx/sbc8641d.c     |    1 -
>>> 8 files changed, 7 insertions(+), 40 deletions(-)
>>> delete mode 100644 arch/powerpc/include/asm/mpc86xx.h
>>>
>>>
>> I assume this patch relies on one of the other patches posted?
>>
>> Just applying this patch to my development tree (based on your main 
>> branch) resulted in the following on a PPC9A:
>>
>> mpic: requesting IPIs ...
>> __ioremap(): phys addr 0x0 is RAM lr c041e5c8
>> Unable to handle kernel paging request for data at address 0x00000010
>> Faulting instruction address: 0xc041e5cc
>> Oops: Kernel access of bad area, sig: 11 [#1]
>> PREEMPT SMP NR_CPUS=2 GE Fanuc PPC9A
>> Modules linked in:
>> NIP: c041e5cc LR: c041e5c8 CTR: c0013d90
>> REGS: ef841ea0 TRAP: 0300   Not tainted  (2.6.30-rc3-00016-gabae74f)
>> MSR: 00001032 <ME,IR,DR>  CR: 24000022  XER: 00000000
>> DAR: 00000010, DSISR: 40000000
>> TASK = ef83f980[1] 'swapper' THREAD: ef840000 CPU: 0
>> GPR00: c041e5c8 ef841f50 ef83f980 00000000 00001032 ffffffff c0480000 
>> 00004000
>> GPR08: c0441a4c 00000000 ef840000 c0440000 22000042 ffffdfff 0ff50d00 
>> 00000001
>> GPR16: ffffffff 00000000 c0440000 c0480000 c0480000 c0468000 c0440000 
>> c0442838
>> GPR24: 00000002 c0480000 c0480000 7d5043a6 00009032 00000004 00000001 
>> 0000c350
>> NIP [c041e5cc] smp_86xx_kick_cpu+0x70/0x11c
>> LR [c041e5c8] smp_86xx_kick_cpu+0x6c/0x11c
>> Call Trace:
>> [ef841f50] [c041e5c8] smp_86xx_kick_cpu+0x6c/0x11c (unreliable)
>>
>> [ef841f70] [c0435010] __cpu_up+0xa4/0x1b0
>> [ef841f90] [c04355ec] cpu_up+0x104/0x1cc
>> [ef841fd0] [c0412368] kernel_init+0x1d8/0x1f0
>> [ef841ff0] [c0012cb8] kernel_thread+0x4c/0x68
>> Instruction dump:
>> 3c80c000 61290100 38a00001 7d234b78 38843464 83690000 4bbfa7f9 4bbfcb21
>> 38801000 38631000 4bbf91ad 7c0004ac <81230010> 0c090000 4c00012c 
>> 38000001
>> ---[ end trace 31fd0ba7d8756001 ]---
>> Kernel panic - not syncing: Attempted to kill init!
>> Rebooting in 180 seconds..
>
> I'm not able to reproduce this failure.  It seems like either ioremap 
> is returning 0 or you are getting 0 from get_immrbase().. either way I 
> don't see how my change would cause what you are seeing on your board.
I've just built the kernel with no local patches in case they were 
causing the problem and adding this patch causes the above problem.
> Are you running w/CONFIG_PHYS_64BIT=y?
I am using the config in the kernel 
("arch/powerpc/configs/68xx/gef_ppc9a_defconfig") as is, ditto for the DTS.

CONFIG_PHYS_64BIT is not set.

However, looking into it a bit further 'device_type = "soc";' is missing 
from the DTS file, so I assume get_immrbase() is returning "-1".

That might explain some other weird errors I recently noticed that I 
haven't managed to find the time to track down yet...

Martyn
