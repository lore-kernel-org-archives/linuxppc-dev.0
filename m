Return-Path: <linuxppc-dev+bounces-24910-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F794C531D0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 18:29:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h86Yz6l5Gz2yhD;
	Tue, 28 Jul 2026 04:29:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785176951;
	cv=none; b=GSSMUTdnac5Fws+81W0ZTNGyUUipA51e7I24bUGXrBEEd9C09tUp2lDdiMKr75Zmte2c8VmgpvO4dF36FGR/8FLRErvgHGFUsDerezYf00Z5O5DJe3T/B5LggCDrmDdollbW8ING0AQmEsk+DlpLwC9wQ5u1lkCnKc8sXqXfmo8FC36VRPlxWdc0PRW11+2lKcLpjHth39BI0aioN5sFcJRGKB0+8FUcs+wbUFazt7Idsv20caJz0tBCPRSZ18Zc+0ppzy3LfaexoJGlyptKuHgf4z/AR1XkhEg9Ed5tvhj6qRciOPux4InYRO4K55evEDteXwtOck2UhzBpnU11cw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785176951; c=relaxed/relaxed;
	bh=WA5IH2DyW1h9ppaWcLGXuslqAZapCSDasbKWS+alQLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=An97f2F1kLusEcVf4JpcfvwK0xkrrOpYrKIrOUb2uMF/A7b//V7JapnhGlaDS91DRqj+vU399ZE5aduvyFrgbfh5iaQXujXCjnWmt8U+QrWDAmjT0hiOWIEjV6gPHnilS0EdlvwzJkd3BmMj4pplFp8p1lYFnOUZDmJkV+96/Vh68tlD7f9TpzdP9xQqQ8fkA8ZDFDKBEUNAjPtTk8C64qpbWIx4K1A7nbUbY+IEw6t4bzWumJoZ8e0/E9xnMwj2J/2JK9JS025Y4SSV5enoaL9zCzZpukOLpehPXuzOSD7vLiPzlus3P7bC2j7HKSe1g+W/t6LOAan23fu44zkVIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bZu1NLqW; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bZu1NLqW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h86Yy6C4Wz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 04:29:10 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DDF8940B8A;
	Mon, 27 Jul 2026 18:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153891F000E9;
	Mon, 27 Jul 2026 18:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785176945;
	bh=WA5IH2DyW1h9ppaWcLGXuslqAZapCSDasbKWS+alQLM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bZu1NLqWWZ98krkcVG48/8nVqirUkK7bubnXmDSGrGX3b71IlKrMHRJkP89Irc78d
	 31YZDzKxOVWCUVm2LxGE6YQSTeTf2TICBY7L+3IPHkLduMe2KKpBG3rJJJKfdZlkBq
	 ULNQZn6h+iPJDx7ckzIIxZY/TADTKcEtwDzEFj96dBlCjydR19qaT2NQzsIKXp/Igu
	 7suMXf7sRVOUaCrFJeefECjmIH6evl1Ew1Cggzt5KXrQUZe2SUdJmwGD7eEtMBTQfJ
	 /qiiNat0URQq5zw30V4gazE9JAw0nVBYVqRmYQtIi4GXzhqT+iKTVe1SE467zg4A4F
	 SmFgsl8rMmPDw==
Message-ID: <f81777c3-e341-4ec5-8d61-b333d7170b3f@kernel.org>
Date: Mon, 27 Jul 2026 20:29:00 +0200
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
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
To: Shrikanth Hegde <sshegde@linux.ibm.com>, Jirka Hladky
 <jhladky@redhat.com>, paulmck@kernel.org
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 npiggin@gmail.com, bigeasy@linutronix.de, will@kernel.org,
 linux-kernel@vger.kernel.org
References: <20250210184334.567383-1-sshegde@linux.ibm.com>
 <20250210184334.567383-2-sshegde@linux.ibm.com>
 <CAE4VaGBwMp3Ke1+Bt11-v6CCE0h=mPm8k_Cf8DazFSQNT9Mz8g@mail.gmail.com>
 <c0f51eda-21c4-4e9d-95e9-75b2740c3f43@linux.ibm.com>
 <500d8e8c-088c-4e6d-ab53-868ade6b0eda@paulmck-laptop>
 <CAE4VaGDGS8wkZj4SF5XVC3-1yDmvJxjUjThTPqVw3kxg56ssQA@mail.gmail.com>
 <e013e88a-6137-4de8-9dfd-925b707f2e01@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <e013e88a-6137-4de8-9dfd-925b707f2e01@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Shrikanth,

Le 27/07/2026 à 19:10, Shrikanth Hegde a écrit :
> Hi Jirka.
> 
> On 7/27/26 10:20 PM, Jirka Hladky wrote:
>> On Mon, Jul 27, 2026 at 6:16 PM Paul E. McKenney <paulmck@kernel.org> 
>> wrote:
>>> Yes, non-preemptible RCU's __rcu_read_{,un}lock() are (almost) no-ops,
>>> but preemptible RCU must actually execute real code.  But I would not
>>> expect *this* much overhead.
>>
> 
> Thanks for doing these experiment.
> 
>> I've now isolated the PREEMPT_RCU cost with a controlled experiment.
>> Built two kernels from the same 6.15-rc6 upstream source on the same
>> POWER10 machine, no CONFIG_PREEMPT_DYNAMIC in either case:
>>
>> Config A: CONFIG_PREEMPT_VOLUNTARY=y (no PREEMPT_RCU)
>> Config B: CONFIG_PREEMPT=y           (PREEMPT_RCU=y) 
> 
> That's full preemption mode.
> 
>>
>> Results (stress-ng --kill 1 -t 23, SELinux enforcing):
>>
>> Kernel                       PREEMPT_RCU   kill bogo-ops/sec
>> ---------------------------  -----------   -----------------
>> 6.15-rc6-voluntary-test      no            105,014
>> 6.15-rc6-preempt-test        yes            73,317
>> Delta                                      -30.2%
>>
> 
> That is voluntary -> full preemption change.
> 
> When preemption mode changes preempt_enable/disable which were just a
> barrier earlier now become real preemption points. If the code path
> repeatedly does the exact same thing, it might pop up.
> But, can we say is that number expected? it is difficult to put a number 
> to it.
> 
> What I was asking is below. (You can do this only with below 7.0)
> 
> Config A: CONFIG_PREEMPT_VOLUNTARY=y (CONFIG_PREEMPT_DYNAMIC=n i.e no 
> PREEMPT_RCU)
> Config B: CONFIG_PREEMPT_VOLUNTARY=y (CONFIG_PREEMPT_DYNAMIC=y i.e 
> PREEMPT_RCU)
> 
> That should keep in voluntary preemption.
> You can confirm with dynamic preemption using /sys/kerenl/debug/sched/ 
> preempt.
> 
> In Config B, though there is rcu_read_lock/unlock it should be just a 
> barrier.
> 
> 
>> PREEMPT_RCU alone accounts for ~30% on this workload. The kill()
>> path hits rcu_read_lock/unlock very heavily through the SELinux AVC
>> (avc_has_perm -> avc_lookup wraps every hash table lookup in an RCU
>> read-side critical section).
>>
>> This also answers Shrikanth's question about whether the regression
>> is from the preemption mode change (voluntary -> lazy) or from
>> PREEMPT_RCU. Since no PREEMPT_DYNAMIC is involved in either build,
>> the preemption mode is not a factor. Additionally, switching between
>> full and lazy at runtime on 7.1 showed only ~1% difference (57,476
>> vs 56,892), further confirming the mode doesn't matter.
> 
> Lazy/full switch is same. There will not be any additional overhead.
> The real concern is none/voluntary vs lazy/full.

That's right with CONFIG_PREEMPT_DYNAMIC=y

With CONFIG_PREEMT_DYNAMIC=n:
- CONFIG_PREEMPT (full) implies CONFIG_PREEMPT_RCU
- CONFIG_PREEMPT_LAZY (lazy) doesn't imply CONFIG_PREEMPT_RCU

because of kernel/rcu/Kconfig,

config PREEMPT_RCU
	bool
	default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
	select TREE_RCU

Christophe


> 
>>
>>> OK, if you are executing an isync or an lwsync instruction in each call
>>> to __rcu_read_{,un}lock(), that would explain the overhead.
>>
>> Yes, that's what perf shows. __rcu_read_lock and __rcu_read_unlock
>> together consume ~9% of total cycles on ppc64le with PREEMPT_RCU,
>> vs essentially 0% without.
>>
>>> CONFIG_PREEMPT_DYNAMIC=n for the win?
>>
>> That's the simplest distro workaround for ppc64le. But since commit
>> 7dadeaa6e851 ("sched: Further restrict the preemption modes")
>> removed PREEMPT_VOLUNTARY as an option for architectures with
>> ARCH_HAS_PREEMPT_LAZY (which includes powerpc), distros that want
>> voluntary preemption on ppc64le would need to disable PREEMPT_DYNAMIC
>> anyway.
>>
>> Is there any path to reducing the barrier cost in
>> __rcu_read_lock/__rcu_read_unlock on weakly-ordered architectures?
>> Or is the current implementation fundamentally constrained by the
>> memory model?
>>
> 
> Are you saying you see regression with voluntary with 
> CONFIG_PREEMPT_DYNAMIC=y?
> 
>> Jirka
>>
> 


