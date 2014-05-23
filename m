Return-Path: <john.d@servergy.com>
Received: from mail-ob0-f171.google.com (mail-ob0-f171.google.com
 [209.85.214.171])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A7F671A007D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 May 2014 05:22:45 +1000 (EST)
Received: by mail-ob0-f171.google.com with SMTP id wn1so5882502obc.16
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 12:22:42 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 23 May 2014 14:22:42 -0500
Message-ID: <CAGtOQbS=GbQ5uC7_gtLB8pE5q6UpP1ORNXM9D9xk8pKLANCjqg@mail.gmail.com>
Subject: panic: ttwu_activate() e500mc: 3.13.9.
From: John Donnelly <john.d@servergy.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The failing code snippet :

void ttwu_activate(struct rq *rq, struct task_struct *p, int en_flags)
{
c0088b90:       7c 08 02 a6     mflr    r0
c0088b94:       90 01 00 04     stw     r0,4(r1)
c0088b98:       4b f8 87 29     bl      c00112c0 <_mcount>
c0088b9c:       94 21 ff f0     stwu    r1,-16(r1)
c0088ba0:       7c 08 02 a6     mflr    r0
c0088ba4:       90 01 00 14     stw     r0,20(r1)
c0088ba8:       bf c1 00 08     stmw    r30,8(r1)
c0088bac:       7c 9f 23 78     mr      r31,r4
c0088bb0:       7c 7e 1b 78     mr      r30,r3
        activate_task(rq, p, en_flags);
c0088bb4:       4b ff f5 2d     bl      c00880e0 <activate_task>
        p->on_rq = 1;

        /* if a worker is waking up, notify workqueue */
        if (p->flags & PF_WQ_WORKER)
c0088bb8:       81 3f 00 0c     lwz     r9,12(r31)

r31- looks valid ( 0xc0b0b340)


Entering kdb (current=0xe62b8000, pid 74) on processor 1 Oops: (null)
due to oops @ 0x0
dCPU: 1 PID: 74 Comm: kworker/1:1 Tainted: G        W    3.13.9+ #3
dWorkqueue: events linkwatch_event
dtask: e62b8000 ti: e6338000 task.ti: e6338000
NIP: 00000000 LR: c0088bb8 CTR: 00000000
REGS: e6339c70 TRAP: 0400   Tainted: G        W     (3.13.9+)
MSR: 00021002 <CE,ME>  CR: 22002028  XER: 00000000

GPR00: c0088bb8 e6339d20 e62b8000 d1826900 c0b0b340 00000005 127fa664 00000004
GPR08: 00000000 00000000 00000004 9fe99900 00000000 00000000 c0078250 e6311920
GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 d1826680
GPR24: c0b60000 00000001 00000000 d1829800 10d20000 00000000 d1826900 c0b0b340
NIP [00000000]   (null)
LR [c0088bb8] ttwu_activate+0x28/0x70
Call Trace:
[e6339d20] [c0088bb8] ttwu_activate+0x28/0x70 (unreliable)
[e6339d30] [c0088e70] ttwu_do_activate+0x50/0x70
[e6339d50] [c0088ff4] sched_ttwu_pending+0x84/0xb0
[e6339d70] [c0089f10] scheduler_ipi+0x60/0x190
[e6339d90] [c00126d0] smp_ipi_demux+0xa0/0xf0
[e6339db0] [c0010250] doorbell_exception+0x70/0xa0
[e6339dd0] [c0010bb0] ret_from_except_full+0x0/0x4c
--- Exception: 2070 at linkwatch_event+0x0/0x50

Regards,
 John.

--

o Energy-efficiency is #1 reason data centers look to expand.  --
Digital Realty Trust
o Green Data Centers spending to increase 300% worldwide by 2016.  --
Pike Research
o Data Centers have become as vital to the functioning of society as
power stations.  -- The Economist
