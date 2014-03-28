Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0239.outbound.protection.outlook.com [207.46.163.239])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 03993140085
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Mar 2014 20:00:21 +1100 (EST)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Subject: RE: [PATCH] powerpc/irq: Remove HAVE_IRQ_EXIT_ON_IRQ_STACK feature
 at powerpc platform
Date: Fri, 28 Mar 2014 09:00:13 +0000
Message-ID: <98283b6c8da549479d924d99d2b6d300@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1395992312-23035-1-git-send-email-dongsheng.wang@freescale.com>
 <20140328081827.GB2176@pek-khao-d1.corp.ad.wrs.com>
In-Reply-To: <20140328081827.GB2176@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Ingo Molnar <mingo@kernel.org>, James Hogan <james.hogan@imgtec.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "fweisbec@gmail.com" <fweisbec@gmail.com>, Helge Deller <deller@gmx.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Heiko
 Carstens <heiko.carstens@de.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@au1.ibm.com>, "James
 E.J. Bottomley" <jejb@parisc-linux.org>, Martin
 Schwidefsky <schwidefsky@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Scott Wood <scottwood@freescale.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, "David
 S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks Kevin. Your patch works normal. :)

I still have some confused. I think when __do_softirq always get a interrup=
t, the hard stack will be run out, isn't it?

Regards,
-Dongsheng

> -----Original Message-----
> From: Kevin Hao [mailto:haokexin@gmail.com]
> Sent: Friday, March 28, 2014 4:18 PM
> To: Wang Dongsheng-B40534
> Cc: fweisbec@gmail.com; James Hogan; Andrew Morton; David S. Miller; Pete=
r
> Zijlstra; Helge Deller; H. Peter Anvin; Heiko Carstens; linux-
> kernel@vger.kernel.org; Paul Mackerras; James E.J. Bottomley; Linus Torva=
lds;
> Jin Zhengxiong-R64188; Wood Scott-B07421; Thomas Gleixner; linuxppc-
> dev@lists.ozlabs.org; Ingo Molnar; Martin Schwidefsky
> Subject: Re: [PATCH] powerpc/irq: Remove HAVE_IRQ_EXIT_ON_IRQ_STACK featu=
re at
> powerpc platform
>=20
> On Fri, Mar 28, 2014 at 03:38:32PM +0800, Dongsheng Wang wrote:
> > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> >
> > If softirq use hardirq stack, we will get kernel painc when a hard irq
> > coming again during __do_softirq enable local irq to deal with softirq
> > action. So we need to switch satck into softirq stack when invoke soft =
irq.
> >
> >  Task--->
> > 	| Task stack
> > 	|
> > 	Interrput->EXCEPTION->do_IRQ->
> > 	^			     | Hard irq stack
> > 	|			     |
> > 	|			     irq_exit->__do_softirq->local_irq_enable--   --
> >local_irq_disable
> > 	|									| Hard irq
> stack
> > 	|									|
> > 	|									Interrupt
> coming again
> > 	|		There will get a Interrupt nesting			|
> >
> > ----------------------------------------------------------------------
> > --
> >
> > Trace 1: Trap 900
> >
> > Kernel stack overflow in process e8152f40, r1=3De8e05ec0
> > CPU: 0 PID: 2399 Comm: image_compress/ Not tainted
> > 3.13.0-rc3-03475-g2e3f85b #432
> > task: e8152f40 ti: c080a000 task.ti: ef176000
> > NIP: c05bec04 LR: c0305590 CTR: 00000010
> > REGS: e8e05e10 TRAP: 0901   Not tainted  (3.13.0-rc3-03475-g2e3f85b)
>=20
> Could you double check if you got the following patch applied?
>=20
> commit 1a18a66446f3f289b05b634f18012424d82aa63a
> Author: Kevin Hao <haokexin@gmail.com>
> Date:   Fri Jan 17 12:25:28 2014 +0800
>=20
>     powerpc: Set the correct ksp_limit on ppc32 when switching to irq sta=
ck
>=20
>     Guenter Roeck has got the following call trace on a p2020 board:
>       Kernel stack overflow in process eb3e5a00, r1=3Deb79df90
>       CPU: 0 PID: 2838 Comm: ssh Not tainted 3.13.0-rc8-juniper-00146-g19=
eca00
> #4
>       task: eb3e5a00 ti: c0616000 task.ti: ef440000
>       NIP: c003a420 LR: c003a410 CTR: c0017518
>       REGS: eb79dee0 TRAP: 0901   Not tainted (3.13.0-rc8-juniper-00146-g=
19eca00)
>       MSR: 00029000 <CE,EE,ME>  CR: 24008444  XER: 00000000
>       GPR00: c003a410 eb79df90 eb3e5a00 00000000 eb05d900 00000001 65d876=
46
> 00000000
>       GPR08: 00000000 020b8000 00000000 00000000 44008442
>       NIP [c003a420] __do_softirq+0x94/0x1ec
>       LR [c003a410] __do_softirq+0x84/0x1ec
>       Call Trace:
>       [eb79df90] [c003a410] __do_softirq+0x84/0x1ec (unreliable)
>       [eb79dfe0] [c003a970] irq_exit+0xbc/0xc8
>       [eb79dff0] [c000cc1c] call_do_irq+0x24/0x3c
>       [ef441f20] [c00046a8] do_IRQ+0x8c/0xf8
>       [ef441f40] [c000e7f4] ret_from_except+0x0/0x18
>       --- Exception: 501 at 0xfcda524
>           LR =3D 0x10024900
>       Instruction dump:
>       7c781b78 3b40000a 3a73b040 543c0024 3a800000 3b3913a0 7ef5bb78 4820=
1bf9
>       5463103a 7d3b182e 7e89b92e 7c008146 <3ba00000> 7e7e9b78 48000014 57=
fff87f
>       Kernel panic - not syncing: kernel stack overflow
>       CPU: 0 PID: 2838 Comm: ssh Not tainted 3.13.0-rc8-juniper-00146-g19=
eca00
> #4
>       Call Trace:
>=20
>     The reason is that we have used the wrong register to calculate the
>     ksp_limit in commit cbc9565ee826 (powerpc: Remove ksp_limit on ppc64)=
.
>     Just fix it.
>=20
>     As suggested by Benjamin Herrenschmidt, also add the C prototype of t=
he
>     function in the comment in order to avoid such kind of errors in the
>     future.
>=20
>     Cc: stable@vger.kernel.org # 3.12
>     Reported-by: Guenter Roeck <linux@roeck-us.net>
>     Tested-by: Guenter Roeck <linux@roeck-us.net>
>     Signed-off-by: Kevin Hao <haokexin@gmail.com>
>     Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> Thanks,
> Kevin
