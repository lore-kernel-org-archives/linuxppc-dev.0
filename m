Return-Path: <SRS0=Efpx=BA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD42C433E1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2020 11:22:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EA2220702
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2020 11:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mu8Irwtk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA2220702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B9x56550ZzDqWd
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2020 21:22:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::443;
 helo=mail-wr1-x443.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=mu8Irwtk; dkim-atps=neutral
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B9x395tL1zDqWc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2020 21:20:20 +1000 (AEST)
Received: by mail-wr1-x443.google.com with SMTP id z2so20861868wrp.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2020 04:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=cgE7yCvC2TsM3N9RxN0ivNvrTATSLMzpTj/dTB9AGDk=;
 b=mu8Irwtky5HM+EiEeEeJR5ujsfvK+4dRAQRaaVcc7HsqkvVK5OdZ66y3jHwGTwX8Cu
 zczEMY4FPKkfMJPyqoq/zEQTDqVrWHiKq35CWL+NseYxjRUXqM17lsfcA3S2fUbacz4F
 paoMeJ2RbHu5MMFCr9bSA1dbKVqhP5CQFlBIRXxKK2DBfodI5dmWrdix02VwYwBLvq7Y
 TftEIFzy6Oqpsf3KxqPjswQGUu4zx2fkccY9iW9azevcnJDENK3yYmxXnT8KmtHnkU+O
 QAlb9uxvjbo6Lx3o/O/kQVN+N4n65xMKivLjHruWEFxL5BOP2ogapw3UZF/MG5dgU8Tv
 2Uxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=cgE7yCvC2TsM3N9RxN0ivNvrTATSLMzpTj/dTB9AGDk=;
 b=d2Q9hh5a6tSsoPcW9WlN6SNnJGbm2STzzSltvcmOP8ZjwIC5ExI11Hslolnx557GWD
 glpf5ckcp3ZGCi+S4DybE8yeyI6BjRPsQGk3I/9U1mN6x+W8u1dPW4xhR2w+jeQARXd+
 Hi3lF8s0yzM2j9E6pje9X0RL4oLmb3fNauidYlw8p/ocVUV2Uohg8Gfixp20FTNJ1UCD
 JpiqjK4L2jnc7u/luR3KPtXzf/FhTdYUxZmxRrvCqTGoGzhTBkyJLr4wqbAUPhHY8xnz
 y3ZycEv36Wbd4CIrJxgTSmjJ3WiMuV0P1Z8ohtz5j0xlIJc+PngkABzcSH3YTWEHfh2Y
 4IMQ==
X-Gm-Message-State: AOAM533Nm5NV8Y9Ved7/3R6nDd6usIuKhzBQmf3G2dpcgGy9DZg5N/wL
 X+aVRCY4apNQFVn+elMBuIErjZQs
X-Google-Smtp-Source: ABdhPJwmCaJOo8AdzQqS2eChCE+7XLE3Au1lXisG7/a/kYL/4vC9x9VNW5OotawEVy00sIUB49kphA==
X-Received: by 2002:adf:de12:: with SMTP id b18mr28232045wrm.390.1595330417294; 
 Tue, 21 Jul 2020 04:20:17 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
 by smtp.gmail.com with ESMTPSA id c188sm3106579wma.22.2020.07.21.04.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 04:20:16 -0700 (PDT)
Date: Tue, 21 Jul 2020 21:20:09 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
To: Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
 <1594101082.hfq9x5yact.astroid@bobo.none>
 <20200708084106.GE597537@hirez.programming.kicks-ass.net>
 <a9834278-25bf-90e9-10f2-cd10e5407ff6@redhat.com>
 <20200709083113.GI597537@hirez.programming.kicks-ass.net>
In-Reply-To: <20200709083113.GI597537@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1595329799.y24rka8cv4.astroid@bobo.none>
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
Cc: linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Peter Zijlstra's message of July 9, 2020 6:31 pm:
> On Wed, Jul 08, 2020 at 07:54:34PM -0400, Waiman Long wrote:
>> On 7/8/20 4:41 AM, Peter Zijlstra wrote:
>> > On Tue, Jul 07, 2020 at 03:57:06PM +1000, Nicholas Piggin wrote:
>> > > Yes, powerpc could certainly get more performance out of the slow
>> > > paths, and then there are a few parameters to tune.
>> > Can you clarify? The slow path is already in use on ARM64 which is wea=
k,
>> > so I doubt there's superfluous serialization present. And Will spend a
>> > fair amount of time on making that thing guarantee forward progressm, =
so
>> > there just isn't too much room to play.
>> >=20
>> > > We don't have a good alternate patching for function calls yet, but
>> > > that would be something to do for native vs pv.
>> > Going by your jump_label implementation, support for static_call shoul=
d
>> > be fairly straight forward too, no?
>> >=20
>> >    https://lkml.kernel.org/r/20200624153024.794671356@infradead.org
>> >=20
>> Speaking of static_call, I am also looking forward to it. Do you have an
>> idea when that will be merged?
>=20
> 0day had one crash on the last round, I think Steve send a fix for that
> last night and I'll go look at it.
>=20
> That said, the last posting got 0 feedback, so either everybody is
> really happy with it, or not interested. So let us know in the thread,
> with some review feedback.
>=20
> Once I get through enough of the inbox to actually find the fix and test
> it, I'll also update the thread, and maybe threaten to merge it if
> everybody stays silent :-)

I'd like to use it in powerpc. We have code now for example that patches=20
a branch immediately at the top of memcpy which branches to a different=20
version of the function. pv queued spinlock selection obviously, and
there's a bunch of platform ops struct things that get filled in at boot=20
time, etc.

So +1 here if you can get them through. I'm not 100% sure we can do
it with existing toolchain and no ugly hacks, but there's no way to
structure things that can get around that AFAIKS. We'd eventually
use it though, I'd say.

Thanks,
Nick
