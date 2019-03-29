Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A63C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 16:22:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78630218A3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 16:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78630218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44W6Ss3GrXzDqBY
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 03:22:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=s2ql=sa=goodmis.org=rostedt@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=goodmis.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44W5LC1LTWzDqTX
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 02:31:14 +1100 (AEDT)
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D642B218A2;
 Fri, 29 Mar 2019 15:31:11 +0000 (UTC)
Date: Fri, 29 Mar 2019 11:31:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [Qemu-ppc] pseries on qemu-system-ppc64le crashes in
 doorbell_core_ipi()
Message-ID: <20190329113109.3a9bd24e@gandalf.local.home>
In-Reply-To: <1553850306.nyv11r9iej.astroid@bobo.none>
References: <20190327123615.rwhk6h3ayfurvapf@linutronix.de>
 <7d97f3c6-4614-ead7-179a-e7e223ea3997@kaod.org>
 <2bbc1490-400d-585e-d74b-924c570b4236@kaod.org>
 <1553836851.2264.2.camel@gmail.com>
 <1553850306.nyv11r9iej.astroid@bobo.none>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, qemu-ppc@nongnu.org,
 =?UTF-8?B?Q8OpZHJp?= =?UTF-8?B?Yw==?= Le Goater <clg@kaod.org>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Paul Mackerras <paulus@samba.org>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

[ Added Peter ]

On Fri, 29 Mar 2019 19:13:55 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> Suraj Jitindar Singh's on March 29, 2019 3:20 pm:
> > On Wed, 2019-03-27 at 17:51 +0100, C=C3=A9dric Le Goater wrote: =20
> >> On 3/27/19 5:37 PM, C=C3=A9dric Le Goater wrote: =20
> >> > On 3/27/19 1:36 PM, Sebastian Andrzej Siewior wrote: =20
> >> > > With qemu-system-ppc64le -machine pseries -smp 4 I get:
> >> > >  =20
> >> > > > #  chrt 1 hackbench
> >> > > > Running in process mode with 10 groups using 40 file
> >> > > > descriptors each (=3D=3D 400 tasks)
> >> > > > Each sender will pass 100 messages of 100 bytes
> >> > > > Oops: Exception in kernel mode, sig: 4 [#1]
> >> > > > LE PAGE_SIZE=3D64K MMU=3DHash PREEMPT SMP NR_CPUS=3D2048 NUMA pS=
eries
> >> > > > Modules linked in:
> >> > > > CPU: 0 PID: 629 Comm: hackbench Not tainted 5.1.0-rc2 #71
> >> > > > NIP:  c000000000046978 LR: c000000000046a38 CTR:
> >> > > > c0000000000b0150
> >> > > > REGS: c0000001fffeb8e0 TRAP: 0700   Not tainted  (5.1.0-rc2)
> >> > > > MSR:  8000000000089033 <SF,EE,ME,IR,DR,RI,LE>  CR:
> >> > > > 42000874  XER: 00000000
> >> > > > CFAR: c000000000046a34 IRQMASK: 1
> >> > > > GPR00: c0000000000b0170 c0000001fffebb70 c000000000a6ba00
> >> > > > 0000000028000000 =20
> >> > >=20
> >> > > =E2=80=A6 =20
> >> > > > NIP [c000000000046978] doorbell_core_ipi+0x28/0x30
> >> > > > LR [c000000000046a38] doorbell_try_core_ipi+0xb8/0xf0
> >> > > > Call Trace:
> >> > > > [c0000001fffebb70] [c0000001fffebba0] 0xc0000001fffebba0
> >> > > > (unreliable)
> >> > > > [c0000001fffebba0] [c0000000000b0170]
> >> > > > smp_pseries_cause_ipi+0x20/0x70
> >> > > > [c0000001fffebbd0] [c00000000004b02c]
> >> > > > arch_send_call_function_single_ipi+0x8c/0xa0
> >> > > > [c0000001fffebbf0] [c0000000001de600]
> >> > > > irq_work_queue_on+0xe0/0x130
> >> > > > [c0000001fffebc30] [c0000000001340c8]
> >> > > > rto_push_irq_work_func+0xc8/0x120 =20
> >> > >=20
> >> > > =E2=80=A6 =20
> >> > > > Instruction dump:
> >> > > > 60000000 60000000 3c4c00a2 384250b0 3d220009 392949c8 81290000
> >> > > > 3929ffff
> >> > > > 7d231838 7c0004ac 5463017e 64632800 <7c00191c> 4e800020
> >> > > > 3c4c00a2 38425080
> >> > > > ---[ end trace eb842b544538cbdf ]--- =20
>=20
> This is unusual and causing powerpc code to crash because the rt
> scheduler is telling irq_work_queue_on to queue work on this CPU.
> Is that something allowed? There's no warnings in there but it must
> be a rarely tested path, would it be better to ban it?
>=20
> Steven is this queue_work_on to self by design?

I just figured that a irq_work_queue_on() would default to just
irq_work_queue() if cpu =3D=3D smp_processor_id().

I'm sure this case has been tested (on x86), as I stressed this quite a
bit, and all it takes is to have an RT task queued on the CPU
processing the current "push" logic when it's not holding the rq locks
and read that the current CPU now has an overloaded RT task.

If calling irq_work_queue_on() is really bad to do to the same CPU,
then we can work on changing the logic to do something different if the
CPU returned from rto_next_cpu() is the current CPU.

Or would it be possible to just change irq_work_queue_on() to call
irq_work_queue() if cpu =3D=3D smp_processor_id()?

-- Steve


>=20
> >> > >=20
> >> > > and I was wondering whether this is a qemu bug or the kernel is
> >> > > using an
> >> > > opcode it should rather not. If I skip doorbell_try_core_ipi() in
> >> > > smp_pseries_cause_ipi() then there is no crash. The comment says
> >> > > "POWER9
> >> > > should not use this handler" so=E2=80=A6 =20
> >> >=20
> >> > I would say Linux is using a msgsndp instruction which is not
> >> > implemented
> >> > in QEMU TCG. But why have we started using dbells in Linux ?  =20
> >=20
> > Yeah the kernel must have used msgsndp which isn't implemented for TCG
> > yet. We use doorbells in linux but only for threads which are on the
> > same core.
> > And when I try to construct a situation with more than 1 thread per
> > core (e.g. -smp 4,threads=3D4), I get "TCG cannot support more than 1
> > thread/core on a pseries machine".
> >=20
> > So I wonder why the guest thinks it can use msgsndp... =20
>=20
> IPI to self evidently. Under TCG it really should implement the
> instruction or remove the DBELL feature.
>=20
> Thanks,
> Nick
>=20

