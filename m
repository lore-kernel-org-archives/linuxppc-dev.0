Return-Path: <linuxppc-dev+bounces-12260-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB42ACAC597
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Sep 2025 02:10:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cQlk54HYZz301G;
	Tue, 16 Sep 2025 12:10:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.181
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757988653;
	cv=none; b=ljqgV0blsK4MPeFhiWplMPKeUTX9QmOqjXKZmMAtHiIsvctXup3r7mGDk1ldi9RwGEju3zI+sNkIZIx1S1Sg/VTPVB6PeI6pg2BIIgWKaNKc10xYnHj5L0I46hkTu5xmTIg4fAe7mXuwX5f377NMG7lPt41ZbHuCkVot8YWK6LyiBnBzzO32/UgAWhqJjUapOO43os3GFvLJlvh4zOKPmwPmjUE7KdDphx5sRzGQwdP3ivmfP8o8oTsFCTynhXESLYrdU+QDT6yS85lCJwbgly4ROTCFHK0m1zqeat3E4QCJvsiamkGzb0LW2L6mYcUWW/CXpmTVb0lN5pv4vmyTuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757988653; c=relaxed/relaxed;
	bh=iJr24DEs/rWeHHDqtfvtPlFLof2ltSbnJvrEvQKwOHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XTy3Sn9TeXVXSnHtQRe9MuDVEMEb/hbw0RNDztQzeEN9b5IqsfrRneGjXjxkILo5yik3KV2Jyo/l39sVEBeph0aTW99UF3vAKv/a19GVK8wErCxOnU9s/PMzZNzUmx+TA+tRxMP4HOtzM98KZxT//bbYAdOueyjnEOcB27xt96SspyMNITCIlu2HFSvBQ2d4TNKw1OWqdKoBqb+gU3KcPmFmCUa/CpF5k7/qQx9hchHmAuE+R3kLwrUgRkXsP9VZ3CIveYLF2/MfNsphZM8bGPjEP2Y6vJNOxH/Puv9gLX9DuJ6zlFcv/sv2mJmKCmcbvnw/WZcFadZ2If5y4OpAgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=heyquark.com; dkim=pass (2048-bit key; secure) header.d=heyquark.com header.i=@heyquark.com header.a=rsa-sha256 header.s=key1 header.b=eRF/+CFr; dkim-atps=neutral; spf=pass (client-ip=91.218.175.181; helo=out-181.mta0.migadu.com; envelope-from=ash@heyquark.com; receiver=lists.ozlabs.org) smtp.mailfrom=heyquark.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=heyquark.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=heyquark.com header.i=@heyquark.com header.a=rsa-sha256 header.s=key1 header.b=eRF/+CFr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=heyquark.com (client-ip=91.218.175.181; helo=out-181.mta0.migadu.com; envelope-from=ash@heyquark.com; receiver=lists.ozlabs.org)
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cQlk34SHdz2yPd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2025 12:10:51 +1000 (AEST)
Message-ID: <95d176d1-e1be-4594-91bd-caf0d68fd532@heyquark.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heyquark.com;
	s=key1; t=1757988626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iJr24DEs/rWeHHDqtfvtPlFLof2ltSbnJvrEvQKwOHo=;
	b=eRF/+CFr1nTu6HDehRO4fvmEVi8PQElVzr9pKXog1aJk0eEtUK7ZQcdbABGk0cl3sI2gME
	Q1AfB4m6d5V7Pgsfn5lNmwA3BbGLW5eDQNFaH+5fmg3ealHyJyw/JsyQM5poP3qiQRFIVh
	CQvvB2z3abIjCYgzrYALUaruzVET4modJ5T+6Lx5xN3H3QKdb4z6hwIhmWl3ct3ZePcZWh
	mFpBDEmFZGQKGHQvbihd71tyjMNbamXkQvmstyvcTvAkKAdglezTAhgqNnw4g0k/Hufi0W
	yoLD/tzJw36KWKrsQ1iSDM7HfNdLWK6hMAWzD3B4+uVTqtTKYhnQ/9S5mfWrNQ==
Date: Tue, 16 Sep 2025 12:10:14 +1000
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
Subject: Re: 32-bit HIGHMEM and game console downstreams
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: arnd@arndb.de, christophe.leroy@csgroup.eu,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 officialTechflashYT@gmail.com, AWilcox@wilcox-tech.com,
 Michael Ellerman <mpe@ellerman.id.au>
References: <3e8cb683-a084-4847-8f69-e1f4d9125c45@heyquark.com>
 <aMbNwBrxtBSPl8NQ@gate>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ash Logan <ash@heyquark.com>
In-Reply-To: <aMbNwBrxtBSPl8NQ@gate>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 15/9/25 00:14, Segher Boessenkool wrote:

Hello!

> On Sat, Sep 13, 2025 at 08:53:08PM +1000, Ash Logan wrote:
>> Wii (2006)
>> - 1x PowerPC 750CL "Broadway" @ 729MHz
>> - 24MB "MEM1" + 64MB "MEM2" (non-contiguous - MEM2 starts 256MiB in)
>> - Kernel 4.19 (+ CIP patchset), dev has been working on forward-porting all
>> the drivers one major version at a time (he's currently up to 5.15 last I
>> checked) + limited upstream support (hardware bringup, UART, not many
>> peripherals)
> 
> There *aren't* many peripherals, so that is quite okay :-)

That's true. The lack of a UART or similar does make USB kinda essential 
for an input device in my opinion, though getting it working is 
Complicated for DMA reasons. (I think this is the main thing holding the 
downstream back in their rebasing efforts)

>> Wii U (2012)
>> - 3x PowerPC 750CL "Espresso" @ 1.2GHz
> 
> It is not a 750CL.  We never found out what the model # is, if indeed it
> has one!  But the CPU cores are compatible to the Broadway, sure, there
> even are configuration bits to make it do the bugs that were fixed in
> Espresso!  (Just like Broadway can emulate a Gekko, 750CXe, the GCN
> thing).
> 
> It does have its own PVR value of course, that is something at least :-)
> 
> (Espresso is one chip btw, with three mostly symmetrical cores).

Yeah, I was just going for the closest "public" chip :) I think the PVR 
is closer to the CXe too, but all the HIDs, missing THRM, missing 
frequency scaling - it's very CL-y...

>> - 32MB "MEM1" + 2GB "MEM2" (also starts 256MiB in) + various small SRAMs
> 
> It has 32MB MEM1?  Huh.  Why?

New generation upgrade? MEM1 does get used for Wii U software too, 
usually to keep framebuffers and other 3D things, so I guess they wanted 
just a little more for all the 1080p buffers the new console juggles.

>> Distribution-wise, we're supported by ArchPOWER [5], Adélie Linux [6], and
>> other distros. The Wii U's Espresso has CPU errata requiring a patched
>> compiler,
> 
> Can you remind me what that is about?  It shouldn't be too hard to
> include it in mainline GCC.

The short version is "every stwcx. should be prefaced with a dcbst" - 
something to do with bus snooping (store-with-flush, store-with-kill) 
I'd guess. I have some GCC patches drafted (activated by -mcpu=espresso) 
here: https://gitlab.com/linux-wiiu/smp-patches

I'm impressed by how often IBM stuffed up atomics during this 
generation. The Xbox 360 has an extremely similar issue despite being an 
entirely different lineage of chip. No surprise the console vendors all 
went to x86 and ARM right after, I suppose.

Thanks,
Ash

