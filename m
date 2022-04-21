Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09889C433EF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Apr 2022 06:43:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KkSfD1bxKz3bWt
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Apr 2022 16:43:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=ZPF7oY3I;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KkSdV1KM0z2xtQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2022 16:42:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=ZPF7oY3I; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4KkSdP5XNdz4xPw;
 Thu, 21 Apr 2022 16:42:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1650523338;
 bh=Vq8aQQ7x9r9hQTwpUpgf1xEauPJ2w6wRlIKNaFLmLew=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=ZPF7oY3IzCue7FBk+3C5MWaf+mpnMLrDyUObLKiyVIu6uu+flNUqPxCrQB5OxJjKe
 RuP0uZkNR/rxlznxh95WzEJ0qCv0FngqJICzPdzdqrPh9PBK56zNSUhHXwTYZNjsLY
 Uqj6X7H0QjhzL1tvQas1X8QzWXzGIO68oNfAX0uou7ImeAXv4M57vNt1tVx05MdEs0
 vOz90n53G3mSO7GpDcNrDW8/fkSPNQdPw0akA5HuGsp36Qo9zVHAA48SncDs/MpzJH
 MYRFuF12pnHbaiIKqIVniOpIZ/3OY3MWWKcEV3qUpDlkOhG5KAYART16Dw7LKAKPgz
 KztVnhqzWRypg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Subject: Re: [PATCH] powerpc/time: Always set decrementer in timer_interrupt()
In-Reply-To: <20220420142821.GR163591@kunlun.suse.cz>
References: <20220420141657.771442-1-mpe@ellerman.id.au>
 <20220420142821.GR163591@kunlun.suse.cz>
Date: Thu, 21 Apr 2022 16:42:13 +1000
Message-ID: <87a6cfey4a.fsf@mpe.ellerman.id.au>
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
Cc: miguel.ojeda.sandonis@gmail.com, linuxppc-dev@lists.ozlabs.org,
 npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michal Such=C3=A1nek <msuchanek@suse.de> writes:
> Hello,
>
> On Thu, Apr 21, 2022 at 12:16:57AM +1000, Michael Ellerman wrote:
>> This is a partial revert of commit 0faf20a1ad16 ("powerpc/64s/interrupt:
>> Don't enable MSR[EE] in irq handlers unless perf is in use").
>>=20
>> Prior to that commit, we always set the decrementer in
>> timer_interrupt(), to clear the timer interrupt. Otherwise we could end
>> up continuously taking timer interrupts.
>>=20
>> When high res timers are enabled there is no problem seen with leaving
>> the decrementer untouched in timer_interrupt(), because it will be
>> programmed via hrtimer_interrupt() -> tick_program_event() ->
>> clockevents_program_event() -> decrementer_set_next_event().
>>=20
>> However with CONFIG_HIGH_RES_TIMERS=3Dn or booting with highres=3Doff, we
>
> How difficult is it to detect this condition?
>
> Maybe detecting this could be just added?

We could but it would be quite a hack.

This patch is just meant as a minimal fix to put the code back the way
it's been for the last ~15 years.

I think Nick has identified the problem in the core timing code, so
fixing that should be the right solution.

If that's wrong for some reason then we can do some detection in our
timer_interrupt() to avoid the set_dec() when it's unnecessary.

cheers
