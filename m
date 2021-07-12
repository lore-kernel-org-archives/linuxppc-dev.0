Return-Path: <SRS0=qNK6=ME=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A49C07E96
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Jul 2021 02:41:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B96E6102A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Jul 2021 02:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B96E6102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GNShM571Bz30Qk
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Jul 2021 12:41:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=ep4r/2jK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536;
 helo=mail-pg1-x536.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=ep4r/2jK; dkim-atps=neutral
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GNSgv48Pyz2yMn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jul 2021 12:41:15 +1000 (AEST)
Received: by mail-pg1-x536.google.com with SMTP id k20so9760484pgg.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Jul 2021 19:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=W4wjdueyKU7tUJT7diUT2o0ACfWlpKnLEzMxeOyAcnU=;
 b=ep4r/2jKBnuz3OEvZAH1a16RYlqRfoLhg1UaNsdzQaPqtxs9rEUaR6YtnJb7UACztf
 vCb61seYmzh2tU2/fjHZcZsxl1F7mfDDAXo/33dMr2miJQp8psmpgF+Aam+I+/Z7izQX
 oXnK7ZNaJQyCNUURBGV+giqXdZNHXprqUzmbMpDqnDrp5S/lnwGqzH9ajXNfdfOWZAyR
 UPGYdST/KHzBmD03gpie642EESRB/qggMbF0pPB1yiHlHHuH3UcSKl7Mrec8vBLoLhS9
 nlQ0PajOMPjlVCDu16C26l4nwg+m2RdZtfPV4Mi1jFG6mNT1XaIjtWQTYYytGAOFX1H4
 ZOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=W4wjdueyKU7tUJT7diUT2o0ACfWlpKnLEzMxeOyAcnU=;
 b=r7Ii9FIrozsUPfBV35YKIoClPur+dHbx3U/9grXI3awwMhCue5darY3pio7lJxe1qn
 MppY51yV7/G4q+QxHc7q9O8EhrU5X2nKC1Psieqj2pZNQZapZD9CJN3fFElUi18X41Vl
 68v6IlxaSqyYfJ0oQGdzP0S1fdO1g0TPLTWoyYsiuyaZdrvhOfW2WzEB7gOnztEs/vhu
 1B1sdGLtGbboFxQWQdXb9VnFehpEyXkK9Ojec9jJz0bY1HvT5pNFr/hSisx2cKwk27v6
 8gS5/m4rJ2ST3GFB8DzbxWR7SZfFfy8enyvGoAQvgDNQnkP3+pvt6qGHNr9OO69v9mvq
 orQQ==
X-Gm-Message-State: AOAM531hlZvSc1HozHv7js81yXhsNa2hb6i+iMhCX1y7XyOyw71KLyEC
 88QyfQalwCQdFsAThXAAp/k=
X-Google-Smtp-Source: ABdhPJyNIBffjh0JPLtHrANnvn4X3lUBfJ6nSwEefvuOqPvwRXK5s2KBNEfAGY5r+Q645WyoGaDzmA==
X-Received: by 2002:a63:f306:: with SMTP id l6mr51847102pgh.46.1626057672315; 
 Sun, 11 Jul 2021 19:41:12 -0700 (PDT)
Received: from localhost (203-219-181-43.static.tpgi.com.au. [203.219.181.43])
 by smtp.gmail.com with ESMTPSA id
 e18sm13453836pfc.85.2021.07.11.19.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jul 2021 19:41:11 -0700 (PDT)
Date: Mon, 12 Jul 2021 12:41:07 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 10/43] powerpc/64s: Always set PMU control registers
 to frozen/disabled when not in use
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
References: <20210622105736.633352-1-npiggin@gmail.com>
 <20210622105736.633352-11-npiggin@gmail.com>
 <C58A063A-3B5D-4188-80E2-4C19802785BF@linux.vnet.ibm.com>
In-Reply-To: <C58A063A-3B5D-4188-80E2-4C19802785BF@linux.vnet.ibm.com>
MIME-Version: 1.0
Message-Id: <1626057462.8m12ralsd6.astroid@bobo.none>
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
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Athira Rajeev's message of July 10, 2021 12:50 pm:
>=20
>=20
>> On 22-Jun-2021, at 4:27 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
>>=20
>> KVM PMU management code looks for particular frozen/disabled bits in
>> the PMU registers so it knows whether it must clear them when coming
>> out of a guest or not. Setting this up helps KVM make these optimisation=
s
>> without getting confused. Longer term the better approach might be to
>> move guest/host PMU switching to the perf subsystem.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>> arch/powerpc/kernel/cpu_setup_power.c | 4 ++--
>> arch/powerpc/kernel/dt_cpu_ftrs.c     | 6 +++---
>> arch/powerpc/kvm/book3s_hv.c          | 5 +++++
>> arch/powerpc/perf/core-book3s.c       | 7 +++++++
>> 4 files changed, 17 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/arch/powerpc/kernel/cpu_setup_power.c b/arch/powerpc/kernel=
/cpu_setup_power.c
>> index a29dc8326622..3dc61e203f37 100644
>> --- a/arch/powerpc/kernel/cpu_setup_power.c
>> +++ b/arch/powerpc/kernel/cpu_setup_power.c
>> @@ -109,7 +109,7 @@ static void init_PMU_HV_ISA207(void)
>> static void init_PMU(void)
>> {
>> 	mtspr(SPRN_MMCRA, 0);
>> -	mtspr(SPRN_MMCR0, 0);
>> +	mtspr(SPRN_MMCR0, MMCR0_FC);
>> 	mtspr(SPRN_MMCR1, 0);
>> 	mtspr(SPRN_MMCR2, 0);
>> }
>> @@ -123,7 +123,7 @@ static void init_PMU_ISA31(void)
>> {
>> 	mtspr(SPRN_MMCR3, 0);
>> 	mtspr(SPRN_MMCRA, MMCRA_BHRB_DISABLE);
>> -	mtspr(SPRN_MMCR0, MMCR0_PMCCEXT);
>> +	mtspr(SPRN_MMCR0, MMCR0_FC | MMCR0_PMCCEXT);
>> }
>>=20
>> /*
>> diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_=
cpu_ftrs.c
>> index 0a6b36b4bda8..06a089fbeaa7 100644
>> --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
>> +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
>> @@ -353,7 +353,7 @@ static void init_pmu_power8(void)
>> 	}
>>=20
>> 	mtspr(SPRN_MMCRA, 0);
>> -	mtspr(SPRN_MMCR0, 0);
>> +	mtspr(SPRN_MMCR0, MMCR0_FC);
>> 	mtspr(SPRN_MMCR1, 0);
>> 	mtspr(SPRN_MMCR2, 0);
>> 	mtspr(SPRN_MMCRS, 0);
>> @@ -392,7 +392,7 @@ static void init_pmu_power9(void)
>> 		mtspr(SPRN_MMCRC, 0);
>>=20
>> 	mtspr(SPRN_MMCRA, 0);
>> -	mtspr(SPRN_MMCR0, 0);
>> +	mtspr(SPRN_MMCR0, MMCR0_FC);
>> 	mtspr(SPRN_MMCR1, 0);
>> 	mtspr(SPRN_MMCR2, 0);
>> }
>> @@ -428,7 +428,7 @@ static void init_pmu_power10(void)
>>=20
>> 	mtspr(SPRN_MMCR3, 0);
>> 	mtspr(SPRN_MMCRA, MMCRA_BHRB_DISABLE);
>> -	mtspr(SPRN_MMCR0, MMCR0_PMCCEXT);
>> +	mtspr(SPRN_MMCR0, MMCR0_FC | MMCR0_PMCCEXT);
>> }
>>=20
>> static int __init feat_enable_pmu_power10(struct dt_cpu_feature *f)
>> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
>> index 1f30f98b09d1..f7349d150828 100644
>> --- a/arch/powerpc/kvm/book3s_hv.c
>> +++ b/arch/powerpc/kvm/book3s_hv.c
>> @@ -2593,6 +2593,11 @@ static int kvmppc_core_vcpu_create_hv(struct kvm_=
vcpu *vcpu)
>> #endif
>> #endif
>> 	vcpu->arch.mmcr[0] =3D MMCR0_FC;
>> +	if (cpu_has_feature(CPU_FTR_ARCH_31)) {
>> +		vcpu->arch.mmcr[0] |=3D MMCR0_PMCCEXT;
>> +		vcpu->arch.mmcra =3D MMCRA_BHRB_DISABLE;
>> +	}
>> +
>> 	vcpu->arch.ctrl =3D CTRL_RUNLATCH;
>> 	/* default to host PVR, since we can't spoof it */
>> 	kvmppc_set_pvr_hv(vcpu, mfspr(SPRN_PVR));
>> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-bo=
ok3s.c
>> index 51622411a7cc..e33b29ec1a65 100644
>> --- a/arch/powerpc/perf/core-book3s.c
>> +++ b/arch/powerpc/perf/core-book3s.c
>> @@ -1361,6 +1361,13 @@ static void power_pmu_enable(struct pmu *pmu)
>> 		goto out;
>>=20
>> 	if (cpuhw->n_events =3D=3D 0) {
>> +		if (cpu_has_feature(CPU_FTR_ARCH_31)) {
>> +			mtspr(SPRN_MMCRA, MMCRA_BHRB_DISABLE);
>> +			mtspr(SPRN_MMCR0, MMCR0_FC | MMCR0_PMCCEXT);
>> +		} else {
>> +			mtspr(SPRN_MMCRA, 0);
>> +			mtspr(SPRN_MMCR0, MMCR0_FC);
>> +		}
>=20
>=20
> Hi Nick,
>=20
> We are setting these bits in =E2=80=9Cpower_pmu_disable=E2=80=9D function=
. And disable will be called before any event gets deleted/stopped. Can you=
 please help to understand why this is needed in power_pmu_enable path also=
 ?

I'll have to go back and check what I needed it for.

Basically what I'm trying to achieve is that when the guest and host=20
are not running perf, then the registers should match. This way the host=20
can test them with mfspr but does not need to fix them with mtspr.

It's not too important for performance after TM facility demand faulting
and the nested guest PMU fix means you can usually just skip that=20
entirely, but I think it's cleaner. I'll double check my perf/ changes
it's possible that part should be split out or is unnecessary.

Thanks,
Nick
