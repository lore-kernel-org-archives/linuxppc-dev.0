Return-Path: <linuxppc-dev+bounces-24832-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64CEC531C9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2026 20:31:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6xMm03ttz2yYY;
	Sun, 26 Jul 2026 06:31:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785011475;
	cv=none; b=Wcw7J+koSFLpTpPymlkpCBp0SdPKGRrdes/zpH/KC1V+fZElNQjNEM9brgMr7DH416G5lcTfCllp1rNCqtPdBME0utdRpEdvTOfx0LmW1dNxaVuZiKQIMG0EApEr9tY1A8ZzYyh2rtfFQJAXvZMj+oSPD1DWHa5MSi63sJtmN5hKHND3bWo4Edjzypg9QZhfJVOa80oKO7h6geVC8nG2hhPpcDnqPjit9g/KHyXi1kTpEaQuvZhcpYx1hLMLRV3XHjbjpjHbDjNBqyQrSynz1/GkhPWTEeau06vL7z8h1zvakXoSwRgMVnqsEhGgQ1aRDuxlyGaM3T0seBOZjhJwSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785011475; c=relaxed/relaxed;
	bh=e6KMoD3bd5/q6p3xQeg23qgiuejFXySUo/aGZ6esyCc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SeIWwruh8jX3r/C7D1pq1IMB+6i/diC/EnDL9yZVDm0LFOTkf55ZKKGXRCw1wxdatam57Qa3Mbodm6vwVaayJLX3up88djeqmmlW+l+bKbb448rQ4dnm1WG2ab3/YtnPBF9KwpBYQVQBTQhCIOd8iEPtEDtwI7SMp/cF7iWLiz2Scl0O1tFTRFr304M6Lr/6fFoMCUou+CcsFEhquVVRlLqrCNZeaP7hM9/byv13gI2LAVW33SlFEoIfDzUh5EiTlcdYR0UVqbIxcCvwYQr+S/O1gxo+XH7OWDdnlBm7Zl7WCBjjhidwzLjla3qu2+2cfnUnx7fb3QtkEbR4nJYuQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hAfTn9kP; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hAfTn9kP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6xMk4wBxz2yFg
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2026 06:31:14 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 15DAD60A6E;
	Sat, 25 Jul 2026 20:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFA01F000E9;
	Sat, 25 Jul 2026 20:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785011470;
	bh=e6KMoD3bd5/q6p3xQeg23qgiuejFXySUo/aGZ6esyCc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=hAfTn9kP3ZABFKIwidJBkzkwUEnV03/r5N7p8kmUos3uDtUKUWtEJzQPpdypzC87s
	 s8zXrjsDbl2M4eM1W7J86H4KiLLuZnMtxMMILtEw98qiQcngdzhm3Z933lwVaUuZ1u
	 NLkyUWEUlaRXQiJD2BrV3+doGFNu5m2sLbsSq0EGZklaA6R4wtvLOLLa2OnPQe5qNl
	 qRc/eqpUyUDjcyObmg1ruSpXH9PI078U1i4aarlF7k3SAVuPPwJdBfCiYHUHqv1JgK
	 gHSHbd+Pb+4KEwvFVr0Xj05kVhoMd7+HPlRE8f80fEhbz02ckPWPFwbzdqixw/v4UL
	 pVfAw00n8dMXA==
From: Thomas Gleixner <tglx@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Philipp Reisner <philipp.reisner@linbit.com>, Lars
 Ellenberg <lars.ellenberg@linbit.com>, Christoph =?utf-8?Q?B=C3=B6hmwalde?=
 =?utf-8?Q?r?=
 <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>, Johan
 Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Michal Januszewski <spock@gentoo.org>, Helge Deller
 <deller@gmx.de>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Trond Myklebust
 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Chuck Lever
 <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, NeilBrown
 <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Mark Fasheh
 <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, Joseph Qi
 <joseph.qi@linux.alibaba.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
 Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez
 <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Aaron
 Tomlin <atomlin@atomlin.com>, Pavel Machek <pavel@kernel.org>, Len Brown
 <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Danilo
 Krummrich <dakr@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David
 Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, Kentaro Takeda <takedakn@nttdata.co.jp>,
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
Subject: Re: [PATCH v2 2/3] time/jiffies: Include linux/sysctl.h for
 proc_int_u2k_conv_uop(), ...
In-Reply-To: <20260721131207.803760-3-petr.pavlu@suse.com>
References: <20260721131207.803760-1-petr.pavlu@suse.com>
 <20260721131207.803760-3-petr.pavlu@suse.com>
Date: Sat, 25 Jul 2026 22:31:07 +0200
Message-ID: <874ihmke0k.ffs@fw13>
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
Content-Type: text/plain

On Tue, Jul 21 2026 at 15:11, Petr Pavlu wrote:

> The kernel/time/jiffies.c file uses proc_int_u2k_conv_uop(),

jiffies.c uses ...

> proc_int_k2u_conv_kop(), proc_int_conv(), proc_dointvec_conv() and
> proc_doulongvec_minmax_conv(), which are declared in linux/sysctl.h. It
> currently relies on this header being included indirectly through
> linux/module.h -> linux/kmod.h. Add the missing include in preparation for
> removing the linux/sysctl.h include from linux/kmod.h.

Can you please split that spaghetti sentence into paragraphs?

https://docs.kernel.org/process/maintainer-tip.html#changelog

> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Other than that.

Acked-by: Thomas Gleixner <tglx@kernel.org>

