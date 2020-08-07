Return-Path: <SRS0=mIln=BR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52E2C433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2020 02:47:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C84D21744
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2020 02:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="MPMsNyeT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C84D21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BN8st2r1fzDqvw
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2020 12:47:46 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BN8pN3DvkzDqNR
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2020 12:44:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=MPMsNyeT; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BN8pM1JlRz9sSG;
 Fri,  7 Aug 2020 12:44:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1596768284;
 bh=FZuIxnPjJkYxCWMXw2mxcRhOKtZPN4eNLc1MN/Gupm4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=MPMsNyeTn9a8d9v3fgyBEE07kO0XqO2/i5FfHbv9CyGV1GB8vH5IhwduGCenlTyPB
 ZYSTBZwtvBB0vFIwr9kUfvEI14D2YJ+gHaFR6FA0sPDvCvxxFpFSONBUyKuBg6bQrl
 U9VW0RJcVFHSTynki4Fz+vwmS8SG1pYoKBL8wXe5ZlwAHzfgPoLNq0GieUdNAoZ+BB
 aCj1+BSpCjXIY8vLjuh8Fnr9vMoJ/8a5RLgie/8bnzElqwrwFdXKgkTjYYEeC4F4J3
 Mq7Rofv/RlSpKFLB5N2LIsV4DPkQotvYf740maIf3gyM1ZynE1dEGGcRvdpomw+GSx
 P0t+HR6XtxnGA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v8 5/8] powerpc/vdso: Prepare for switching VDSO to
 generic C implementation.
In-Reply-To: <20200806183316.GV6753@gate.crashing.org>
References: <cover.1588079622.git.christophe.leroy@c-s.fr>
 <2a67c333893454868bbfda773ba4b01c20272a5d.1588079622.git.christophe.leroy@c-s.fr>
 <878sflvbad.fsf@mpe.ellerman.id.au>
 <65fd7823-cc9d-c05a-0816-c34882b5d55a@csgroup.eu>
 <87wo2dy5in.fsf@mpe.ellerman.id.au> <20200805133505.GN6753@gate.crashing.org>
 <87r1sky1hm.fsf@mpe.ellerman.id.au> <20200806183316.GV6753@gate.crashing.org>
Date: Fri, 07 Aug 2020 12:44:42 +1000
Message-ID: <87mu37xjhh.fsf@mpe.ellerman.id.au>
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
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, nathanl@linux.ibm.com,
 arnd@arndb.de, linux-kernel@vger.kernel.org,
 Tulio Magno Quites Machado Filho <tuliom@linux.ibm.com>,
 Paul Mackerras <paulus@samba.org>, luto@kernel.org, linux-arch@vger.kernel.org,
 tglx@linutronix.de, vincenzo.frascino@arm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Thu, Aug 06, 2020 at 12:03:33PM +1000, Michael Ellerman wrote:
>> Segher Boessenkool <segher@kernel.crashing.org> writes:
>> > On Wed, Aug 05, 2020 at 04:24:16PM +1000, Michael Ellerman wrote:
>> >> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> >> > Indeed, 32-bit doesn't have a redzone, so I believe it needs a stack 
>> >> > frame whenever it has anything to same.
>
> ^^^
>
>> >> >     fbb60:	94 21 ff e0 	stwu    r1,-32(r1)
>> >
>> > This is the *only* place where you can use a negative offset from r1:
>> > in the stwu to extend the stack (set up a new stack frame, or make the
>> > current one bigger).
>> 
>> (You're talking about 32-bit code here right?)
>
> The "SYSV" ELF binding, yeah, which is used for 32-bit on Linux (give or
> take, ho hum).
>
> The ABIs that have a red zone are much nicer here (but less simple) :-)

Yep, just checking I wasn't misunderstanding your comment about negative
offsets.

>> >> At the same time it's much safer for us to just save/restore r2, and
>> >> probably in the noise performance wise.
>> >
>> > If you want a function to be able to work with ABI-compliant code safely
>> > (in all cases), you'll have to make it itself ABI-compliant as well,
>> > yes :-)
>> 
>> True. Except this is the VDSO which has previously been a bit wild west
>> as far as ABI goes :)
>
> It could get away with many things because it was guaranteed to be a
> leaf function.  Some of those things even violate the ABIs, but you can
> get away with it easily, much reduced scope.  Now if this is generated
> code, violating the rules will catch up with you sooner rather than
> later ;-)

Agreed.

cheers
