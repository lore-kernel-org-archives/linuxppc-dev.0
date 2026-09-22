Return-Path: <linuxppc-dev+bounces-27917-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A0AC982FF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 12:40:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hq06z1xGBz2yQJ;
	Tue, 22 Sep 2026 22:40:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:3a::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790080811;
	cv=none; b=l5fx9hiYF9NogGa6RmCs4x0466pLZRTKi3WfpO7jDjPXh82VPeAZ3g1Bwlm1vfqh/AcjSJ56oBWho+xWDCILNFpNn9ODc2Jsyy0hV1QhnhUSwp9RR6XVjdYb9uaBQAlDmpD2GZLFcjGHaX2y5ytm046ET4bPbiSeCwest7ya91aEGT5NqHhO1DcRAsAkdgUUMLGuOYFVwEFZ52c7nWWr00tz/TYn7te62XCdjv+WO2EziO/SQCjhQzxymigqxZ8RYcMRJPDqLXlUA8c3fe851Lh3jqE011bA1tOMPI1jvVwE+4o2HyXT3S0LE2KHOujZjdPHqGPin+VCbCUrz2UpkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790080811; c=relaxed/relaxed;
	bh=o9blDfaIlaDE7zWOzf7sAkl81n8mIgiGQIMLz8R8dVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GpQevZq0q42rV4SRN85CbeAVJBY7Lcfj79SATGF2eM1tfY+Gq0xr/IANm6hADYLjgR5ixYlj+tIOPTBNGcCdtaj3/45pskjGGzYAMCmjisxzDIq4hgQ73Vs/Enr/GuXNCJuGNdavMtFWTHBxAsZ3C3fFgz1BBdiE+dSEfqqZE2YS3mmS7oXnIc+NataSPim/W9ISbJgooT8FrYcW3c9lX+yex2Prd9khZAFtKWSpnUMhu5/S2dwoWQv2d5lAu9v5I03guxqXE7550prUxzBBaU4cFCOuC/2vCHcOl31XEyJWFdTegrQsnXwmQ3YxJ3bC5cP6o24kTykwXLi4Fp9OSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; dkim=pass (1024-bit key; unprotected) header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=GDLtcCRA; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:3a::f; helo=mail-vs2-x0f.google.com; envelope-from=elder@ieee.org; receiver=lists.ozlabs.org) smtp.mailfrom=ieee.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=GDLtcCRA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ieee.org (client-ip=2a00:1450:4864:3a::f; helo=mail-vs2-x0f.google.com; envelope-from=elder@ieee.org; receiver=lists.ozlabs.org)
Received: from mail-vs2-x0f.google.com (mail-vs2-x0f.google.com [IPv6:2a00:1450:4864:3a::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hq06w4YtLz2yHT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 22:40:06 +1000 (AEST)
Received: by mail-vs2-x0f.google.com with SMTP id 71dfb90a1353d-5c83be8db39so2326031e0c.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 05:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1790080799; x=1790685599; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o9blDfaIlaDE7zWOzf7sAkl81n8mIgiGQIMLz8R8dVg=;
        b=GDLtcCRAO35mxAxQN3yfb+ktc0u9NbmgVZcY6Ai9rWib0nKQ3TAJfQIiHmQdF1oqQe
         incviCtNqDdaQKrY/GPQMyV3kOs7MMMT4b5QEPEoS0eZUVCDI4FscoDKF1lyLfbkU6CS
         3/qmWszFWl2u/A+8/IhgoZEmfvS9Pvva3BqCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790080799; x=1790685599;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o9blDfaIlaDE7zWOzf7sAkl81n8mIgiGQIMLz8R8dVg=;
        b=mUiewYvFCqmzHPYISr3W+5lnV86DmcGXLPqZeg8nbLpMf+EHWneh1s18PG/Lrk7zpG
         a6/RBkmIDr7nFnk3WRp3wo5pPWFnOeKqkliIMSUx8n2kTwj/X8rDQz+aE/1EeAsAifj1
         ZJlknTklEo6U0pWYFbaPiI402oUJinyZD/ZrhCNkrbLDieFZJzxoAfmHGwCqo+DBPkTz
         3shudT4VL+NU/4cAE2U5wrKAfTUazRKIXRG4ih4VyQHukr8c5GKZB3+bKMZIYn7qnGOM
         +GlnNP8Y6gIFJ3ekvyiannJxgEOXyAYU+vc9nAJ7JwAbstOMrS9hmUqE4EACjHeTQVBY
         Vo1w==
X-Forwarded-Encrypted: i=1; AKwUvByJvIirUpAATpSN4DlCr2+n/0w3FxFNf36jrcs3dUAZqqwMg4cu1KfMLSMpVTi7g9w8C8N1TREif1fuyPI=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l8QFm+4/Z++8TTQQNtGdzOZIex0EayRajyAv5SvzSPNK3ZL5M8
	bmLN2/I0JUM+7VdxH89m6q4IbBGc1rToDrRk/wZZRSVxr8gtuMJ7FvuRaLGAd687tA==
X-Gm-Gg: AYBFou3wDJ/NUHAcsefIpOvp0TDuidA1j+j/S4BgUZtzDi6g9gtIswJAZMhyRjnyIjt
	J/skIKYH75Iv/tUnZ5RstxdMtlO2ve2VKQczN+g6agONAK/T80kRTFJVJJG1mo4q/27KmcZpK61
	0c2xWgoaJxtMVHpHnDVX7wByC6xuIS4mlpJIPYCszseNZGcItRy5uCDG7S8LKC/nWaQeYtFoyPh
	gANZHNDvLmRq4bjLgkpbflYPcJKhhHf2nvOZrK6scR5N9U1jYpZeiIt4OB4zUPQTuc4G3tpdZ5q
	wEAGsfhTFeY5+hLKw6RMdu0KQXXpOF2vg2fs0Q1JJcWokQVNEIuYUqM7IitM5YKoKO+sweVqyUF
	cYHRg85x+BvU+ez2voF3c5PI/Id/BjyWo8Uy8uCE3HK/jiMc/YpnuSFz+1XW+pxYqrj3v4LpVPT
	5NH5C4w6gNskL2tW68xKN2uEy7l+hHQlx7Uclts9+4+NMxET4o/5qwpR/d5O9vfzdB3sQ0/AIk+
	Rvv
X-Received: by 2002:a05:6122:e22b:b0:5c9:a60c:2736 with SMTP id 71dfb90a1353d-5c9b598e442mr8405960e0c.14.1790080799199;
        Tue, 22 Sep 2026 05:39:59 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-91402535ce1sm14566906d6.48.2026.09.22.05.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 05:39:53 -0700 (PDT)
Message-ID: <d2052425-3fb4-4104-b1ed-f2d53e5a710d@ieee.org>
Date: Tue, 22 Sep 2026 07:39:47 -0500
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
Subject: Re: [PATCH v3 1/3] umh, treewide: Explicitly include linux/umh.h
 where needed
To: Petr Pavlu <petr.pavlu@suse.com>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@kernel.org>,
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
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
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
 <20260911-module-include-kmod-v3-1-6ebccc3e0731@suse.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20260911-module-include-kmod-v3-1-6ebccc3e0731@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/26 9:46 AM, Petr Pavlu wrote:
> The usermode helper declarations were previously provided by linux/kmod.h
> but commit c1f3fa2a4fde ("kmod: split off umh headers into its own file")
> moved them to linux/umh.h in 2017.
> 
> Add explicit includes of linux/umh.h to files that use usermode helpers and
> remove linux/kmod.h where it is no longer needed.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>   arch/x86/kernel/cpu/mce/dev-mcelog.c | 2 +-
>   drivers/block/drbd/drbd_nl.c         | 1 +
>   drivers/greybus/svc_watchdog.c       | 1 +

For Greybus:

Acked-by: Alex Elder <elder@riscstar.com>

>   drivers/macintosh/windfarm_core.c    | 1 +
>   drivers/pnp/pnpbios/core.c           | 2 +-
>   drivers/video/fbdev/uvesafb.c        | 1 +
>   fs/coredump.c                        | 2 +-
>   fs/nfs/cache_lib.c                   | 2 +-
>   fs/nfsd/nfs4layouts.c                | 2 +-
>   fs/nfsd/nfs4recover.c                | 1 +
>   fs/ocfs2/stackglue.c                 | 1 +
>   kernel/cgroup/cgroup-v1.c            | 2 +-
>   kernel/module/kmod.c                 | 1 +
>   kernel/power/process.c               | 2 +-
>   kernel/reboot.c                      | 2 +-
>   kernel/umh.c                         | 2 +-
>   lib/kobject_uevent.c                 | 2 +-
>   net/bridge/br_stp_if.c               | 2 +-
>   security/keys/request_key.c          | 2 +-
>   security/tomoyo/common.h             | 2 +-
>   20 files changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
> index 053555206d81..af4e76babe7a 100644
> --- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
> +++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
> @@ -11,7 +11,7 @@
>   
>   #include <linux/miscdevice.h>
>   #include <linux/slab.h>
> -#include <linux/kmod.h>
> +#include <linux/umh.h>
>   #include <linux/poll.h>
>   
>   #include "internal.h"
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index b77f901fc3ef..6f5d059394b3 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -14,6 +14,7 @@
>   #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
>   
>   #include <linux/module.h>
> +#include <linux/umh.h>
>   #include <linux/drbd.h>
>   #include <linux/in.h>
>   #include <linux/fs.h>
> diff --git a/drivers/greybus/svc_watchdog.c b/drivers/greybus/svc_watchdog.c
> index 16e6de5e9eff..b318eb34bcca 100644
> --- a/drivers/greybus/svc_watchdog.c
> +++ b/drivers/greybus/svc_watchdog.c
> @@ -7,6 +7,7 @@
>   
>   #include <linux/delay.h>
>   #include <linux/suspend.h>
> +#include <linux/umh.h>
>   #include <linux/workqueue.h>
>   #include <linux/greybus.h>
>   
. . .

