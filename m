Message-ID: <407D2786.3080801@imc-berlin.de>
Date: Wed, 14 Apr 2004 13:59:02 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kfree_skb on hard IRQ ???
References: <407C065A.9010004@imc-berlin.de> <407C1601.2080100@imc-berlin.de>
In-Reply-To: <407C1601.2080100@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Scholz wrote:

> And what means
>
> alloc_skb called nonatomically from interrupt c00eb8d0
> kernel BUG at skbuff.c:174!
> Oops: Kernel Mode Software FPU Emulation, sig: 8
> NIP: C00E065C XER: 00000000 LR: C00E065C SP: C016BC80 REGS: c016bbd0 TRAP:
> 1000    Not tainted
> MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = c0169fa0[0] 'swapper' Last syscall: 120
> last math 00000000 last altivec 00000000
> ...
> Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
>  <0>Rebooting in 10 seconds..

BTW the backtrace shows
0xc00dd374 -- 0xc00dd2f4 + 0x0080   alloc_skb
0xc00e85e8 -- 0xc00e85c0 + 0x0028   rtmsg_ifinfo
0xc00e8bb4 -- 0xc00e8b50 + 0x0064   rtnetlink_event
0xc001c200 -- 0xc001c1c0 + 0x0040   notifier_call_chain
0xc00e1668 -- 0xc00e15b0 + 0x00b8   dev_close
0xc00e3b84 -- 0xc00e3b60 + 0x0024   unregister_netdevice
0xc00b396c -- 0xc00b394c + 0x0020   unregister_netdev
0xc39c320c -- 0xc01afe08 + 0x3813404   _end
0xc39c5bbc -- 0xc01afe08 + 0x3815db4   _end
0xc39a8b60 -- 0xc01afe08 + 0x37f8d58   _end
0xc39a8c80 -- 0xc01afe08 + 0x37f8e78   _end
0xc39b4dac -- 0xc01afe08 + 0x3804fa4   _end
0xc0003844 -- 0xc00036b4 + 0x0190   ppc_irq_dispatch_handler
0xc0003924 -- 0xc00038e8 + 0x003c   do_IRQ

The irq comes from unplugging the WLAN pcmcia card without calling "cardctl
eject" before (which btw worked for every other wlan card so far).

Ideas?

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
