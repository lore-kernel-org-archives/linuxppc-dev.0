From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E42992644595405B23685@penguin.adic.com>
To: ebs@ebshome.net
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Kernel Preemption patch
Date: Mon, 24 Feb 2003 07:56:25 -0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Eugene,

Sorry, I'm using microsoft outlook and I can't seem to figure out how to
embedded comments in a satisfactory manner, so I have to write my replies at
the top of email threads all the time...

Below is an excerp from your post below. You include it to show the
redefinition of the line "#if !defined(CONFIG_4xx) || defined(CONFIG_440)".

However, I noticed that your 'preempt_enable' at the bottom of the exerp has
been changed from 'preempt_enable' as in the RML patch, to
'preempt_enable_no_reshed'. What's the reason for this inconsistency?

<----------------- cut ------------------->
#if !defined(CONFIG_4xx) || defined(CONFIG_440)
         case 0x900:
#else
         case 0x1000:
#endif
                 ret = timer_interrupt(regs);
                 break;
         default:
                 BUG();
         }

         preempt_enable_no_resched();
         return ret;
}
#endif /* CONFIG_PREEMPT */
<------------------ cut -------------------->

-- Brian

-----Original Message-----
From: Eugene Surovegin [mailto:ebs@ebshome.net]
Sent: Sunday, February 23, 2003 5:54 PM
To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel Preemption patch

At 02:28 PM 2/23/2003, brian.auld@adic.com wrote:
>Hello,
>
>Has anyone successfully applied and run the linux kernel preemption patch
on
>a 2.4.20 kernel. I have the following:
>
>- Latest Denx kernel (2_4_devel) running on 440GP ebony
>- 'preempt-kernel-rml-2.4.20-1.patch' applied to my kernel source
>   (I manually corrected a couple of fails and double checked a few
>    'successfully applied with fuzz' instances when applying the patch).
>- Kernel compiled with 'Kernel preemption =y' in make oldconfig
>
>When I try to boot this kernel, I get the following error:
>
><------- snipped
>Kernel command line: root=/dev/nfs rw
>nfsroot=172.16.77.152:/opt/eldk/ppc_4xx
>ip=172.16.77.155:172.16.77.152::255.255.255.0:EBONY-2::off
>kernel BUG at irq.c:575!
>Oops: Exception in kernel mode, sig: 4
>NIP: C0002B04 XER: 00000000 LR: C0002B04 SP: C0125F50 REGS: c0125ea0 TRAP:
>0700    Not tainted
>MSR: 00001030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
>TASK = c0124060[0] 'swapper' Last syscall: 0
>last math 00000000 last altivec 00000000
>PLB0: bear= 0x00008000 acr=   0x9b000000 besr=  0x00000000
>
>GPR00: C0002B04 C0125F50 C0124060 00000019 00001030 00000001 00000020
>C0170000
>GPR08: 000001D8 00000002 00000000 C0125E70 C012A8A8 71000000 07FE7300
>007FFC73
>GPR16: 00000000 00000001 007FFC00 FFFFFFFF 00001032 C0125F60 00000000
>C00017CC
>GPR24: C0002AA0 007FFB90 00000E00 007FFC73 007FFC00 00000000 00000000
>007FFB90
>Call backtrace:
>C0002B04 C00017CC C0133504 C0000224
>Kernel panic: Attempted to kill the idle task!
>In idle task - not syncing
>  <0>Rebooting in 180 seconds..

RML patches doesn't support 2_4_devel tree very well (and especially
PPC440).

If irq.c:575 correspond to preempt_intercept function in your tree, it
should look like:

#ifdef CONFIG_PREEMPT
int
preempt_intercept(struct pt_regs *regs)
{
         int ret;

         preempt_disable();

         switch(regs->trap) {
         case 0x500:
                 ret = do_IRQ(regs);
                 break;
#if !defined(CONFIG_4xx) || defined(CONFIG_440)
         case 0x900:
#else
         case 0x1000:
#endif
                 ret = timer_interrupt(regs);
                 break;
         default:
                 BUG();
         }

         preempt_enable_no_resched();
         return ret;
}
#endif /* CONFIG_PREEMPT */


Please, note additional "defined(CONFIG_440)"

Eugene


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
