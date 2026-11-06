Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F838606A326
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PKDP3O9E
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLbjl5Rrqz2xNC;
	Fri, 06 Nov 2026 21:57:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793962651;
	cv=none; b=Qu8RvmzNPI/SQCd1UVnsXYzCc73lSa9yreDcN0jKwwYAbBsUYI0JgGK1fGIeJbC96dXn62ZHVZbh/NW60iEQTwJc/Ussuhy7dMln+Xchd5ZFWFeTGzdWhj+/ICM+KHQ61xFY/9W60/NdeYNFAMen+1jXwjCsY3VpFWNCu+FjcHx7R/eLTQanZV5YVggPqWGi/hv/MeVIqy+z1tPGY7GMmDaqaHtMX0w66N6iC1tS+2BEWASUCr1T1bAK4nxqswk+I97ycZZth3fktW1YLD8f6+O2gLUe2kVQvGZXC4eestt58utSxndBm9pPWIrLeqbBnwbdN1esSiboCgIf3aUIfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793962651; c=relaxed/relaxed;
	bh=pfqToaUfOwa2BNs1RVBSdeIeaCGsAxyyC3g3zGNtaCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i3hm65K+myRoz62Dh70kGEOcARON61g+jbLFCx6sVUsXEdLmjEQk0KOEU5qKWhefyXHTQopNcRKgFP0DMdyLh50ZzO6Mr1fGH9wlHNWHnb/3aBh7+zzRClJ1cyjZgycd2YukRQR49Or+7LI+os5MVaNKCLI9K1EWiHFG4SZt5ynkADciKXBkcu4HsSyCZ/jnjKOukRrpwMwHYig7qHIyohzWqg25R29ZQKRzK4Vk1HyBP+TRf+/bInxpZvpifmOVZUxW07B6PL1pBDNnqxbjfH606KVQ1d3HHjwKMd74R++a0iOmDro8cpT4g0FIgdd1mCVSw8/w9qd1ZN5rwinKeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PKDP3O9E; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=mpe@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PKDP3O9E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=mpe@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLbjl0brwz2xJR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 21:57:30 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 85CEC6020F;
	Fri,  6 Nov 2026 10:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A8D1F008A1;
	Fri,  6 Nov 2026 10:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793962648;
	bh=pfqToaUfOwa2BNs1RVBSdeIeaCGsAxyyC3g3zGNtaCo=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=PKDP3O9EdT8R20foZVxCAKeykZd2N0U4Pzo/mwbJoyWLtruNkkurgOsg+CW7mCq8m
	 Gp7CE1qZZywE0Drfd5loCRaydwf+qIELvIai2ecyTwJ9/bg/jPKGb5AsGvGmdT68qu
	 20M/e8HlsSYlu7Nr1cjikr8k+mj9yZ0UU578XXvPJFnkURFV9yBtSGCIbDS1BJ3Azk
	 dACtrfRyMxtnCxt9M40MHts5wOQjyPfa5IPIytlf9A6kDeyR1e3oiMng1YT0NXZ4fA
	 kilkL4eAg0jqXlrIkZ8bmp34SUPiQL6t6L52z59NBSu6+gYTcq246c82xkMK+tPAAp
	 aajGMal5tneZw==
Message-ID: <5d7c5630-2834-4320-9b53-01bf8624527e@kernel.org>
Date: Fri, 6 Nov 2026 21:57:25 +1100
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] Does PowerVM populate the rtas-sensors device-tree
 property?
To: Kay <kaylovefoss@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20261101144716.119289-1-kaylovefoss@gmail.com>
 <CADb9fe66VWdLCsB1c7FL=AuQmA3yvrppLjimSW0w8drPxmmuTw@mail.gmail.com>
Content-Language: en-US
From: Michael Ellerman <mpe@kernel.org>
In-Reply-To: <CADb9fe66VWdLCsB1c7FL=AuQmA3yvrppLjimSW0w8drPxmmuTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 3/11/26 7:35 pm, Kay wrote:
> Hi,
> 
> I asked a while back whether PowerVM populates rtas-sensors. The
> answer is yes. Michael Bringmann posted a live pHyp device-tree dump
> in June 2017 that contains:
> 
>      rtas-sensors     00000001 00000000 00000005 00000000
>                       00000009 00000000 0000232d 00000000
> 
> That's four (token, maxindex) pairs, 32 bytes on an IBM 8408-E8E running pHyp.

There's also a dump here from an old system:
   https://github.com/linuxppc/example-device-trees/blob/main/power6-lpar/lsprop.txt#L278

So it has been populated in the past, I don't know about newer systems.
> I looked at LoPAPR 1.1 section 7.2.6.1.2 and couldn't find a stated
> maximum. Linux uses MAX_SENSORS = 17 with the comment "I only know of
> 17 sensors", which reads to me like an implementation choice rather
> than a documented firmware limit. Bringmann's dump has 4. Can PowerVM
> ever emit more than 17?

It's possible.

New features on PowerVM have tended to use hcalls rather than adding more use
of device tree, but that's just a general tendency, not to say a new sensor
couldn't show up here.

> In case you might wonder why I ask: ppc_rtas_find_all_sensors()
> computes sensors.quant = len / 8 and copies that many entries into
> sensors.sensor[17] without checking. I reproduced this in QEMU with an
> 18-descriptor (144-byte) property against unmodified upstream
> cbbddb6b08cc with CONFIG_KASAN=y. Reading /proc/powerpc/rtas/sensors
> as uid 65534 gives me:
> 
>      BUG: KASAN: global-out-of-bounds in ppc_rtas_sensors_show
>      Write of size 4 at ... by task cat/66
>      ... sensors+0x8c/0xc0
> 
> I then applied Pengpeng Hou's April bounds check
> (<20260401160317.88585-1-pengpeng@iscas.ac.cn>, never merged,
> https://lore.kernel.org/linuxppc-dev/20260401160317.88585-1-pengpeng@iscas.ac.cn/)
> on the same kernel and property:
> 
>      too many sensors reported: 18
>      No sensors are available
> 
> No KASAN report at all. So the overrun is demonstrable from an
> unprivileged read once a >17-descriptor property exists. What I can't
> determine is reachability: does any shipped firmware emit one? If 17
> is a firmware cap, the fix is defensive only, if not, I think
> Pengpeng's check is worth reviving.
Yes that patch looks good even if we think 17 is a maximum.

A better solution would be to allocate the array based on the number of sensors found, but that could be a follow-up.

cheers

