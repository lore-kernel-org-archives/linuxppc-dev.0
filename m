Return-Path: <linuxppc-dev+bounces-21512-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F66CD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 11:38:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPrNm4zyVz2y8t;
	Tue, 26 May 2026 21:38:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779795512;
	cv=none; b=ADH4Agf83ZeEPEGD172kEJk1RifuFhdNqncHIt0HbZSMY3z25Rn5CcF1UV1TKCXYsu0EmlYrB/Wbdd9TnATbSCVMYpHcGPwW36o2sVyi/xivh2x9yiB+ToQe05UolAU+IagJdUbg8xcjzPMCcCovvfahnVh6BXz30otYZ9riGTgBlGpJxLwnGEPjZYSb4tt3O0opFfA4f24hJXqura9a+lIBwSOrn7SwYvkFVxykVnyy33+9CdWJJpw7+CNgoQlI0i6tLi49/GCNl5DVBQDSKGjvMdS+WLYlNW0LtBK6ZPCkYCWfTne+GggqguQOfvpLFLKnQFX5qpwvtQP+7TyVbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779795512; c=relaxed/relaxed;
	bh=d6dn2a7TQJ70h7LxKIS8YIip4+9CCa2Str2P4iVHOqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuWzn/8fklOs+Ow8oZahEPxfr9ujugfovzWNqIsSlApErCoDyEnZ82YJjWHHUjzgY/rkUUTPWIWo14j1W6ohZQrOMvIKkkNmvjRY07zIuGbbkS5iySx4Gf0+7vdyRir994EtssW3+Dqyu9pkCDUJlZsplYwyMUcwKWms+GvVFUcpSR2yiw05m0rQOFKRgw9TAnUvpw7pbUTmNaqOAV5VoIxHfUZwlUwmhSFwH7bM8/XKbbyVVh6oCVqhZ49YI4uPsm3GvsRZGnr2VtTrZDSxZnBxn6AwjSph9k9FuFKHbG3t5Df+Ysh/9nsQZD+2q7qFxsb1eTQ4OsuwA0rXxyp3lQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=ITIfPnNS; dkim-atps=neutral; spf=pass (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=ITIfPnNS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPrNl75Qnz2xjQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 21:38:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1779795508;
	bh=kTAeZ3xw/Df4ezBjxQUd+PwImFlqzKYS6yA31g42XCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ITIfPnNSj4iYGsWPx3Tx9oUQY5RTkoSnYSt5EUf34ubhh7X+6E48t9zD8QK7p9UPJ
	 XunUJqRsVIEwWtiN2Rg9Bt86WZKhK6wBBXgLhouWeUEnyeCOr/EUakWvBODqgl2TFz
	 sDgAbkSNsaErv2LOwqvJaTrHYSPNfR2ht4L4Vb1g=
Date: Tue, 26 May 2026 13:38:27 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
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
Subject: Re: [PATCH v5 07/14] module: Make module authentication usable
 without MODULE_SIG
Message-ID: <4ee3c775-1fbf-45e1-8b77-5f9034f45125@t-8ch.de>
References: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>
 <20260505-module-hashes-v5-7-e174a5a49fce@weissschuh.net>
 <0a0736a4-2cdd-49f2-9062-e2f18d769fc0@suse.com>
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
In-Reply-To: <0a0736a4-2cdd-49f2-9062-e2f18d769fc0@suse.com>

On 2026-05-26 12:53:22+0200, Petr Pavlu wrote:
> On 5/5/26 11:05 AM, Thomas Weißschuh wrote:
> > The module authentication functionality will also be used by the
> > hash-based module authentication. Split it out from CONFIG_MODULE_SIG
> > so it is usable by both.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > [...]
> > diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
> > index f535181e0d98..84297da666ff 100644
> > --- a/kernel/module/Kconfig
> > +++ b/kernel/module/Kconfig
> > @@ -271,9 +271,12 @@ config MODULE_SIG
> >  	  debuginfo strip done by some packagers (such as rpmbuild) and
> >  	  inclusion into an initramfs that wants the module size reduced.
> >  
> > +config MODULE_AUTH
> > +	def_bool MODULE_SIG
> > +
> >  config MODULE_SIG_FORCE
> >  	bool "Require modules to be validly signed"
> > -	depends on MODULE_SIG
> > +	depends on MODULE_AUTH
> >  	help
> >  	  Reject unsigned modules or signed modules for which we don't have a
> >  	  key.  Without this, such modules will simply taint the kernel.
> 
> Should MODULE_SIG_FORCE be renamed to MODULE_AUTH_FORCE, along with
> renaming the sig_enforce functionality in kernel/module/auth.c to
> auth_enforce?

Given that it is a user-visible symbol we'll need to be a bit careful
not to break existing configurations.
I'll try to use the new "transitional" kconfig attribute.


Thomas

