Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6DDC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 09:15:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD062173C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 09:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LltuiqZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD062173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Vx0t3SD8zDqSj
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 20:15:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="LltuiqZ5"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Vwz432JnzDqR5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 20:14:07 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id i19so773196pfd.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 02:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=h54JovAg/2TMYntmkJuN7st+ornA1IP6LD/X7EvBfvU=;
 b=LltuiqZ50quBI/wcP7PP0CBPpAjfsuvGxyqzDPeB9acZJrervTbTAUI4UuorqJPLjV
 1Lai6HkkHtAdgeVcDP19COgbgEn9xNrgWVKDpTKaUIQobcldBj7mnbRWikt8cG60CxEP
 4sHLLXlEgc8a/WOfqD3bYDeVLjM3vukmEMRqGLT6uOJJWYuFuWPGnzgpWIlLAmClV65J
 ey2/SysAW/kObqZNL500BB2rUZejhjZBeIUAvldR57ITmkBlrTy42VerbFFq1tyRFSo6
 NsJ5Jga7bbkaYhBEKn7CEhAwRZF8IOPs8IM/JqplyWAzGhm8zxUreA+Klvl3wtFZYL+T
 bf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=h54JovAg/2TMYntmkJuN7st+ornA1IP6LD/X7EvBfvU=;
 b=S7RPDgol/TIENnhq5c+VZg4ZQ/fsv496HKiDxScLgBpuHV5koGRh587VzxbkjuKOqs
 x6iHK7o1oScJt7reMl4NFAamekvHos1SAPmlR8VGxOqW1TFrrI+Bf2SrvuF7hDPqji4m
 S1atxLbn45loUQhroiODQRHORxxLE/yHPPCc8/pQJwaxbXOFJqmEQAVW0o7tkJWRJFoG
 8t856DVe99w97cmJ7zNsmhCDk+oJkHh0+gZ7kF3daaAKVDzl8YFZFgGjPzep4ARrrTvA
 ymSqkvghdkIOx+lfvSL3kZ9HFQT4K64OtWJwFZffe2pXrIGRQ6YLBdyfFGRgCDFAmoIv
 bMgQ==
X-Gm-Message-State: APjAAAXiG3AqIlm2Ioi3NA0KDxqp1lcfA7YPWaEU4GD6AFn6hj0vfTgj
 brqdcUpvFRD6zP4Ryt+ksU4=
X-Google-Smtp-Source: APXvYqwyJaxqsj2WqA8cZtNu/b7aSoKRmr9GiNlv1W/MQFG/6Hl5ne3NAlnJlBB1IWMjSRBoURQNRA==
X-Received: by 2002:a63:ef57:: with SMTP id c23mr44764653pgk.176.1553850843490; 
 Fri, 29 Mar 2019 02:14:03 -0700 (PDT)
Received: from localhost ([58.84.105.43])
 by smtp.gmail.com with ESMTPSA id g2sm2050200pfd.134.2019.03.29.02.14.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 29 Mar 2019 02:14:02 -0700 (PDT)
Date: Fri, 29 Mar 2019 19:13:55 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [Qemu-ppc] pseries on qemu-system-ppc64le crashes in
 doorbell_core_ipi()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org, qemu-ppc@nongnu.org, Suraj Jitindar Singh
 <sjitindarsingh@gmail.com>
References: <20190327123615.rwhk6h3ayfurvapf@linutronix.de>
 <7d97f3c6-4614-ead7-179a-e7e223ea3997@kaod.org>
 <2bbc1490-400d-585e-d74b-924c570b4236@kaod.org>
 <1553836851.2264.2.camel@gmail.com>
In-Reply-To: <1553836851.2264.2.camel@gmail.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1553850306.nyv11r9iej.astroid@bobo.none>
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
Cc: tglx@linutronix.de, Paul Mackerras <paulus@samba.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Suraj Jitindar Singh's on March 29, 2019 3:20 pm:
> On Wed, 2019-03-27 at 17:51 +0100, C=C3=A9dric Le Goater wrote:
>> On 3/27/19 5:37 PM, C=C3=A9dric Le Goater wrote:
>> > On 3/27/19 1:36 PM, Sebastian Andrzej Siewior wrote:
>> > > With qemu-system-ppc64le -machine pseries -smp 4 I get:
>> > >=20
>> > > > #  chrt 1 hackbench
>> > > > Running in process mode with 10 groups using 40 file
>> > > > descriptors each (=3D=3D 400 tasks)
>> > > > Each sender will pass 100 messages of 100 bytes
>> > > > Oops: Exception in kernel mode, sig: 4 [#1]
>> > > > LE PAGE_SIZE=3D64K MMU=3DHash PREEMPT SMP NR_CPUS=3D2048 NUMA pSer=
ies
>> > > > Modules linked in:
>> > > > CPU: 0 PID: 629 Comm: hackbench Not tainted 5.1.0-rc2 #71
>> > > > NIP:  c000000000046978 LR: c000000000046a38 CTR:
>> > > > c0000000000b0150
>> > > > REGS: c0000001fffeb8e0 TRAP: 0700   Not tainted  (5.1.0-rc2)
>> > > > MSR:  8000000000089033 <SF,EE,ME,IR,DR,RI,LE>  CR:
>> > > > 42000874  XER: 00000000
>> > > > CFAR: c000000000046a34 IRQMASK: 1
>> > > > GPR00: c0000000000b0170 c0000001fffebb70 c000000000a6ba00
>> > > > 0000000028000000
>> > >=20
>> > > =E2=80=A6
>> > > > NIP [c000000000046978] doorbell_core_ipi+0x28/0x30
>> > > > LR [c000000000046a38] doorbell_try_core_ipi+0xb8/0xf0
>> > > > Call Trace:
>> > > > [c0000001fffebb70] [c0000001fffebba0] 0xc0000001fffebba0
>> > > > (unreliable)
>> > > > [c0000001fffebba0] [c0000000000b0170]
>> > > > smp_pseries_cause_ipi+0x20/0x70
>> > > > [c0000001fffebbd0] [c00000000004b02c]
>> > > > arch_send_call_function_single_ipi+0x8c/0xa0
>> > > > [c0000001fffebbf0] [c0000000001de600]
>> > > > irq_work_queue_on+0xe0/0x130
>> > > > [c0000001fffebc30] [c0000000001340c8]
>> > > > rto_push_irq_work_func+0xc8/0x120
>> > >=20
>> > > =E2=80=A6
>> > > > Instruction dump:
>> > > > 60000000 60000000 3c4c00a2 384250b0 3d220009 392949c8 81290000
>> > > > 3929ffff
>> > > > 7d231838 7c0004ac 5463017e 64632800 <7c00191c> 4e800020
>> > > > 3c4c00a2 38425080
>> > > > ---[ end trace eb842b544538cbdf ]---

This is unusual and causing powerpc code to crash because the rt
scheduler is telling irq_work_queue_on to queue work on this CPU.
Is that something allowed? There's no warnings in there but it must
be a rarely tested path, would it be better to ban it?

Steven is this queue_work_on to self by design?

>> > >=20
>> > > and I was wondering whether this is a qemu bug or the kernel is
>> > > using an
>> > > opcode it should rather not. If I skip doorbell_try_core_ipi() in
>> > > smp_pseries_cause_ipi() then there is no crash. The comment says
>> > > "POWER9
>> > > should not use this handler" so=E2=80=A6
>> >=20
>> > I would say Linux is using a msgsndp instruction which is not
>> > implemented
>> > in QEMU TCG. But why have we started using dbells in Linux ?=20
>=20
> Yeah the kernel must have used msgsndp which isn't implemented for TCG
> yet. We use doorbells in linux but only for threads which are on the
> same core.
> And when I try to construct a situation with more than 1 thread per
> core (e.g. -smp 4,threads=3D4), I get "TCG cannot support more than 1
> thread/core on a pseries machine".
>=20
> So I wonder why the guest thinks it can use msgsndp...

IPI to self evidently. Under TCG it really should implement the
instruction or remove the DBELL feature.

Thanks,
Nick

=
