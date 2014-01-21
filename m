Return-Path: <groeck7@gmail.com>
Received: from mail-pb0-x231.google.com (mail-pb0-x231.google.com
 [IPv6:2607:f8b0:400e:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BA7F32C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 03:14:54 +1100 (EST)
Received: by mail-pb0-f49.google.com with SMTP id up15so8010509pbc.22
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 08:14:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 21 Jan 2014 08:14:50 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH] powerpc: set the correct ksp_limit on ppc32 when
 switching to irq stack
Message-ID: <20140121161450.GA3311@roeck-us.net>
References: <1389932728-25178-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389932728-25178-1-git-send-email-haokexin@gmail.com>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 17, 2014 at 12:25:28PM +0800, Kevin Hao wrote:
> Guenter Roeck has got the following call trace on a p2020 board:
>   Kernel stack overflow in process eb3e5a00, r1=eb79df90
>   CPU: 0 PID: 2838 Comm: ssh Not tainted 3.13.0-rc8-juniper-00146-g19eca00 #4
>   task: eb3e5a00 ti: c0616000 task.ti: ef440000
>   NIP: c003a420 LR: c003a410 CTR: c0017518
>   REGS: eb79dee0 TRAP: 0901   Not tainted (3.13.0-rc8-juniper-00146-g19eca00)
>   MSR: 00029000 <CE,EE,ME>  CR: 24008444  XER: 00000000
>   GPR00: c003a410 eb79df90 eb3e5a00 00000000 eb05d900 00000001 65d87646 00000000
>   GPR08: 00000000 020b8000 00000000 00000000 44008442
>   NIP [c003a420] __do_softirq+0x94/0x1ec
>   LR [c003a410] __do_softirq+0x84/0x1ec
>   Call Trace:
>   [eb79df90] [c003a410] __do_softirq+0x84/0x1ec (unreliable)
>   [eb79dfe0] [c003a970] irq_exit+0xbc/0xc8
>   [eb79dff0] [c000cc1c] call_do_irq+0x24/0x3c
>   [ef441f20] [c00046a8] do_IRQ+0x8c/0xf8
>   [ef441f40] [c000e7f4] ret_from_except+0x0/0x18
>   --- Exception: 501 at 0xfcda524
>       LR = 0x10024900
>   Instruction dump:
>   7c781b78 3b40000a 3a73b040 543c0024 3a800000 3b3913a0 7ef5bb78 48201bf9
>   5463103a 7d3b182e 7e89b92e 7c008146 <3ba00000> 7e7e9b78 48000014 57fff87f
>   Kernel panic - not syncing: kernel stack overflow
>   CPU: 0 PID: 2838 Comm: ssh Not tainted 3.13.0-rc8-juniper-00146-g19eca00 #4
>   Call Trace:
> 
> The reason is that we have used the wrong register to calculate the
> ksp_limit in commit cbc9565ee826 (powerpc: Remove ksp_limit on ppc64).
> Just fix it.
> 
> As suggested by Benjamin Herrenschmidt, also add the C prototype of the
> function in the comment in order to avoid such kind of errors in the
> future.
> 
Was this patch accepted, or are there any problems with it ?
I didn't see any comments, and it still isn't upstream nor in linux-next.

Thanks,
Guenter
