Return-Path: <SRS0=bUW7=VN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75329C76188
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jul 2019 12:35:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B180320880
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jul 2019 12:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B180320880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45p0Gf62RjzDqD9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jul 2019 22:35:06 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nzMW1bHJzDqXJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jul 2019 21:54:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45nzMT0yFwz9s7T;
 Tue, 16 Jul 2019 21:54:13 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Alexey Kardashevskiy
 <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH kernel v2] powerpc/xive: Drop deregistered irqs
In-Reply-To: <9bc6b177-e440-1510-ff65-795e4c3c1695@kaod.org>
References: <20190715071131.86173-1-aik@ozlabs.ru>
 <303bfc1d-230b-76ed-8059-48951ee16426@kaod.org>
 <b8722c86-317d-ba60-1b16-d848c86d0e71@ozlabs.ru>
 <9bc6b177-e440-1510-ff65-795e4c3c1695@kaod.org>
Date: Tue, 16 Jul 2019 21:54:13 +1000
Message-ID: <87r26q8aai.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
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
Cc: Alistair Popple <alistair@popple.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

C=C3=A9dric Le Goater <clg@kaod.org> writes:
> On 16/07/2019 11:10, Alexey Kardashevskiy wrote:
>> On 16/07/2019 18:59, C=C3=A9dric Le Goater wrote:
>>> On 15/07/2019 09:11, Alexey Kardashevskiy wrote:
>>>> There is a race between releasing an irq on one cpu and fetching it
>>>> from XIVE on another cpu as there does not seem to be any locking betw=
een
>>>> these, probably because xive_irq_chip::irq_shutdown() is supposed to
>>>> remove the irq from all queues in the system which it does not do.
>>>>
>>>> As a result, when such released irq appears in a queue, we take it
>>>> from the queue but we do not change the current priority on that cpu a=
nd
>>>> since there is no handler for the irq, EOI is never called and the cpu
>>>> current priority remains elevated (7 vs. 0xff=3D=3Dunmasked). If anoth=
er irq
>>>> is assigned to the same cpu, then that device stops working until irq
>>>> is moved to another cpu or the device is reset.
>>>>
>>>> This adds a new ppc_md.orphan_irq callback which is called if no irq
>>>> descriptor is found. The XIVE implementation drops the current priority
>>>> to 0xff which effectively unmasks interrupts in a current CPU.
>>>
>>>
>>> The test on generic_handle_irq() catches interrupt events that
>>> were served on a target CPU while the source interrupt was being
>>> shutdown on another CPU.
>>>
>>> The orphan_irq() handler restores the CPPR in such cases.
>>>
>>> This looks OK to me. I would have added some more comments in the
>>> code.
>>=20
>> Which and where? Thanks,
>
> Above xive_orphan_irq() explaining the complete problem that we are=20
> addressing. XIVE is not super obvious when looking at the code ...

Yes adding a comment would be good, thanks.

This will also need a Fixes: tag.

cheers
