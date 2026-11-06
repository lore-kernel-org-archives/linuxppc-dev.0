Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099AA606A326
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=HTy0aolF
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLg3w5PVqz2xNC;
	Sat, 07 Nov 2026 00:28:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793960806;
	cv=none; b=hZcq+ff//nLQUGU6Mm5VmoR+hOhuQzIlutLN9RgSOnrlkyqk2W/nxjXk1TEPgAm3RLyNzGervoFLeEvgV95FCkbo4yY56LQu8LnlDR5GUx4v4egCJHCEaIQ1D4c9W7Vp+7x4Tef4TUCsO9Ivm3VTa6pWnlgvUXZFB/Vlr+uEylA1Jrn7Pm6dDuQHYPxJzegaeSUmOpIOrySEiAU5OYyKVMJ1AIT6gGgAxZzw3geBD9DcsSkMUKGeMg0Oc/ogiMweIMdxFdHSRKvLfA7Xxj0F3oyqttuWweMdBmWBPh6Vw9jLg/7fEwQFQuTxC9N2s4zuLmCRYlIkWqV5Qq8TElwKOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793960806; c=relaxed/relaxed;
	bh=5SnQm8FyNQxZwAbJCgUjqGUAHNHa65Xtbn/htElEqBY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FbYHs8E9NVEbG3KFAQyawY6khme+ROyO6QzPVhAOCZXMVMM6RqXeHkVkwKNSmj/RvyFpe0spi0aGUcb++kFpSfLz4+/GV9zPNlioM+9UEITWOMV422xnqvJlNSWs0Xc40yhXg+CnM/Jte/g617K8a96A/pQwqt0kl4WkcGhddST9L5U9lX4H68H6BXiYUZkR0/NSyUGh3oQljckEgpuSCQZehR41vnGEx6BotGCf/pxySxdhsp47mhsB47dDyIZuL8xaM7SlAm649787lK3ttaT1nXgzb303uFu42fCkT0eiNzPeZjP4CwxmztYboJoLGD25x0AFMNEE8E824tBgAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tenstorrent.com; dkim=pass (2048-bit key; unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=HTy0aolF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=mpe@tenstorrent.com; receiver=lists.ozlabs.org) smtp.mailfrom=tenstorrent.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tenstorrent.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=HTy0aolF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tenstorrent.com (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=mpe@tenstorrent.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132e.google.com (mail-dy1-x132e.google.com [IPv6:2607:f8b0:4864:20::132e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLb2D1g0wz2xJR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 21:26:42 +1100 (AEDT)
Received: by mail-dy1-x132e.google.com with SMTP id 5a478bee46e88-3535a54bed9so677934eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 02:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1793960800; x=1794565600; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5SnQm8FyNQxZwAbJCgUjqGUAHNHa65Xtbn/htElEqBY=;
        b=HTy0aolFvFArig7bGOmnga55tJETfsQzLVeFIkPpknJ8M5ScU//NzJkze9JEWkj4Go
         KEbBLaEVf7dLFgrZqEDtS+c67xMGSMby4W68/Ko8tNziLgosWqHV0Wr8pzo13ITbZgbS
         C+S3TS17pHLpjsZ41FpuVv5+g9TdhpSx/8mtIpXRCg1c6LtwMWsWyyUTwlRqLM6X1o2E
         lo9w1y39mmuZljWnmVMLkdjGiuMUFnP9CJMg95uhiwmF7FIz9nQbaJXQhTpv0WBZgt8A
         zum8GF6TBWnnHzgyg1DzA9ZlENgCnjBFJRa1Lcu6bJL05iSTSOt5ofUH3i/q5ead7ziR
         HZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793960800; x=1794565600;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5SnQm8FyNQxZwAbJCgUjqGUAHNHa65Xtbn/htElEqBY=;
        b=lBT2u0kCn5rI/LVuXIW+COsu7jgqYBX1nOI/LSahXaRVgqk6YO6seB8JHzWPsJCVbT
         uuYmYsX5qKjZf3NaSaV35XjOm40mVDDfwFViKzSTN/SpBPsETXlog6MABEgGU3Ihf3UT
         1ncPr8D9sU99JXaYipFuvhUQFs8p+8Tkqav3AGpQtvEnQm1hN3aXMF7qxCY8rQPrM/Cx
         OD0S8AsvdLUw0d0BkDRnJFkX1CDghkgnctvyanh31eUtpgDEvCCP78QiAxDVBblYTpqE
         yPDF8dhBvQ+W+w6hkJykK7aoozakgo1gpyDDMnPLOFl8L2G+Fo9gEmtVp2cI/xXfxHML
         hEiQ==
X-Forwarded-Encrypted: i=1; AL+hErHeyyrtf11/+r+mZLOxw2Zob0/FbxP8x1mm4wt1mmTpC4N3Ff9vsQsJI6XUu3hjiRGUiUKeM+sxYwEr0LM=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/jxz/hx8B/cbvFEiULYAW0SE9xS51sfRv/uqNpwqmmZG5BZjVC
	d2vsG6pddLERJx5qWbAe8C7o2a1xQJe5gsE6KTGn3SDZg4ZowTWtKXMXYathvWzZZjs=
X-Gm-Gg: AYBFou1uDq+4a72ttttcnPv2+Q7uOWSxXIrz/vcyp/jyZP8COQBMww4SL/SwN2t9+BK
	gZqoCcMtEoDsGFZWGclCMo6rOCVSdsByDCIXinGjXKpN03HTfqGF0/dNFmREhVnSuK/MtWBNgg3
	LfFwkMO1PtsBLFw7CFMDO3wr65iSdb0V0UX3owzRBS/F8mpzVAtEat8OGg3Qi/JXWTjIkkKs5wM
	/mxSrsy6xjmIEMf2bNg04akXmTwJhyd/OEkFwCwdfJidpRP9DwYtC1cgDftAFxkkZdHRfTYRSi/
	AYVcMpLLjJwbnisllF1E243PRxCdY/3EujTpIzerP61kt659rJZzbueYZJMdhZn+2Q8F/iSHd9+
	R3FSUFaMTcvAjsaogRUKLt97v8T45WpN+JGPhpysVghayhdMlUfJDVh0V/y/oIQ7by5+7lbbxr+
	cL95tLipSr08j+x3k9V3BLPU/gfeMuMFu6UezN/PTt4K5aranLvGBDNZSY3HXgu72Up3sFfUDey
	Y1m5+MLA8Yj28KJcCBIbFark1YY0ksA5DeCtLDhxDrRzuH6vxWoMPTootSWHwI8DcNaSCYA+sIx
	JhT6oyki5BtWEtHnMFz8z8ndul4=
X-Received: by 2002:a05:693c:250a:b0:36c:c483:7077 with SMTP id 5a478bee46e88-36f75b1ffefmr2361493eec.14.1793960800111;
        Fri, 06 Nov 2026 02:26:40 -0800 (PST)
Received: from [192.168.1.107] ([203.221.253.165])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa651e6b1sm11482680eec.3.2026.11.06.02.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 02:26:39 -0800 (PST)
From: Michael Ellerman <mpe@tenstorrent.com>
X-Google-Original-From: Michael Ellerman <mpe@kernel.org>
Message-ID: <9fada7bf-11b5-45b6-858d-4c6b79d6a507@kernel.org>
Date: Fri, 6 Nov 2026 21:26:34 +1100
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
Subject: Re: [PATCH] powerpc/watchdog: disable watchdog when watchdog_thresh=0
To: "Luiz Capitulino (Red Hat)" <luiz.capitulino@linux.dev>,
 maddy@linux.ibm.com, npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org
Cc: chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org
References: <20261104034018.2676750-1-luiz.capitulino@linux.dev>
Content-Language: en-US
In-Reply-To: <20261104034018.2676750-1-luiz.capitulino@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 4/11/26 2:40 pm, Luiz Capitulino (Red Hat) wrote:
> On powerpc, trying to disable the hardlockup detector with:
> 
>   # echo 0 > /proc/sys/kernel/watchdog_thresh
> 
> causes an immediate and endless hardlockup detection, eventually leading
> to an unusable system (splat example below).

...
> This condition is already checked in __lockup_detector_reconfigure() for
> the soft lockup detector and the arch-independent hardlockup detector,
> what's missing is powerpc performing the same check in start_watchdog().

Arguably setting watchdog_thresh to 0 should mean watchdog_enabled becomes false.
Then there wouldn't need to be extra checks for thresh == 0 anywhere.

But if the existing code already checks for thresh == 0 then this is fine.

> Fixes: 2104180a5369 ("powerpc/64s: implement arch-specific hardlockup watchdog")
> Cc: stable@vger.kernel.org
> Signed-off-by: Luiz Capitulino (Red Hat) <luiz.capitulino@linux.dev>
> ---
> Notes:
> - This issue was not discovered by AI. We have a new test-case in our CI that
>    sets watchdog_thresh=0, when running on powerpc we get the described issue
> - This issue was initially reproduced on Power10, but I developed the fix
>    on Power9 (which is what I have access now)
> 
>   arch/powerpc/kernel/watchdog.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
> index 582ee3fd71c1..44f178e07531 100644
> --- a/arch/powerpc/kernel/watchdog.c
> +++ b/arch/powerpc/kernel/watchdog.c
> @@ -487,6 +487,9 @@ static void start_watchdog(void *arg)
>   	if (!(watchdog_enabled & WATCHDOG_HARDLOCKUP_ENABLED))
>   		return;
>   
> +	if (!watchdog_thresh)
> +		return;
> +
>   	if (!cpumask_test_cpu(cpu, &watchdog_cpumask))
>   		return;


Fix looks good to me.

Reviewed-by: Michael Ellerman <mpe@kernel.org>

cheers

