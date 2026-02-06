Return-Path: <linuxppc-dev+bounces-16657-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A31EB28EE
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Feb 2026 08:38:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6nY04GTGz2xqk;
	Fri, 06 Feb 2026 19:38:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770367092;
	cv=none; b=NyvhNnG6PuSj7Ym+nEcvvuD+1KXt/qwWvCWrRv/C8J64An+ioVrK7qKayJtSeFWZ1orD9QThW0647gwekAaGwqGbZwFP2v3fu1vFWEI273fz9jLtunFNKv0U+/nCgcjPGdJvs8Ypr7yS+eW+YK02FzwTQJZraueUcEuqgTOQn7o8C1Y2RHu85ynxZbaaGB2YiAe8wYkfmDrt/ikrR/6Ea/4eNY/dL25NmShF5D7O0FPu0DOwXDoxo5WtP4sY2zydyMgt9XT5VC0u5JmvU10LtrofEdhqAI1V7H/SwmcWbXZ2HhGC9sRAGgaGqCLh5DJDPbuJ7HVxsjLvIQNqCJZp/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770367092; c=relaxed/relaxed;
	bh=Q9ycdsaxEpijgdU+RaHTmq8JxzjgGQv7feYyRsFD0pg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjG9w2i60AO/2Ury6h/CbCmQvnOX4hSraPi/3WfeBWjxfiUEriCgggwBr92yqISuoJ9BexbB9IHIHoU9Cyc0PzrITDbd/2yIb/X94IEc5IizGvg7Fm+uyB2Pu8v6o6nexxrPK2LpbD4o7kipnZHwmUOS78ji/2vYelr14whhI4LJPkvGScT/35gRWvhHV9nOakHtI+EaOAgdnTGV7dkbouNvtISuUFQGNUERgSaq1RCB7gAgirTpdfTO6T8ibmzDir37LKj2O4evkFwrjL+7R/Jsk1YXFzCexd/42r1AvFhdiBlQGP5v1GpT0F4IEkNRBS1Xm1wdq5k7RZ/Uroy9RA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=lC6l85Da; dkim-atps=neutral; spf=pass (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=lC6l85Da;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6nXz3bHxz2xWJ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Feb 2026 19:38:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1770367087;
	bh=su7FBYVicdGhRvt56gHhQmYzpUnWthWMP4R173ydEmg=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=lC6l85Da6t0X83D9MSdF+rrwYpLGVaWK+Xg63weYUn13dYVZG8LoS1IkERKbA0VxU
	 eXtFagHfIkW0+2Nt4h3K4217dro8uw+kNYhA+Jea23v6FFzE84ypMvOVnGLtlMb66a
	 vke8iVYP2yDoFauo7ono6lRopUzDGDLu+wsELEj0=
Date: Fri, 6 Feb 2026 09:38:07 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Nicolas Schier <nsc@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
	Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, Arnout Engelen <arnout@bzzt.net>, 
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>, 
	Christian Heusel <christian@heusel.eu>, =?utf-8?B?Q8OianU=?= Mihai-Drosi <mcaju95@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 05/17] module: Switch load_info::len to size_t
Message-ID: <8fd4914d-5cff-4030-822c-98c8e76d0e60@t-8ch.de>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-5-0b932db9b56b@weissschuh.net>
 <aYWmkEzjvo9RrzI9@levanger>
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
In-Reply-To: <aYWmkEzjvo9RrzI9@levanger>

On 2026-02-06 09:30:08+0100, Nicolas Schier wrote:
> On Tue, Jan 13, 2026 at 01:28:49PM +0100, Thomas Weißschuh wrote:
> > Switching the types will make some later changes cleaner.
> > size_t is also the semantically correct type for this field.
> > 
> > As both 'size_t' and 'unsigned int' are always the same size, this
> > should be risk-free.
> 
> include/uapi/asm-generic/posix_types.h states:
> | * Most 32 bit architectures use "unsigned int" size_t,
> | * and all 64 bit architectures use "unsigned long" size_t.
> 
> Is that statement wrong?  Or did I mix up the context?

That statement is correct. But as both 'unsigned int' and 'unsigned
long' are 32-bit wide on 32-bit Linux platforms they are compatible.


Thomas

