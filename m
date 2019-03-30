Return-Path: <SRS0=BcJT=SB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBFCC43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 03:12:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C84F4218D8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 03:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Npy3DY0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84F4218D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44WNvB3659zDqTk
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 14:12:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Npy3DY0u"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44WNsG14jgzDqXG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 14:10:40 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id j26so2080716pgl.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 20:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=vSVyccanEjH2gc3L1vx9as6TS4RC/ZUpI7wHEhvl0mI=;
 b=Npy3DY0uaYo6M0CvMX+VufS4GQ9GZ/UhsnhlgwyploXcFticAFhqZ9ii9jDbSCa9V2
 pibF+88cue97ou9fzkiGMfaElFnfCGnzi/Gy5tshGmJ8ujabybLLIsRdy1PMwaRahXec
 amps72C93x8O170Au/FLMzmzJABEzjx+J0/LSGilqPqnhLwdPRiKPCwBYg1ULEnF6F2l
 dC0gHPgdy7kKOV2w96foS4F0VDzTVV4+scNqiy7TTTZ8iJviNAlfEk3dqY3LMY1+2ZOX
 3Sy4ZksvW8rKxxMdOw6KlKgvX85rkzMzVb/EUUr4Mrv/kUVfL9DngLreY+6pGolR5nvn
 T4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=vSVyccanEjH2gc3L1vx9as6TS4RC/ZUpI7wHEhvl0mI=;
 b=uFlHy68z8BTr8uutY3GF/RTSPLul6CnyjJY9sRqRr2K21qFg+JCpnS52Ih3KcTArPr
 2YN1AcTR+of1vZwHH+Ip8AoVBK4GfiZrytTpKhaugN0rIz3M1PpR10sLxGdLMhyV1QMW
 aTE3iuH4JufZBJIeWHO2ZJEVle7EgfyM3O4R+Jz1aszFBn/X2ckAF29PwSrAp5ooIcRB
 WxHwLLc2AoaM02EjY9Ej6xI6M3QWu/hGGXtBUmJQAg+kCn2cZ9IenFb6tmVc58DfHoTO
 ekdsXtmV1sP2ibIRfTkrx4Az2pnM0/5owfYGnoCLHeWHWEbxkEytC2keFXWKv8HiSYHV
 CTvA==
X-Gm-Message-State: APjAAAXc4Fm+qbefmIOYhc/8acqKYEvleJWssA9Se64YR0B47vJcGfgL
 3nzmpsL+5oxqHzg9InM/KU0=
X-Google-Smtp-Source: APXvYqzsM2awD6bAAOx4nj2YavGEFDqTFgBA4As3qzCIQUC0EjRvyqyXQoOtDfy4CmyuAULyqBHQeg==
X-Received: by 2002:a63:470a:: with SMTP id u10mr50034175pga.17.1553915435202; 
 Fri, 29 Mar 2019 20:10:35 -0700 (PDT)
Received: from localhost (61-68-208-233.tpgi.com.au. [61.68.208.233])
 by smtp.gmail.com with ESMTPSA id c1sm4022740pfd.114.2019.03.29.20.10.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 29 Mar 2019 20:10:34 -0700 (PDT)
Date: Sat, 30 Mar 2019 13:10:28 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [Qemu-ppc] pseries on qemu-system-ppc64le crashes in
 doorbell_core_ipi()
To: Steven Rostedt <rostedt@goodmis.org>
References: <20190327123615.rwhk6h3ayfurvapf@linutronix.de>
 <7d97f3c6-4614-ead7-179a-e7e223ea3997@kaod.org>
 <2bbc1490-400d-585e-d74b-924c570b4236@kaod.org>
 <1553836851.2264.2.camel@gmail.com>
 <1553850306.nyv11r9iej.astroid@bobo.none>
 <20190329113109.3a9bd24e@gandalf.local.home>
In-Reply-To: <20190329113109.3a9bd24e@gandalf.local.home>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1553912871.ce5mzizoek.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
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
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Paul Mackerras <paulus@samba.org>,
 =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
 =?iso-8859-1?q?David=0A?= Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Steven Rostedt's on March 30, 2019 1:31 am:
> [ Added Peter ]
>=20
> On Fri, 29 Mar 2019 19:13:55 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
>=20
>> Suraj Jitindar Singh's on March 29, 2019 3:20 pm:
>> > On Wed, 2019-03-27 at 17:51 +0100, C=C3=A9dric Le Goater wrote: =20
>> >> On 3/27/19 5:37 PM, C=C3=A9dric Le Goater wrote: =20
>> >> > On 3/27/19 1:36 PM, Sebastian Andrzej Siewior wrote: =20
>> >> > > With qemu-system-ppc64le -machine pseries -smp 4 I get:
>> >> > >  =20
>> >> > > > #  chrt 1 hackbench
>> >> > > > Running in process mode with 10 groups using 40 file
>> >> > > > descriptors each (=3D=3D 400 tasks)
>> >> > > > Each sender will pass 100 messages of 100 bytes
>> >> > > > Oops: Exception in kernel mode, sig: 4 [#1]
>> >> > > > LE PAGE_SIZE=3D64K MMU=3DHash PREEMPT SMP NR_CPUS=3D2048 NUMA p=
Series
>> >> > > > Modules linked in:
>> >> > > > CPU: 0 PID: 629 Comm: hackbench Not tainted 5.1.0-rc2 #71
>> >> > > > NIP:  c000000000046978 LR: c000000000046a38 CTR:
>> >> > > > c0000000000b0150
>> >> > > > REGS: c0000001fffeb8e0 TRAP: 0700   Not tainted  (5.1.0-rc2)
>> >> > > > MSR:  8000000000089033 <SF,EE,ME,IR,DR,RI,LE>  CR:
>> >> > > > 42000874  XER: 00000000
>> >> > > > CFAR: c000000000046a34 IRQMASK: 1
>> >> > > > GPR00: c0000000000b0170 c0000001fffebb70 c000000000a6ba00
>> >> > > > 0000000028000000 =20
>> >> > >=20
>> >> > > =E2=80=A6 =20
>> >> > > > NIP [c000000000046978] doorbell_core_ipi+0x28/0x30
>> >> > > > LR [c000000000046a38] doorbell_try_core_ipi+0xb8/0xf0
>> >> > > > Call Trace:
>> >> > > > [c0000001fffebb70] [c0000001fffebba0] 0xc0000001fffebba0
>> >> > > > (unreliable)
>> >> > > > [c0000001fffebba0] [c0000000000b0170]
>> >> > > > smp_pseries_cause_ipi+0x20/0x70
>> >> > > > [c0000001fffebbd0] [c00000000004b02c]
>> >> > > > arch_send_call_function_single_ipi+0x8c/0xa0
>> >> > > > [c0000001fffebbf0] [c0000000001de600]
>> >> > > > irq_work_queue_on+0xe0/0x130
>> >> > > > [c0000001fffebc30] [c0000000001340c8]
>> >> > > > rto_push_irq_work_func+0xc8/0x120 =20
>> >> > >=20
>> >> > > =E2=80=A6 =20
>> >> > > > Instruction dump:
>> >> > > > 60000000 60000000 3c4c00a2 384250b0 3d220009 392949c8 81290000
>> >> > > > 3929ffff
>> >> > > > 7d231838 7c0004ac 5463017e 64632800 <7c00191c> 4e800020
>> >> > > > 3c4c00a2 38425080
>> >> > > > ---[ end trace eb842b544538cbdf ]--- =20
>>=20
>> This is unusual and causing powerpc code to crash because the rt
>> scheduler is telling irq_work_queue_on to queue work on this CPU.
>> Is that something allowed? There's no warnings in there but it must
>> be a rarely tested path, would it be better to ban it?
>>=20
>> Steven is this queue_work_on to self by design?
>=20
> I just figured that a irq_work_queue_on() would default to just
> irq_work_queue() if cpu =3D=3D smp_processor_id().

Yeah it actually doesn't, it raises a CALL_FUNCTION IPI on the
current CPU. Maybe it should do that.

>=20
> I'm sure this case has been tested (on x86), as I stressed this quite a
> bit, and all it takes is to have an RT task queued on the CPU
> processing the current "push" logic when it's not holding the rq locks
> and read that the current CPU now has an overloaded RT task.
>=20
> If calling irq_work_queue_on() is really bad to do to the same CPU,
> then we can work on changing the logic to do something different if the
> CPU returned from rto_next_cpu() is the current CPU.

I don't actually know that it is bad. It does seem to violate the
principle of least surprise for arch code though.

From this bug report, I'm guessing it's pretty rare case to hit so
I would worry about subtle bugs. And I just cc'ed you in case your
code was actually not intending to do this.

> Or would it be possible to just change irq_work_queue_on() to call
> irq_work_queue() if cpu =3D=3D smp_processor_id()?

Something like this?

kernel/irq_work: Do not raise an IPI when queueing work on the local CPU

The QEMU powerpc/pseries machine model was not expecting a self-IPI,
and it may be a bit surprising thing to do, so have irq_work_queue_on
do local queueing when target is current CPU.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/irq_work.c | 78 ++++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 35 deletions(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 6b7cdf17ccf8..f0e539d0f879 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -56,61 +56,69 @@ void __weak arch_irq_work_raise(void)
 	 */
 }
=20
-/*
- * Enqueue the irq_work @work on @cpu unless it's already pending
- * somewhere.
- *
- * Can be re-enqueued while the callback is still in progress.
- */
-bool irq_work_queue_on(struct irq_work *work, int cpu)
+/* Enqueue on current CPU, work must already be claimed and preempt disabl=
ed */
+static void __irq_work_queue(struct irq_work *work)
 {
-	/* All work should have been flushed before going offline */
-	WARN_ON_ONCE(cpu_is_offline(cpu));
-
-#ifdef CONFIG_SMP
-
-	/* Arch remote IPI send/receive backend aren't NMI safe */
-	WARN_ON_ONCE(in_nmi());
+	/* If the work is "lazy", handle it from next tick if any */
+	if (work->flags & IRQ_WORK_LAZY) {
+		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
+		    tick_nohz_tick_stopped())
+			arch_irq_work_raise();
+	} else {
+		if (llist_add(&work->llnode, this_cpu_ptr(&raised_list)))
+			arch_irq_work_raise();
+	}
+}
=20
+/* Enqueue the irq work @work on the current CPU */
+bool irq_work_queue(struct irq_work *work)
+{
 	/* Only queue if not already pending */
 	if (!irq_work_claim(work))
 		return false;
=20
-	if (llist_add(&work->llnode, &per_cpu(raised_list, cpu)))
-		arch_send_call_function_single_ipi(cpu);
-
-#else /* #ifdef CONFIG_SMP */
-	irq_work_queue(work);
-#endif /* #else #ifdef CONFIG_SMP */
+	/* Queue the entry and raise the IPI if needed. */
+	preempt_disable();
+	__irq_work_queue(work);
+	preempt_enable();
=20
 	return true;
 }
+EXPORT_SYMBOL_GPL(irq_work_queue);
=20
-/* Enqueue the irq work @work on the current CPU */
-bool irq_work_queue(struct irq_work *work)
+/*
+ * Enqueue the irq_work @work on @cpu unless it's already pending
+ * somewhere.
+ *
+ * Can be re-enqueued while the callback is still in progress.
+ */
+bool irq_work_queue_on(struct irq_work *work, int cpu)
 {
+#ifndef CONFIG_SMP
+	return irq_work_queue(work);
+
+#else /* #ifndef CONFIG_SMP */
+	/* All work should have been flushed before going offline */
+	WARN_ON_ONCE(cpu_is_offline(cpu));
+
 	/* Only queue if not already pending */
 	if (!irq_work_claim(work))
 		return false;
=20
-	/* Queue the entry and raise the IPI if needed. */
 	preempt_disable();
-
-	/* If the work is "lazy", handle it from next tick if any */
-	if (work->flags & IRQ_WORK_LAZY) {
-		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
-		    tick_nohz_tick_stopped())
-			arch_irq_work_raise();
-	} else {
-		if (llist_add(&work->llnode, this_cpu_ptr(&raised_list)))
-			arch_irq_work_raise();
-	}
-
+	if (cpu !=3D smp_processor_id()) {
+		/* Arch remote IPI send/receive backend aren't NMI safe */
+		WARN_ON_ONCE(in_nmi());
+		if (llist_add(&work->llnode, &per_cpu(raised_list, cpu)))
+			arch_send_call_function_single_ipi(cpu);
+	} else
+		__irq_work_queue(work);
 	preempt_enable();
=20
 	return true;
+#endif /* #else #ifndef CONFIG_SMP */
 }
-EXPORT_SYMBOL_GPL(irq_work_queue);
+
=20
 bool irq_work_needs_cpu(void)
 {
--=20
2.20.1

=
