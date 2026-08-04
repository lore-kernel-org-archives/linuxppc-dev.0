Return-Path: <linuxppc-dev+bounces-25371-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFBEC55822
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 12:45:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDtYg5vw9z2xyk;
	Tue, 04 Aug 2026 22:45:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785847527;
	cv=none; b=nr3d0TrrCq4ZRshTdhSPyOSEQJkflUl2B5I4NKEGvK+OfoIW5n9BPaEEPYdI7PkDNM85ScNEDqJ2m89D9+KvkAIfVb3A84wKerje9/6xZEDqZjy61A/XZVtx979G/1bI3H635i1Bar7xGKWw9y0hEBrncJAnc69X9AZ1827xOfU/rjXWsXFAY8c8zZ5uEH2+Gu3AtN5/nscDln5nhHlo5BWMFEftdkXJsAjiyOgiGlK7utrc4XnJpNtxyPPKm+mL6geJELDMeRLcHG8RcUUuYuJgL5fq7vkZgWgy9tQeDF4VeroFCzaci5PGwaiKBsZBbVwh79M/JZPXCdq2KJwLJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785847527; c=relaxed/relaxed;
	bh=qkmSpOo+riS6SJ1m143AMJU3zjQ0dKkCNvZFgS3mnbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtSx+EDfAI9QTdIpLJqJ5TbMAhE26Y4MIuCYsIli0Fab/jVaV5ikfDv9FfFFQy6U3ymR/KJSMehsU0hellLNWiiJPtlnca/FZ++glxWV3iLJCIut0CjUFTSxXNKY2ZsHhiFIqd04xUHyfNaVC//vGzs/El8l83UpqV3XHDosADp6hSNGUcYDc7amkpAL4gg3INShPOp4eZP40upnuNmpbA8HODE7NLjvjpy+pf/UrsP7oRHL7Qw0Z4XQpNWhaVksgBqZ1RmGL1H0t4JZD2F7gsQJo2iqRy43w0iLnZ8X4MXlDWzF+FBEjYDDlIO2hbls6FqzWkTK7K/r5d08vLfisA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mGnCbcgo; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=nsc@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mGnCbcgo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=nsc@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4hDtYg1PtCz30F0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 22:45:27 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id 8166B418C2;
	Tue,  4 Aug 2026 12:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D623F1F000E9;
	Tue,  4 Aug 2026 12:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785847525;
	bh=qkmSpOo+riS6SJ1m143AMJU3zjQ0dKkCNvZFgS3mnbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mGnCbcgo8OLWitR3Jf1DQYBgKD65OgaNwD/p/VabSj60DKqnY7s20Pc/EB0G8e+JM
	 QvGs7VeZP3YETgtWRbbTH+76/r7KuA6vBBs0XMqQsQllEwHCJCysjb3tRSSIH26WC7
	 K62ll27VSkCZhThcAm82F/il1iGHMwhSw2GcYyCiVXkC8mmFxJHnFBbRZ3T064Yf9+
	 basQCIX22If9y01aJiQ9t1psXF8oyoCthioOj4q6MCAlljPTeT2XnPjMZ7KtK27QSs
	 oKYDN4i4zLno/6/jzacdQyxdemIX0oo2LmfBivQBk4jUKxWzTBDWTNZojN9j1BF/wC
	 BLwKQLmtXUafw==
Date: Tue, 4 Aug 2026 14:44:35 +0200
From: Nicolas Schier <nsc@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
	Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>,
	Arnout Engelen <arnout@bzzt.net>,
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
	Christian Heusel <christian@heusel.eu>,
	=?iso-8859-1?Q?C=E2ju?= Mihai-Drosi <mcaju95@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
	debian-kernel@lists.debian.org
Subject: Re: [PATCH v5 14/14] kbuild: make CONFIG_MODULE_HASHES compatible
 with module stripping
Message-ID: <anHeswYHqwvKk3XL@levanger>
Mail-Followup-To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
	Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>,
	Arnout Engelen <arnout@bzzt.net>,
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
	Christian Heusel <christian@heusel.eu>,
	=?iso-8859-1?Q?C=E2ju?= Mihai-Drosi <mcaju95@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
	debian-kernel@lists.debian.org
References: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>
 <20260505-module-hashes-v5-14-e174a5a49fce@weissschuh.net>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505-module-hashes-v5-14-e174a5a49fce@weissschuh.net>

On Tue, May 05, 2026 at 11:05:18AM +0200, Thomas Weiﬂschuh wrote:
> CONFIG_MODULE_HASHES needs to process the modules at build time in the
> exact form they will be loaded at runtime. If the modules are stripped
> afterwards they will not be loadable anymore.
> 
> Also evaluate INSTALL_MOD_STRIP at build time and build the hashes based
> on modules stripped this way.
> 
> If users specify inconsistent values of INSTALL_MOD_STRIP between build
> and installation time, an error is reported.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  .gitignore                | 1 +
>  kernel/module/Kconfig     | 5 +++++
>  scripts/Makefile.modfinal | 9 +++++++++
>  scripts/Makefile.modinst  | 4 ++--
>  scripts/Makefile.vmlinux  | 2 +-
>  5 files changed, 18 insertions(+), 3 deletions(-)
> 

For kbuild:

Reviewed-by: Nicolas Schier <nsc@kernel.org>

-- 
Nicolas

