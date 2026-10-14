Return-Path: <linuxppc-dev+bounces-29454-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67282CC6B1A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 05:36:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4KhQ2DTNz2yYK;
	Wed, 14 Oct 2026 16:36:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791956214;
	cv=none; b=LQsP+IM7wNylIr82NQR4x6jlPQvtvAuGOva42/R4mZ5ak4TNyaNGobecHca2oDx9V9CP0hCfYm1tryz9Y2rHF6yPNOnKCywGvvZGqVJStTkAqmmKxm4rzrE/yhaaoSI4/5YU8GRuR8CP4rBOf9cE98n93q+1edChzaxhAnO51GQXyYV2LoybpBCr8QiEk7NjPOJQxaBeWb2oJM4mcmZyPMKjHfNbqN+2O1XRYmo6QPyb+W0php+wfe8JSVLFIgBsM1mnDNs3uc84a9nJ6iA+IeqMcsaY0x4Q7jjP5qf76oD220PFkBzQQjiIfdNj0+osQ7DcCRko+7nDnKrUxEEujw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791956214; c=relaxed/relaxed;
	bh=20IeJwlfbHOwAOqBybbPglj4DioVDbfCTggyOUmG6AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPbRAmuBEamfmeiUFFdvT2JyxAC0u13e555CoK6NCnm2GXhCiJU80vELka9MPVGQ5kggl6+mwOGJDcgX1I5mxKTO0eNifZ2E5m7kUM0BzLYOfn+vmhiDph4Ed5tNIBEhRCTUlWhohlhQvOWxGJ/tgm0vsLqDfXM7YdkgQNXXKj9nafVOl2Ck0ZeV3ZDbrEHGGCiLkQMWcKWA6vZ55imjgKDFa/lke5lS0EVr1v5Lc5OfhH6VyxS9T/dy6MtNYnborvzGg4Nb1ssFYoO3Nx3M/IJQA0LJt3amPqBtwFwOGZwLRHsigdgTX2hvu6jnIe5/9IB+QepIqlUtxZmFg9VdQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Qh2L+lns; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Qh2L+lns;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4KhM4CsJz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 16:36:50 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8D84B407C1;
	Wed, 14 Oct 2026 05:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60E01F000FF;
	Wed, 14 Oct 2026 05:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791956207;
	bh=20IeJwlfbHOwAOqBybbPglj4DioVDbfCTggyOUmG6AM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qh2L+lns+TC45tZ3ta2Bf3sHpQuD7ArGYrxTnkjJVsISJDd215cAUFX7buojC10XX
	 PxZbUFGpn526urHl9iW1zA+jq+Q49VIAoWCaSVIjSYQA+Pdp0aIxZO/l3JMBTZ5a0o
	 W38eNJtQMa+oY0XJ4+Fg38TXLC108OEL5jmzsnVI=
Date: Wed, 14 Oct 2026 07:36:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ian Rogers <irogers@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Nayna Jain <nayna@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	David Teigland <teigland@redhat.com>,
	Alexander Aring <aahringo@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	driver-core@lists.linux.dev, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	gfs2@lists.linux.dev, xen-devel@lists.xenproject.org,
	linux-s390@vger.kernel.org, linux-mtd@lists.infradead.org,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] kobject: Require explicit initialization of struct
 kobj_type::release
Message-ID: <2026101425-why-boring-4f2d@gregkh>
References: <20261013223946.1836757-1-irogers@google.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013223946.1836757-1-irogers@google.com>

On Tue, Oct 13, 2026 at 03:39:35PM -0700, Ian Rogers wrote:
> Clang supports the 'require_explicit_initialization' attribute on struct
> fields to enforce that the field is explicitly initialized when an
> aggregate object is constructed, emitting -Wuninitialized-explicit-init
> (enabled by default) if the field is omitted.
> 
> Following discussion at the Linux Plumbers Conference [1], this series
> introduces __require_explicit_initialization in
> include/linux/compiler_attributes.h and applies it to
> struct kobj_type::release.

Cool, sorry I missed that talk.

> As Documentation/core-api/kobject.rst notes:
>   "One important point cannot be overstated: every kobject must have a
>   release() method, and the kobject must persist (in a consistent state)
>   until that method is called. If these constraints are not met, the code
>   is flawed."
> 
> Annotating struct kobj_type::release caught 30 struct kobj_type
> definitions across the tree that omitted .release:
> - Patches 2-10 fix 10 struct kobj_type definitions where dynamically
>   allocated kobjects, ksets, or enclosing structures were either leaked on
>   kobject_put() or freed prematurely before kobject release (risking a
>   use-after-free when CONFIG_DEBUG_KOBJECT_RELEASE=y).
> - Patch 11 annotates struct kobj_type::release with
>   __require_explicit_initialization and explicitly sets .release = NULL
>   (with explanatory comments) on the remaining legacy struct kobj_type
>   definitions whose kobjects are static, per-CPU, or embedded in devm- or
>   parent-managed structures.

Sounds great, but let's fix up the users before adding the attribute.
Looks like some of these need another version so it might take a bit of
time to get them all merged.

thanks,

greg k-h

