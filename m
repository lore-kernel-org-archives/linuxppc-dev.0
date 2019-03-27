Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB86BC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 13:13:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DEDA2146F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 13:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DEDA2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TpMv5qZLzDqQN
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 00:13:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linutronix.de
 (client-ip=2a01:7a0:2:106d:700::1; helo=galois.linutronix.de;
 envelope-from=bigeasy@linutronix.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linutronix.de
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES256-SHA256 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TpHl5r4bzDqHX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 00:09:39 +1100 (AEDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>)
 id 1h97mx-0007lV-G7; Wed, 27 Mar 2019 13:36:15 +0100
Date: Wed, 27 Mar 2019 13:36:15 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linuxppc-dev@lists.ozlabs.org, qemu-ppc@nongnu.org
Subject: pseries on qemu-system-ppc64le crashes in doorbell_core_ipi()
Message-ID: <20190327123615.rwhk6h3ayfurvapf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: NeoMutt/20180716
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
Cc: tglx@linutronix.de, David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

With qemu-system-ppc64le -machine pseries -smp 4 I get:

|#  chrt 1 hackbench
|Running in process mode with 10 groups using 40 file descriptors each (=3D=
=3D 400 tasks)
|Each sender will pass 100 messages of 100 bytes
| Oops: Exception in kernel mode, sig: 4 [#1]
| LE PAGE_SIZE=3D64K MMU=3DHash PREEMPT SMP NR_CPUS=3D2048 NUMA pSeries
| Modules linked in:
| CPU: 0 PID: 629 Comm: hackbench Not tainted 5.1.0-rc2 #71
| NIP:  c000000000046978 LR: c000000000046a38 CTR: c0000000000b0150
| REGS: c0000001fffeb8e0 TRAP: 0700   Not tainted  (5.1.0-rc2)
| MSR:  8000000000089033 <SF,EE,ME,IR,DR,RI,LE>  CR: 42000874  XER: 00000000
| CFAR: c000000000046a34 IRQMASK: 1
| GPR00: c0000000000b0170 c0000001fffebb70 c000000000a6ba00 0000000028000000
=E2=80=A6
| NIP [c000000000046978] doorbell_core_ipi+0x28/0x30
| LR [c000000000046a38] doorbell_try_core_ipi+0xb8/0xf0
| Call Trace:
| [c0000001fffebb70] [c0000001fffebba0] 0xc0000001fffebba0 (unreliable)
| [c0000001fffebba0] [c0000000000b0170] smp_pseries_cause_ipi+0x20/0x70
| [c0000001fffebbd0] [c00000000004b02c] arch_send_call_function_single_ipi+=
0x8c/0xa0
| [c0000001fffebbf0] [c0000000001de600] irq_work_queue_on+0xe0/0x130
| [c0000001fffebc30] [c0000000001340c8] rto_push_irq_work_func+0xc8/0x120
=E2=80=A6
| Instruction dump:
| 60000000 60000000 3c4c00a2 384250b0 3d220009 392949c8 81290000 3929ffff
| 7d231838 7c0004ac 5463017e 64632800 <7c00191c> 4e800020 3c4c00a2 38425080
| ---[ end trace eb842b544538cbdf ]---

and I was wondering whether this is a qemu bug or the kernel is using an
opcode it should rather not. If I skip doorbell_try_core_ipi() in
smp_pseries_cause_ipi() then there is no crash. The comment says "POWER9
should not use this handler" so=E2=80=A6

(This is QEMU emulator version 3.1.0 (Debian 1:3.1+dfsg-6))

Sebastian
