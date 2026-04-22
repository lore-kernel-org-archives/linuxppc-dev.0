Return-Path: <linuxppc-dev+bounces-19944-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54EDDF9B5EE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 09:09:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0tj105NKz2yr6;
	Wed, 22 Apr 2026 19:09:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776848996;
	cv=none; b=ja3kh3pFjfHyKveh2d2sQpeqx+ixd0LUT6lq4ojHouL1+M2g1jPApgRxhQ34kl2SSbVCHwm2eDkSOMtYfuTH+3KleexiJPGTE+zepyYMiV5kiW66Wm2P2JsgzkW2BStnAKmijX9cKm9SZrQrUI9Cq3iGiovIa4h8x7DmLgUYqv9iRNSzKdv91JITd9SftbEQ+Ef0TgTb4V+wBz3JpgVIQZYKtQE+Xc/pVOwdF3Taf6xxBoPnnlFshfB2KeQ3uUMyQjzeP4bqrlAumZgfM64nbZHqBZyjjm9MRAgjfp1wsdTRyTn/fUVAN+Gb4xSdrlB0Sa8e3Ak3NZ8+e3tx8Q221A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776848996; c=relaxed/relaxed;
	bh=Xr8QxbYshkOJjMrSj7nRCdGJ+EKCV/0wXnSEvRwBPSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOkaxo0OrZIIkJn0gP9725Sh4Nja5Ad4PN7LGujp8Fp/D7SRBdXKoti26abvGRpDrKtocGcqLJvSmwAnl948wQAdszTl4jF3jSKJXRL19hrxF4FqFczjG1R/+fFxfbqLfbS9CW1Rs+TphsVJIM1WubToorbrUeGM0+lmopFvVOZulnwjs7c3a2U4Yg3Gcm/RcebZCTfeztIhvd94IowKFAHBeQ8GQvOEEn6nUnHD4tnu7tqbomQtagCvizbRHEij+qVjjcSHFdLw23MXMG2IB6srLAOAKV+vg6q/h5ycttLdlTBj37o7SIpVJD/o4LLCSp+r4ekA95UXZ7sdgPs2Kw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bW4Len4g; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bW4Len4g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0thz1Yjvz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 19:09:55 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1A518600AE;
	Wed, 22 Apr 2026 09:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4049C2BCB3;
	Wed, 22 Apr 2026 09:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776848991;
	bh=1eBiYpZdYpgrWMNpR3shEhEFDXlBwGOvrMbmmwxsIng=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bW4Len4g/CMaeDxoMwtPt5R0RQC6dQ/fVnbzypeBRlJOlhNA+pUi8PAMQYJOR/9zm
	 GoJYKV0iZ+dSVl8Ev3deBLJZMqSRmR8yI5+4ctzahOrVIm5c4RdoPXVFvaDx74rE7p
	 N4Fa7ypy2ukD8f0VgT6QBvoBIGKH3uSwVlWjF8jErom+1x5BSOm+2K3VXo7HXsA6pF
	 cIrTfTcVJDl+uw6Iu3GnwuUwWvMPReXw5s1w5/MawkFfJ7okgEUjY8bqpZqSIXiQyB
	 50zfeRm5ixn6y9AuxBGVBknQUSDr7/Xzx5h1RXvb1toUQZbaP3LmsdwZ+CyfY3ChyF
	 Y5y3UxY/lwGTw==
Message-ID: <f23f863a-38ed-4e28-8df9-a592638c9fda@kernel.org>
Date: Wed, 22 Apr 2026 11:09:49 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: New warning in linus/master
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Ricardo Ribalda <ribalda@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
References: <CANiDSCsOy0P1if-gJZqOM5pTJ0RDcwVfru1B7KFbTOEMqjPKJw@mail.gmail.com>
 <20260422071541-9a295128-d913-418f-a21c-1386fca30290@linutronix.de>
 <CANiDSCviww1L1p2+MvF59Biqb6hc7WdL1J37kBjFd1NXz-Yt8A@mail.gmail.com>
 <20260422092713-4021a1a5-3a54-4260-878a-aec1bef3f8c7@linutronix.de>
 <CANiDSCtfiPDiqzhjZGoCJbLC0fRoH1HLKrvYUt7jLDYEBQHqgg@mail.gmail.com>
 <20260422103218-1efdbb73-51fa-48c9-ae92-75306147d61f@linutronix.de>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260422103218-1efdbb73-51fa-48c9-ae92-75306147d61f@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 22/04/2026 à 10:45, Thomas Weißschuh a écrit :
> On Wed, Apr 22, 2026 at 04:06:45PM +0800, Ricardo Ribalda wrote:
>> On Wed, 22 Apr 2026 at 15:32, Thomas Weißschuh
>> <thomas.weissschuh@linutronix.de> wrote:
>>>
>>> On Wed, Apr 22, 2026 at 03:00:11PM +0800, Ricardo Ribalda wrote:
>>>> On Wed, 22 Apr 2026 at 13:57, Thomas Weißschuh
>>>> <thomas.weissschuh@linutronix.de> wrote:
>>>>> On Wed, Apr 22, 2026 at 11:51:45AM +0800, Ricardo Ribalda wrote:
>>>>>> Media-CI has found a couple of new warnings in the latest kernel
>>>>>> version for aarch64 and powerpc. They get fixed with this patch and
>>>>>> before moving I wanted to know if this was under your radar.
>>>>>
>>>>> Thanks for the report. I was not aware of these so far.
>>>>>
>>>>>> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
>>>>>> index 7dec05dd33b7..65914842fae0 100644
>>>>>> --- a/arch/arm64/kernel/vdso/Makefile
>>>>>> +++ b/arch/arm64/kernel/vdso/Makefile
>>>>>> @@ -50,7 +50,7 @@ CFLAGS_vgettimeofday.o = $(CC_FLAGS_ADD_VDSO)
>>>>>>   CFLAGS_vgetrandom.o = $(CC_FLAGS_ADD_VDSO)
>>>>>>
>>>>>>   ifneq ($(c-gettimeofday-y),)
>>>>>> -  CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
>>>>>> +  CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
>>>>>> -Wno-maybe-uninitialized
>>>>>>   endif
>>>>>
>>>>> (...)
>>>>>
>>>>> I'd like to know exactly what is going on before suppressing the warning.
>>>>> It is a non-standard warning, only enabled by *some* of the vDSO builds
>>>>> for some reason.
>>>>>
>>>>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Flinux-media%2Fusers%2Fribalda%2F-%2Fpipelines%2F1649144%2Ftest_report%3Fjob_name%3Dcross-gcc&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C7cbf9009269d4ddc16d208dea04b86f1%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639124443421115079%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=O4r8HjaUn7KEgW8tDE9GEC9e8CWyJBpCfhVTJZZ%2BFHs%3D&reserved=0
>>>>>
>>>>> While I was able to download a configuration from this job and also use the
>>>>> same container image, I can not reproduce the issue. Is the configuration the
>>>>> full one or only the template?
>>>>>
>>>>> Could you provide full reproduction steps?
>>>>
>>>> You can try repro with:
>>>>
>>>> work/linux $ podman run -v .:/workdir/ --rm -it
>>>> registry.freedesktop.org/linux-media/media-ci/build:latest
>>>> $ cd /workdir
>>>> $ CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 make allyesconfig
>>>> $ CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 make
>>>> arch/arm64/kernel/vdso/vgettimeofday.o
>>>>
>>>> The gcc version discrepancy is because I the error was due to old gcc
>>>> version and I was playing around with that... but it fails in both
>>>> gcc14 and gcc15
>>>
>>> Ack.
>>>
>>>> You can try with debian testing with
>>>> work/linux$ podman run -v .:/workdir/ --rm -it debian:testing
>>>> $ apt-get update
>>>> $ apt-get install gcc-aarch64-linux-gnu build-essential flex bison libssl-dev bc
>>>> $ cd /workdir
>>>> $ CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 make allyesconfig
>>>> $ CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 make
>>>> arch/arm64/kernel/vdso/vgettimeofday.o
>>>
>>> Both reproducers do *not* reproduce the issue for me.
>>> (It is more or less exactly what I tried before)
>>
>>
>> Ok, I think I found what is going on. media-ci was forcing
>> KCFLAGS=-Wmaybe-uninitialized
>>
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Flinux-media%2Fmedia-ci%2F-%2Fblob%2Fmain%2Ftest-build.sh%3Fref_type%3Dheads%23L29&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C7cbf9009269d4ddc16d208dea04b86f1%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639124443421146576%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=%2FpTHYfCn5ob42%2Fm6FVOZ32PVzuXBNBT3rlMVWslCfhw%3D&reserved=0
>>
>> And something has changed in the kernel in the last version that
>> triggers a (hopefully) false positive.
>>
>> can you try with:
>>
>> CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 make
>> KCFLAGS=-Wmaybe-uninitialized  allyesconfig
>> CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 make
>> KCFLAGS=-Wmaybe-uninitialized  prepare
> 
> That works!
> 
> The warning was introduced in ed78b7b2c5ae ("vdso/gettimeofday: Add a helper to
> read the sequence lock of a time namespace aware clock").
> 
> It is *not* a false-positive, specifically:
> 
> do {
> 	if (vdso_read_begin_timens(vc, &seq)) {
> 		vd = __arch_get_vdso_u_timens_data(vd);
> 		vc = &vd->aux_clock_data[idx];
> 		/* Re-read from the real time data page */
> 		continue;
> 
> This 'continue' jumps to the end of the loop body and if the real vDSO datapage
> by chance has a sequence counter of '1' will exit the loop, leaving 'sec' and
> 'nsec' uninitialized. My believe was that the 'continue' would jump to the
> *beginning* of the loop body, which is cleary wrong. Previously there was an
> inner while loop() which would make the 'continue' effectively start at the
> beginning of the outer do-while loop.

Well spotted. I missed it too while reviewing.

A 'retry:' label at the begining of the loop with a 'goto retry' instead 
of the 'continue' should make it.

Christophe

> 
> 	}
> 
> 	/* Auxclock disabled? */
> 	if (vc->clock_mode == VDSO_CLOCKMODE_NONE)
> 		return false;
> 
> 	if (!vdso_get_timestamp(vd, vc, VDSO_BASE_AUX, &sec, &ns))
> 		return false;
> 
> } while (vdso_read_retry(vc, seq));
> 
> vdso_set_timespec(ts, sec, ns);
> 
> 
> I'm working on a fix.
> 
> 
> Thomas
> 


