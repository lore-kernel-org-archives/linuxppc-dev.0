Return-Path: <linuxppc-dev+bounces-19931-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B69F94CD9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 07:26:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0rPG5Lkgz2yZN;
	Wed, 22 Apr 2026 17:26:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776842770;
	cv=none; b=cUtM3kDUkYxMarvAHpyDfhombTGG6dyhr6G/1N+i3DsfvVsC6fOufyAd2ktPm4bwFWBW9RVeazO7w790fjl1E4321bhNvIIYcdBpxldU6o0XUNyLcRrEtCbvmPUo512UoCZhxCZseG9bR4E5GshE03LnLXJxTfCE3AvnjwX5jEGHwIx46iox8bmOXCNTYoTNemmH8b3vZsADZJ4X8QER8yCQ6kAEc6oQneg/QW4btoxKkpLPGa4+GAAOpmXBx7pkDhjk0sBk8jgdgeyQC+CKY8mtcoYOYptUw4oQPgyBIfNZs0T7nKjPg/ADO5w8wiyrc+TK4eWVgd1BgnsXiu18Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776842770; c=relaxed/relaxed;
	bh=7lK25W7+Mcjv1QQUKw5l94ZN7yEGQLyRTS4aEO3CXdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJDH47VIVUefV91K3JbxMkKjJy8Z60kH/j3cSntqhdMK1T+sfXIjrRzkM+zziBxlylNWLoQoYD0uyBtRKf9NB02cxg17Reo8HouOk3IAFKTSwJ/tQDX6frLC2duiCXdm2hKOdnkOl1MkuckIw3GgV/f770GifpAwPeEJ1n8ODSFu+DuX5n+TE6UCDZPbCwRCZl+a0lq5LBlmMIAggKajvuoq6F3NB/St62/DIb+Y8H+AXqybyeZoQ/bteTS7NpoPGCTyZM1jDyH9Yz4ywpGb4Zz8aH7wlpjJ4WuhvRm5Kqm+xQfPTLKUdY4NpKOr7mhJPNMwWqbH0I7Xm83aLmN0EQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EzBqLzuO; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EzBqLzuO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0rPF401kz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 17:26:09 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 87AF460018;
	Wed, 22 Apr 2026 07:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7F7C19425;
	Wed, 22 Apr 2026 07:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776842765;
	bh=IvSjzT4GEYNAHFGcrljPx1kOL3wXhKmoqPv4Tv8CkaU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EzBqLzuONJJv0ldtemEnj0bXdUh9Q6jzanPurHh8Miflfd8barSPM45kdHimemhIt
	 1eMFfC5fT848W+2iwSmKEnYavFqS3uq5Azd6rGxw0rP59V+eJy3bOVzvbsFXDS33WC
	 mjJh2LRhXVMpQr97ZfguumkupzTHXoJ2J2RPpSWRVsxNZLt+L2c6OoxcMztVwNnh7X
	 uiPZT0XNuZhd6gP48BoVOaHIojh6QR7HcqrMDL5pzMXXLYiJZsj4WVVj/qRUHgmtjn
	 tNkCp+X4hCKUScXVf1gd3/4RrgzyMhcQvtV8NoXRLtRATX5ltBsI67PYcF1YVNifaV
	 RymlAA9f3ksEQ==
Message-ID: <5d16def3-3bad-49b1-866d-94a522e8d394@kernel.org>
Date: Wed, 22 Apr 2026 09:26:02 +0200
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
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260422071541-9a295128-d913-418f-a21c-1386fca30290@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 22/04/2026 à 07:56, Thomas Weißschuh a écrit :
> Hi Ricardo,
> 
> On Wed, Apr 22, 2026 at 11:51:45AM +0800, Ricardo Ribalda wrote:
>> Media-CI has found a couple of new warnings in the latest kernel
>> version for aarch64 and powerpc. They get fixed with this patch and
>> before moving I wanted to know if this was under your radar.
> 
> Thanks for the report. I was not aware of these so far.
> 
>> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
>> index 7dec05dd33b7..65914842fae0 100644
>> --- a/arch/arm64/kernel/vdso/Makefile
>> +++ b/arch/arm64/kernel/vdso/Makefile
>> @@ -50,7 +50,7 @@ CFLAGS_vgettimeofday.o = $(CC_FLAGS_ADD_VDSO)
>>   CFLAGS_vgetrandom.o = $(CC_FLAGS_ADD_VDSO)
>>
>>   ifneq ($(c-gettimeofday-y),)
>> -  CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
>> +  CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
>> -Wno-maybe-uninitialized
>>   endif
> 
> (...)
> 
> I'd like to know exactly what is going on before suppressing the warning.
> It is a non-standard warning, only enabled by *some* of the vDSO builds
> for some reason.
> 
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Flinux-media%2Fusers%2Fribalda%2F-%2Fpipelines%2F1649144%2Ftest_report%3Fjob_name%3Dcross-gcc&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C5c0f15ee20a44072f47108dea0340304%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639124342424606113%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=9Tvp2aYfB02ijxVGLzCOYcMwZlPvqVDufxEporLl1mc%3D&reserved=0
> 
> While I was able to download a configuration from this job and also use the
> same container image, I can not reproduce the issue. Is the configuration the
> full one or only the template?
> 
> Could you provide full reproduction steps?
> 
>> CONFIG_CC_VERSION_TEXT="aarch64-linux-gnu-gcc (Debian 15.2.0-16) 15.2.0"
> 
> The linked test log shows GCC 14.2, not 15.2.
> Not that I could reproduce it with either one...
> 
>>    SYNC    include/config/auto.conf
>>    CC      arch/arm64/kernel/vdso/vgettimeofday.o
>> In file included from <command-line>:
>> In function ‘vdso_set_timespec’,
>>      inlined from ‘do_aux’ at /workdir/lib/vdso/gettimeofday.c:266:2,
>>      inlined from ‘__cvdso_clock_gettime_common’ at
>> /workdir/lib/vdso/gettimeofday.c:293:10,
>>      inlined from ‘__cvdso_clock_gettime_data.constprop’ at
>> /workdir/lib/vdso/gettimeofday.c:306:7:
>> /workdir/lib/vdso/gettimeofday.c:104:26: warning: ‘sec’ may be used
>> uninitialized [-Wmaybe-uninitialized]
>>    104 |         ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
>>        |                      ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> /workdir/lib/vdso/gettimeofday.c: In function
>> ‘__cvdso_clock_gettime_data.constprop’:
>> /workdir/lib/vdso/gettimeofday.c:242:13: note: ‘sec’ was declared here
>>    242 |         u64 sec, ns;
>>        |             ^~~
> 
> The same pattern is used in some other do_ handlers, which do not generate this
> warning. I also can't immediately see what is wrong.

You are likely in a special case where vdso_get_timestamp() returns 
false without setting &sec, and some versions of GCC and/or CLANG fail 
to see that vdso_set_timespec() is not called when vdso_get_timestamp() 
returns false.

Christophe

