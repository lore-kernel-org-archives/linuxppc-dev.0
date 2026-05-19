Return-Path: <linuxppc-dev+bounces-21181-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0C1CD4F5B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 18:19:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKjd50cb5z2xwH;
	Wed, 20 May 2026 04:19:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779214792;
	cv=none; b=RKL3on2UWxbyhqKcXoQi4QZ4V8aTtllqnKr2U6Gk8ZXyvEy+68CDUR1PmPKMqDm2cHFB1n4Mj16Ctwr4qDdg3b5Y3zQ1gvXKKeogcygLUxLrYxFFaezhqDaD1Y7yd11hLW1jLn7Yok4fWL//GbTRGFLcceQ59aELBIQaYd2dBxYH0oEZs6cvu1VMCBd/yc4MSAMGXSXQvHyfwY9YDsPdBV0BxTAVK6l6Net/jIZoY7HhUSE+sJtURbWPcze0saj1FXrIlxfn5CbmbE0tn5mVZW+tx8BM1hUKyeVQZ4BTTLNfnim0Ha9sEF8ru3gqlEnakj+9vnIMDGJYwafHqKbFhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779214792; c=relaxed/relaxed;
	bh=tSlHjMAtYdrlV0hDaa+zIjdt3iwIuXPNTBBq3yNSO4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntgE672Ev9nkTBdIfNiovuCudNnHr84UXZ+F4R+kEZws0wBKJwZ5/YNiEEpA2yaMPizx/mlDuZgZRxtD4o1R3b41dduAKptAKv0mnWf+TkoHKC9xwpl5svJ248DokF5gCAWpVdpimylD7tdt10PyLqtstJqkcsi9r24K2BszhmkhuL2xk+ueRAcFFyg3bXQc/EcVHZOlXunf740rAnrPG2iQUAlM5lOmFUY4CkAYFJl+s5HPT8VtvjSg/LmOr0Z9lrIiMqFe9LMA1FqibyrnCacLTsl3+y/eZLS9pkWJBbMZ0FjtXeuhbnJ1hvXAHKsW00XlHNINTsyOSVxBruMAyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=NdQD2zkT; dkim-atps=neutral; spf=pass (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=NdQD2zkT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKjd21fzPz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 04:19:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1779214783;
	bh=v4SY6HigQ/OOsllBvHWhDfaSzCSvRwcpB55NIroxYRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NdQD2zkTt1Vg9+d5xPbFs/rZabXzVYqYNbkmay7bmbURQRlVQgmdR/B+lNrKO/wnl
	 1sbEfjBOCBZinr7ADwsrKwPOLPyNy01sn050oiI8Z1+dSOENnfOYkdJcWLo/dMo86Q
	 BmkG/C5RjZiti4BDcsEE/fXj4HnkbrPupz3pqug4=
Date: Tue, 19 May 2026 20:19:43 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Xiu Jianfeng <xiujianfeng@huawei.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, Arnout Engelen <arnout@bzzt.net>, 
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>, 
	Christian Heusel <christian@heusel.eu>, =?utf-8?B?Q8OianU=?= Mihai-Drosi <mcaju95@gmail.com>, 
	Eric Biggers <ebiggers@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org, debian-kernel@lists.debian.org
Subject: Re: [PATCH v5 00/14] module: Introduce hash-based integrity checking
Message-ID: <e00a5b59-71c9-4c52-9747-0447d5e66b51@t-8ch.de>
References: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>
 <20260518215543.GA1878854@google.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518215543.GA1878854@google.com>

Hi Sami,

On 2026-05-18 21:55:43+0000, Sami Tolvanen wrote:
> On Tue, May 05, 2026 at 11:05:04AM +0200, Thomas Weißschuh wrote:
> > The current signature-based module integrity checking has some drawbacks
> > in combination with reproducible builds. Either the module signing key
> > is generated at build time, which makes the build unreproducible, or a
> > static signing key is used, which precludes rebuilds by third parties
> > and makes the whole build and packaging process much more complicated.
> > 
> > The goal is to reach bit-for-bit reproducibility. Excluding certain
> > parts of the build output from the reproducibility analysis would be
> > error-prone and force each downstream consumer to introduce new tooling.
> > 
> > Introduce a new mechanism to ensure only well-known modules are loaded
> > by embedding a merkle tree root of all modules built as part of the full
> > kernel build into vmlinux.
> 
> I noticed Sashiko had a few concerns about the build changes. Would you
> mind taking a look to see if they're valid?
> 
> https://sashiko.dev/#/patchset/20260505-module-hashes-v5-0-e174a5a49fce%40weissschuh.net

I definitively have these on my list. Unfortunately I am busy with
something else right now. But this series and the Sashiko comments
are next.


Thomas

