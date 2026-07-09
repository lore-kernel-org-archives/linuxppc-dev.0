Return-Path: <linuxppc-dev+bounces-23925-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BFEC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 09:49:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwqv81ztKz3c6f;
	Thu, 09 Jul 2026 19:49:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783590596;
	cv=none; b=PVhOSvzJ9CuKwDUk81RclC4wSeUqWFQQ0RMaZ8dMiQsrAtoIACcuyPMCfUNXuf/0VFG7nLjHxCAKei3agl7Wn4d8V39umykE2Q1rqZI/vGh76Hsit8YlX73ykYjoBUKcKgetUnWDOVWslKL9ykis8Ve190Toi+nZPhQN/JFtfueQVCiTjqmn/NI36ob6veRoLMxCBDsjNwCVt6mGn6+AlA8qov5NG3GHrxVnURX2fVwITUCPKjUYK5WlwvWK/N5mbQSJRZ+gHFTXPNyztpQqcP5KN1hcol+RC93uhN2LEZdz0PE80LVhgSw9VOcY4nbfhQN489MTRxVNrBPFuFmC3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783590596; c=relaxed/relaxed;
	bh=MXemn+RWgfgniHXL+Z+iccp115cwF5wMpUS4nNjdkFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BgsGPbBYJonFgapA0YWEcdaOrxLda7XOSJOd+AxDYH6OKtdUC73bw6+qbjU1B/KHPJSBlk/JfD308Dw3uY6RZx2ZX84ayipXSK879O1o7H4LCs6ZKbI6sveAmbqW7OkCz15DH+MIIhVVSw2ozIj3uCZIjf5sIDikin3MMDKIN1tz8YLPB4DIFg9nf8ZKYMGWRE1DcMMrjTepBpghFbPJE/di+NpVoIKs6XNIqULM/qIPGOt/bGn+CcMeOSpcKFSvBYv+ug04E+1DbBM8MVt7td5ggS/DKOKfAHfGu+cn0/Y+kxKMDHqKVA2U54Bi5ovcMcCBAdsI2cr0AAdFevAIBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=AQSNaikr; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=AQSNaikr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwqv55ynjz3byF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 19:49:52 +1000 (AEST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-493b61b52b6so15647595e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 02:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783590589; x=1784195389; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MXemn+RWgfgniHXL+Z+iccp115cwF5wMpUS4nNjdkFs=;
        b=AQSNaikrJyO4zSnuBPGXZ26hULN2JEexrr+C0owTkWNeF/cRH+4pgxyZDBR0sTp1Gl
         YzQA4lvmxme8RJX4kOSFYTySGSBNCsWXjoUlgqyFOu3T07JJLQgjUVkipXyq3xVi2bPa
         nMhjWInkFlVYPDZVl5BXpRL0aDCU2La2yyDOMA5m1GjjeCh8IsCUktYpC1g5wdDyZRnD
         rqVPPwyDjH8qEXPlTy436AHmt22WrEsrotJG93JbP1Ho4szTuJvooqfjxf/AzYt1jZul
         /pymrMvgFaCmURxS4v5F9PI2HYUbifo1Jh2kgN/RGQwS1AaqZxRw+CyINAnsTsvWNrzX
         R9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590589; x=1784195389;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MXemn+RWgfgniHXL+Z+iccp115cwF5wMpUS4nNjdkFs=;
        b=H1/NSVcHGfi8Y/JCwfE0aXIFZeQa9n9/Vs9mBrBS9P5WxHoUvGEpv/CgmKQ/SOZ9+7
         CeH0ZENcNB6MyYAXtMjPIXDLmornbuh6f9397NcoohwBO18inTfUo0QsGrVXcNJCEw5v
         ZQyKTXtc3UbSeSXKkCHcyQhp0/nFcj04puAP66yLIAyYbuQ3nXSP/HhDqzVQyqI0s4YJ
         xWnLhKNUEwuxf3TcpulQtqLAbPoQyzajCYKK6IX5ekS3eLfSFVFnzABozyCtPPFY+maJ
         ZtpWMFf11w87njOtwer/xkD9qVRm0Tjp/9N3/NbSlRtJ0Pir+CqufD3FAgDIP5EdP0gT
         ZYAw==
X-Forwarded-Encrypted: i=1; AHgh+Rp8fycR/EQw7at/1QRBvmAKBnbWGV63qKxLgKB2UQBMo4/Fk+I2kr7Xo4H+EaPGIjgBWQhIIYRq2Bidgkw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzyav0ZskrSlROaRQ9P8Nx/9JVOsGgyjNhCkm1moKHPfiTZteJw
	H92LNmewK8uGHwVUgFLDp1O3gwIeqq10tbxnlXb8ZYBURtnmjdBRipVP26Rm6s8RHAw=
X-Gm-Gg: AfdE7cldBxacbbbCe7xxjP85UWTBoWRepW89ZDF5SnRRhWBJzrcca/fjWh0KQGK0OZn
	Oa3O3IKzTquM3H6h+6kTzCFUBTAvygTLQwBErposYdrwu/EAxU9umYWr7p5Gs5r+rrZZKLFK0Bh
	1//IE7RMrlRcDZJZ5xGooPFXSLGET9ZDpIdj9Cir7bLeRxHJqKAHYeepNPfs2jXbmLkYL6fdy2o
	eycmWc7SVJv45egtF8eHi87Tg5MXIlfK61mhf4Wa7x7A8rtJiBO24fIMOT5WVZ3SVlSDaG+uQP+
	PeHaohRSWraS8V8AInhH1RGZpzM4PN8BlgLzQ8sxX+4gQWWBRGMPfJr+oPaTU0ZTT2VuleU/z26
	o/DKWgioP/52teIU65X96/0UDyZilpE+Cd1wiOXkLHe9y2t9ChvFRdP/7et5E7cNICSQ9O4GAbt
	wx5OTdr0tRBTzDY1FoheEOVGRCJAZRuQbcYA==
X-Received: by 2002:a05:600c:c1d7:20b0:490:9782:3eb8 with SMTP id 5b1f17b1804b1-493e68c3535mr47652155e9.25.1783590588957;
        Thu, 09 Jul 2026 02:49:48 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6d53absm47837275e9.6.2026.07.09.02.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 02:49:48 -0700 (PDT)
Message-ID: <3e2ae6e8-41ad-45f0-a885-131a5711c276@suse.com>
Date: Thu, 9 Jul 2026 11:49:45 +0200
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
Subject: Re: [PATCH 1/2] umh, treewide: Explicitly include linux/umh.h where
 needed
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Jens Axboe <axboe@kernel.dk>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Michal Januszewski <spock@gentoo.org>, Helge Deller <deller@gmx.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Nikolay Aleksandrov
 <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 drbd-dev@lists.linux.dev, linux-block@vger.kernel.org,
 greybus-dev@lists.linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-acpi@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev,
 cgroups@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
 bridge@lists.linux.dev, netdev@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20260708154510.6794-1-petr.pavlu@suse.com>
 <20260708154510.6794-2-petr.pavlu@suse.com>
 <ak6STbqZd-Q-c56v@localhost.localdomain>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <ak6STbqZd-Q-c56v@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/8/26 8:13 PM, Michal Koutný wrote:
> Hi Petr.
> 
> On Wed, Jul 08, 2026 at 05:44:29PM +0200, Petr Pavlu <petr.pavlu@suse.com> wrote:
>> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
>> index a4337c9b5287..60eb994c32ae 100644
>> --- a/kernel/cgroup/cgroup-v1.c
>> +++ b/kernel/cgroup/cgroup-v1.c
>> @@ -16,6 +16,7 @@
>>  #include <linux/pid_namespace.h>
>>  #include <linux/cgroupstats.h>
>>  #include <linux/fs_parser.h>
>> +#include <linux/umh.h>
>>  
>>  #include <trace/events/cgroup.h>
> 
> There is kmod.h in here too but it's unnecessary, no module lazy loading
> in this code.

You're right. I'll remove the kmod.h include from
kernel/cgroup/cgroup-v1.c. I went through all the files again and it
seems this was the only place I missed.

-- 
Thanks,
Petr

