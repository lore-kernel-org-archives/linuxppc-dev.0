Return-Path: <SRS0=LND+=BN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29313C433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 11:11:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6F320719
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 11:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ecphZuxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6F320719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BKwDp6BZHzDqS1
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 21:11:22 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BKwBp0QR9zDqDK
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2020 21:09:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=ecphZuxZ; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BKwBn2Nw4z9s1x;
 Mon,  3 Aug 2020 21:09:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1596452977;
 bh=IWLgPiM5I4iS04rZIDQceT85UcRl8lxf9/puQ2anwzY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=ecphZuxZTp4KL4PZQFZx3hXIVFT8iC4x4reVm8yUIMNGTiVWCDYrO5DKas7nXo/0H
 Q667aiyV8KzSz/LQWFHXPvblMYfNtPeWbthrpuWeGwNKtpSTCNwaRPjUdpqb1mEHmu
 BGECtuEciWPNEZmLJ5pK630dMEojbyIJjazZB3ql1nVudiaeLgaSAk52TpSHMFVXWx
 J2N0qj8rIFr/NLEj/bmHi9hGtM2nr/nlXyM+fopB7zS8Um8CG07ZGPHuv7kDaq4hRs
 6ZxtpNjVGaRq/D7jN85MkDbQxm2AaI3qdmG8djKbgpgbuiLblgYmFG4lVkVG7G7RQc
 5O74oR7BcTxiQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/boot: Use address-of operator on section symbols
In-Reply-To: <CAMuHMdUmHE-KVQuo=b2rn9EPgmnqSDi4i16NPbL5rXLLSCoyKg@mail.gmail.com>
References: <20200624035920.835571-1-natechancellor@gmail.com>
 <CAMuHMdU_KfQ-RT_nev5LgN=Vj_P97Fn=nwRoC6ZREFLa3Ysj7w@mail.gmail.com>
 <20200720210252.GO30544@gate.crashing.org>
 <CAMuHMdUmHE-KVQuo=b2rn9EPgmnqSDi4i16NPbL5rXLLSCoyKg@mail.gmail.com>
Date: Mon, 03 Aug 2020 21:09:36 +1000
Message-ID: <87zh7cyoi7.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Arnd Bergmann <arnd@arndb.de>, Geoff Levand <geoff@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>,
 Nathan Chancellor <natechancellor@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Geert Uytterhoeven <geert@linux-m68k.org> writes:
> On Mon, Jul 20, 2020 at 11:03 PM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
>> On Sat, Jul 18, 2020 at 09:50:50AM +0200, Geert Uytterhoeven wrote:
>> > On Wed, Jun 24, 2020 at 6:02 AM Nathan Chancellor
>> > <natechancellor@gmail.com> wrote:
>> > >         /* If we have an image attached to us, it overrides anything
>> > >          * supplied by the loader. */
>> > > -       if (_initrd_end > _initrd_start) {
>> > > +       if (&_initrd_end > &_initrd_start) {
>> >
>> > Are you sure that fix is correct?
>> >
>> >     extern char _initrd_start[];
>> >     extern char _initrd_end[];
>> >     extern char _esm_blob_start[];
>> >     extern char _esm_blob_end[];
>> >
>> > Of course the result of their comparison is a constant, as the addresses
>> > are constant.  If clangs warns about it, perhaps that warning should be moved
>> > to W=1?
>> >
>> > But adding "&" is not correct, according to C.
>>
>> Why not?
>>
>> 6.5.3.2/3
>> The unary & operator yields the address of its operand.  [...]
>> Otherwise, the result is a pointer to the object or function designated
>> by its operand.
>>
>> This is the same as using the name of an array without anything else,
>> yes.  It is a bit clearer if it would not be declared as array, perhaps,
>> but it is correct just fine like this.
>
> Thanks, I stand corrected.
>
> Regardless, the comparison is still a comparison between two constant
> addresses, so my fear is that the compiler will start generating
> warnings for that in the near or distant future, making this change
> futile.

They're not constant at compile time though. So I don't think the
compiler could (sensibly) warn about that? (surely!)

cheers

