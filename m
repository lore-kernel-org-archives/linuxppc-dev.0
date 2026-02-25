Return-Path: <linuxppc-dev+bounces-17149-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0A3F357D9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Feb 2026 07:16:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLQrQ2DvRz3dK9;
	Wed, 25 Feb 2026 18:16:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772003814;
	cv=none; b=eEtQeFZ6OO76mZSuJxzC/bFqpiscKWVpO1TuzAjU9DOq3tk4XQ1+yAEun70M00ros8eeUqIqGJHqLw5H1Xm2+0YirMDXh7aA8gco3eJ2hb7Qrjqd9A5XMKF565P+yVDscPUzwCvGHu2WZzTn3otxEZ10FurHhtgyFetT4RNiU1fBfVqYduHjDNbnR92a28GAMGzv14Cvad3njUCt2gDAuhUfJU3fj+becvYcamjZ+iJC2c/TPYSSPDLpXra4UrEb77hAizSSlnwG493WLPgPJq5Gn0wekMepbYiWKmCjuiC0RCOpN5UFskVIGVXSMViS6n1dGF9QXhYkcchiGymGVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772003814; c=relaxed/relaxed;
	bh=/6cw0Akl2Q2J+TmRORRg0/zCSbR/V64Kmi8Q7m/9ttk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vpl0UAI2JI+dGwJb+oDoXWrJSX2waax+O3bz5aPSD1XWA4BiDU1NBA8MdhmvR/U039fOyQmxn79CTIhD4mwFi4EGB++4SNP2QCVWGpejBt76lEz/ytdY2s3n0cVDechlVWTIy7tuVi6RC1NQeXCYUpOJJjE5rcYLF6wrpQKIamH+k3yJt8PwH5Y4MmR01YSekxdwp2O6i58A1C2k9l7GjgRvXyu7nwX+ec99xRXHugsqCSTuijDoet5kume3ljO9uSTG8Muj9CuOaLwPzDIWutwvW2giJX2nhNKzjYUSi1XkgJbik3nlULUtRVClnz5bFvaS05Xz1abjGfbMfARylw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HhGHbd6J; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HhGHbd6J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLQrP3j1zz3d8d
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2026 18:16:53 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DC1E060051;
	Wed, 25 Feb 2026 07:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC70C116D0;
	Wed, 25 Feb 2026 07:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772003810;
	bh=0VoyvgVLV83OpwaPy00QzkStcLMj9l0dy7bXC5TxxWk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HhGHbd6JJH07IUaYX046Ao6B9dcliOfhUr1xO4B9pi4R9bqN/800FOrs8kWtviVaW
	 EJSoKix0cJj7MQfzNR0CLmBs8XAQ66BNJga4ZmUrRV6bKiK+NyfbvowfNf5zZpnnOV
	 k6olCvKiYPjiWNDrXDa4ZYkeg+E6Fz3cBr1aflSx1LwWFmAxdbDU7qs36hf65VJxwQ
	 ylR+vpwFMTeKAZpsgVktRwO3sAEd6pT8GX9lo0su6IuyFQhgA5yH+q2KsnjjHzrBtK
	 CLr9P/MWNTm654jQZA31gBpE9XHiW80KLRwPO5eFbXQXv2dLs7MFudwdRhmz+Hs1KE
	 XKWxpZ08z2PLw==
Message-ID: <1c9b879a-7907-4849-a416-5df3db5617d6@kernel.org>
Date: Wed, 25 Feb 2026 08:16:46 +0100
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
Subject: Re: [Linux PPC] Disable PREEMPT
To: Christian Zigotzky <chzigotzky@xenosoft.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: "R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
 mad skateman <madskateman@gmail.com>, Christian Zigotzky <info@xenosoft.de>
References: <b897b0fd-90f2-4215-bcd4-3714e497d773@xenosoft.de>
 <185d7a42-f7b4-44e1-a129-f5989d211c74@linux.ibm.com>
 <40154f6a-39da-959d-e039-5ab9ff62db3c@xenosoft.de>
 <709b864f-9daa-4a48-b3d6-39baedce63b2@linux.ibm.com>
 <dbbb7998-5245-170f-626b-81bc75a32591@xenosoft.de>
 <843b7c60-23f1-47d0-b4e8-2147c3e40c23@linux.ibm.com>
 <2a27e6fc-7eb4-41a5-ba88-58f6a22625b5@xenosoft.de>
 <1d79ec6f-ce7f-4432-80e0-a54fa1668642@linux.ibm.com>
 <e425cd24-e19a-3860-aad2-11e91af8323f@xenosoft.de>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <e425cd24-e19a-3860-aad2-11e91af8323f@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

+Peter

Hi Christian,

Le 25/02/2026 à 06:54, Christian Zigotzky a écrit :
> Hello,
> 
> We were previously able to disable PREEMPT in the kernel configuration, 
> but the latest kernels now enable it by default and it is no longer 
> possible to disable it.
> 
> Is it possible to let us decide whether to activate PREEMPT or not?

Can you give more details on why you want to be able to deactivate PREEMPT ?

Read https://github.com/torvalds/linux/commit/7dadeaa6e851e


> 
> Currently we use the following revert patch for our non-preempt kernels.
> 
> --- a/kernel/Kconfig.preempt    2026-02-14 10:06:32.000000000 +0000
> +++ b/kernel/Kconfig.preempt    2026-02-08 21:03:27.000000000 +0000
> @@ -16,13 +16,11 @@ config ARCH_HAS_PREEMPT_LAZY
> 
>   choice
>       prompt "Preemption Model"
> -    default PREEMPT_LAZY if ARCH_HAS_PREEMPT_LAZY
>       default PREEMPT_NONE
> 
>   config PREEMPT_NONE
>       bool "No Forced Preemption (Server)"
>       depends on !PREEMPT_RT
> -    depends on ARCH_NO_PREEMPT
>       select PREEMPT_NONE_BUILD if !PREEMPT_DYNAMIC
>       help
>         This is the traditional Linux preemption model, geared towards
> @@ -37,7 +35,6 @@ config PREEMPT_NONE
> 
>   config PREEMPT_VOLUNTARY
>       bool "Voluntary Kernel Preemption (Desktop)"
> -    depends on !ARCH_HAS_PREEMPT_LAZY
>       depends on !ARCH_NO_PREEMPT
>       depends on !PREEMPT_RT
>       select PREEMPT_VOLUNTARY_BUILD if !PREEMPT_DYNAMIC
> 
> ---
> 
> Thanks in advance,
> 
> Christian
> 


