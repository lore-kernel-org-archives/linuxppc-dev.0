Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	TVD_SUBJ_WIPE_DEBT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A789BC432BE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Aug 2021 01:29:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8F060EFE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Aug 2021 01:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C8F060EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gwhvd5JGMz306n
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Aug 2021 11:29:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=NA9GElv4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634;
 helo=mail-pl1-x634.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=NA9GElv4; dkim-atps=neutral
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gwhtr5dNmz2yK3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Aug 2021 11:28:35 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id e15so2896208plh.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Aug 2021 18:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=sW8AGYIk/UaGtGqdRe+NjeOpRZWC7qxLFst7xNdC0P0=;
 b=NA9GElv4yx2yFAsW8GYz0PWrtd793+HB9JwiDJjGJeG9ze2sjL8rd5kEvMeSagaIhu
 plKh710FVM8K7UIHpjWJ5vixYMm7MV5nROhYAYEw9zCGNAhaXlEj/kYY3KgR7/WLP6nL
 oeNsuz0Cv7nqhqDF1UjRH0BC6H4jQ+lhdo5F6BLdXCd7xIyjesNPbCCRGAdFXiv2Z6h8
 A8tDhe4R4JnWx36RHXRgoqQqxfMy35tvryWao1PpGKvw2H49s3aevoHsSKMpQH6r49am
 BWIxAmhpgaqxJZqh1uBC4R5APVJktAY0PrPkF6NL8bskHktZJc+SJKInoNXYgY9w8rJd
 wT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=sW8AGYIk/UaGtGqdRe+NjeOpRZWC7qxLFst7xNdC0P0=;
 b=arqGSc+n8VCxgXO3UssJQG+07aCa3bufFi+Nt9mA09WuFrRvHaT/2CLsrW9gvGZ7uJ
 rS+2YI05/NS7phFZ2jUNUB8eTU8aQSf94eeJlJGLk0eEDQF6BToQd7+BEzGPmZ7ZGVmr
 MEG5nXxnDReUunyWgoS0gEK9t1op6zDVZjbWTAU+JzxnfldaA+wFotSxrOSsEhiqyDR6
 qNLx4YtwChxTQpYfUWPpN1hvGGlTWpArTHxyTVPSYfsYdHYcYhWtqKacmIpejzJ9uyc/
 RRzsigJRJtn7r+JWF4XGJMfRjfIsjrA/Yz9To1I5lATdkoeNyAXY7SbOAUzUeAtpwV25
 +GKw==
X-Gm-Message-State: AOAM5310qJ23IRiRfyJao/A4/N/IDFlE/Ekd8PquDFtUEtQTnKpObQyw
 Y8A4/pXYx2PnhZsKDPMmmxA=
X-Google-Smtp-Source: ABdhPJwlZNJmjEB36AnHjCJJwKiJSOBKwTPeBc0R+VveBiO4pUkDqmT6pw2Bq6rUOWaeLIECUwCZRg==
X-Received: by 2002:a17:90b:360c:: with SMTP id
 ml12mr19108240pjb.158.1630027713636; 
 Thu, 26 Aug 2021 18:28:33 -0700 (PDT)
Received: from localhost (220-244-72-10.tpgi.com.au. [220.244.72.10])
 by smtp.gmail.com with ESMTPSA id d22sm4635766pgi.73.2021.08.26.18.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Aug 2021 18:28:33 -0700 (PDT)
Date: Fri, 27 Aug 2021 11:28:27 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 1/2] powerpc/bug: Remove specific powerpc BUG_ON() and
 WARN_ON() on PPC32
To: Segher Boessenkool <segher@kernel.crashing.org>
References: <b286e07fb771a664b631cd07a40b09c06f26e64b.1618331881.git.christophe.leroy@csgroup.eu>
 <1628834356.pr4zgn1xf1.astroid@bobo.none>
 <20210818150653.GJ1583@gate.crashing.org>
 <1629946707.f6ptz0tgle.astroid@bobo.none>
 <20210826124901.GY1583@gate.crashing.org>
 <1629983260.5jkx2jf0y8.astroid@bobo.none>
 <20210826143708.GC1583@gate.crashing.org>
 <1629989540.drlhb24t2w.astroid@bobo.none>
 <20210826153048.GD1583@gate.crashing.org>
In-Reply-To: <20210826153048.GD1583@gate.crashing.org>
MIME-Version: 1.0
Message-Id: <1630026648.b7bpnt3hrh.astroid@bobo.none>
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
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Segher Boessenkool's message of August 27, 2021 1:30 am:
> On Fri, Aug 27, 2021 at 01:04:36AM +1000, Nicholas Piggin wrote:
>> Excerpts from Segher Boessenkool's message of August 27, 2021 12:37 am:
>> >> No, they are all dispatched and issue to the BRU for execution. It's=20
>> >> trivial to construct a test of a lot of not taken branches in a row
>> >> and time a loop of it to see it executes at 1 cycle per branch.
>> >=20
>> > (s/dispatched/issued/)
>>=20
>> ?
>=20
> Dispatch is from decode to the issue queues.  Issue is from there to
> execution units.  Dispatch is in-order, issue is not.

I know what those mean, I wonder what your s/dispatched/issued means.
I was saying they are dispatched in response to you saying they never
hit the issue queue.

>=20
>> >> How could it validate prediction without issuing? It wouldn't know wh=
en
>> >> sources are ready.
>> >=20
>> > In the backend.  But that is just how it worked on older cores :-/
>>=20
>> Okay. I don't know about older cores than POWER9. Backend would normally=
=20
>> include execution though.
>> Only other place you could do it if you don't
>> issue/exec would be after it goes back in order, like completion.
>=20
> You do not have to do the verification in-order: the insn cannot finish
> until it is no longer speculative, that takes care of all ordering
> needed.

Branches *can* finish out of order and speculative as they do in P9 and=20
P10. Are you talking about these CPUs or something else which can=20
verify branches without issuing them?

>=20
>> But that would be horrible for mispredict penalty.
>=20
> See the previous point.  Also, any insn known to be mispredicted can be
> flushed immediately anyway.

The point is it has to know sources (CR) to verify (aka execute) the=20
branch prediction was right, and if it needs sources then it needs to=20
either issue and execute in the out of order part, or it needs to wait
until completion which would seem to be prohibitively expensive. I am
interested to know how it works.

>=20
>> >> >> The first problem seems like the show stopper though. AFAIKS it wo=
uld=20
>> >> >> need a special builtin support that does something to create the t=
able
>> >> >> entry, or a guarantee that we could put an inline asm right after =
the
>> >> >> builtin as a recognized pattern and that would give us the instruc=
tion
>> >> >> following the trap.
>> >> >=20
>> >> > I'm not quite sure what this means.  Can't you always just put a
>> >> >=20
>> >> > bla:	asm("");
>> >> >=20
>> >> > in there, and use the address of "bla"?
>> >>=20
>> >> Not AFAIKS. Put it where?
>> >=20
>> > After wherever you want to know the address after.  You will have to
>> > make sure they stay together somehow.
>>=20
>> I still don't follow.
>=20
> some_thing_you_want_to_know_the_address_after_let_us_call_it_A;
> empty_asm_that_we_can_take_the_address_of_known_as_B;
>=20
> You have to make sure the compiler keeps A and B together, does not
> insert anything between them, does put them in the assembler output in
> the same fragment, etc.

How does all this help our problem of putting the address of the trap=20
into the table?

>=20
>> If you could give a built in that put a label at the address of the trap=
=20
>> instruction that could be used later by inline asm then that could work
>> too:
>>=20
>>     __builtin_labeled_trap("1:");
>>     asm ("    .section __bug_table,\"aw\"  \n\t"
>>          "2:  .4byte 1b - 2b               \n\t"
>>          "    .previous");
>=20
> How could a compiler do anything like that?!

How could it add a label at the trap instruction it generates? It didn't=20
seem like an outlandish thing to do, but I'm not a compiler writer. It was=20
just a handwaving idea to show what we want to be able to do.

Thanks,
Nick
