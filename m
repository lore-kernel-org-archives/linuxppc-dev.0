Return-Path: <linuxppc-dev+bounces-23860-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE94C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 23:37:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwZJh10K6z3bxf;
	Thu, 09 Jul 2026 09:37:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783534419;
	cv=none; b=CzrSZYT0sYhVLhqLi+q2ymiTUpz3DwqdAkI8vKbtkejFdwF3J5nfM1gy1iRlRCV3qAObwmQjea4bTtEzDkY+6VwPaaVCE08NfZQc+xpnMUcvRnFpbxqsMRIkgKRDJDcgJcKsnGLFbwaAmvTBOqS1+tLFPO5mAQFo0d4LoN663aIV57mGJIImz9Q7oqS22y47yBjqEnMF69ysDopMZtCSdb90RwT0aE7g+OdkJR6cKhfamxYKD7pjAhwGhoyzglQjlolZVeLnAmj29K6X2wEo6UzKgrkMgvvda0YFUzcr5DjP9KP3QzQEaYgXmZd9TWwWnJIJY48hdABalj1AkeiNEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783534419; c=relaxed/relaxed;
	bh=WEMJWE1zcwQ4UkLGDHzDIo1wA9TMgoKtQk475YCTe6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMk561B6fFPviPVac3KqAEskUzXIFJJxaWGp4D+hXdxKrwAF5NP6P1BEf6oQVUS+LtvbCdkruIWx7ZLT0Y231bgh8K9psAo8YpgNlGR1Ll4wcv8i8CreWJdURNvmvNSvyiL3L9cfvGbTulJa52nVaTpGAcJZJEQvee1GFPge59IF7PqnsoUH1qxGXawQVHtGx0HD9d6jssM2avJpicTbJkGnykWVyQNUTWAkjLCM4Q9HJJZUbSKVrPcD+Tt6ckLyX8ONdVmlp/kgpWK0sMaRn49xFy242M/ehg1o4jHaWdtTaf63yiG2oEaH3jLYFv/mMoIUXg368zMRAbYas7YxZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=G27gor3D; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=mkoutny@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=G27gor3D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=mkoutny@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwR6n0Wm7z2y7r
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 04:13:35 +1000 (AEST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-4758bd3731bso89869f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 11:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783534407; x=1784139207; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WEMJWE1zcwQ4UkLGDHzDIo1wA9TMgoKtQk475YCTe6o=;
        b=G27gor3DBMrpisG5hXjtVmbjbn+Md8yhY9/hJ2uA4b3ouwzvH5MfcPAXtBbBzlMRsx
         O7Ir9DRlGwBZKJdVu5lvQu+46PL9ZyTYZR+HkPap/Nl+DWf3YJj7nT0bUZkVs2/sdo0/
         s5Mohj3oKJ6hIbimWfW0p06SnCxaWvCe2ZBnmhehiQ14NjLz5b0mjudaxzJDqB+9G16L
         PqiOU4QAQC7qLxlGgfgc2d7Y96N9KlJWQBgrvb9J63O8G+0TNASvOTJGF5uh8HokWZGz
         vf5X7qUrFnjuerdEbpNDfiZSzyjoZ/KIqQ1Yl3lF+CV5DdCEyjQpsxrL74SFMWvgyRri
         A/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783534407; x=1784139207;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WEMJWE1zcwQ4UkLGDHzDIo1wA9TMgoKtQk475YCTe6o=;
        b=kUmGQ4MifazgYytbxDA+IAPYqEc47zmmK8dDaHtvMbCgAZHIolyyenzd3g+r5SeLUV
         trQ2kd+VcZpUl1LtZm0tTUSQtQN/8HTldyGNpoAtg31b2I3tAKRN/5DlYLgT7/c434kY
         3mcHTiHwCMgfrGH5Xb3c+wdXGW7+cV6IEbFtT2u9xbebsHrke0gNQ1GczD55RXUafVt5
         tuaeHkWGPWmlKeXtClZz1h/Pc9/zDXdyx+nqPLuFjoAbuxxuNe/2L345rrWkBKZkHidf
         8Ww4T/ZwdTtiTof79iU/BeD8SHN2liM+8uYR1dq8cWc3oENns78VMm8Rb5gYBK6kNCd9
         h97w==
X-Forwarded-Encrypted: i=1; AHgh+Rq52GRVR6W6HWgZ/0tjw7tzl8LFQ3cKDO0ATAGxzoz3KlUjYvTP5yJnohUdSjKRu5vEJ3LtOOeoAJu/O+Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyK6WZVBulps7D/QI70fXOAA0yLKiqlys4fNprppeI3tAMFmJki
	3ve22xuQ6F7ORnMduZmrZwwVP/kTi2iIhgD0ACQzp0nocPmglXCviLY4tgB+xQvBByE=
X-Gm-Gg: AfdE7cleNY39+X2K89p0qrsU9C2iXs3TqXItVEaWjXYcrAwrMKH8Bg3m/7OTNWYRcOJ
	iQpZbPmVC5HcgYOeEWB5FU0fmI9R1UfAIvRgLIux2q69Sj/Q1LPr9aUQgyW957uOzjKTjALetHk
	t3oYiX5xemoJ6eswiau7eLZHHqiZFgTinWS8YNhrywh4gmV8RjrFx8eRt58l8M/pRh8gUiaCXXk
	yx/gEj5vo7jpBH+vQ/gT+Rqky6tPWxnL9a/nZluvSK2UACOIBUKxMRBQL6PxjVbVTknx2DfTJWJ
	w5V8IlE3WwhHGxRjHdXKau3Sw6uRpYFaBYkEi/J/MDGf6EYM+e3uqEVQSmZ8YPjx+VGBWwlcozP
	n/so+DfAtLWteI6TZnJ6iBEofIznywB/qLftG4P4jqY23LQgyaZe8zx6pdNnGfXgg7EE5DHXtBR
	RR/dQG9SewVDOfo5NTbl3hgTJXd0on/1Wpr8uLUA==
X-Received: by 2002:a05:6000:460c:b0:473:c608:eeb5 with SMTP id ffacd0b85a97d-47de9a4f159mr9196162f8f.29.1783534406837;
        Wed, 08 Jul 2026 11:13:26 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d910sm43325516f8f.6.2026.07.08.11.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 11:13:26 -0700 (PDT)
Date: Wed, 8 Jul 2026 20:13:23 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>, Johan Hovold <johan@kernel.org>, 
	Alex Elder <elder@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Michal Januszewski <spock@gentoo.org>, 
	Helge Deller <deller@gmx.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
	drbd-dev@lists.linux.dev, linux-block@vger.kernel.org, greybus-dev@lists.linaro.org, 
	linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, cgroups@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev, bridge@lists.linux.dev, 
	netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/2] umh, treewide: Explicitly include linux/umh.h where
 needed
Message-ID: <ak6STbqZd-Q-c56v@localhost.localdomain>
References: <20260708154510.6794-1-petr.pavlu@suse.com>
 <20260708154510.6794-2-petr.pavlu@suse.com>
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
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kijzkd5xnaepafl2"
Content-Disposition: inline
In-Reply-To: <20260708154510.6794-2-petr.pavlu@suse.com>


--kijzkd5xnaepafl2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] umh, treewide: Explicitly include linux/umh.h where
 needed
MIME-Version: 1.0

Hi Petr.

On Wed, Jul 08, 2026 at 05:44:29PM +0200, Petr Pavlu <petr.pavlu@suse.com> =
wrote:
> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
> index a4337c9b5287..60eb994c32ae 100644
> --- a/kernel/cgroup/cgroup-v1.c
> +++ b/kernel/cgroup/cgroup-v1.c
> @@ -16,6 +16,7 @@
>  #include <linux/pid_namespace.h>
>  #include <linux/cgroupstats.h>
>  #include <linux/fs_parser.h>
> +#include <linux/umh.h>
> =20
>  #include <trace/events/cgroup.h>

There is kmod.h in here too but it's unnecessary, no module lazy loading
in this code.

Thanks,
Michal

--kijzkd5xnaepafl2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCak6TOhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AgY2gEAgOkCGIEUNQ8/AFfxYtdb
0XG1ZQXkD0d1Rm0cAq1+u8cBANw3nWI/wHkp5zcHmZWevxdnweU507gsyVTXzMGQ
ZwsB
=k+w6
-----END PGP SIGNATURE-----

--kijzkd5xnaepafl2--

