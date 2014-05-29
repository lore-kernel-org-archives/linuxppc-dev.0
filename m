Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0208.outbound.protection.outlook.com [207.46.163.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 22A3E1A024E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 May 2014 08:22:32 +1000 (EST)
Message-ID: <1401402135.6603.191.camel@snotra.buserror.net>
Subject: Re: panic: ttwu_activate() e500mc: 3.13.9.
From: Scott Wood <scottwood@freescale.com>
To: John Donnelly <john.d@servergy.com>
Date: Thu, 29 May 2014 17:22:15 -0500
In-Reply-To: <CAGtOQbS=GbQ5uC7_gtLB8pE5q6UpP1ORNXM9D9xk8pKLANCjqg@mail.gmail.com>
References: <CAGtOQbS=GbQ5uC7_gtLB8pE5q6UpP1ORNXM9D9xk8pKLANCjqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-05-23 at 14:22 -0500, John Donnelly wrote:
> The failing code snippet :
> 
> void ttwu_activate(struct rq *rq, struct task_struct *p, int en_flags)
> {
> c0088b90:       7c 08 02 a6     mflr    r0
> c0088b94:       90 01 00 04     stw     r0,4(r1)
> c0088b98:       4b f8 87 29     bl      c00112c0 <_mcount>
> c0088b9c:       94 21 ff f0     stwu    r1,-16(r1)
> c0088ba0:       7c 08 02 a6     mflr    r0
> c0088ba4:       90 01 00 14     stw     r0,20(r1)
> c0088ba8:       bf c1 00 08     stmw    r30,8(r1)
> c0088bac:       7c 9f 23 78     mr      r31,r4
> c0088bb0:       7c 7e 1b 78     mr      r30,r3
>         activate_task(rq, p, en_flags);
> c0088bb4:       4b ff f5 2d     bl      c00880e0 <activate_task>
>         p->on_rq = 1;
> 
>         /* if a worker is waking up, notify workqueue */
>         if (p->flags & PF_WQ_WORKER)
> c0088bb8:       81 3f 00 0c     lwz     r9,12(r31)
> 
> r31- looks valid ( 0xc0b0b340)

r31 isn't relevant -- it didn't fault on that lwz, but rather on a
branch to NULL, via CTR.  The branch to NULL could have been either
inside activate_task or after returning from activate_task.  Since LR
doesn't point to the instruction after a bctrl, that means it was a
non-linking bctr.  I believe it's the one at the end of enqueue_task()
that is responsible.

https://lkml.org/lkml/2011/9/19/331 suggests that a NULL enqueue_task
may be the result of the idle thread attempting to block.  Did you have
CONFIG_DEBUG_ATOMIC_SLEEP enabled?

> Entering kdb (current=0xe62b8000, pid 74) on processor 1 Oops: (null)
> due to oops @ 0x0
> dCPU: 1 PID: 74 Comm: kworker/1:1 Tainted: G        W    3.13.9+ #3

The taint shows that there's previously been a WARN() -- what was it?

Could you describe more about the circumstances of this?  Is it
reproducable?  Any special config?  What exact SHA?  Any local changes?

-Scott
