Return-Path: <SRS0=e0K3=L2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D0FC11F67
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Jul 2021 00:27:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 036D0613AB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Jul 2021 00:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036D0613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GGGBQ0JxNz3bYL
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Jul 2021 10:27:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=tnj7SZol;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535;
 helo=mail-pg1-x535.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=tnj7SZol; dkim-atps=neutral
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GGG9t2pMzz2xtx
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jul 2021 10:27:12 +1000 (AEST)
Received: by mail-pg1-x535.google.com with SMTP id d12so7878692pgd.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Jul 2021 17:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=Mv2l8L9qkZyjNEBQ/qaLZr9TMbL0H/dYxh7Xq2ikV4I=;
 b=tnj7SZolgjHrF03LW2p20NAscL2YLSslrU/PDl8j/LGHIQxp89B2qr5u81/+T2vWbE
 AVJfQKK0xDionU9F9aTmYL0XKAJbAToDmCB6ZYK1lGcOKRvt5H1aV1FTLpBu+6ya8eIh
 gYUXnImdWv1np1JkUf7/MiaWmCo6LQlfdrg6+63sJjr9yBuE8biNApQtWqRikNmEHWuA
 0UCQ+v9TLZlrLQAvcbpb9BxM+hFFyJQRzR2nl6LlyhJOPRPG+Y7s0bPF24umkXXgCPEf
 1ldOJ0B0ricQbGVK3GQfiiXeArDaauPUb7btMOImLlkE2kXp2rpJC5QWlsanrCWYajpq
 VDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=Mv2l8L9qkZyjNEBQ/qaLZr9TMbL0H/dYxh7Xq2ikV4I=;
 b=hMzzjbiQL1LVFXjsaF5XLh6pz0uep2P0E7upyWtMdNy/zkuak9P7UoedaByX9bDA2A
 Mbuyja4ua3ouxP3mRo2oGUm6fwWb13uKqQUHgth6ia+iP0rK3t6Gb2xrXDr6nAHEwmhh
 NqiIpiQBpHO0gFeYakei+6L3QzG+NV3hxDgLnaGkHx6hk1+ew8BP0y/UJFWj5LCXPNxC
 zhIJ9qLZ763CQvgYPNHP9MG6PwkkNQ3R6xwc4vi4EBYVavTEWZ/xdETjf7Ln970Rpl3+
 T+L7pX9gDYvB5xKwUJb4Bxzk+jGM1ldgWiLostA0wvYhmKRjuF1AYceIIyEriJQhmxmq
 z+DA==
X-Gm-Message-State: AOAM532Ea7syj/btdZER9hXAxz4vtuyvLB9M2ZTDGDFfNaszJfHVn9WJ
 wnbdszIgaxBnzBAEdw7uc7I=
X-Google-Smtp-Source: ABdhPJwfBAENLTeGErOioItJ3alfV6XsGGlY06CXfjBAosOWpL3uSEtCn3lFSAygVYBPaupaFafn/w==
X-Received: by 2002:a63:450e:: with SMTP id s14mr2232004pga.312.1625185627158; 
 Thu, 01 Jul 2021 17:27:07 -0700 (PDT)
Received: from localhost ([118.209.250.144])
 by smtp.gmail.com with ESMTPSA id e1sm1228899pfd.16.2021.07.01.17.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jul 2021 17:27:06 -0700 (PDT)
Date: Fri, 02 Jul 2021 10:27:01 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 10/43] powerpc/64s: Always set PMU control registers
 to frozen/disabled when not in use
To: kvm-ppc@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20210622105736.633352-1-npiggin@gmail.com>
 <20210622105736.633352-11-npiggin@gmail.com>
 <c607e40c-5334-e8b1-11ac-c1464332e01a@linux.ibm.com>
In-Reply-To: <c607e40c-5334-e8b1-11ac-c1464332e01a@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <1625185125.n8jy7yqojr.astroid@bobo.none>
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

Excerpts from Madhavan Srinivasan's message of July 1, 2021 11:17 pm:
>=20
> On 6/22/21 4:27 PM, Nicholas Piggin wrote:
>> KVM PMU management code looks for particular frozen/disabled bits in
>> the PMU registers so it knows whether it must clear them when coming
>> out of a guest or not. Setting this up helps KVM make these optimisation=
s
>> without getting confused. Longer term the better approach might be to
>> move guest/host PMU switching to the perf subsystem.
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   arch/powerpc/kernel/cpu_setup_power.c | 4 ++--
>>   arch/powerpc/kernel/dt_cpu_ftrs.c     | 6 +++---
>>   arch/powerpc/kvm/book3s_hv.c          | 5 +++++
>>   arch/powerpc/perf/core-book3s.c       | 7 +++++++
>>   4 files changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/cpu_setup_power.c b/arch/powerpc/kernel=
/cpu_setup_power.c
>> index a29dc8326622..3dc61e203f37 100644
>> --- a/arch/powerpc/kernel/cpu_setup_power.c
>> +++ b/arch/powerpc/kernel/cpu_setup_power.c
>> @@ -109,7 +109,7 @@ static void init_PMU_HV_ISA207(void)
>>   static void init_PMU(void)
>>   {
>>   	mtspr(SPRN_MMCRA, 0);
>> -	mtspr(SPRN_MMCR0, 0);
>> +	mtspr(SPRN_MMCR0, MMCR0_FC);
>=20
> Sticky point here is, currently if not frozen, pmc5/6 will
> keep countering. And not freezing them at boot is quiet useful
> sometime, like say when running in a simulation where we could calculate
> approx CPIs for micro benchmarks without perf subsystem.

You even can't use the sysfs files in this sim environment? In that case
what if we added a boot option that could set some things up? In that=20
case possibly you could even gather some more types of events too.

Thanks,
Nick
