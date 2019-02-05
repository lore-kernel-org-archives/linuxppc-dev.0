Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BD6C282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 10:11:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71FAF20844
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 10:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71FAF20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43v0jJ4wV6zDqLK
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 21:11:32 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43v0gZ75L9zDqDY
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 21:10:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43v0gZ4Zgnz9sMl;
 Tue,  5 Feb 2019 21:10:02 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC/WIP] powerpc: Fix 32-bit handling of MSR_EE on exceptions
In-Reply-To: <5a97253c-0ec4-d61f-fa9e-ea5da8590f32@c-s.fr>
References: <fe3a79e078c644d9c1379ef5f8c431d787b6d0c8.camel@kernel.crashing.org>
 <cbce315b-82f9-c748-92e4-97bb819c9098@c-s.fr>
 <ab9139902a64f8d0b187f7db0f8a16a5b85791ac.camel@kernel.crashing.org>
 <5a97253c-0ec4-d61f-fa9e-ea5da8590f32@c-s.fr>
Date: Tue, 05 Feb 2019 21:10:01 +1100
Message-ID: <87pns6mtqe.fsf@concordia.ellerman.id.au>
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
Cc: Diana Craciun <diana.craciun@nxp.com>, Scott Wood <oss@buserror.net>,
 Nick Piggin <npiggin@au1.ibm.com>, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Le 20/12/2018 =C3=A0 23:35, Benjamin Herrenschmidt a =C3=A9crit=C2=A0:
>>=20
>>>>    /*
>>>>     * MSR_KERNEL is > 0x10000 on 4xx/Book-E since it include MSR_CE.
>>>> @@ -205,20 +208,46 @@ transfer_to_handler_cont:
>>>>    	mflr	r9
>>>>    	lwz	r11,0(r9)		/* virtual address of handler */
>>>>    	lwz	r9,4(r9)		/* where to go when done */
>>>> +#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PERF_EVENTS)
>>>> +	mtspr	SPRN_NRI, r0
>>>> +#endif
>>>
>>> That's not part of your patch, it's already in the tree.
>>=20
>> Yup rebase glitch.
>>=20
>>   .../...
>>=20
>>> I tested it on the 8xx with the below changes in addition. No issue seen
>>> so far.
>>=20
>> Thanks !
>>=20
>> I'll merge that in.
>
> I'm currently working on a refactorisation and simplification of
> exception and syscall entry on ppc32.
>
> I plan to take your patch in my serie as it helps quite a bit. I hope=20
> you don't mind. I expect to come out with a series this week.

Ben's AFK so go ahead and pull it in to your series if that helps you.
=20
>> The main obscure area is that business with the irqsoff tracer and thus
>> the need to create stack frames around calls to trace_hardirqs_* ... we
>> do it in some places and not others, but I've not managed to make it
>> crash either. I need to get to the bottom of that, and possibly provide
>> proper macro helpers like ppc64 has to do it.
>
> I can't see anything special around this in ppc32 code. As far as I=20
> understand, a stack frame is put in place when there is a need to
> save and restore some volatile registers. At the places where nothing=20
> needs to be saved, nothing is done. I think that's the normal way for=20
> any function call, isn't it ?

The concern was that the irqsoff tracer was doing
__builtin_return_address(1) (or some number > 0) and that crashes if
there aren't sufficiently many stack frames available.

See ftrace_return_address.

Possibly the answer is that we don't have CONFIG_FRAME_POINTER and so we
get the empty version of that.

cheers
