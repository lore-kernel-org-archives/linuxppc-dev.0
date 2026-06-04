Return-Path: <linuxppc-dev+bounces-22044-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC91CD6E6D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 14:51:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWSF74yDHz2yT0;
	Fri, 05 Jun 2026 00:51:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780584683;
	cv=none; b=HMpOIuw1hNCxuzIvYW6l1BgmzARzaW000tduGp8cNDaN82BclQHJf64iedVgkWr0tZu3bM5+O89zff2EAkk2JGz1C0klooTK+5UaJrbozks6mTvz2BNk1oOISvmCf29bvi975zs0xxSpfghid4du++zAd8Upfo3Trn1RFdW9DxRv6Lp7gCP3J7jhEZl7ttkNM/eNSwye1g1zJK7GVhW+IkVC2eXX439+PyubdQfJL2mfcivlfi93xXm2A5n48l/yxyTMwmi61P3laQR+WgJCdYEeqx+6vgiKduh2mZbDVqR8bXey7QmHMKbE12iJ6l1TUum9nqsML0+TW1S0SbEyCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780584683; c=relaxed/relaxed;
	bh=vMRkB+bsG7MQrnmD1SIkDjqzVBAuKZZBEYpnkmM6tuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRwTumjwEINxp3WSbyD8VbRewzVWfWPTVmO35vdV9cbJgOEQcUrhI17JI7UgYtb4Z4leRZ3HJjyhbQPTuUQzSn+OXzvizoGVdh6c54E8IfN5oppJ6qWLV5QSYlrNcCFBdgET/5sY57ZOahFVhQjy8DtYqbjFCye9ETJeIGFr1rcYgvDDdYLLeUox6Fblat6ax1Vd2yDsmFKhvRqLsYsfmWgcdfaimTx/QogRhMgmugswlo8jdS0o/mXP7bY3hFn5zNcIk4AGPqQKnaq6uXNe861Z/PMQHLuwVnZC0uoSVYWNBi84NyxBuzdBlK9mQRze0U/NBXZJtwBq1ItzWmZmag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KY1hBhxL; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KY1hBhxL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWSF65Dbsz2yRn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 00:51:22 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E7742408B1;
	Thu,  4 Jun 2026 14:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF17B1F00893;
	Thu,  4 Jun 2026 14:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780584679;
	bh=vMRkB+bsG7MQrnmD1SIkDjqzVBAuKZZBEYpnkmM6tuM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KY1hBhxLUPgsPhPLS09/7kv6ufZ5PxQIS6PLEvedQPA/B3cFVZr9hd9s6cGXzrSE5
	 sP9IITSxBfGOQqpgHOo8TuFGeGEQ6LCmhsaxojHQ6o5lW8/KekQ1babntEou5W4A/W
	 O2N0kAgG1Rp7igy6dKlmu+K6swJaEONCuOpx0JWXe/lpyhQgvVd/nX7dQf7EXr0FbG
	 vEeDgw0pJaRiGKO+0OyduCFoRMSjRAOxrVBhm2Zbs2RnyD9qdSjoDwNmAvmOTfWZ1N
	 9Tx4oiNFMfFNTSyLIykKnH6zZjFeFrWxuIw9ShuhpbqGhpyOBlyMK/S4GCabI7ZSFC
	 TgKtbKaPTnCbQ==
Message-ID: <e69ad352-6835-414b-845b-03f45fdd9a45@kernel.org>
Date: Thu, 4 Jun 2026 16:51:14 +0200
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
Subject: Re: [PATCH] powerpc/vtime: Initialize starttime at boot for native
 accounting
To: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu
Cc: frederic@kernel.org
References: <20260604132429.297665-1-sshegde@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260604132429.297665-1-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/06/2026 à 15:24, Shrikanth Hegde a écrit :
> It was observed that /proc/stat had very large value for one ore more
> CPUs. It was more visible after recent code simplifications around
> cpustats.
> 
> System has 240 CPUs.
> 
> cat /proc/uptime;
> 194.18 46500.55
> cat /proc/stat
> cpu  5966 39 837032887 4650070 164 185 100 0 0 0
> cpu0 108 0 837030890 19109 24 4 23 0 0 0
> 
> Since uptime is 194s, system time of each CPU can't be more than 19400.
> Sum of system time  of all CPUs can't be more than 19400*240 4656000.
> In fact huge value is close to mftb(). Note mftb doesn't reset on powerVM
> when the LPAR restart. It only resets when whole system resets. The same
> issue exists for kexec too.
> 
> This happens since starttime is not setup at init time. Once it is set
> then subsequent vtime_delta will return the right delta.
> 
> Fix it by initializing the starttime during CPU initialization. This
> fixes the large times seen.
> 
> cat /proc/uptime; cat /proc/stat
> 15.78 3694.63
> cpu  6035 35 1347 369479 23 144 49 0 0 0
> cpu0 19 0 38 1508 0 1 14 0 0 0
> 
> Now, system time is reported as expected.
> 
> Suggested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
> 
> Christophe, I have taken the patch as is from the discussion we had.
> Let me know if i should send it with your signed-off-by tag. I have just
> written the changelog. I sent it like this since tag was not there.

Suggested-by is fine for me.

> 
> discussion thread:
> https://lore.kernel.org/all/cd10be19-e0bc-4e0c-8dac-4f1c05d0de8f@kernel.org/
> 
> Also, does this warrant Fixes tag? I found these two likely candidates.
> Likely this issues exists since beginning.
> c223c90386bc powerpc32: provide VIRT_CPU_ACCOUNTING

You say system has 240 CPU so I suppose this is not ppc32. That commit 
wsa not supposed to change anything for ppc64, did you identify anything 
special in that commit related to ppc64 ?

> b38a181c11d0 powerpc/time: isolate scaled cputime accounting in dedicated functions.

This one is also pure code re-organisation, unless you've been able to 
spot a particular issue ?

> 
>   arch/powerpc/kernel/time.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 3460d1a5a97c..11145c40183d 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -377,7 +377,6 @@ void vtime_task_switch(struct task_struct *prev)
>   	}
>   }
>   
> -#ifdef CONFIG_NO_HZ_COMMON
>   /**
>    * vtime_reset - Fast forward vtime entry clocks
>    *
> @@ -394,6 +393,7 @@ void vtime_reset(void)
>   #endif
>   }
>   
> +#ifdef CONFIG_NO_HZ_COMMON
>   /**
>    * vtime_dyntick_start - Inform vtime about entry to idle-dynticks
>    *
> @@ -933,6 +933,7 @@ static void __init set_decrementer_max(void)
>   static void __init init_decrementer_clockevent(void)
>   {
>   	register_decrementer_clockevent(smp_processor_id());
> +	vtime_reset();
>   }
>   
>   void secondary_cpu_time_init(void)
> @@ -948,6 +949,7 @@ void secondary_cpu_time_init(void)
>   	/* FIME: Should make unrelated change to move snapshot_timebase
>   	 * call here ! */
>   	register_decrementer_clockevent(smp_processor_id());
> +	vtime_reset();
>   }
>   
>   /*


