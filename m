Return-Path: <linuxppc-dev+bounces-29184-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C1BCA9EBE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Oct 2026 17:31:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j29l50q3dz2yqx;
	Sun, 11 Oct 2026 04:31:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791653505;
	cv=none; b=Tytn5VukYahbBNbK/mF4gj2t8Dpit5zo9L+hrdH/uRXpYXyKrg2a6d+ovnwd0Z2TzJWerk1xiC71ZPvisB7FizU0hD0QjN2a20SFmr5UBWChWe2ojkY6APDtys5JlkALz4eVRyqDUrGo/lW591rLxQVpHmZpjk05iHSz6dBLjDxtEJTgKmJ/fcjPfrVgs9zMuyTCjbaK0hO8A6pgSF2XI5d93aNm6ZI4vIztI6K16/NyTtT4yXaQrekw32ioYwc00VyLmr8jDn9E+AVbn75j+Y9v/B1hjVvZ8Aa/GsoDhB9vyLHijntZ3J7EVymldavEMu4YByr7MvcPa6aY6pjrOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791653505; c=relaxed/relaxed;
	bh=e2SG1oGKx1pJ9O3O89wodpevhJou8Cyz1CclTJcPSOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KdQcJFMXPgEoRMRtbCuqFWOEeDyfFM0sHnTX0H/vSuWU8c7BMjOERpIZ3/FLH4Qpzz/dVqVFwJ0z127TNEK3dqqZeq9tGnMPFOEhbcYZBe3TKqdY9vDXT6x0AR0KF8aVaNuFozJHUWyjoWHOpT9yBcUBSW6nk8nZ6dcnv5dLmkBHX42u8EVN9Qbw6SiIcHg+Zfronz6jeDOvUnyQR7/3HPBzvDfVAPmAPWrjy7QkOKJ23SHsObM2fgGhwtlY2L8C+z6LPChd7u/Hlei3ncYnliPLYSFuKYS7FHzpluDYfVhRmASd5yH0eLD+wrf0xkwrlQfvte+LBqKffkBzbyJZOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q5VU2pmn; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q5VU2pmn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j29l36HY4z2yjp
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Oct 2026 04:31:43 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5435D4017F;
	Sat, 10 Oct 2026 17:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007B51F000FF;
	Sat, 10 Oct 2026 17:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791653500;
	bh=e2SG1oGKx1pJ9O3O89wodpevhJou8Cyz1CclTJcPSOw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Q5VU2pmnyga/EOzEG90Yo3Y7DLmndxWBIb6qC/Bc2DZvJu/kjyeBa7KOqemmfHgsp
	 Ll/Pv5nhggrT9NTfkqrpUCLjObuIEPFF1iBqiYNybEkvsCK/ZKocWkl+kpgPSNtarL
	 BC0kCsmcEWhY9R3J5NguAn7JjfR5jFvmWmhtlA+jnKdNq99WReX9Om9k0mtsQZBtZt
	 WgWpwSMlW/a8MS4fsRmjZ9c08mtsNtw/7ZDnrsEN7hekPLt9xAyTUd25MgHelDfwSe
	 4fP1Nlf9rOCxNHBnYK++RTGCiO/irZ4JgYgjLlR1sbiZg9LfctK3LsTZEyGAewBfrQ
	 QTgjSIKGOlUqA==
Message-ID: <cbc1ae4e-3e83-4f47-91e0-f4f2913b141e@kernel.org>
Date: Sat, 10 Oct 2026 19:31:35 +0200
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
Subject: Re: [PATCH] powerpc/lib: prefetch ahead in __csum_partial()
To: Rosen Penev <rosenp@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20261008034932.3180490-1-rosenp@gmail.com>
 <509cac24-1b3b-4b85-8ad2-ef90da521dd6@kernel.org>
 <CAKxU2N9imBpPHmJSefACvSR1FJofF9JY=ziRatmnQyKK9084gw@mail.gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <CAKxU2N9imBpPHmJSefACvSR1FJofF9JY=ziRatmnQyKK9084gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/10/2026 à 22:13, Rosen Penev a écrit :
> On Fri, Oct 9, 2026 at 9:23 AM Christophe Leroy (CS GROUP)
> <chleroy@kernel.org> wrote:
>>
>> Hi Rosen,
>>
>> Le 08/10/2026 à 05:49, Rosen Penev a écrit :
>>> __csum_partial() reads every byte of the buffer once and never touches
>>> it again, so on cores without a hardware prefetcher every cache line is
>>> a demand miss. After a non-coherent DMA the received data is never in
>>> the cache, which makes the GRO checksum validation of forwarded TCP
>>> traffic the top entry in the profile on a 464FP (APM82181): 22% of all
>>> cycles were spent in __csum_partial() when routing with GRO enabled.
>>
>> Very nice patch. What is the new % after the change ?
> 22.2% -> 13.4% of cycles, but the second profile also had a larger RX
> ring (RXB 256) and was forwarding ~20% more traffic, so it understates
> the reduction per byte. I can redo a clean A/B profile if useful.

Yes would be usefull

>>
>> How do you test that ? I'd like to do some performance test on 8xx and 83xx.
> Single-stream iperf3 TCP routed through the board (LAN and WAN in
> separate netns on the host), GRO on, median of 3 runs, A/B in the same
> boot. On the MX60 the TAH can't verify the checksum because of the
> qca8k tag in front of the EtherType, so every forwarded packet is
> checksummed by GRO in software. Any setup where GRO has to checksum
> in software should show it; "perf record -a" during the run shows
> the __csum_partial share.
> 
> - The 8xx distance. On 8xx, 3x is only 48 bytes, shorter than the
> shortest distance tested on the 464 (64 bytes). The reviewer's 8xx
> results may argue for a fixed distance in bytes instead of a multiple
> of L1_CACHE_BYTES.

Let see

>>
>>
>> When you say "never touches it again", do you mean the data is not used
>> again after that ? In that case would it help to do a 'dcbi' after using
>> the data in order to make the cache line available again and avoid
>> possible writeback to free a new cache line ?
> "Never touches it again" was poorly worded. I meant the loop reads each
> byte once, so there is no reuse within the function. The caller may
> well use the data (local receive followed by a copy to user space), and
> csum_partial() is also called on buffers the CPU just wrote, where dcbi
> would throw away dirty data. For the DMA'd RX case the lines are clean,
> so evicting them costs no writeback anyway. I'll reword it in v2.

Yes of course, I should have thought twice before asking.

A reword will be welcome anyway.

>>
>>>
>>> Issue a dcbt four cache lines ahead in the main loop. dcbt is a hint and
>>> never faults, so prefetching past the end of the buffer is harmless.
>>>
>>> On a Meraki MX60 (APM82181 at 800 MHz, single TCP stream routed through
>>> a qca8k DSA switch, iperf3 median of 3, A/B in the same boot):
>>>
>>>     prefetch distance   LAN->WAN   WAN->LAN  (Mbit/s)
>>>     none                370        341
>>>     64 bytes            430        381
>>>     96 bytes            438        397
>>>     128 bytes           438        385
>>>     160 bytes           434        386
>>>     256 bytes           423        383
>>
>> 3x CACHE_SIZE distance seems the most efficient, why did you choose to
>> implement 4x CACHE_SIZE ?
> AI answer:
> 
> Why 4x
> 
> There wasn't a measured reason. In the original session's reasoning,
> 96 to 160 bytes were treated as the same within noise, and 128 was
> picked from the middle of that range. The full log is less one-sided
> than the table in the commit message:
> 
> dist=96  head=0  up=438(375-443) down=397(392-398)   <- run once, one bad up run
> dist=96  head=3  up=425(422-443) down=391(386-392)
> dist=128 head=0  up=438(433-439) down=385(385-389)
> dist=128 head=4  up=444(437-444) down=387(386-392)
> dist=128 head=4  up=440(420-446) down=380(380-389)
> pf128 small_rx=0 up=436(426-439) down=389(384-393)
> pf128 small_rx=0 up=431(422-438) down=387(380-389)
> dist=160 head=0  up=434(425-435) down=386(385-391)
> 
> 128 was run five times, with WAN->LAN between 380 and 393. 96 was run
> once with a clean configuration, and that run had an outlier upstream
> sample of 375. The 397 vs 385 gap is about 3%, which is close to the
> spread between 128 runs. So 96 may be slightly better, but the data
> can't separate the two. The honest answer is "no strong reason, happy
> to switch to 3x."

Ok

>>
>>>
>>> Prefetching the first lines before the loop made no measurable
>>> difference and is not done.
>>>
>>> Assisted-by: LLM
>>
>> In what way did LLM help ?
> All of it. I set up a serial console to my Meraki MX60, sudo chmod 666
> /dev/ttyUSB0, and hooked up two ethernet cables to my desktop and its
> WAN and one of its LAN ports so it could test routing performance.
> 
> The task I gave it was to speed up ethernet performance. I expected a
> fair amount of work on its dated ethernet driver (IBM EMAC) but
> because GRO (software checksumming actually) was unavoidable, it made
> this change. It was using perf to find out where the bottlenecks were.
> This is one place. I probably should have constrained it further.
> 
> All responses before the above were generated. I'll fix the patch up
> once I get the MX60 set up again.  I currently have a bcm47xx device
> hooked up which codewise is in a really bad shape.

Nice to know.


