Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F109FC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 11:39:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 411FB204FD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 11:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411FB204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JK1g0DzMzDqHv
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 22:39:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43JJym1PtYzDqVp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 22:36:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43JJyl4Hyhz9sD4;
 Mon, 17 Dec 2018 22:36:47 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc/mm: make NULL pointer deferences explicit on bad
 page faults.
In-Reply-To: <276439ce-aad9-e72f-7bc9-c57fb4a59339@c-s.fr>
References: <42e7e2e9b74af526523fb5a1451fdb29cfe2687a.1539060806.git.christophe.leroy@c-s.fr>
 <87zht9udqh.fsf@concordia.ellerman.id.au>
 <276439ce-aad9-e72f-7bc9-c57fb4a59339@c-s.fr>
Date: Mon, 17 Dec 2018 22:36:42 +1100
Message-ID: <87va3stmet.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Hi Michael,
>
> Le 14/12/2018 =C3=A0 01:57, Michael Ellerman a =C3=A9crit=C2=A0:
>> Hi Christophe,
>>=20
>> You know it's the trivial patches that are going to get lots of review
>> comments :)
>
> I'm so happy to get comments.

Haha :)

>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>> As several other arches including x86, this patch makes it explicit
>>> that a bad page fault is a NULL pointer dereference when the fault
>>> address is lower than PAGE_SIZE
>>=20
>> I'm being pedantic, but it's not necessarily a NULL pointer dereference.
>> It might just be a direct access to a low address, eg:
>>=20
>>   char *p =3D 0x100;
>>   *p =3D 0;
>>=20
>> That's not a NULL pointer dereference.
>>=20
>> But other arches do print this so I guess it's OK to add, and in most
>> cases it will be an actual NULL pointer dereference.
>>=20
>> I wonder though if we should use 4096 rather than PAGE_SIZE, given
>> that's the actual value other arches are using. We support 256K pages on
>> some systems, which is getting quite large.
>
> Those invalid accesses are catched because the first page is marked non=20
> present or non accessible in the page table, so I thing using PAGE_SIZE=20
> here is valid regardless of the page size.

It's not a question of whether we catch the fault it's what we print
when we catch it. Most of the time on 64-bit the first few GB of the
page tables will be empty, so those will all fault, but we don't call
them NULL pointer deferences.

So I'm just saying that this is a heuristic, ie. an access close to zero
is probably an access at a small offset from a NULL pointer, but it may
not be. And so it's kind of arbitrary where we decide to make the cut
off point between printing that it's a NULL pointer vs a regularly bad
access.

Anyway I'm happy to use PAGE_SHIFT for now, if anyone complains we can
always change it.

>> What about:
>>=20
>>    BUG: Unable to handle kernel instruction fetch at 0x00000000
>
> I think we still need to make it explicit that we jumped there due to a=20
> NULL function pointer, allthought I don't have a good text idea yet for=20
> this.

Being pedantic again, we don't know that it was a NULL function pointer.
You might have done a bad setcontext and set your NIP to zero.

But it's probably fine to print it as a hint, and it's probably right
most of the time.

cheers
