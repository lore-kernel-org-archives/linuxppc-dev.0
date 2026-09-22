Return-Path: <linuxppc-dev+bounces-27910-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AF2C982FA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 09:58:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpwXN37kYz2yQJ;
	Tue, 22 Sep 2026 19:58:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790071108;
	cv=none; b=k3OG7c9Omo/izwUxZc+QxmLPRmUKhZq1fgPiqr9gx3/BeYF83Mogz+D4Dfw9PQEe6jpo4W3LhWW/CiVygIWHCotGZgUcup3nUJ4VI13px26sB1NzzAANkzhunMt946WdVryggtfvCwOplpHuubdV9o5TdpolM6CloST+Oi4yBRbJA9e/opa6LVNq3lFqGCa/jnapA9PFqpXEGcl/oupf1WhyPe03DqT3aVe28M4zfFyMHNGpbCORIAZYguhqRr8jfMMZbyv+L78i2hYvTfHPOEz7AN+xFqZYOFv+IAf2f4bwMEiJCtDr0pL5P3GpfjDEHXBY7kxRdapHMltXn7hRog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790071108; c=relaxed/relaxed;
	bh=nZUNZdA2VreC5ZuzVVTaU77y9kWQRV4FmcQNBHWyLvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TiuPnFBSFJubns87gR5Y7DfEHsdR0U0KL9kzEJBgf5lhMkhlGS/C4zREwwx6PFzlER/DmnuoixwZORI4JgMjK6H05YHOTUSDHnBGGVJ6G6qos0Avt7erHOzW/1eWJ7uJFykjGGoMM5tcXIl+OBK/5E1hUQqMFRoiBbAUY0GzHqazAuE/m+BfDhFEMC3NuepfVtCiJS3DkrOSZfcPNur+HeUIJzGu4ekcPk7B72b/e1rgc7r5oLO6KEHmVWuYIzjIhdvnB/1HoL9IGM/yIFcf3mmIa5UO4zWwdqfHGS6ew23BtqzldVG2r+OWUopJOtCSWKEwo0TsPl/VbpTidAiu/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=e8CKi3ix; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=e8CKi3ix;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com [IPv6:2a00:1450:4864:31::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpwXL5dpwz2yFQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 19:58:25 +1000 (AEST)
Received: by mail-wm2-x11.google.com with SMTP id 5b1f17b1804b1-49b912e4ad9so22933245e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 02:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790071102; x=1790675902; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nZUNZdA2VreC5ZuzVVTaU77y9kWQRV4FmcQNBHWyLvk=;
        b=e8CKi3ixWbT2cuvTT06RQeyJx1MsDuItt/NOrjux3NHqprDCaLrNdFx+YK3dQN6Dh/
         KDQzDBM6qNxveesDO/AGv0ERsgT0bfWxoB0Q8vKZwG60Ht9TEBKQHRQz/YjkDd6o51Mf
         AFdM9KmBxePjYMiZFDhEDpMVDu9YjVFqSilLq5BAgqau8jGBUZR0N42FPjZQdhRxZG6N
         ylg91TSEHit6LjVFk3QLmvsohnI//X9FdQ5Z6aG2YogkKap1BjUEKhj1Fuh4qa37Wi+l
         3OMCABEY2O6rC2ZukNRh4ynttFQHZyuZqZgfptjwFAwRW5ppBTwTU7okWBa8ik/MtoP6
         3HWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790071102; x=1790675902;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nZUNZdA2VreC5ZuzVVTaU77y9kWQRV4FmcQNBHWyLvk=;
        b=HbnlfkVGv732y+NxXlL2TBuqWFznW50vOm0hIx/ZT73vqFzNyO4hoEplPPOhGoqXrF
         qliDNA1tMGhbFJxSYBMpqjYUilf5s7OGM7F8BuEMdgP9J5GrWHaPY/9yumXejIuQemNV
         4nc3onhnj6yfqMJN0gHocRR01IVeRMrXw7WhI0AmV91/eml0DU0wT9AmkgUk+PL1+E/U
         SDPr7z4ClV2AuRTAPw77nm2LxTqL22K6s2Rw6ELoFFa0XIQZ0Gp2QK2jhug+2ddCm8xz
         qdk3GEIfgaaDG7Is7/zN+RJHxAyeapbcBkYe3IDwaXkA5s4ATOYRMTxmcfQhpkOAGEE+
         KrXw==
X-Forwarded-Encrypted: i=1; AKwUvBzXFGWRVY8QqrAFETPa8XLWyFwoBH/+pHYqmCr9S0jqWcRdCeT0iDHNljWOkXLPBOTCmG3+piHIQxOq1FM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n48JXn8cNWnS4qUy/T+JYJXz4kqdiNuOUBCFUfwrzpcjlr19L+
	3QWFkDO7hkLI/+bJvHez1DBMdrIfMe2X9NSm0zptco9w/zNbW5dQa3pNB2DJe4hQNoQ=
X-Gm-Gg: AYBFou27BYcvkoaAZMAcFH5bvtHxSuIZC2PtdqYDYGcccYFhQmal0DOMn4gLQUwLnmj
	qLoL0W6spK5kFStT7OvKq4VdAdgYchUKJx3OmNrX/IIUN4IBT1uMv1fSlWpU+lKU1twYQlbf6Q+
	u1teWbnsO/iaazoSIrzgY7VGrpedBqPMuoLRDmwB147tb4/+YFvY16RQ4lgvUpG704u5/AmBoLM
	OJYJ8bMK34yEqjBPNJSc+DUdDGNLfqxm4YZ351U5sVaFKaddEufSvslxNXb+WSTbMWtiwA/SawL
	jFsKjYP7/XFVBZdgpu5hecRs0hmy12wotQBIcmIs0qpD71FtH06ClAQI0KJyVwg5Umn1bw1UNk5
	NeQdFaXzx0CnsYJfWFl0maZoEIT//HbOyhl8khxY1jpNcFMzNTYhSYTUC5BrHJCjFTCCBzLeE0+
	zE238tWhgb1JxqqFDn+9kRkhUfkuXyLhi8E7I4xaMWtXHB4Tq+EvN73m/8yRakti5GSG5YdyoU/
	dlLKUJZoJPoemjyQJLjyUtSkwGdBDmoAw00jsy/4bkkBtWHAlNdhKtii4eerlIY27iffFx+rJLC
	VUJFoiRZ/yk88Dymb0JG14T9LiBOeUABwEIkj7x7
X-Received: by 2002:a05:600c:a0a:b0:49e:84bf:6110 with SMTP id 5b1f17b1804b1-49fc56dbb49mr199597855e9.6.1790071101618;
        Tue, 22 Sep 2026 02:58:21 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdab0c240sm27108755e9.4.2026.09.22.02.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 02:58:21 -0700 (PDT)
Message-ID: <2bf82e0b-a032-4ee7-8d93-c5604222723d@suse.com>
Date: Tue, 22 Sep 2026 11:58:18 +0200
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
Subject: Re: [PATCH v3 0/3] Bring includes in linux/kmod.h up to date
To: petr.pavlu@suse.com
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
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
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
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
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
References: <20260911-module-include-kmod-v3-0-6ebccc3e0731@suse.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260911-module-include-kmod-v3-0-6ebccc3e0731@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/26 4:46 PM, Petr Pavlu wrote:
> The usermode helper declarations were previously provided by linux/kmod.h
> but commit c1f3fa2a4fde ("kmod: split off umh headers into its own file")
> moved them to linux/umh.h in 2017. Add explicit includes of linux/umh.h to
> files that use usermode helpers and remove linux/kmod.h where it is no
> longer needed.
> 
> Also add a missing include of linux/sysctl.h to kernel/time/jiffies.c.
> 
> Finally, clean up linux/kmod.h so that it includes only the headers that it
> actually requires, importantly removing the compat linux/umh.h include.
> 
> This cleanup is motivated by trying to reduce the preprocessed size of
> linux/module.h, which includes linux/kmod.h. linux/module.h appears in
> roughly 15k #include directives across the kernel. This makes it a "hot"
> header, so it should avoid pulling in unnecessary definitions. Note that
> this series doesn't immediately improve the situation, since most of the
> files included by linux/kmod.h are, for now, also included by
> linux/module.h through other paths.
> 
> Apologies for the wide distribution. Acked-bys are appreciated.

I've queued the series on modules-next for 7.4-rc1.

-- 
Thanks,
Petr

