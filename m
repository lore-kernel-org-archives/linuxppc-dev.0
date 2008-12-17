Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C0823DDF60
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 03:13:52 +1100 (EST)
Message-Id: <65726BB2-D9DC-4312-BB18-CB320BC56324@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Dave Liu <daveliu@freescale.com>
In-Reply-To: <1229509455-23597-1-git-send-email-daveliu@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc/fsl-booke: Fix the miss interrupt restore
Date: Wed, 17 Dec 2008 10:11:45 -0600
References: <1229509455-23597-1-git-send-email-daveliu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, b11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 17, 2008, at 4:24 AM, Dave Liu wrote:

> The commit e5e774d8833de1a0037be2384efccadf16935675
> powerpc/fsl-booke: Fix problem with _tlbil_va being interrupted
> introduce one issue. that casue the problem like this:
>
> Kernel BUG at c00b19fc [verbose debug info unavailable]
> Oops: Exception in kernel mode, sig: 5 [#1]
> MPC8572 DS
> Modules linked in:
> NIP: c00b19fc LR: c00b1c34 CTR: c0064e88
> REGS: ef02b7b0 TRAP: 0700   Not tainted  (2.6.28-rc8-00057-g1bda712)
> MSR: 00021000 <ME>  CR: 44048028  XER: 20000000
> TASK = ef02c000[1] 'init' THREAD: ef02a000
> GPR00: 00000001 ef02b860 ef02c000 eec201a0 c0dec2c0 00000000  
> 000078a1 00000400
> GPR08: c00b4e40 000078a1 c048ec00 a1780000 44048028 ecd26917  
> 00000001 ef02b948
> GPR16: ffffffea 0000020c 00000000 00000000 00000003 0000000a  
> 00000000 000078a1
> GPR24: eec201a0 00000000 ed849000 00000400 ef02b95c 00000001  
> ef02b978 ef02b984
> NIP [c00b19fc] __find_get_block+0x24/0x238
> LR [c00b1c34] __getblk+0x24/0x2a0
> Call Trace:
> [ef02b860] [c017b768] generic_make_request+0x290/0x328 (unreliable)
> [ef02b8b0] [c00b1c34] __getblk+0x24/0x2a0
> [ef02b910] [c00b4ae4] __bread+0x14/0xf8
> [ef02b920] [c00fc228] ext2_get_branch+0xf0/0x138
> [ef02b940] [c00fcc88] ext2_get_block+0xb8/0x828
> [ef02ba00] [c00bbdc8] do_mpage_readpage+0x188/0x808
> [ef02bac0] [c00bc5b4] mpage_readpages+0xec/0x144
> [ef02bb50] [c00fba38] ext2_readpages+0x24/0x34
> [ef02bb60] [c006ade0] __do_page_cache_readahead+0x150/0x230
> [ef02bbb0] [c0064bdc] filemap_fault+0x31c/0x3e0
> [ef02bbf0] [c00728b8] __do_fault+0x60/0x5b0
> [ef02bc50] [c0011e0c] do_page_fault+0x2d8/0x4c4
> [ef02bd10] [c000ed90] handle_page_fault+0xc/0x80
> [ef02bdd0] [c00c7adc] set_brk+0x74/0x9c
> [ef02bdf0] [c00c9274] load_elf_binary+0x70c/0x1180
> [ef02be70] [c00945f0] search_binary_handler+0xa8/0x274
> [ef02bea0] [c0095818] do_execve+0x19c/0x1d4
> [ef02bed0] [c000766c] sys_execve+0x58/0x84
> [ef02bef0] [c000e950] ret_from_syscall+0x0/0x3c
> [ef02bfb0] [c009c6fc] sys_dup+0x24/0x6c
> [ef02bfc0] [c0001e04] init_post+0xb0/0xf0
> [ef02bfd0] [c046c1ac] kernel_init+0xcc/0xf4
> [ef02bff0] [c000e6d0] kernel_thread+0x4c/0x68
> Instruction dump:
> 4bffffa4 813f000c 4bffffac 9421ffb0 7c0802a6 7d800026 90010054  
> bf210034
> 91810030 7c0000a6 68008000 54008ffe <0f000000> 3d20c04e 3b29ffb8  
> 38000008
>
> Signed-off-by: Dave Liu <daveliu@freescale.com>
> ---
> arch/powerpc/kernel/misc_32.S |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)

Good catch.

applied

- k
