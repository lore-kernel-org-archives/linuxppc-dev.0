Return-Path: <linuxppc-dev+bounces-24902-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091A6C531FC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 14:58:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h81tk0xRtz2yhD;
	Tue, 28 Jul 2026 00:58:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785164302;
	cv=none; b=K9TnOi7OVHwoVrqchZvoPN6sduwUvPoTCKTkGkjBZHLsn/K4H2HRVWTMvHOk+ObOKwv7w3QzyXx2kQandIwUflZDQyLIXWSHbF2Y1yT6yqUuVVY+VezRgp+e/6FBVqgf6vZQdsXIP14vjUL7sChVBjCvTWaPXnLuQWqORXULHOYCq/4IXL8stb6TTirv8avB3kzuFKi0ymV2brdoeveFS4sxV3FRiUJ9BGmdaYVDzKNkjYFTRG+3Ly/oe0k6p8eS+/7Mr1cOvv7GOgC5lKHkbNvUwv9V6Bv7l8c/1YHrSHvxzPUE8oxCKgTV3LDYpPy88EJV6nBjSSQ9NROB65PgRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785164302; c=relaxed/relaxed;
	bh=cdTAOusKdU7cIGVdiXhGRlX7Lluomu67uAna+oJrbLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fY3UbJrvIaWrI3LN+USzLr6bQuZpNolvRlU6ogCu68TM2xJjPnNmaMd00Pu/eCOhjPk/zs/zlugqSaczlUADYBzel1gH1OoirHcTT04/yAI0zmc3p7aUgHQJOCegBHh8jcA2YjwnZsEg84xrNCge23WjT7cfrxOaALbtswfMHlylUsSrCzhgyIC7y7uiaDd4ADLfiw6PafkGFBgK5eyafOFXum8XNZ5zNGFNp4j2FKYT58IJCfe00UPmV2jtO+Jdodf56XRfxj3sD6x5wG1uyUO2AsiEmWaI9sTdYZD4+cS+BHSRjzIR1jQo5NkN+AyMxYfhfzdH1xw/f0psJ61uLg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=E7Hlw62E; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=E7Hlw62E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h81th1ZjBz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 00:58:18 +1000 (AEST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-476a130c138so2750191f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 07:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785164294; x=1785769094; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cdTAOusKdU7cIGVdiXhGRlX7Lluomu67uAna+oJrbLI=;
        b=E7Hlw62E0OcP+QklZysh62GfuswJ3dbkIJQYzBvvPNr3wXMm5YXCkTrSxrnNdUbu2E
         3glnrFnCMidB8QQrXgriKGUsOOt+0wk/OzrTXjw6nMJhnnrYFtATGX+D3BVZn3QnsUIU
         uBxw1j+KW/zgORNozfhNvw8VSYpjFTxWHzoUy0kdSlU8ZI+tePmgmz4t5Zwz3fbRJH5b
         yaJHIoMS0V0b3rBzXIN3sTpbPhqi2Pi9DvuW8GaF/jxnfkHHYovCWf1Klf5a2u3G9fO1
         KPmT8jNb6vSVFEd41DrstpqCJpV89J4GJkzlRTCfmRsHn0tSKDc43r5H9CY8i+EFxsHx
         VmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785164294; x=1785769094;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cdTAOusKdU7cIGVdiXhGRlX7Lluomu67uAna+oJrbLI=;
        b=iC/FdHK46MWAtqWH5RI6iCTPJbRJAJInyqDeZeaRSVFdoQiS21UIpwDvnJW/qpjidt
         VHO6fFf2wCRUyqrFLg/CS/P4Bl3FgmPNYJL7kAdLUP+PrxmotWRFryoonysL3opPZMjs
         MVafYt3nzK81Yg1NB+rO9SYlLPiaG3p/YQwWSrDF+67PeSllQpL5/kgrRQ+vtIzDqZJm
         ETGRVOgrbnmPI/Hu9FpvMagAbOM5FM3izIKORzWdh6jvVpQemCUbTzdulEltPPoC640X
         FOIV0fVS+mpvfrqdHSNc3S06c9yY3GU82sYMQojxRDUggdNBEOtlVB5eqJwBMRlNqv8E
         7sgw==
X-Forwarded-Encrypted: i=1; AHgh+RoPhsQFEE67t4zFE4fbUM+55VeW1RUkw2w59VXdcgFcUMGvoUqrluOlVimf8cLuCu2qG0nR84BIcAkhFao=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzP1muoOTFlLJ9FDw3fVao26vuMLRPeAxKHW7VnGbST4Y1fKwN0
	nUbBVyDQDQpYX4rX40m+7A3G2JbLQ5Hz8HDJE+pzqY269AzTmNHWsb5EUh2DextKtOg=
X-Gm-Gg: AR+sD10fzAIUWgFfrcvPL1lYNkIpH+NX2tobQ/00wQ3KQPKoTPFaCf/9ZweO9zFMIMC
	zt86wVLBghC1V/tdSAPCkliqBG5chmPZwdnVVVH+mP4ANKEFVUfna/4A5XhtU2D/Uk5JuWKwXaM
	GrBZl3fOdEL1LmmWAUWBuocJfemUn3cphALV02IYcs90GdXlW6f5mJ4xdn7UENA85cp5/rvuLRI
	s1vFN/eDCoZbHmK+BdIIIf7v+zKDlDG922y3ngxAz07GHeXOpMk7igx54KZEAvuREhkHgULZj1O
	l60yPmYDnHFhLleY1l5EuPMHFblQ5MzHCBQ8UlLkbQUU0QZnczmIEbvufUrx/AAKZRsX0r/QvAM
	epqQzw+ERG/OWpjTG1lKB4QLbLf4JrU7VOKF2iq55ZF1E5V6ql4Wz9NzGO4fa5ZBOX8TmY0gVfr
	sWUO1g+QFuv4TJaP+4+ydKkqDN6fZMgHe0dQm1fJE=
X-Received: by 2002:a05:600c:1553:b0:493:e97c:216e with SMTP id 5b1f17b1804b1-496b5731987mr114339235e9.39.1785164294020;
        Mon, 27 Jul 2026 07:58:14 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4ee0e91sm231594995e9.4.2026.07.27.07.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 07:58:13 -0700 (PDT)
Message-ID: <ead73f81-26ef-4a46-9ad8-fcd2915563e1@suse.com>
Date: Mon, 27 Jul 2026 16:58:11 +0200
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
Subject: Re: [PATCH v2 2/3] time/jiffies: Include linux/sysctl.h for
 proc_int_u2k_conv_uop(), ...
To: Thomas Gleixner <tglx@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
References: <20260721131207.803760-1-petr.pavlu@suse.com>
 <20260721131207.803760-3-petr.pavlu@suse.com> <874ihmke0k.ffs@fw13>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <874ihmke0k.ffs@fw13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/26 10:31 PM, Thomas Gleixner wrote:
> On Tue, Jul 21 2026 at 15:11, Petr Pavlu wrote:
> 
>> The kernel/time/jiffies.c file uses proc_int_u2k_conv_uop(),
> 
> jiffies.c uses ...
> 
>> proc_int_k2u_conv_kop(), proc_int_conv(), proc_dointvec_conv() and
>> proc_doulongvec_minmax_conv(), which are declared in linux/sysctl.h. It
>> currently relies on this header being included indirectly through
>> linux/module.h -> linux/kmod.h. Add the missing include in preparation for
>> removing the linux/sysctl.h include from linux/kmod.h.
> 
> Can you please split that spaghetti sentence into paragraphs?
> 
> https://docs.kernel.org/process/maintainer-tip.html#changelog

I will update it to:

    jiffies.c uses proc_int_u2k_conv_uop(), proc_int_k2u_conv_kop(),
    proc_int_conv(), proc_dointvec_conv() and proc_doulongvec_minmax_conv(),
    which are declared in linux/sysctl.h. It currently gets that header
    indirectly through linux/module.h -> linux/kmod.h, but the latter no longer
    needs to include linux/sysctl.h.

    Include linux/sysctl.h directly in jiffies.c ahead of removing the
    unnecessary include from linux/kmod.h.

> 
>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> 
> Other than that.
> 
> Acked-by: Thomas Gleixner <tglx@kernel.org>

-- 
Thanks,
Petr

