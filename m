Return-Path: <linuxppc-dev+bounces-23451-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9630C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 20:46:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grpnP5dMqz2yN8;
	Fri, 03 Jul 2026 06:46:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783025161;
	cv=none; b=KTbFpbNjER/L9vw7+nwIsydfprib6L7clyfAetPdBb5DQ5Bz/SR8rbDHCTzTbWiEcoX+PLLkANEUNMsBhOOoigx4GVthqiaLsOjSr39LEGBYn1399Rv+HYvjH+ia/6kyYnHnzTJ+ntHTVdIl5wrEbWODOqjYMf2hRuDNZ46TalFiTk4J3tz0Osoegs04DZr0Z/+Sw+vdGOw++krYcjAQCXjtrS4dbbqgxvQg0QUmJ0IFmBWZMYJCcPtw++EUL3kcvQ8s/Gwb4ruWMDLN7Txdx1eREn5LFLxIB6rIMpWhNQF5ss6z5mJfPupU4CVaeZSb8SouQwtnFfSA0rynd3/4Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783025161; c=relaxed/relaxed;
	bh=RgKO/UZyvy5Z38gyC0IxY1FJQhRYi6rg13CXydLdQY0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RTxarB3TNQphA71ya48iEDCcGUuomY+Se7T2/F1ykm1/qkfuolDGDIUCzBmogLuOURFXKXNvYP5BpWxLwWDYzfrYWBnHaDY/hB/IsW0f0G7oStqYIHTDsPoE62dQ0Q7OwP5WGIrreRP4VWqnTbQgvFte6mix2cxNLfVN2DXcR0z9RKUtqpWZtd3ShQMi0jwmX9w1D8DrXfX1Ta1fKp0e6R2hRlTmXRpjmsCkn406kqmHV9mLWOQIc3o792RPTNsuxmaKIptsfwZC9BHx2G39ni1PuFmW9dx1ty9VUvq45VBpplZcQqCq20KNXDXkI/bjsubVxMhC5rY1QcG+GKo0mA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UaD5CREX; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UaD5CREX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grpnN22N4z2yMn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 06:46:00 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 677034013B;
	Thu,  2 Jul 2026 20:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E22A1F000E9;
	Thu,  2 Jul 2026 20:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783025157;
	bh=RgKO/UZyvy5Z38gyC0IxY1FJQhRYi6rg13CXydLdQY0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=UaD5CREX6zIC4y3TKyphGTRRC28mz0dermBnriIDo4VJeBY/fdSm+bo4SMeeqxcg4
	 2nZAzjliM6+hr13yB3w26OsBLeq2/LrH4mPoYTvdvIoIgX7/pLVzQh7YACklPUTPLp
	 FLllWVPCLOhkab1Df0IWNyhs3Ywb2DxH7ixWEd8w6zgUPmPOydjr19iHGh9HjLcZ4F
	 9UCuRvgiy4zhYBZoDyEW5Z9msFbTaIp5y2F8IW6O+Mb0197Xa/ngseuyyyv0Wudwne
	 iFoJGUnjorvAS2hYs4zLCLoOB5VYqaG8YVDJzvMwOcYqcJ7sZ/KrRKbchO6zN9ftrj
	 z/YENEra/5DFg==
From: Thomas Gleixner <tglx@kernel.org>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Andrew Donnellan <andrew+kernel@donnellan.id.au>, Mark
 Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Ryan Roberts <ryan.roberts@arm.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Mukesh Kumar Chaurasiya
 <mkchauras@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Zong
 Li <zong.li@sifive.com>, Nam Cao <namcao@linutronix.de>, Deepak Gupta
 <debug@rivosinc.com>, Lukas Gerlach <lukas.gerlach@cispa.de>, Rui Qi
 <qirui.001@bytedance.com>, Kees Cook <kees@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [RFC] entry: Untangle the return value of
 syscall_enter_from_user_mode from syscall NR
In-Reply-To: <akZPakNl6JT_jgGd@kunlun.suse.cz>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz> <878q7tprau.ffs@fw13>
 <akZPakNl6JT_jgGd@kunlun.suse.cz>
Date: Thu, 02 Jul 2026 22:45:54 +0200
Message-ID: <87jyrdnmrh.ffs@fw13>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 02 2026 at 13:45, Michal Such=C3=A1nek wrote:
> On Thu, Jul 02, 2026 at 01:24:57PM +0200, Thomas Gleixner wrote:
>> On Wed, Jul 01 2026 at 19:42, Michal Such=C3=A1nek wrote:
>> > The return value of syscall_enter_from_user_mode is used both for the
>> > adjusted syscall number and the indicator that a syscall should be
>> > skipped.
>> >
>> > As seccomp can be invoked on any syscall, including invalid ones this
>> > somewhat undermines seccomp.
>> >
>> > While the seccomp variants that terminate the process do not need to
>> > care about this for the filter that sets the syscall return value this
>> > disctinction is required.
>>=20
>> You completely fail to explain why and what actual problem you are
>> trying to solve. At least I can't figure it out from the above word
>> salad.
>
> syscall_enter_from_user_mode returns the new syscall number after doing
> something arbitrarry with it, including running seccomp.
>
> Wehn the syscall is already handled, eg. by seccomp filtering it returns
> -1 as the new syscall number. -1 is an invalid syscall number but it can
> still be filtered by seccomp.

Once syscall_enter_from_user_mode() returns -1 nothing can filter it
anymore.

> When the syscall number was -1 to start with it's not possible to
> determine if the syscall was fileterd from the return value. s390
> returns the filtered state in a flag it sets on the regs structure,
> avoiding this problem.

What needs to determine whether the syscall was filtered or not?

> However, the API should be specified in a way that does not require
> everyone implementing such flag.

Which exact problem does the flag solve?

>> > -	instrumentation_begin();
>> > -	if (!invoke_syscall(regs, nr) && nr !=3D -1)
>> > -	 	result_reg(regs) =3D __sys_ni_syscall(regs);
>> > -	instrumentation_end();
>> > +	/* Skip syscall when -1 is returned */
>> > +	if (!syscall_enter_from_user_mode(regs, &nr)) {
>>=20
>> Seriously?
>>=20
>> If we go and separate the syscall number from the return value, then the
>> return value 0 means success and anything else fail. Which in other
>> words is a boolean. So instead of tastelessly adding a completely
>> nonsensical comment about -1 here, syscall_enter_from_user_mode() wants
>> to have the return value type bool with a proper boolean logic: true =3D
>> success, false =3D abort.
>
> We have that very same API down to __secure_computing() which returns
> boolean represented as -1 and 0 values. That does not mean it's not
> tasteless.

Hahahahaha.

We have a lot of functions which have a boolean return value but a
int/long return type for historical reasons.

We've added bool because it's not ambiguous and allows the compiler to
optimize better. It also makes the code more clear. Modern code uses a
non-boolean return type only when there is an actual reason for it,
e.g. propagating an error code all the way back through the call chain.
The historical 0=3Dsuccess <0 =3D errorcode model really want's to be
restricted to such cases.

Just for the record:

  https://lore.kernel.org/all/67c3ae5c-d88b-4172-9996-4e2046b7e0dc@huawei.c=
om/
  https://lore.kernel.org/all/20260629130616.642022-2-ruanjinjie@huawei.com/

So I stand with my comment that it is sloppy and tasteless to slap an
argument into a pile of functions, claim separation of return value and
syscall number and leave the return value in an ill-defined state.

>> > @@ -168,8 +168,7 @@ __visible noinstr void do_int80_emulation(struct p=
t_regs *regs)
>> >  	nr =3D syscall_32_enter(regs);
>> >=20=20
>> >  	local_irq_enable();
>> > -	nr =3D syscall_enter_from_user_mode_work(regs, nr);
>> > -	do_syscall_32_irqs_on(regs, nr);
>> > +	syscall_enter_from_user_mode_work(regs, &nr);
>>=20
>> How exactly is this ever going to invoke a valid syscall?
>
> That's one of the problems with giant all-in-one patch, things like this
> easily slip in. However, it is in cluded mostly for illustration, I
> don't expect anyone to merge this as-is.

It's a problem with hastily cobbled together slop. Even RFC patches
should at least be functional.
=20
>> > +	if (!syscall_enter_from_user_mode_work(regs, &nr)) {
>> > +		nr &=3D GENMASK(31, 0);
>> > +		do_syscall_32_irqs_on(regs, nr);
>>=20
>>   do_syscall_32_irqs_on(regs, (int)nr);
>>=20
>> would be too simple, right?
>
> Also way less explicit.

Now you care about explicit, but the return value mess can be left
ambiguous, right?

Aside of that, the cast is very much explicit for people who can read C.

It would be great if you could sit back and come up with a very explicit
and comprehensible explanation for the problem you are trying to solve.

Thanks,

        tglx

