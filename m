Return-Path: <SRS0=PwIb=H5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F4DC433DB
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Feb 2021 00:56:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF2364EBA
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Feb 2021 00:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF2364EBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DnSkq5srNz3cnV
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Feb 2021 11:56:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=Q99f8hSD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b;
 helo=mail-pj1-x102b.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Q99f8hSD; dkim-atps=neutral
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DnSkL0zBWz3cL4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Feb 2021 11:55:35 +1100 (AEDT)
Received: by mail-pj1-x102b.google.com with SMTP id o6so7092728pjf.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2021 16:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=WbhoV+EhT9xDqYu+Psiz7bSbboeYh+LR933V/idLc/I=;
 b=Q99f8hSDZ6dNPuZdp4+AXFGu5PQ0e8+RDYAeDtDwPllALV/vrY7zgvq6itYRyjIAwO
 ndfITycOhyz0eMi6A4KJlhW2bZoxM0kEnFUZIHijsmgKbSkueCebkhhAlzZdih03FELd
 aEHxVV9OSUTZN+z02ISbCvXad9DBDGNzayOWu8mP+08S4i28Mj4GKlxu8aClaovZlv6I
 DCg/GZ6rkRO54oa6jjAWVNDanT1NXZ7TAVhQzi2aFV/u7a4SEMoLzBrzUWbrXxJ8N3MW
 nruO7smEmxMpuhWh99k2uaNwTqSEKH+eV7KsYr2NcapOe4zfa3HJTGa3/7RePqtNtNy5
 WfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=WbhoV+EhT9xDqYu+Psiz7bSbboeYh+LR933V/idLc/I=;
 b=W/3d9Zz87XYLhwTgZwoPeiQt6+lDSIyPPvGK9KqzGUbOQGk0Op99EENYZr7GtFppTm
 KLrfu5rSgF8jewPM8zgyu7+jK6+pHXdZew4LMDqacHbBOFXdOcVQo87aJ6TNMdqEhENX
 PyCMQWNRT62VhpihG0rJxFpUkqSECTMZdun4g3eA6pvMpvK8o/hLDjtyGGNUyHyoN0JV
 DrJ6xFnfUiGj1UVkNJmlYoWkHbP73g0nGzX6klnMSOflBi/umMnbeDketNzoN/IdaMde
 8d10e+VoaWLSG4qCYDJBMH/x4eovBLtmfwyyLjXGZ66ktoWX/01O9TzlsDkpHWjx5smr
 yCrg==
X-Gm-Message-State: AOAM530by/+PzqZ5/FIVLb7qlRZxkt3+A2kEX/dL6NuadzAAfCu2C6J/
 N5jvv2L1ia1G8Tv11vxD1EA=
X-Google-Smtp-Source: ABdhPJxKxSHskjlilN0pG+HI/4GgLy4EwSoyEtlGJ5u9BW4afDwHxxaPsiKm6Zk1ysfSRHBDxxH9rQ==
X-Received: by 2002:a17:90a:8:: with SMTP id 8mr5989397pja.6.1614387332652;
 Fri, 26 Feb 2021 16:55:32 -0800 (PST)
Received: from localhost (58-6-239-121.tpgi.com.au. [58.6.239.121])
 by smtp.gmail.com with ESMTPSA id 3sm11055505pfd.45.2021.02.26.16.55.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Feb 2021 16:55:32 -0800 (PST)
Date: Sat, 27 Feb 2021 10:55:26 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 23/37] KVM: PPC: Book3S HV P9: Implement the rest of
 the P9 path in C
To: Fabiano Rosas <farosas@linux.ibm.com>, kvm-ppc@vger.kernel.org
References: <20210225134652.2127648-1-npiggin@gmail.com>
 <20210225134652.2127648-24-npiggin@gmail.com> <87y2fawj4n.fsf@linux.ibm.com>
 <1614384320.mv2klmakck.astroid@bobo.none>
In-Reply-To: <1614384320.mv2klmakck.astroid@bobo.none>
MIME-Version: 1.0
Message-Id: <1614387292.p913p71yw8.astroid@bobo.none>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Nicholas Piggin's message of February 27, 2021 10:21 am:
> Excerpts from Fabiano Rosas's message of February 27, 2021 8:37 am:
>> Nicholas Piggin <npiggin@gmail.com> writes:
>>=20
>> Hi, thanks for this. It helped me clarify a bunch of details that I
>> haven't understood while reading the asm code.
>=20
> Yes, me too :)
>=20
>>> +/*
>>> + * void kvmppc_p9_enter_guest(struct vcpu *vcpu);
>>> + *
>>> + * Enter the guest on a ISAv3.0 or later system where we have exactly
>>> + * one vcpu per vcore, and both the host and guest are radix, and thre=
ads
>>> + * are set to "indepdent mode".
>>> + */
>>> +.balign	IFETCH_ALIGN_BYTES
>>> +_GLOBAL(kvmppc_p9_enter_guest)
>>> +EXPORT_SYMBOL_GPL(kvmppc_p9_enter_guest)
>>> +	mflr	r0
>>> +	std	r0,PPC_LR_STKOFF(r1)
>>> +	stdu	r1,-SFS(r1)
>>> +
>>> +	std	r1,HSTATE_HOST_R1(r13)
>>> +	std	r3,STACK_SLOT_VCPU(r1)
>>=20
>> The vcpu was stored on the paca previously. I don't get the change,
>> could you explain?
>=20
> The stack is a nicer place to keep things. We only need one place to=20
> save the stack, then most things can come from there. There's actually=20
> more paca stuff we could move into local variables or onto the stack
> too.
>=20
> It was probably done like this because PR KVM which probably can't=20
> access the stack in real mode when running in an LPAR, and came across=20
> to the HV code that way. New path doesn't require it.
>=20
>>> +kvmppc_p9_exit_interrupt:
>>> +	std     r1,HSTATE_SCRATCH1(r13)
>>> +	std     r3,HSTATE_SCRATCH2(r13)
>>> +	ld	r1,HSTATE_HOST_R1(r13)
>>> +	ld	r3,STACK_SLOT_VCPU(r1)
>>> +
>>> +	std	r9,VCPU_CR(r3)
>>> +
>>> +1:
>>> +	std	r11,VCPU_PC(r3)
>>> +	std	r12,VCPU_MSR(r3)
>>> +
>>> +	reg =3D 14
>>> +	.rept	18
>>> +	std	reg,__VCPU_GPR(reg)(r3)
>>> +	reg =3D reg + 1
>>> +	.endr
>>> +
>>> +	/* r1, r3, r9-r13 are saved to vcpu by C code */
>>=20
>> If we just saved r1 and r3, why don't we put them in the vcpu right now?
>> That would avoid having the C code knowing about scratch areas.
>=20
> Putting it in C avoids having the asm code know about scratch areas.
>=20
>>> @@ -4429,11 +4432,19 @@ static int kvmppc_vcpu_run_hv(struct kvm_vcpu *=
vcpu)
>>>  		else
>>>  			r =3D kvmppc_run_vcpu(vcpu);
>>>
>>> -		if (run->exit_reason =3D=3D KVM_EXIT_PAPR_HCALL &&
>>> -		    !(vcpu->arch.shregs.msr & MSR_PR)) {
>>> -			trace_kvm_hcall_enter(vcpu);
>>> -			r =3D kvmppc_pseries_do_hcall(vcpu);
>>> -			trace_kvm_hcall_exit(vcpu, r);
>>> +		if (run->exit_reason =3D=3D KVM_EXIT_PAPR_HCALL) {
>>> +			if (unlikely(vcpu->arch.shregs.msr & MSR_PR)) {
>>> +				/*
>>> +				 * Guest userspace executed sc 1, reflect it
>>> +				 * back as a privileged program check interrupt.
>>> +				 */
>>> +				kvmppc_core_queue_program(vcpu, SRR1_PROGPRIV);
>>> +				r =3D RESUME_GUEST;
>>=20
>> This is in conflict with this snippet in kvmppc_handle_exit_hv:
>>=20
>> 	case BOOK3S_INTERRUPT_SYSCALL:
>> 	{
>> 		/* hcall - punt to userspace */
>> 		int i;
>>=20
>> 		/* hypercall with MSR_PR has already been handled in rmode,
>> 		 * and never reaches here.
>> 		 */
>>=20
>> That function already queues some 0x700s so maybe we could move this one
>> in there as well.
>=20
> I don't think it conflicts, but I think perhaps it should go in the=20
> patch which removed the real mode handlers.

Oh I'm wrong, it's actually the other way around by the looks.

Okay I'll fix this up.

Thanks,
Nick
