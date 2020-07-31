Return-Path: <SRS0=XZtv=BK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C30EC433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2020 13:19:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1DE2076B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2020 13:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="UXi89WeI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1DE2076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BJ7Cc0rkSzDqdp
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2020 23:19:08 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BJ78s45NrzDqd9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2020 23:16:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=UXi89WeI; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BJ78s28Hpz9sRN;
 Fri, 31 Jul 2020 23:16:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1596201405;
 bh=1JbEFZUUsHvWdZwnibgE6UHCnlPslOOz7UrpISJ3wsU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=UXi89WeIk9sIfFGoPTwobFpIVZFYZrSo+Q5qUcyGUOY03RQPOjQhZsr5tFcwl5mH5
 UjTMJW9n85y6QIwSqCnWqZtcQ5x8b5B+6yRBO4FL8XCB5W0YBM3oRBVGv7gUckhkWD
 PdqyLP/iXr2sTsv0vQV7y/g6PiXcbEiKi7JOeGPSsSXHDE+h/RUDR5kp2HHnw3/Wme
 TO0jXo6RvVGihBTnQecPZd32WzauaxZq5xlGQ/93MwtXL+rS+9G+h4XBp1GxLN44I0
 Bie7F7xScLa4SL2tv1GWjRB7fYhZXQIwwZLMh1YC5Yy70ioKUsCMguZW5s0S1LbtMG
 iBsS2BnaGYNzA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Lynch <nathanl@linux.ibm.com>,
 Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: explicitly reschedule during drmem_lmb
 list traversal
In-Reply-To: <875za511z6.fsf@linux.ibm.com>
References: <20200728173741.717372-1-nathanl@linux.ibm.com>
 <bd9225f2-40c9-0460-ba45-c29c920b5f91@linux.ibm.com>
 <878sf31m8k.fsf@linux.ibm.com> <87lfj16cql.fsf@mpe.ellerman.id.au>
 <875za511z6.fsf@linux.ibm.com>
Date: Fri, 31 Jul 2020 23:16:44 +1000
Message-ID: <87ft974yf7.fsf@mpe.ellerman.id.au>
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
Cc: tyreld@linux.ibm.com, cheloha@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nathan Lynch <nathanl@linux.ibm.com> writes:
> Michael Ellerman <mpe@ellerman.id.au> writes:
>> Nathan Lynch <nathanl@linux.ibm.com> writes:
>>> Laurent Dufour <ldufour@linux.ibm.com> writes:
>>>> Le 28/07/2020 =C3=A0 19:37, Nathan Lynch a =C3=A9crit=C2=A0:
>>>>> The drmem lmb list can have hundreds of thousands of entries, and
>>>>> unfortunately lookups take the form of linear searches. As long as
>>>>> this is the case, traversals have the potential to monopolize the CPU
>>>>> and provoke lockup reports, workqueue stalls, and the like unless
>>>>> they explicitly yield.
>>>>>=20
>>>>> Rather than placing cond_resched() calls within various
>>>>> for_each_drmem_lmb() loop blocks in the code, put it in the iteration
>>>>> expression of the loop macro itself so users can't omit it.
>>>>
>>>> Is that not too much to call cond_resched() on every LMB?
>>>>
>>>> Could that be less frequent, every 10, or 100, I don't really know ?
>>>
>>> Everything done within for_each_drmem_lmb is relatively heavyweight
>>> already. E.g. calling dlpar_remove_lmb()/dlpar_add_lmb() can take dozens
>>> of milliseconds. I don't think cond_resched() is an expensive check in
>>> this context.
>>
>> Hmm, mostly.
>>
>> But there are quite a few cases like drmem_update_dt_v1():
>>
>> 	for_each_drmem_lmb(lmb) {
>> 		dr_cell->base_addr =3D cpu_to_be64(lmb->base_addr);
>> 		dr_cell->drc_index =3D cpu_to_be32(lmb->drc_index);
>> 		dr_cell->aa_index =3D cpu_to_be32(lmb->aa_index);
>> 		dr_cell->flags =3D cpu_to_be32(drmem_lmb_flags(lmb));
>>
>> 		dr_cell++;
>> 	}
>>
>> Which will compile to a pretty tight loop at the moment.
>>
>> Or drmem_update_dt_v2() which has two loops over all lmbs.
>>
>> And although the actual TIF check is cheap the function call to do it is
>> not free.
>>
>> So I worry this is going to make some of those long loops take even
>> longer.
>
> That's fair, and I was wrong - some of the loop bodies are relatively
> simple, not doing allocations or taking locks, etc.
>
> One way to deal is to keep for_each_drmem_lmb() as-is and add a new
> iterator that can reschedule, e.g. for_each_drmem_lmb_slow().

If we did that, how many call-sites would need converting?
Is it ~2 or ~20 or ~200?

> On the other hand... it's probably not too strong to say that the
> drmem/hotplug code is in crisis with respect to correctness and
> algorithmic complexity, so those are my overriding concerns right
> now. Yes, this change will pessimize loops that are reinitializing the
> entire drmem_lmb array on every DLPAR operation, but:
>
> 1. it doesn't make any user of for_each_drmem_lmb() less correct;
> 2. why is this code doing that in the first place, other than to
>    accommodate a poor data structure choice?
>
> The duration of the system calls where this code runs are measured in
> minutes or hours on large configurations because of all the behaviors
> that are at best O(n) with the amount of memory assigned to the
> partition. For simplicity's sake I'd rather defer lower-level
> performance considerations like this until the drmem data structures'
> awful lookup properties are fixed -- hopefully in the 5.10 timeframe.

Yeah fair enough.

cheers
