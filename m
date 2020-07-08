Return-Path: <SRS0=luaH=AT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE58C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2020 14:16:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18D9620720
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2020 14:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Mst6b4tR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D9620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B21ZX0RtxzDqY4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2020 00:16:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=efficios.com (client-ip=167.114.26.124; helo=mail.efficios.com;
 envelope-from=compudj@efficios.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256
 header.s=default header.b=Mst6b4tR; dkim-atps=neutral
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B21Tv4sbdzDqWY
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2020 00:12:34 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 445831B5C91;
 Wed,  8 Jul 2020 10:12:32 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id dyUYSYYd0_cL; Wed,  8 Jul 2020 10:12:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id F14FB1B586C;
 Wed,  8 Jul 2020 10:12:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com F14FB1B586C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=default; t=1594217551;
 bh=ZbJcrkbdvyTqPfeZb8iusPjkZ8XiMQXX6lZKgVlkHCU=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=Mst6b4tROqtQpP5xBYQmofE1rE3p92VcC8mPkJUZKe7jnB8LN2XSmerybm6N8CMXF
 SEbDQBWzt/tZ0WiGrZ2DxHOg25c3lCHwFFgH8jPFQm2Af7kT1G2jQNeIrnOmEUGzO6
 bku8/Eq0lF90V6Ieggqo+SWRFTvFHASV62+3N98R+U5ykDIoaN0qTLZ+a21TJpDdN/
 GsvHJ3NWoqNeZs9HvGDS7Vf1hh6dzBo/hNWijeGIdXL8Fokk6HqjfNRfU1aOWqRdd0
 VeCv8hhuqEckSxVhhpZK8NnqsRUycnDflR2ME+gYLONhUlAa5WVaJBJVozN+jXzZP9
 hiYXlTnvr8cPQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id xnJCUT8kTkcZ; Wed,  8 Jul 2020 10:12:31 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id E44AE1B5C8E;
 Wed,  8 Jul 2020 10:12:31 -0400 (EDT)
Date: Wed, 8 Jul 2020 10:12:31 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <407005394.1910.1594217551840.JavaMail.zimbra@efficios.com>
In-Reply-To: <1594185107.e130s0d92x.astroid@bobo.none>
References: <20200706021822.1515189-1-npiggin@gmail.com>
 <cf10b0bc-de79-1b2b-8355-fc7bbeec47c3@csgroup.eu>
 <1594098302.nadnq2txti.astroid@bobo.none>
 <638683144.970.1594121101349.JavaMail.zimbra@efficios.com>
 <1594185107.e130s0d92x.astroid@bobo.none>
Subject: Re: [PATCH] powerpc: select ARCH_HAS_MEMBARRIER_SYNC_CORE
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: powerpc: select ARCH_HAS_MEMBARRIER_SYNC_CORE
Thread-Index: 7ZdakloO4BcuERqqIFVdRhXTmEAP1A==
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

----- On Jul 8, 2020, at 1:17 AM, Nicholas Piggin npiggin@gmail.com wrote:

> Excerpts from Mathieu Desnoyers's message of July 7, 2020 9:25 pm:
>> ----- On Jul 7, 2020, at 1:50 AM, Nicholas Piggin npiggin@gmail.com wrote:
>> 
[...]
>>> I should actually change the comment for 64-bit because soft masked
>>> interrupt replay is an interesting case. I thought it was okay (because
>>> the IPI would cause a hard interrupt which does do the rfi) but that
>>> should at least be written.
>> 
>> Yes.
>> 
>>> The context synchronisation happens before
>>> the Linux IPI function is called, but for the purpose of membarrier I
>>> think that is okay (the membarrier just needs to have caused a memory
>>> barrier + context synchronistaion by the time it has done).
>> 
>> Can you point me to the code implementing this logic ?
> 
> It's mostly in arch/powerpc/kernel/exception-64s.S and
> powerpc/kernel/irq.c, but a lot of asm so easier to explain.
> 
> When any Linux code does local_irq_disable(), we set interrupts as
> software-masked in a per-cpu flag. When interrupts (including IPIs) come
> in, the first thing we do is check that flag and if we are masked, then
> record that the interrupt needs to be "replayed" in another per-cpu
> flag. The interrupt handler then exits back using RFI (which is context
> synchronising the CPU). Later, when the kernel code does
> local_irq_enable(), it checks the replay flag to see if anything needs
> to be done. At that point we basically just call the interrupt handler
> code like a normal function, and when that returns there is no context
> synchronising instruction.

AFAIU this can only happen for interrupts nesting over irqoff sections,
therefore over kernel code, never userspace, right ?

> 
> So membarrier IPI will always cause target CPUs to perform a context
> synchronising instruction, but sometimes it happens before the IPI
> handler function runs.

If my understanding is correct, the replayed interrupt handler logic
only nests over kernel code, which will eventually need to issue a
context synchronizing instruction before returning to user-space.

All we care about is that starting from the membarrier, each core
either:

- interrupt user-space to issue the context synchronizing instruction if
  they were running userspace, or
- _eventually_ issue a context synchronizing instruction before returning
  to user-space if they were running kernel code.

So your earlier statement "the membarrier just needs to have caused a memory
barrier + context synchronistaion by the time it has done" is not strictly
correct: the context synchronizing instruction does not strictly need to
happen on each core before membarrier returns. A similar line of thoughts
can be followed for memory barriers.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
