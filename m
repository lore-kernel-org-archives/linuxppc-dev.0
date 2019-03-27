Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1081C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 17:02:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F0F206C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 17:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F0F206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TvSq2CdHzDqPj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 04:02:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.63.100; helo=6.mo68.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 6.mo68.mail-out.ovh.net (6.mo68.mail-out.ovh.net
 [46.105.63.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TvQs6r57zDqHr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 04:01:07 +1100 (AEDT)
Received: from player699.ha.ovh.net (unknown [10.109.160.239])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 6B03711CDD5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 17:52:03 +0100 (CET)
Received: from kaod.org (lfbn-1-2226-17.w90-76.abo.wanadoo.fr [90.76.48.17])
 (Authenticated sender: clg@kaod.org)
 by player699.ha.ovh.net (Postfix) with ESMTPSA id D843741E4446;
 Wed, 27 Mar 2019 16:51:51 +0000 (UTC)
Subject: Re: [Qemu-ppc] pseries on qemu-system-ppc64le crashes in
 doorbell_core_ipi()
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, qemu-ppc@nongnu.org
References: <20190327123615.rwhk6h3ayfurvapf@linutronix.de>
 <7d97f3c6-4614-ead7-179a-e7e223ea3997@kaod.org>
Message-ID: <2bbc1490-400d-585e-d74b-924c570b4236@kaod.org>
Date: Wed, 27 Mar 2019 17:51:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <7d97f3c6-4614-ead7-179a-e7e223ea3997@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 12263864735445257155
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddrkedvgdeklecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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
 Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 3/27/19 5:37 PM, Cédric Le Goater wrote:
> On 3/27/19 1:36 PM, Sebastian Andrzej Siewior wrote:
>> With qemu-system-ppc64le -machine pseries -smp 4 I get:
>>
>> |#  chrt 1 hackbench
>> |Running in process mode with 10 groups using 40 file descriptors each (== 400 tasks)
>> |Each sender will pass 100 messages of 100 bytes
>> | Oops: Exception in kernel mode, sig: 4 [#1]
>> | LE PAGE_SIZE=64K MMU=Hash PREEMPT SMP NR_CPUS=2048 NUMA pSeries
>> | Modules linked in:
>> | CPU: 0 PID: 629 Comm: hackbench Not tainted 5.1.0-rc2 #71
>> | NIP:  c000000000046978 LR: c000000000046a38 CTR: c0000000000b0150
>> | REGS: c0000001fffeb8e0 TRAP: 0700   Not tainted  (5.1.0-rc2)
>> | MSR:  8000000000089033 <SF,EE,ME,IR,DR,RI,LE>  CR: 42000874  XER: 00000000
>> | CFAR: c000000000046a34 IRQMASK: 1
>> | GPR00: c0000000000b0170 c0000001fffebb70 c000000000a6ba00 0000000028000000
>> …
>> | NIP [c000000000046978] doorbell_core_ipi+0x28/0x30
>> | LR [c000000000046a38] doorbell_try_core_ipi+0xb8/0xf0
>> | Call Trace:
>> | [c0000001fffebb70] [c0000001fffebba0] 0xc0000001fffebba0 (unreliable)
>> | [c0000001fffebba0] [c0000000000b0170] smp_pseries_cause_ipi+0x20/0x70
>> | [c0000001fffebbd0] [c00000000004b02c] arch_send_call_function_single_ipi+0x8c/0xa0
>> | [c0000001fffebbf0] [c0000000001de600] irq_work_queue_on+0xe0/0x130
>> | [c0000001fffebc30] [c0000000001340c8] rto_push_irq_work_func+0xc8/0x120
>> …
>> | Instruction dump:
>> | 60000000 60000000 3c4c00a2 384250b0 3d220009 392949c8 81290000 3929ffff
>> | 7d231838 7c0004ac 5463017e 64632800 <7c00191c> 4e800020 3c4c00a2 38425080
>> | ---[ end trace eb842b544538cbdf ]---
>>
>> and I was wondering whether this is a qemu bug or the kernel is using an
>> opcode it should rather not. If I skip doorbell_try_core_ipi() in
>> smp_pseries_cause_ipi() then there is no crash. The comment says "POWER9
>> should not use this handler" so…
> 
> I would say Linux is using a msgsndp instruction which is not implemented
> in QEMU TCG. But why have we started using dbells in Linux ? 

ah. It seems arch_local_irq_restore() / replay_interrupt() generated
some interrupt.

C.
