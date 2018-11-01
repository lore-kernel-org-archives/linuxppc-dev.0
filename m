Return-Path: <SRS0=OEx3=NM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4C6C0044C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 20:35:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5872B205F4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 20:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Xfu7lthm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5872B205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42mH5Q5gBCzF3P7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 07:35:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Xfu7lthm";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::d41; helo=mail-io1-xd41.google.com;
 envelope-from=dvyukov@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="Xfu7lthm"; 
 dkim-atps=neutral
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42mCMW5JDszF3PR
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Nov 2018 04:47:13 +1100 (AEDT)
Received: by mail-io1-xd41.google.com with SMTP id p83-v6so12790500iod.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Nov 2018 10:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=GZ3g5TRsHSoiWmTwurfiPS0thu9nmyugmKBuMq6OY2A=;
 b=Xfu7lthmFocaTqqm4oUshXSI+8ZnFrLXuhIeV7gzUSUo30oBrQ5Ot2i+XioUneRAvV
 4epi7aEXKZ2l5Szj190g6sKE1JcSxDYxoqp9AwJqy5NgcFR+1OUpVW2rHTdHGgC84w6w
 rJk3BEGQ0GoCNSv6vVGJ2awh2d92AETxPMAx3BFNYBA9qK8vSdDKxs8mYtSAAdQ1vqc7
 2eq2Mr5CwIcdUI3FxTGIrq4yC6nBtV7V0v9o/angn1/tud8AP4QLjqYLwb3oHlZzpLfg
 UNGxORvSLriKk1PMRkRjec2lAKl6K/vaHjWtYefQJ+AXaANzPOLimMazCGwXmaxC/b3S
 x4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=GZ3g5TRsHSoiWmTwurfiPS0thu9nmyugmKBuMq6OY2A=;
 b=l0LQ2RVB66sb6PRu0N75rYedDILoBdfSKkV8CW3H52JmKBfcHqKcARaaRpkgs3ntBL
 K2tkpui8Uy7HB9XntyRtC8nrdQk6xZDU/96EKoTq9FC4dp3ENRtlq16LyUBeslPHyNZU
 OPMFEJ+CSK0+UIpvSPQc7isOjAQHWaBaOOK1SPVM2HxKB+tqTs5Y49J3zwn7IXeTUpbB
 grloFOzXDhRj68+3znWt8akJ9Xl1y/uuYAiGYZqCncJ08+KYb8qtSDnKi17wcRDHz1vX
 f21itB9fuCv+UNuo+IW3x0l1NmJbS4NV3oJuZxHZIF1fdFMkcN40WBAjZchTbvl4aMHh
 aUkA==
X-Gm-Message-State: AGRZ1gL4my3QeGTTbwoTqLUhRRbaPxSO5CIHFz+HJ51/xrmjAHzCR8AG
 CFI4hVw7TxdOGin1Qn0j7AdKaOaY+0DBhdeGtpRQPw==
X-Google-Smtp-Source: AJdET5eg28D2pB1ekw21nVpAOzB/FyaT3cOuFpZ8dio02aUzgoBPNz7gY7dCeb7ej+mqfTI72Lcai/crr0MgJ5sQxfE=
X-Received: by 2002:a6b:9383:: with SMTP id
 v125-v6mr5274871iod.282.1541094431071; 
 Thu, 01 Nov 2018 10:47:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP;
 Thu, 1 Nov 2018 10:46:50 -0700 (PDT)
In-Reply-To: <20181101171846.GI3178@hirez.programming.kicks-ass.net>
References: <1541015538-11382-1-git-send-email-linux@roeck-us.net>
 <20181031213240.zhh7dfcm47ucuyfl@pburton-laptop>
 <20181031220253.GA15505@roeck-us.net>
 <20181031233235.qbedw3pinxcuk7me@pburton-laptop>
 <4e2438a23d2edf03368950a72ec058d1d299c32e.camel@hammerspace.com>
 <20181101131846.biyilr2msonljmij@lakrids.cambridge.arm.com>
 <20181101145926.GE3178@hirez.programming.kicks-ass.net>
 <f38e272f7a96e983549e4281aa9fd02833a4277a.camel@hammerspace.com>
 <20181101163212.GF3159@hirez.programming.kicks-ass.net>
 <20181101170146.GQ4170@linux.ibm.com>
 <20181101171846.GI3178@hirez.programming.kicks-ass.net>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 1 Nov 2018 18:46:50 +0100
Message-ID: <CACT4Y+aC45BtS88DXarn3A+LV2RRRsPQoSs_3_DnKjU4O3AMHQ@mail.gmail.com>
Subject: Re: [RFC PATCH] lib: Introduce generic __cmpxchg_u64() and use it
 where needed
To: Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 02 Nov 2018 07:27:06 +1100
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "jhogan@kernel.org" <jhogan@kernel.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "bfields@fieldses.org" <bfields@fieldses.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "Paul E. McKenney" <paulmck@linux.ibm.com>,
 Trond Myklebust <trondmy@hammerspace.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 "linux@roeck-us.net" <linux@roeck-us.net>, "arnd@arndb.de" <arnd@arndb.de>,
 "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "jlayton@kernel.org" <jlayton@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ralf@linux-mips.org" <ralf@linux-mips.org>,
 "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
 "paul.burton@mips.com" <paul.burton@mips.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 1, 2018 at 6:18 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>> > > > > > My one question (and the reason why I went with cmpxchg() in the
>> > > > > > first place) would be about the overflow behaviour for
>> > > > > > atomic_fetch_inc() and friends. I believe those functions should
>> > > > > > be OK on x86, so that when we overflow the counter, it behaves
>> > > > > > like an unsigned value and wraps back around.  Is that the case
>> > > > > > for all architectures?
>> > > > > >
>> > > > > > i.e. are atomic_t/atomic64_t always guaranteed to behave like
>> > > > > > u32/u64 on increment?
>> > > > > >
>> > > > > > I could not find any documentation that explicitly stated that
>> > > > > > they should.
>> > > > >
>> > > > > Peter, Will, I understand that the atomic_t/atomic64_t ops are
>> > > > > required to wrap per 2's-complement. IIUC the refcount code relies
>> > > > > on this.
>> > > > >
>> > > > > Can you confirm?
>> > > >
>> > > > There is quite a bit of core code that hard assumes 2s-complement.
>> > > > Not only for atomics but for any signed integer type. Also see the
>> > > > kernel using -fno-strict-overflow which implies -fwrapv, which
>> > > > defines signed overflow to behave like 2s-complement (and rids us of
>> > > > that particular UB).
>> > >
>> > > Fair enough, but there have also been bugfixes to explicitly fix unsafe
>> > > C standards assumptions for signed integers. See, for instance commit
>> > > 5a581b367b5d "jiffies: Avoid undefined behavior from signed overflow"
>> > > from Paul McKenney.
>> >
>> > Yes, I feel Paul has been to too many C/C++ committee meetings and got
>> > properly paranoid. Which isn't always a bad thing :-)
>>
>> Even the C standard defines 2s complement for atomics.
>
> Ooh good to know.
>
>> Just not for
>> normal arithmetic, where yes, signed overflow is UB.  And yes, I do
>> know about -fwrapv, but I would like to avoid at least some copy-pasta
>> UB from my kernel code to who knows what user-mode environment.  :-/
>>
>> At least where it is reasonably easy to do so.
>
> Fair enough I suppose; I just always make sure to include the same
> -fknobs for the userspace thing when I lift code.
>
>> And there is a push to define C++ signed arithmetic as 2s complement,
>> but there are still 1s complement systems with C compilers.  Just not
>> C++ compilers.  Legacy...
>
> *groan*; how about those ancient hardwares keep using ancient compilers
> and we all move on to the 70s :-)
>
>> > But for us using -fno-strict-overflow which actually defines signed
>> > overflow, I myself am really not worried. I'm also not sure if KASAN has
>> > been taught about this, or if it will still (incorrectly) warn about UB
>> > for signed types.
>>
>> UBSAN gave me a signed-overflow warning a few days ago.  Which I have
>> fixed, even though 2s complement did the right thing.  I am also taking
>> advantage of the change to use better naming.
>
> Oh too many *SANs I suppose; and yes, if you can make the code better,
> why not.

If there is a warning that we don't want to see at all, then we can
disable it. It supposed to be a useful tool, rather than a thing in
itself that lives own life. We already I think removed 1 particularly
noisy warning and made another optional via a config.
But the thing with overflows is that, even if it's defined, it's not
necessary the intended behavior. For example, take allocation size
calculation done via unsigned size_t. If it overflows it does not help
if C defines result or not, it still gives a user controlled write
primitive. We've seen similar cases with timeout/deadline calculation
in kernel, we really don't want it to just wrap modulo-2, right. Some
user-space projects even test with unsigned overflow warnings or
implicit truncation warnings, which are formally legal, but frequently
bugs.
